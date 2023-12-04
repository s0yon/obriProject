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
<script src="https://kit.fontawesome.com/8c929515d1.js"
	crossorigin="anonymous"></script>
	
</head>
<body>

	<!-- nav -->
	<div class="nav_head">
		<div class="logo">
			<a href="<c:url value='/home.do'/>"> <img src="./images/184.png"
				alt="">
			</a>
		</div>
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

		<!-- Contents Start -->
		
		<!-- Contents End -->

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
			<div class="btn_up" onclick="window.scrollTo(0,0)">
				<span class="fa-solid fa-circle-up fa-2xl"></span>
			</div>
		</footer>
</body>
</html>