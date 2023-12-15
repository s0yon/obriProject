<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<title>커뮤니티</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Font Awesome -->
<script src="https://kit.fontawesome.com/8c929515d1.js"></script>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-latest.js"></script>

<!-- 부트스트랩 JS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- 사용자 정의 스타일 -->
    <link rel="stylesheet" href="./css/viewpage.css">

</head>

<body class="bg-body-tertiary">
	<!-- header -->
	<c:import url="/WEB-INF/views/navbar.jsp" />
	<div class="container-sm">
		<main>
			<div class="d-flex justify-content-between my-3 py-3 border-bottom">
				<h3 class="font-weight-bold text-dark">커뮤니티</h3>
			</div>
			<form method=post action="boardUpdate.do"
				enctype="multipart/form-data">
				<input type="hidden" name="commNo" value="${community.commNo}">
				<input type="hidden" name="pageNum" value="${pageNum}">
				<table>
					<tr>
						<th>작성자</th>
						<td><input type=text name="userId" class="form-control" 
							value=" ${community.userId}" readonly></td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input type=text name="commSub" class="form-control" required
							value=" ${community.commSub } "></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea cols="70" rows="10" class="form-control" name="commText" id="commText"
								required>${community.commText} </textarea> <br>
						<br></td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td><input class="form-control" type="file" name="com_file1"
							id="com_file1"></td>
					</tr>
				</table>
				<div align="center">
					<tr>
						<td colspan=2 align=center><input type=submit value="수정"
							id="submitButton" class="btn"> <input type="button"
							class="btn" value="목록" onclick="location.href='boardList.do' ">
						</td>
					</tr>
				</div>
				</form>
			</div>
		</main>
	</div>
	<!-- footer -->
	<c:import url="/WEB-INF/views/footer.jsp" />
</body>
</html>