<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>

<!-- 글 삭제 confirm 창 띄우기 -->
<script>
	
	function del(commReNo, commNo) {
		alert("댓글이 삭제 되었습니다");
			var formData = "commReNo=" + commReNo + "&commNo=" + commNo;
				$.post("commReDelete.do", formData, function(data) {
					$('#commReList').html(data);				
		});
	}
</script>


<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form>
		<table >
			<tr align="center" >
				<th>작성자</th>
				<th>내용</th>
				<th></th>
				<th colspan="2">댓글 작성일</th> 댓글 갯수 : ${reTotal }
			</tr>
			<c:forEach var="commReList" items="${commReList}">
				<c:if test="${commReList.commReDelYn != 'N' }">
					<!-- 컨트롤에서 공유되는  -->
					<tr>

						<!-- 작성자 -->
						<td>${commReList.commReId}&nbsp;&nbsp;</td>




						<!-- 내용 -->
						
							<td id=" ${commReList.commReNo}">${commReList.commReText}&nbsp;&nbsp;</td>
						
						
						
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						
						<!-- 수정일 -->
						<td><fmt:formatDate value="${commReList.commReDate}"
								pattern="MM. dd. HH:mm " /></td>


						<c:if test="${commReList.commReId == sessionScope.userId}">
						<td>
							<!-- 버튼 --> <input type="button" value="삭제"
							onclick="del(${commReList.commReNo},${commReList.commNo})">
						</td>
						</c:if>
				</c:if>

				</tr>
			</c:forEach>
		</table>
	</form>
</body>
</html>