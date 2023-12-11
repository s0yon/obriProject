<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 사용자 정의 스타일 -->
<link rel="stylesheet" href="./css/custom-styles.css">
<title>커뮤니티</title>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://kit.fontawesome.com/8c929515d1.js"></script>


<!-- 게시판 정렬 -->
<script>
	function comSort(){
		var sortValue = $("#sort").val();
		location.href="boardList.do?sort="+sortValue;
	}
</script>

<script>

var sessionId = '<%=(String) session.getAttribute("userId")%>
	';
	console.log("세션ID " + sessionId);
	$(document).ready(function() {

		if (sessionId === "null") {
			console.log("여기들감?");
			$("#commInsert").hide();
		} else {
			$("#commInsert").show();
		}
	});
</script>

</head>
<body>
	<div class="container-sm">
		<!-- 헤더부분 -->
		<c:import url="/WEB-INF/views/navbar.jsp" />

		<main>
			<div>
				<h1>커뮤니티</h1>
			</div>
			<div class="community-header">
				<div class="sort-container">
					<select name="sort" id="sort" onchange="comSort()"  class="sort_box">
						<option value="recent"
							<c:if test="${sort == 'recent'}">${'selected'}</c:if>>최신순
						</option>

						<option value="readcnt"
							<c:if test="${sort == 'readcnt'}">${'selected'}</c:if>>조회순
						</option>

						<option value="likecnt"
							<c:if test="${sort == 'likecnt'}">${'selected'}</c:if>>좋아요순
						</option>
					</select>
				</div>
				<div class="btn-container">
					<input type="button" value="글작성" class="btn btn-sm btn-outline-secondary" 
						onclick="location.href='boardForm.do ' " id="commInsert">
				</div>
			</div>
							
				<table>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자명</th>
						<th>날짜</th>
						<th>조회수</th>
						<th>좋아요 수</th>

					</tr>

					<c:if test="${empty list}">
						<tr>
							<td colspan="6">작성된 글이 없습니다</td>
						</tr>
					</c:if>

					<c:if test="${not empty list}">
						<c:set var="no1" value="${no}"></c:set>
						<c:forEach var="community" items="${list }">
							<c:if test="${community.commDelyn != 'Y' }">
								<tr align="center">

									<td>${no1}<c:set var="no1" value="${no1-1}" />
									</td>


									<td align="center"><fmt:formatDate var="today"
											value="<%=new Date()%>" pattern="yy/MM/dd" /> <fmt:formatDate
											var="dbtoday" value="${community.commDate}"
											pattern="yy/MM/dd" /> <a
										href="boardContent.do?commNo=${community.commNo}&pageNum=${pp.currentPage}">
											${community.commSub} <!-- 조회수 30 이상이면  --> <c:if
												test="${dbtoday == today }">
												<img alt="" src="images/new.png" width="20" height="20">
											</c:if>
									</a></td>

									<td>${community.userId}</td>
									<td><fmt:formatDate value="${community.commDate}"
											pattern="yyyy년 MM월 dd일 " /></td>


									<td>${community.commCount}</td>


									<td>${community.likeCnt }</td>
							</c:if>



						</c:forEach>
					</c:if>
				</table>
				<br>


				<div align="center">
				<ul class="pagination">
					<!-- 검색 했을 경우의 페이징 처리 -->
					<c:if test="${not empty keyword}">

						<c:if test="${pp.startPage > pp.pagePerBlk }">
							<li><a href="boardList.do?pageNum=${pp.startPage - 1}&search=${search}&keyword=${keyword}&sort=${sort}">&laquo;</a></li>
						</c:if>

						<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
							<li<c:if test="${pp.currentPage==i}"></c:if>>
							<a href="boardList.do?pageNum=${i}&search=${search}&keyword=${keyword}&sort=${sort}">${i}</a>
							</li>
						</c:forEach>
						<c:if test="${pp.endPage < pp.totalPage}">
							<li><a href="boardList.do?pageNum=${pp.endPage + 1}&search=${search}&keyword=${keyword}&sort=${sort}">&raquo;</a></li>
						</c:if>
					</c:if>

					<!-- 전체 목록의 페이징 처리 -->
					<c:if test="${empty keyword}">
						<c:if test="${pp.startPage > pp.pagePerBlk }">
							<li><a href="boardList.do?pageNum=${pp.startPage - 1}&sort=${sort}">&laquo;</a></li>
						</c:if>
						<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
							<li<c:if test="${pp.currentPage==i}"></c:if>>
							<a href="boardList.do?pageNum=${i}&sort=${sort}">${i}</a>
							</li>
						</c:forEach>
						<c:if test="${pp.endPage < pp.totalPage}">
							<li><a href="boardList.do?pageNum=${pp.endPage + 1}&sort=${sort}">&raquo;</a></li>
						</c:if>
					</c:if>
					</ul>
					
					<form class="search_bar" action="boardList.do">
						<input type="hidden" name="pageNum" value="1">
						<input type="hidden" name="sort" id="sort" value="${sort}">
							<select name="search" class="search_box">
							<option value="commSub"
								<c:if test="${search=='commSub'}">selected="selected" </c:if>>제목</option>
							<option value="commText"
								<c:if test="${search=='commText'}">selected="selected" </c:if>>내용</option>
							<option value="userId"
								<c:if test="${search=='userId'}">selected="selected" </c:if>>작성자</option>
							<option value="subcon"
								<c:if test="${search=='subcon'}">selected="selected" </c:if>>제목+내용</option>
						</select>
						<input class="search_text" type="text" name="keyword">
						<input class="search_button" type="submit" value="검색">
					 </form>
	            </div>
	    </main>
	</div>
	<!-- footer -->
	<c:import url="/WEB-INF/views/footer.jsp" />


</body>
</html>