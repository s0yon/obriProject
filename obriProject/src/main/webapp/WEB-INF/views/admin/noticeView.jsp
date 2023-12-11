<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 사용자 정의 스타일 -->
<link rel="stylesheet" href="./css/viewpage.css">
</head>
<body>
	<!-- 헤더부분 부분 -->
	<c:import url="/WEB-INF/views/navbar.jsp" />
	<main>
		<div class="container-sm">
			<h1>공지사항</h1>
			<table>
				<tr>
					<th class="text-left">
						<c:out value="${map['NOTSUB']}" /><br>
						<c:out value="${map['ADMINNAME']}" />
					</th>
					<th class="text-right">조회수 : 
						<c:out value="${map['NOTRCOUNT']}" /><br>
						<fmt:formatDate value="${map['NOTDATE']}" pattern="yyyy-MM-dd" />
					</th>
				</tr>
				<tr>
					<td colspan=2>
						<pre>${map['NOTTEXT']}</pre>
					</td>
				</tr>
			</table>
		</div>
		
		<div class="button">
			<input type="button" class="ok_button" value="목록"
				onclick="location='notice_list.do?page=${page}'"/>
		</div>
	</main>
	</div>
	</div>
	<%@include file="../footer.jsp"%>
</body>
</html>