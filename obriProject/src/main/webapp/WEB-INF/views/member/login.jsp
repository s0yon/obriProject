<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta charset="utf-8">
<title>로그인</title>

<!-- css -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="./css/member/login.css" type="text/css">

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	function check() {
		if ($.trim($("#userId").val()) == "") {
			alert("아이디를 입력하세요.");
			$("#userId").val("").focus();
			return false;
		}
		if ($.trim($("#userPw").val()) == "") {
			alert("비밀번호를 입력하세요.");
			$("#userPw").val("").focus();
			return false;
		}
	}
</script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
	Kakao.init('523670a2c81fb6a0bc2490ee556aed4f'); //발급받은 키 중 javascript키를 사용해준다.
	console.log(Kakao.isInitialized()); // sdk초기화여부판단

	function kakaoLogin() {
		Kakao.Auth.login({
			success : function(response) {
				Kakao.API.request({
					url : '/v2/user/me',
					success : function(response) {
						console.log(response)
					},
					fail : function(error) {
						console.log(error)
					},
				})
			},
			fail : function(error) {
				console.log(error)
			},
		})
	}

	function kakaoLogout() {
		if (Kakao.Auth.getAccessToken()) {
			Kakao.API.request({
				url : '/v1/user/unlink',
				success : function(response) {
					console.log(response)
				},
				fail : function(error) {
					console.log(error)
				},
			})
			Kakao.Auth.setAccessToken(undefined)
		}
	}
</script>
<script
	src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js"
	charset="utf-8"></script>
<script>
	var naverLogin = new naver.LoginWithNaverId({
		clientId : "xJeBrLOKcF1jhMTonLZ_", //내 애플리케이션 정보에 cliendId를 입력해줍니다.
		callbackUrl : "http://localhost/member/loginNaver", // 내 애플리케이션 API설정의 Callback URL 을 입력해줍니다.
		isPopup : false,
		callbackHandle : true
	});

	naverLogin.init();

	window.addEventListener('load', function() {
		naverLogin.getLoginStatus(function(status) {
			if (status) {
				var email = naverLogin.user.getEmail(); // 필수로 설정할것을 받아와 아래처럼 조건문을 줍니다.

				console.log(naverLogin.user);

				if (email == undefined || email == null) {
					alert("회원이름, 휴대전화번호는 필수정보입니다. 정보제공을 동의해주세요.");
					naverLogin.reprompt();
					return;
				}
			} else {
				console.log("callback 처리에 실패하였습니다.");
			}
		});
	});

	var testPopUp;
	function openPopUp() {
		testPopUp = window.open("https://nid.naver.com/nidlogin.logout",
				"_blank",
				"toolbar=yes,scrollbars=yes,resizable=yes,width=1,height=1");
	}
	function closePopUp() {
		testPopUp.close();
	}

	function naverLogout() {
		openPopUp();
		setTimeout(function() {
			closePopUp();
		}, 1000);

	}
</script>

</head>

<body class="d-flex align-items-center py-4 bg-body-tertiary">
	<main class="form-signin w-500 m-auto">
		<form method="post" action="checkLogin.do" onsubmit="return check()">
			<br> <img src="images/184.png" alt="" width="100" height="100"
				onclick="location.href='home.do'" style="cursor: pointer;"> <br>
			<br>
			<h1 class="h4 mb-3" align="center">
				연주자를 위한 커뮤니티,<br> <b>오브리</b>에 오신 것을 환영합니다.
			</h1>
			<br>
			<div class="form-floating">
				<input type="text" class="form-control" id="userId" name="userId"
					placeholder="id"> <label for="userId">아이디</label>
			</div>
			<div class="form-floating">
				<input type="password" class="form-control" id="userPw"
					name="userPw" placeholder="pw"> <label for="userPw">비밀번호</label>
			</div>

			<button class="btn w-100 pr-100 fw-bold" type="submit">로그인</button>
			<br><br>
			<ul>
				<li onclick="kakaoLogin();"><a href="javascript:void(0)"> <span>카카오
							로그인</span>
				</a></li>
				<li onclick="kakaoLogout();"><a href="javascript:void(0)">
						<span>카카오 로그아웃</span>
				</a></li>
			</ul>
			<ul>
				<li><a id="naverIdLogin_loginButton" href="javascript:void(0)">
						<span>네이버 로그인</span>
				</a></li>
				<li onclick="naverLogout(); return false;"><a
					href="javascript:void(0)"> <span>네이버 로그아웃</span>
				</a></li>
			</ul>
			<p class="mt-4 mb-3 text-body-secondary" align="center"
				style="font-size: 90%">
				<a href="findId.do" style="color: gray">아이디 찾기</a>&nbsp;|&nbsp;<a
					href="findPw.do" style="color: gray">비밀번호 찾기</a><br>아직 회원이
				아니신가요?&nbsp;<a href="join.do" style="color: gray">회원가입</a>
			</p>

			<p class="mt-5 mb-3 text-body-secondary" align="center"
				style="font-size: 80%">&copy; 2023. 1조</p>
		</form>
	</main>
</body>
</html>