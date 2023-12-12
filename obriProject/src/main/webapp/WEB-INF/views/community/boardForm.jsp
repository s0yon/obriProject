<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>커뮤니티 게시판 글 작성</title>


<link rel="stylesheet" href="./css/header.css">

<script src="https://kit.fontawesome.com/8c929515d1.js"
	crossorigin="anonymous"></script>

<style>
/* 버튼을 원하는 위치로 이동 */
#submitButton {
	margin-top: 20px; /* 상단 여백 조정 */
	margin-left: 10px; /* 왼쪽 여백 조정 */
	background-color: purple;
	color: white;
}

#title {
	color: purple;
}
</style>
<link rel="stylesheet" href="./css/viewpage.css">
</head>
<body>
	<c:import url="/WEB-INF/views/navbar.jsp" />
	<div class="container-sm">
		<main>
			<h2 id="title" align=center>글작성</h2>
			<form method=post action="boardWrite.do"
				enctype="multipart/form-data">
				<table border=1 align=center>
					<tr>
						<th>작성자</th>
						<td><input type="text" name="userId" id="userId" 
							value="${fn:trim(sessionScope.userId)}" readonly="readonly"></td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input type="text" name="commSub" id="commSub" required></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea cols=40 rows=10 name="commText" id="commText"
								required></textarea> <br>
						<br></td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td><input type="file" name="com_file1" id="com_file1"></td>
					</tr>
				</table>
				<div align="center">
					<tr>
						<td colspan=2 align=center><input type=submit value="글올리기"
							id="submitButton"> <input type="button" value="목록으로"
							onclick="location.href='boardList.do' "></td>
					</tr>
				</div>
			</form>
		</main>
	</div>
	<!-- footer -->
	<c:import url="/WEB-INF/views/footer.jsp" />
</body>
</html>