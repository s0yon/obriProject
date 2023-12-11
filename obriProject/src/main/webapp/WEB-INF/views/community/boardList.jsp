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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시판 목록</title>

<link rel="stylesheet" href="./css/nav.css">
<link rel="stylesheet" href="./css/header.css">



<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://kit.fontawesome.com/8c929515d1.js"
	crossorigin="anonymous"></script>


<!-- 게시판 정렬 -->
<script>
	function comSort(){
		var sortValue = $("#sort").val();
		location.href="boardList.do?sort="+sortValue;
	}
</script>

<script>

var sessionId = '<%=(String)session.getAttribute("userId")%>';
console.log("세션ID "+sessionId);
$(document).ready(function() {
	
	if(sessionId === "null"){
		console.log("여기들감?");
		$("#commInsert").hide();
	}else {
		$("#commInsert").show();
	}
});

</script>

<style>
  .container {
    display: flex;
    justify-content: center; /* 수평 가운데 정렬 */
    align-items: center; /* 수직 가운데 정렬 */
  }
</style>

</head>
<body>
 <!-- navbar start -->
	<nav class="navbar">
		<div class="navbar_logo" id="navbar_logo">
			<a href="<c:url value='/home.do'/>"><img src="./images/184.png"></a>
		</div>
		<ul class="navbar_menu" id="navbar_menu">
			<li><a href="boardListShow.do">구인</a></li>
			<li><a href="prCardList.do">홍보</a></li>
			<li><a href="boardList.do">커뮤니티</a></li>
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

		<!-- header start -->
		<section class="header">
			<div class="title">
				<h1>
					오브리<br>
					커뮤티니 게시판
				</h1>
			</div>
		</section>
		<!-- header end -->
 


<div class="container">
 
 <div >
 <br>

<div align="right">전체 글 수 : ${pp.total } 개</div>

<div align="left">
<input type="button" value="글작성"
		onclick="location.href='boardForm.do ' " id="commInsert" >
</div>	

<!-- 최신순,조회순, 좋아요순 -->
<div align="right">
		<select name="sort"   id="sort"  onchange="comSort()">
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



	<table border=1  align="center" width="800" >
		
		<tr>
			<th>No</th>
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
				<c:forEach var="community"  items="${list }">
						<c:if test="${community.commDelyn != 'Y' }">
					<tr align="center">
					
						<td>${no1}
							<c:set var="no1" value="${no1-1}"/>
						</td>
						
						
							<td align="center">
							
							<fmt:formatDate var="today"   value="<%=new Date() %>"   pattern="yy/MM/dd"   />
							<fmt:formatDate var="dbtoday"   value="${community.commDate}"   pattern="yy/MM/dd"   />
						
							<a href="boardContent.do?commNo=${community.commNo}&pageNum=${pp.currentPage}"> 
								 	${community.commSub} 			
								 					 
									<!-- 조회수 30 이상이면  -->
									<c:if test="${dbtoday == today }">
											<img alt="" src="images/new.png"  width="20" height="20">
									</c:if></a>
							</td>	
														
							<td>${community.userId}</td>
							<td>
								<fmt:formatDate value="${community.commDate}"
										pattern="yyyy년 MM월 dd일 "/>							
							</td> 
							
							
							<td>${community.commCount}</td>
							
							
							<td>${community.likeCnt }</td>
						</c:if>
					
					
					
				</c:forEach>
			</c:if>
		</table>
		<br>
		
		
		<div align="center">
		<form action="boardList.do">
			<input type="hidden" name="pageNum" value="1"> 
			<input type="hidden" name="sort" id="sort" value="${sort}">
			<select	name="search">
				<option value="commSub"	<c:if test="${search=='commSub'}">selected="selected" </c:if>>제목</option>
				<option value="commText"	<c:if test="${search=='commText'}">selected="selected" </c:if>>내용</option>
				<option value="userId"	<c:if test="${search=='userId'}">selected="selected" </c:if>>작성자</option>
				<option value="subcon"	<c:if test="${search=='subcon'}">selected="selected" </c:if>>제목+내용</option>
			</select> 
			<input type="text" name="keyword"> 
			<input type="submit" value="검색">
		</form>
		
			<!-- 검색 했을 경우의 페이징 처리 -->
			<c:if test="${not empty keyword}">
			
				<c:if test="${pp.startPage > pp.pagePerBlk }">
					<a href="boardList.do?pageNum=${pp.startPage - 1}&search=${search}&keyword=${keyword}&sort=${sort}">이전</a>
				</c:if>
				
				<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
					<c:if test="${pp.currentPage==i}"></c:if>>
					<a href="boardList.do?pageNum=${i}&search=${search}&keyword=${keyword}&sort=${sort}">${i}</a>
				</c:forEach>
				<c:if test="${pp.endPage < pp.totalPage}">
					<a href="boardList.do?pageNum=${pp.endPage + 1}&search=${search}&keyword=${keyword}&sort=${sort}">다음</a>
				</c:if>
			</c:if>
			
			<!-- 전체 목록의 페이징 처리 -->
			<c:if test="${empty keyword}">
				<c:if test="${pp.startPage > pp.pagePerBlk }">
					<a href="boardList.do?pageNum=${pp.startPage - 1}&sort=${sort}">이전</a>
				</c:if>
				<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
					 <c:if test="${pp.currentPage==i}"></c:if>
						<a href="boardList.do?pageNum=${i}&sort=${sort}">${i}</a>
				</c:forEach>
				<c:if test="${pp.endPage < pp.totalPage}">
				 <a href="boardList.do?pageNum=${pp.endPage + 1}&sort=${sort}">다음</a>
				</c:if>
			</c:if>
		
		</div>
<br>


</div>
</div>


	</main>	
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