<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>문의 작성폼</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/admin/adminNav.css"
	type="text/css">
<link rel="stylesheet" href="./css/nav.css">

<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://kit.fontawesome.com/8c929515d1.js"
	crossorigin="anonymous"></script>
<script>
	$(function() {
		$("#navbar_toggle_btn").click(function() {
			$("#navbar_menu").toggle();
			$("#navbar_icons").toggle();
		});
	});
</script>
<style>
td {
	height: 400px;
}

.container input[type="button"] {
	margin-bottom: 10px;
	margin-left: 5px;
	float: right;
}
</style>
<script src="<%=request.getContextPath()%>/js/notice.js"></script>
</head>

<body>
	<div class="container-fluid">
		<div class="row">
				<!-- navbar start -->
	<nav class="navbar">
		<div class="navbar_logo" id="navbar_logo">
			<a href="<c:url value='/home.do'/>"><img src="./images/184.png"></a>
		</div>
		<ul class="navbar_menu" id="navbar_menu">
			<li><a href="boardListShow.do">구인</a></li>
			<li><a href="prCardList.do">홍보</a></li>
			<li><a href="board_list.do">커뮤니티</a></li>
			<li><a href="notice_list.do">공지</a></li>
		</ul>
		<ul class="navbar_icons" id="navbar_icons">
			<li><a href="<c:url value='${loginOutLink}'/>"> <i
					class="fa-solid fa-user"></i>&nbsp;&nbsp;${loginOut}
			</a></li>
			<li><a href="<c:url value='${myPageLink}'/>"> <i
					class="fa-solid fa-right-to-bracket"></i>&nbsp;&nbsp;${myPage}
			</a></li>
		</ul>
		<a href="#" class="navbar_toggle_btn" id="navbar_toggle_btn"> <i
			class="fa-solid fa-bars"></i>
		</a>
	</nav>
	<!-- navbar end -->

			<main style="padding-top: 80px; padding-bottom: 80px">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="h2">1:1 문의</h1>
				</div>
				<div class="my-3 p-3 bg-body rounded shadow-sm">
					<h4>유의사항</h4> 
					- 문의하실 내용과 관련된 세부 정보를 알려주시면 보다 정확한 답변을 드릴 수 있습니다.<br>
					- 문의에 대한 답변은 보통 일주일 이내에 처리됩니다. 긴급한 문제는 우선적으로 처리될 수 있습니다.<br>
					- 욕설, 비방, 개인정보 포함 등 불건전한 내용은 적절한 조치가 취해질 수 있습니다.<br>
					- 문의가 정상적으로 접수되면 등록하신 이메일로 안내 메일이 발송됩니다. 스팸 메일함도 확인해주세요.</div>
				<div class="table-responsive small">
					<form method="post" action="qna_write_ok.do"
						onsubmit="return qna_check()" enctype="multipart/form-data">
						<br>
						<div class="mb-3">
							<h6>작성자 : <%=(String)session.getAttribute("userId")%></h6>
						</div>
						<div class="mb-3">
							<input type="text" name="qnaSub" id="qnaSub" class="form-control"
								placeholder="제목을 입력해주세요." required>
						</div>
						<div class="form-group">
							<textarea class="form-control col-12" rows="10" name="qnaText"
								id="qnaText" placeholder="내용을 입력해주세요" required></textarea>
						</div>
						<div class="mb-3">
							<label for="formFile" class="form-label"></label> 
							<input class="form-control " type="file" id="formFile" name="formFile">
								-파일은 100KB 이하의 파일만 등록 가능합니다.
						</div>
						<div id="menu" align="center">
							<input type="submit" value="등록" class="btn btn-outline-dark mb-3">
						</div>
					</form>
				</div>
			</main>
		</div>
	</div>
	<!-- footer start -->
	<footer class="nav_foot">
		<div class="nav_container">
			<h2>오브리</h2>
			<p>O&nbsp;B&nbsp;R&nbsp;I&nbsp;&nbsp;&copy;2023.1조</p>
		</div>
		<ul class="nav_menu">
			<li><a href="notice_list.do">공지사항</a></li>
			<li><a href="qna_form.do">문의하기</a></li>
			<li><a href="">개인정보 처리방침</a></li>
			<li><a href="">서비스 이용약관</a></li>
		</ul>
		<div class="btn_up" onclick="window.scrollTo(0,0)">
			<span class="fa-solid fa-circle-up fa-2xl"></span>
		</div>
	</footer>
	<!-- footer end -->
</body>
</html>