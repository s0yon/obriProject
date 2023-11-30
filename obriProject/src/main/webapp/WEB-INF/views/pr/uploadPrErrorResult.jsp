<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${result == 1}">
	<script>
		alert("사진은 100KB 까지 업로드가 가능합니다.");
		history.go(-1);
	</script>
</c:if>

<c:if test="${result == 2}">
	<script>
		alert("첨부파일은 jpg, gif, png 파일만 업로드가 가능합니다.");
		history.go(-1);
	</script>
</c:if>   
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>