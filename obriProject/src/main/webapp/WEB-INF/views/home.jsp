<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OBRI</title>

<link rel="stylesheet" href="./css/header.css">
<link rel="stylesheet" href="./css/animation.css">
<link rel="stylesheet" href="./css/intro.css">

<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://kit.fontawesome.com/8c929515d1.js"
	crossorigin="anonymous"></script>

<script>
	// 숫자 카운트 애니메이션
	$(function() {
		numCount();
	});
	function numCount() {
		$('.numCount').text($('input[id=num]').val())
		$('.numCount').each(function() {
			var t = $(this);
			$({
				Counter : 0
			}).delay(200).animate({
				Counter : t.text().replace(/,/g, "")
			}, {
				duration : 1800,
				easing : 'swing',
				step : function() {
					t.text(Math.ceil(this.Counter));
				},
				complete : function() {
					t.text(Math.ceil(this.Counter));
				}
			});
		});
	}
</script>
</head>

<body>
	<c:import url="/WEB-INF/views/navbar.jsp" />
	
	<main style="padding-top: 65px; padding-bottom: 65px">

		<!-- header start -->
		<section class="header">
			<div class="title">
				<h1>
					연주자를 위한 커뮤니티,<br> 오브리
				</h1>
			</div>
		</section>
		<!-- header end -->
<br><br>
		<!-- animation start -->
		<section class="animation">
			<div class="num_container">
				<div class="num_item">
					<h2 class="title">누적 회원 수</h2>
					<lable class="numCount" 
						style="font-size:24px; font-weight:bold; color:#444;">111</lable>
					<span class="unit">명</span><br>
				</div>
				<div class="num_item">
					<h2 class="title">누적 구인건 수</h2>
					<lable class="numCount" 
						style="font-size:24px; font-weight:bold; color:#444;">222</lable>
					<span class="unit">건</span><br>
				</div>
				<div class="num_item">
					<h2 class="title">누적 좋아요 수</h2>
					<lable class="numCount" 
						style="font-size:24px; font-weight:bold; color:#444;">333</lable>
					<span class="unit">개</span><br>
				</div>
			</div>
		</section>
		<!-- animation end -->

		<!-- intro start -->
		<section class="intro justify-content-between ml-5 mr-5">
			<div class="container ml-5 pl-5">
				<div class="banner">
					<div class="bann_icon">
						<i class="fa-solid fa-magnifying-glass"></i>
					</div>
					<div class="bann_text">
						<p>최신 구인글</p>
					</div>
				</div>
				<div class="item">
					<iframe src="boardListShow.do" frameborder="0" scrolling="no" style="width: 500px; height: 300px"></iframe>
				</div>
				<div class="btn_plus" onclick="location.href='boardList.do'"
					style="cursor: pointer;">
					<span class="fa-solid fa-plus fa-2xl"></span>
				</div>
			</div>
			<div class="container mr-5 pr-5">
				<div class="banner">
					<div class="bann_icon">
						<i class="fa-regular fa-comments"></i>
					</div>
					<div class="bann_text">
						<p>최신 커뮤니티글</p>
					</div>
				</div>
				<div class="item">
					<iframe src="boardListShow.do" frameborder="0" scrolling="no" style="width: 500px; height: 300px"></iframe>
				</div>
				<div class="btn_plus" onclick="location.href='boardList.do'"
					style="cursor: pointer;">
					<span class="fa-solid fa-plus fa-2xl"></span>
				</div>
			</div>
		</section>
		<br><br>
		<!-- intro end -->
	</main>
	<c:import url="/WEB-INF/views/footer.jsp" />
</body>
</html>