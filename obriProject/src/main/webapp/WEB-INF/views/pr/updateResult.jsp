<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<c:if test="${result == 1}">
	<script>
		alert("수정 성공");
// 		location.href="noticecontent.do?not_no=${board.not_no}&page=${page}"; //상세 페이지
		location.href="prDetail.do?prNo=${prNo}&pageNum=${pageNum}"; // 상세페이지 인데 페이징 추가 해야함 
	</script>
</c:if>

<c:if test="${result != 1}">
	<script>
		alert("수정 실패");
		history.go(-1);
	</script>
</c:if>

</body>
</html>