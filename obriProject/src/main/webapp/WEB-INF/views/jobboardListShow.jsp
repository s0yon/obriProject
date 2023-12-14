<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ page import="java.util.*"%>
<%@ page import="music.model.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구인 게시판</title>
<link rel="stylesheet" href="./css/mainTable.css">
<script src="https://kit.fontawesome.com/8c929515d1.js"
	crossorigin="anonymous"></script>
<script>
	function showlist() {
		window.parent.location.href = 'joblist.do';
	}
</script>
</head>
<body>
	<table>
		<tr>
			<th width="50%">제목</th>
			<th width="20%">작성자</th>
			<th width="20%">날짜</th>
			<th width="10%"><i class="fas fa-light fa-eye"></i></th>
		</tr>
		<c:forEach var="job" items="${joblist}">
			<tr>
				<td width="50%"><a href="javascript:showlist();">${job['JOBSUB']}</a></td>
				<td width="20%">${job['USERNAME']}</td>
				<td width="20%"><fmt:formatDate value="${job['JOBDATE']}"
						pattern="yyyy-MM-dd" /></td>
				<td width="10%">${job['JOBRCOUNT']}</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>