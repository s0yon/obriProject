<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html>
<head>
<title>구인</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Font Awesome -->
<script src="https://kit.fontawesome.com/8c929515d1.js"></script>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-latest.js"></script>

<!-- 부트스트랩 JS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- 사용자 정의 스타일 -->
<link rel="stylesheet" href="./css/custom-styles.css">

<script>
	function jobListSort() {
		// 폼 선택
		var form = document.getElementById("selectForm");

		// jobListSel 값을 폼에 추가
		var input = document.createElement("input");
		input.type = "hidden";
		input.id = "jobListSel";
		input.value = $("#jobListSel").val();
		form.appendChild(input);

		// 폼 서브밋
		form.submit();
	}
</script>
<script>
	document.addEventListener('DOMContentLoaded', function() {
		var contentElement = document.querySelector('#consub');
		var contentText = contentElement.innerText
				|| contentElement.textContent;

		var formattedContent = formatText(contentText, 70);
		contentElement.innerHTML = formattedContent;

		function formatText(text, length) {
			var result = '';
			for (var i = 0; i < text.length; i += length) {
				result += text.slice(i, i + length) + '<br>';
			}
			return result;
		}
	});
</script>
</head>

<body class="bg-body-tertiary">
	<!-- header -->
	<c:import url="/WEB-INF/views/navbar.jsp" />
	<div class="container-sm">
		<main>
			<div class="d-flex justify-content-between my-3 py-3 border-bottom">
				<h3 class="font-weight-bold text-dark">구인</h3>
			</div>
			<div class="table-header">
				<div class="sort-container">
					<form id="selectForm" action="joblist.do" method="get">
						<select class="sort_box" id="jobListSel" name="jobListSel"
							onchange="jobListSort()">
							<option value=" ">선택</option>
							<option value="Date">최신순</option>
							<option value="View">조회수순</option>
						</select>
					</form>
				</div>
				<div class="btn-container">
					<c:if test="${sessionScope.userId != null}">
						<input type="button" value="글작성" class="btn"
							onclick="location.href='job_board_write.do?pageNum=${pp.currentPage}'"
							id="board_write">
					</c:if>
				</div>
			</div>

			<table class="table-hover" align="center">
				<thead>
					<tr>
						<th width="10%">번호</th>
						<th width="20%">제목</th>
						<th width="15%">작성자</th>
						<th width="15%">작성일</th>
						<th width="15%">구인마감일</th>
						<th width="15%">공연일</th>
						<th width="10%">조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="job" items="${list}">
						<tr>
							<td>${job['JOBNO']}</td>
							<td id="subject"><a
								href="job_board_view.do?jobNo=${job['JOBNO']}&pageNum=${pp.currentPage}&state=cont"
								class="truncate-text" id="consub">
									<%-- ${job['JOBSUB']}  --%>
									<c:set var="truncatedSub"
										value="${fn:substring(job['JOBSUB'], 0, 15)}" />
									${truncatedSub} <c:if test="${fn:length(job['JOBSUB']) > 15}">...</c:if>
							</a></td>
							<td>${job['USERNAME']}</td>
							<td><fmt:formatDate value="${job['JOBDATE']}"
									pattern="yyyy-MM-dd" /></td>
							<td><fmt:formatDate value="${job['JOBENDDATE']}"
									pattern="yyyy-MM-dd" /></td>
							<td><fmt:formatDate value="${job['JOBCONCERT']}"
									pattern="yyyy-MM-dd" /></td>
							<td>${job['JOBRCOUNT']}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<div align="center">
				<ul class="pagination">
					<c:if test="${not empty keyword}">
						<c:if test="${pp.startPage > pp.pagePerBlk }">
							<li><a
								href="joblist.do?pageNum=${pp.startPage - 1}&search=${search}&keyword=${keyword}">
									<span aria-hidden="true">&laquo;</span>
							</a></li>
						</c:if>

						<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
							<li <c:if test="${pp.currentPage==i}"></c:if>><a
								href="joblist.do?pageNum=${i}&search=${search}&keyword=${keyword}">${i}</a></li>
						</c:forEach>
						<c:if test="${pp.endPage < pp.totalPage}">
							<li><a
								href="joblist.do?pageNum=${pp.endPage + 1}&search=${search}&keyword=${keyword}">
									<span aria-hidden="true">&raquo;</span>
							</a></li>
						</c:if>
					</c:if>

					<!-- 전체 목록의 페이징 처리 -->
					<c:if test="${empty keyword}">
						<c:if test="${pp.startPage > pp.pagePerBlk }">
							<li><a href="joblist.do?pageNum=${pp.startPage - 1}"> <span
									aria-hidden="true" class="page-link">&laquo;</span></a></li>
						</c:if>

						<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
							<li <c:if test="${pp.currentPage == i}"></c:if>><a
								href="joblist.do?pageNum=${i}" class="page-link">${i}</a></li>
						</c:forEach>

						<c:if test="${pp.endPage < pp.totalPage}">
							<li><a href="joblist.do?pageNum=${pp.endPage + 1}"
								class="page-link"><span aria-hidden="true">&raquo;</span></a></li>
						</c:if>
					</c:if>
				</ul>

				<form class="search_bar" action="joblist.do">
					<input type="hidden" name="pageNum" value="1"> <select
						name="search" class="search_box">
						<option value="jobSub"
							<c:if test="${search=='subject'}">selected="selected" </c:if>>제목</option>
						<option value="jobText"
							<c:if test="${search=='content'}">selected="selected" </c:if>>내용</option>
						<option value="subcon"
							<c:if test="${search=='subcon'}">selected="selected" </c:if>>제목+내용</option>
					</select> <input class="search_text" type="text" name="keyword"> <input
						class="btn" type="submit" value="찾기">
				</form>
			</div>
		</main>
	</div>
	<!-- footer -->
	<c:import url="/WEB-INF/views/footer.jsp" />
</body>
</html>