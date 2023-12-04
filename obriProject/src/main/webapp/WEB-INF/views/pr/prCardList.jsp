<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    
    <title>홍보 카드 리스트</title>
</head>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<script>


var sessionId = '<%=(String)session.getAttribute("userId")%>';
console.log("세션ID "+sessionId);
$(document).ready(function() {
	
	if(sessionId === "null"){
		console.log("여기들감?");
		$("#prInsert").hide();
	}else {
		$("#prInsert").show();
	}
});

function prDetailPageMove(prNo) {
    // 클릭한 div의 prNo 값을 사용하여 원하는 페이지로 이동
    location.href = '${path}/prDetail.do?pageNum=${pp.currentPage}&prNo='+prNo;
}
// 이벤트를 처리할 함수
function sortOrderChange() {
    
	let sort = $("#sortOrder").val();
	
	location.href = '${path}/prCardList.do?pageNum=${pp.currentPage}&sortOrder='+sort;
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
	width: 100%; 
	height: 100%;
	object-fit: contain; /* 이미지를 비율 유지하면서 전체 영역에 맞춥니다. */
}

/* 조회수, 좋아요 필터 */
.sort {
	max-width: 150px;
	margin-right: 90px;
}

/* pagingmargin */
.pagingMargin {
	margin-top: 8px;
}

.hashtag-container {
/*   display: flex; */
  justify-content: space-around; /* 해시태그들을 균등하게 분포 */
  padding: 10px;
/*   background-color: #fafafa; /* 배경색 설정 */ */
}

.hashtag {
  padding: 3px 6px; /* 패딩을 줄임 */
  margin: 0 3px; /* 마진을 추가하여 해시태그 간 간격 생성 */
  background-color: #e0e0e0; /* 해시태그 배경색 설정 */
  border-radius: 3px; /* 모서리 둥글게 */
  color: #333; /* 글자색 설정 */
  font-size: 12px; /* 글자 크기를 줄임 */
  text-decoration: none; /* 밑줄 제거 */
}
</style>

<body> 

<%-- 현재 페이지 : ${pp.currentPage}  --%>
<div class="container mt-4 mx-auto ">
	
	<div class="row justify-content-end mb-3">
		<div class="row mb-3">
        <div class="col-md-12 text-right" id="prInsert">
            <a href="${path}/prInsertForm.do" class="btn btn-primary">홍보 등록</a>
        </div>
    </div>
	
		
        <div class="col-md-6 sort">
            <form>
                <select class="form-control" id="sortOrder" onchange="sortOrderChange()">
                	<option value="">선택</option>
                	<option value="regDate">등록순</option>
                    <option value="view">조회순</option>
<!--                     <option value="like">좋아요순</option> -->
                </select>
            </form>
        </div>
    </div>
    
	<div class = "onoffdiv">
    <div class="row justify-content-center">

		<!-- 반복문 시작 -->
		
		<c:if test="${empty prList}">
			<p> 등록된 정보가 없습니다.</p>
		</c:if>
		
		<c:forEach var="pr" items="${prList}">
		<div class="col-md-6 mb-4">

            <div class="card" onclick="prDetailPageMove('${pr.prNo}')">
                <div class="row no-gutters">
                    <div class="col-md-4 mb-2">
                    	 <c:if test="${empty pr.prFile}">
                         	<img src="https://via.placeholder.com/150" class="card-img" >
                         </c:if>
                         <c:if test="${!empty pr.prFile}">
                         	<img src="<%=request.getContextPath()%>/upload/${pr.prFile}"class="card-img">
                         </c:if>
                    </div>
                    <div class="col-md-8 mb-4">
                        <div class="card-body">
                            <h5 class="card-title">${pr.prSub}</h5>
                        </div>
                        	
                        <div class="hashtag-container">
                        	<c:if test="${!empty pr.prHash}">
  								<span class="hashtag"> ${pr.prHash}</span>
  							</c:if>  							
						</div>
						
                    </div>
                </div>
            </div>
        </div>
		</c:forEach>
	</div>
	</div>
	
	<form action="${path}/prCardList.do?pageNum=${currentPage}" class="d-flex justify-content-center">
			<select name="search">
				<option value="prSub"
					<c:if test="${search=='prSub'}">selected="selected" </c:if>>제목</option>
				<option value="prText"
					<c:if test="${search=='prText'}">selected="selected" </c:if>>내용</option>
				<option value="subcon"
					<c:if test="${search=='subcon'}">selected="selected" </c:if>>제목+내용</option>
			</select> 
			<input type="text" name="keyword" style="margin-left: 5px;"> 
			<input type="submit" value="확인" style="margin-left: 5px;">
	</form>
	
	<div class="d-flex justify-content-center pagingMargin">
	<ul class="pagination">
		<c:if test="${not empty keyword }">
			<c:if test="${pp.startPage > pp.pagePerBlk}">
				<li class="page-item"><a class="page-link" href="${path}/prCardList.do?pageNum=${pp.startPage - 1}&search=${search}&keyword=${keyword}">이전</a></li>
			</c:if>
			<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
				<li class="page-item<c:if test="${pp.currentPage == i}"> active</c:if>">   
	 			   <a class="page-link" href="${path}/prCardList.do?pageNum=${i}&search=${search}&keyword=${keyword}">${i}</a>
	 			</li>
			</c:forEach>
			<c:if test="${pp.endPage < pp.totalPage}">
				<li class="page-item"><a class="page-link" href = "${path}/prCardList.do?pageNum=${pp.endPage+1}&search=${search}&keyword=${keyword}">다음</a></li>
			</c:if>
		</c:if>
		<c:if test="${empty keyword }">
			<c:if test="${empty sortOrder}">
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
			</c:if>
			<c:if test="${not empty sortOrder}">
				<c:if test="${pp.startPage > pp.pagePerBlk}">
					<li class="page-item"><a class="page-link" href="${path}/prCardList.do?pageNum=${pp.startPage - 1}&sortOrder=${sortOrder}">이전</a></li>
				</c:if>
				<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
					<li class="page-item<c:if test="${pp.currentPage == i}"> active</c:if>">   
	 			   	<a class="page-link" href="${path}/prCardList.do?pageNum=${i}&sortOrder=${sortOrder}">${i}</a>
	 				</li>
				</c:forEach>
				<c:if test="${pp.endPage < pp.totalPage}">
					<li class="page-item"><a class="page-link" href = "${path}/prCardList.do?pageNum=${pp.endPage+1}&sortOrder=${sortOrder}">다음</a></li>
				</c:if>
			</c:if>
		</c:if>
	</ul>
	</div>
	
</div>
</body>
</html>