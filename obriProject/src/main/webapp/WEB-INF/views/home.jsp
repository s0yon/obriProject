<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="loginOutLink"
	value="${sessionScope.userId==null ? 'login.do' : 'logout.do'}" />
<c:set var="loginOut"
	value="${sessionScope.userId==null ? '로그인' : '로그아웃'}" />
<c:set var="myPageLink"
	value="${sessionScope.userId==null ? 'join.do' : 'editCheck.do'}" />
<c:set var="myPage"
	value="${sessionScope.userId==null ? '회원가입' : '마이페이지'}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오브리</title>

<link rel="stylesheet" href="./css/nav.css">
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
	<!-- nav -->
	<div class="nav_head">
		<div class="logo">
			<a href="<c:url value='/home.do'/>"> <img src="./images/184.png"
				alt="">
			</a>
		</div>
		<!-- 테스트 만들기 입니다. -->
		<div class="menu_left">
			<a href="boardListShow.do">구인</a> <a href="prCardList.do">홍보</a> <a
				href="board_list.do">커뮤니티</a> <a href="board_list.do">공지</a>
		</div>
		<div class="menu_right">
			<a href="<c:url value='${loginOutLink}'/>">${loginOut}</a> <a
				href="<c:url value='${myPageLink}'/>">${myPage}</a>
		</div>
	</div>

	<main style="padding-top: 80px; padding-bottom: 80px">
		<!-- Header -->
		<section class="header">
			<div class="title">
				<h1>
					연주자를 위한 커뮤니티,<br> 오브리
				</h1>
			</div>
		</section>

		<!-- Animation -->
		<section class="animation">
			<div class="num_container">
				<div class="num_item">
					<h2 class="title">누적 회원 수</h2>
					<lable class="numCount"
						style="font-size:24px; font-weight:bold; color:#400080;">111</lable>
					<span class="unit">명</span><br>
				</div>
				<div class="num_item">
					<h2 class="title">누적 구인건 수</h2>
					<lable class="numCount"
						style="font-size:24px; font-weight:bold; color:#400080;">222</lable>
					<span class="unit">건</span><br>
				</div>
				<div class="num_item">
					<h2 class="title">누적 좋아요 수</h2>
					<lable class="numCount"
						style="font-size:24px; font-weight:bold; color:#400080;">333</lable>
					<span class="unit">개</span><br>
				</div>
			</div>
		</section>

		<!-- Intro -->
		<section class="intro">
			<div class="container">
				<div class="banner">
					<div class="ban_img">
						<img src="./images/banner.png" alt="">
					</div>
					<div class="ban_text">
						<p>최신 구인글</p>
					</div>
				</div>
				<div class="item">
					<iframe src="boardListShow.do" frameborder="0" scrolling="no"
						style="min-width: 480px; min-height: 270px;"></iframe>
				</div>
				<div class="btn_plus" onclick="location.href='board_list.do'"
					style="cursor: pointer;">
					<span class="fa-solid fa-plus fa-2xl"></span>
				</div>
			</div>
			<div class="container">
				<div class="banner">
					<div class="ban_img">
						<img src="./images/banner.png" alt="">
					</div>
					<div class="ban_text">
						<p>최신 커뮤니티글</p>
					</div>
				</div>
				<div class="item">
					<iframe src="boardListShow.do" frameborder="0" scrolling="no"
						style="min-width: 480px; min-height: 270px;"></iframe>
				</div>
				<div class="btn_plus" onclick="location.href='board_list.do'"
					style="cursor: pointer;">
					<span class="fa-solid fa-plus fa-2xl"></span>
				</div>
			</div>

		</section>
	</main>

	<!-- Footer -->
	<footer>
		<div class="nav_foot">
			<div class="container">
				<h2>오브리</h2>
				<p>O&nbsp;B&nbsp;R&nbsp;I&nbsp;&nbsp;&copy;2023.1조</p>
			</div>
			<div class="menu">
				<a href="">공지사항</a> <a href="">문의하기</a> <a href="">개인정보 처리방침</a> <a
					href="">서비스 이용약관</a>
			</div>
		</div>
		<div class="copyright">
			<p>&copy; 2023. 1조</p>
		</div>
		<div class="btn_up" onclick="window.scrollTo(0,0)">
			<span class="fa-solid fa-circle-up fa-2xl"></span>
		</div>
	</footer>

</body>
</html>