<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="music.model.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 게시판</title>
<link rel="stylesheet" href="./css/mainTable.css">
<script src="https://kit.fontawesome.com/8c929515d1.js"
	crossorigin="anonymous"></script>
<script>
function showlist(){
	window.parent.location.href='boardList.do';
}
</script>
</head>
<body>
	<table>
		<tr>
			<th>제목</th>
			<th>작성자</th>
			<th>날짜</th>
			<th><i class="fas fa-light fa-eye"></i></th>
			<th><i class="fas fa-light fa-thumbs-up"></i></th>
		</tr>
		<tbody>
			<c:forEach var="community" items="${list}">
				<c:if test="${community.commDelYn != 'Y'}">
					<tr align="center">
						<td align="center"><fmt:formatDate var="today"
								value="<%=new Date()%>" pattern="yy/MM/dd" /> <fmt:formatDate
								var="dbtoday" value="${community.commDate}" pattern="yy/MM/dd" />
							<a
							href="javascript:showlist();">
								${community.commSub} <!-- 조회수 30 이상이면  --> <c:if
									test="${dbtoday == today}">
									<img alt="" src="images/new.png" width="20" height="10">
								</c:if>
						</a></td>
						<td>${community.userId}</td>
						<td><fmt:formatDate value="${community.commDate}"
								pattern="yyyy년 MM월 dd일" /></td>
						<td>${community.commCount}</td>
						<td>${community.likeCnt}</td>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>