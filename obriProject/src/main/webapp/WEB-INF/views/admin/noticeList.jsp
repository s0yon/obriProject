<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>공지사항</title>
<meta charset="utf-8">

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

</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<!-- 헤더부분 부분 -->
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
				<h2></h2>
				<div class="table-responsive small">
					<table class="table table-striped table-sm">
						<thead class="table-primary">
							<tr>
								<td><input type="checkbox" class="form-check-input"></td>
								<th scope="col">번호</th>
								<th scope="col">제목</th>
								<th scope="col">작성자</th>
								<th scope="col">작성일</th>
								<th scope="col">조회수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="n" items="${noticelist}">
								<tr>
									<td><input type="checkbox" class="form-check-input"
										name="selectedNotList" value="${n['NOTNO']}"></td>
									<td>${n['NOTNO']}</td>
									<td><a
										href="notice_read.do?notNo=${n['NOTNO']}&pageNum=${pageNum}&state=cont">
											${n['NOTSUB']}</a></td>
									<td>${n['ADMINNAME']}</td>
									<td><fmt:formatDate value="${n['NOTDATE']}"
											pattern="yyyy-MM-dd" /></td>
									<td>${n['NOTRCOUNT']}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					<nav aria-label="Page navigation example">
						<ul class="pagination justify-content-center">
							<c:if test="${not empty keyword}">
								<c:if test="${pp.startPage > pp.pagePerBlk }">
									<li class="page-item"><a class="page-link"
										href="notice_list.do?pageNum=${pp.startPage - 1}&search=${search}&keyword=${keyword}"
										aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
									</a></li>
								</c:if>
								<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
									<li class="page-item" <c:if test="${pp.currentPage==i}"></c:if>>
										<a
										href="notice_list.do?pageNum=${i}&search=${search}&keyword=${keyword}">${i}</a>
									</li>
								</c:forEach>
								<c:if test="${pp.endPage < pp.pageCount}">
									<li class="page-item"><a class="page-link"
										href="notice_list.do?pageNum=${pp.endPage + 1}&search=${search}&keyword=${keyword}"
										aria-label="Next"> <span aria-hidden="true">&raquo;</span>
									</a></li>
								</c:if>
							</c:if>

							<!-- 전체 목록의 페이징 처리 -->
							<c:if test="${empty keyword}">
								<c:if test="${pp.startPage > pp.pagePerBlk }">
									<li class="page-item"><a class="page-link"
										href="notice_list.do?pageNum=${pp.startPage - 1}"
										aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a></li>
								</c:if>
								<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
									<li class="page-item" <c:if test="${pp.currentPage==i}"></c:if>><a
										href="notice_list.do?pageNum=${i}">${i}</a></li>
								</c:forEach>
								<c:if test="${pp.endPage < pp.pageCount}">
									<li class="page-item"><a class="page-link"
										href="notice_list.do?pageNum=${pp.endPage + 1}"
										aria-label="Next"> <span aria-hidden="true">&raquo;</span>
									</a></li>
								</c:if>
							</c:if>
						</ul>
					</nav>
					<form action="admin_notice.do">
						<input type="hidden" name="pageNum" value="1"> <select
							name="search">
							<option value="notSub"
								<c:if test="${search=='notSub'}">selected="selected" </c:if>>제목</option>
							<option value="notText"
								<c:if test="${search=='notText'}">selected="selected" </c:if>>내용</option>
							<option value="subcon"
								<c:if test="${search=='subcon'}">selected="selected" </c:if>>제목+내용</option>
						</select> <input type="text" name="keyword"> <input type="submit"
							value="확인">
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