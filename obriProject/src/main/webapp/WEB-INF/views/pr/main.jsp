<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<%
		// 세션에 id 속성을 설정
		String userId = "kakao"; // 여기에 실제 사용자 아이디 값을 설정
		HttpSession idsession = request.getSession();
		idsession.setAttribute("id", userId);
	%>
	
	<table>
		<caption>메인</caption>
		<tr>
			<th> <a href="prCardList.do">홍보리스트</a> </th>
			<th> <a href="prInsertForm.do">홍보작성폼</a> </th>
		</tr>	
	</table>
	
</body>
</html>