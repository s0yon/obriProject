<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>공지사항</title>
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
<style>
td {
	height: 400px;
}

.container input[type="button"] {
	margin-bottom: 10px;
	margin-left: 5px;
	float: right;
}

 #nottable {
        width: 100%;
        margin-bottom: 1rem;
        background-color: transparent;
    }

    #nottable th, #nottable td {
        padding: 0.75rem;
        vertical-align: top;
        border-top: 1px solid #dee2e6;
    }

    .btn {
        display: inline-block;
        font-weight: 400;
        color: #212529;
        text-align: center;
        vertical-align: middle;
        user-select: none;
        background-color: #f8f9fa;
        border: 1px solid #f8f9fa;
        padding: 0.375rem 0.75rem;
        font-size: 1rem;
        line-height: 1.5;
        border-radius: 0.25rem;
        transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
    }
    
    .btn-outline-secondary {
        color: #6c757d;
        background-color: transparent;
        background-image: none;
        border-color: #6c757d;
    }
</style>
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

</head>

<body>
	<div class="container-fluid">
		<div class="row">
			<!-- 헤더 부분 -->
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
						<h1 class="h2">공지사항</h1>
					</div>
				<table id="nottable" class="table">
					<tr class="table-active">
						<th scope="col" style="width: 60%"><c:out
								value="${map['NOTSUB']}" /><br> <c:out
								value="${map['ADMINNAME']}" /></th>
						<th scope="col" style="width: 40%" class="text-right">
						조회수 : <c:out value="${map['NOTRCOUNT']}" /><br>
						<fmt:formatDate value="${map['NOTDATE']}" pattern="yyyy-MM-dd" />
						</th>
					</tr>

					<tr>
						<td colspan=2><pre>${map['NOTTEXT']}</pre></td>
					</tr>
				</table>

				<div id="menu">
						<input type="button" value="목록" class="btn btn-outline-secondary"
						onclick="location='admin_notice.do?page=${page}'" />
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