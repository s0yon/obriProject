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
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
	charset="utf-8"></script>

<!-- <script type="text/javascript">
	window.addEventListener("message", function(event) {
		if (event.data === "naverLoginSuccess") {
			window.location.href = "list.board";
		}
	});
</script> -->
</head>

<body class="d-flex align-items-center py-4 bg-body-tertiary">
	<main class="form-signin w-500 m-auto">
		<form method="post" action="checkLogin.do" onsubmit="return check()">
			<div id="logo">
				<img src="images/184.png" alt="" width="100" height="100"
				onclick="location.href='home.do'" style="cursor: pointer;">
			</div>
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
			<br> <br>

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