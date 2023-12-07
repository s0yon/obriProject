<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>신청자 리스트</title>
<meta charset="utf-8">

<script>
	function toggleAllCheck(){
		var checkboxes = document.getElementsByName('selectedList');
	}

</script>

</head>
<body>

<table>
	<tr>
		<td><input type="checkbox" id="toggleCheckBox" onchange="toggleAllCheck()"></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	<c:forEach>
	<tr>
	</tr>
	</c:forEach>
</table>




jobNo 게시글번호
appName 게시글명
appNo 신청자수
userId 신청자아이디
appCheck 승인처리
appDone 완료처리
appDelYn 취소처리

</body>
</html>