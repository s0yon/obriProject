<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OBRI</title>
<!-- <link rel="stylesheet" href="./css/footer.css"> -->
<!-- Font Awesome -->
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
</head>
<body>
	<!-- footer start -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-bottom">
		<p class="font-weight-bold ml-5 my-auto">O&nbsp;B&nbsp;R&nbsp;I&nbsp;&nbsp;&copy;2023.1조</p>
		<div
			class="collapse navbar-collapse justify-content-between font-weight-bold"
			id="navbarNav">
			<ul class="navbar-nav ml-5">
				<li class="nav-item pr-3"><a class="nav-link"
					href="notice_list.do">공지사항</a></li>
				<li class="nav-item pr-3"><a class="nav-link"
					href="qna_form.do">문의하기</a></li>
				<li class="nav-item pr-3"><a class="nav-link" href="">개인정보
						처리방침</a></li>
				<li class="nav-item pr-3"><a class="nav-link" href="">서비스
						이용약관</a></li>
			</ul>
		</div>
		<div class="btn_up" onclick="window.scrollTo(0,0)">
			<span class="fa-solid fa-circle-up fa-2xl"></span>
		</div>
	</nav>
	<!-- navbar end -->

	<!-- 부트스트랩 JS 및 jQuery -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>