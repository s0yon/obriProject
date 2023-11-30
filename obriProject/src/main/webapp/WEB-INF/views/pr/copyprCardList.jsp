<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<!--     <link rel="stylesheet" -->
<!-- 	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"> -->
<%--     <link rel="stylesheet" href="${path}/css/bootstrap.min.css" /> --%>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<!--     <link rel="stylesheet" href="assets/css/main.css" /> -->
    <title>홍보 카드 리스트</title>
</head>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
function prDetailPageMove(prNo) {
    // 클릭한 div의 prNo 값을 사용하여 원하는 페이지로 이동
    location.href = '${path}/prDetail.do?pageNum=${pp.currentPage}&prNo='+prNo;
}

function sortOrderChange(value){
	
	let i = $("#sortOrder").val();
	
	console.log($("#sortOrder").val());
	console.log("select선택된값"+i);
	
}
</script>

<style>
	 
    /* 카드 크기 고정 */
    .card {
        width: 450px;
        height: 150px;
    }
    /* 이미지 크기 조절 */
    .card-img {
    	width: 140px;
        height: 140px;
/*         width: 100%; */
/*         height: 100%; */
         object-fit: cover;  
    }
    
    /* 필터 */
    .sort {
    	max-width: 150px;
    	margin-right : 90px;
    }
     
    
</style>

<body> 
<%-- 현재 페이지 : ${pp.currentPage}  --%>
<div class="container mt-4 mx-auto">
	
	
	
	<div class="row justify-content-end mb-3">
        <div class="col-md-6 sort">
            <form>
                <select class="form-control" id="sortOrder" onchange="sortOrderChange(this.value)">
                	<option value="regDate">등록순</option>
                    <option value="view">조회순</option>
                    <option value="like">좋아요순</option>
                </select>
            </form>
        </div>
    </div>
	
    <div class="row">

		<!-- 반복문 시작 -->
		
		<c:if test="${empty prList}">
			<p> 등록된 정보가 없습니다.</p>
		</c:if>
		
		<c:forEach var="pr" items="${prList}">
		<div class="col-md-6 mb-4">

            <div class="card" onclick="prDetailPageMove('${pr.prNo}')">
                <div class="row no-gutters">
                    <div class="col-md-4">
                    	 <c:if test="${empty pr.prFile}">
                         	<img src="https://via.placeholder.com/150" class="card-img" >
                         </c:if>
                         <c:if test="${!empty pr.prFile}">
                         	<img src="<%=request.getContextPath()%>/upload/${pr.prFile}"class="card-img">
                         </c:if>
                    </div>
                    <div class="col-md-8">
                        <div class="card-body">
                            <h5 class="card-title">${pr.prSub}</h5>
                            <p class="card-text">${pr.prHash}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
		</c:forEach>
	</div>
	
	<form action="${path}/prCardList.do?pageNum=${currentPage}">
			<select name="search">
				<option value="subject"
					<c:if test="${search=='subject'}">selected="selected" </c:if>>제목</option>
				<option value="content"
					<c:if test="${search=='content'}">selected="selected" </c:if>>내용</option>
				<option value="writer"
					<c:if test="${search=='writer'}">selected="selected" </c:if>>작성자</option>
				<option value="subcon"
					<c:if test="${search=='subcon'}">selected="selected" </c:if>>제목+내용</option>
			</select> 
			<input type="text" name="keyword"> 
			<input type="submit" value="확인">
	</form>
	
<!-- 	<div class = "row justify-content-center"> -->
	<div class = "row justify-content-center">
	<ul class="pagination">
		<c:if test="${pp.startPage > pp.pagePerBlk}">
			<li class="page-item"><a class="page-link" href="${path}/prCardList.do?pageNum=${pp.startPage - 1}">이전</a></li>
		</c:if>
		<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
			<li class="page-item<c:if test="${pp.currentPage == i}"> active</c:if>">   
 			   <a class="page-link" href="${path}/prCardList.do?pageNum=${i}">${i}</a>
 			</li>
		</c:forEach>
		<c:if test="${pp.endPage < pp.totalPage}">
			<li class="page-item"><a class="page-link" href = "${path}/prCardList.do?pageNum=${pp.endPage+1}">다음</a></li>
		</c:if>
	</ul>
	</div>
</div>
</body>
</html>