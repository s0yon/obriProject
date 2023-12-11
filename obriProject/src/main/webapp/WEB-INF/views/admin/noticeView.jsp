<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>공지사항</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="./css/viewpage.css">

</head>
<body>
	<div class="container-sm">
		<div class="row">
            <!-- 헤더부분 -->
            <c:import url="/WEB-INF/views/navbar.jsp" />
			<main>
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
						<h1 class="h2">공지사항</h1>
					</div>
				<table id="nottable" class="table">
					<tr class="table-active">
						<th scope="col" style="width: 60%"><c:out
								value="${map['NOTSUB']}" /><br> <c:out
								value="${map['ADMINNAME']}" /></th>
						<th scope="col" style="width: 40%" class="text-right">
						조회수 : <c:out value="${map['NOTRCOUNT']}" /><br>
						<fmt:formatDate value="${map['NOTDATE']}" pattern="yyyy-MM-dd" />
						</th>
					</tr>

					<tr>
						<td colspan=2><pre>${map['NOTTEXT']}</pre></td>
					</tr>
				</table>
		
		<div class="button">
			<input type="button" class="ok_button" value="목록"
				onclick="location='notice_list.do?page=${page}'"/>
		</div>
	</main>
	</div>
	<!-- footer -->
	<c:import url="/WEB-INF/views/footer.jsp" />
	</div>
</body>
</html>