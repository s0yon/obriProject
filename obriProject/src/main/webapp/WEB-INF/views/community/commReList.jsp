<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>

<!-- 글 삭제 confirm 창 띄우기 -->
<script>
	
	function del(commReNo, commno) {
		alert("댓글이 삭제 되었습니다");
			var formData = "commReNo=" + commReNo + "&commno=" + commno;
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
		<table>
			<tr>
				<th>작성자</th>
				<th>내용</th>
				<th>댓글 작성일</th> 댓글 갯수 : ${reTotal }
			</tr>
			<c:forEach var="commReList" items="${commReList}">
				<c:if test="${commReList.commReDelYn != 'N' }">
					<!-- 컨트롤에서 공유되는  -->
					<tr>

						<!-- 작성자 -->
						<td>${commReList.commReId}</td>




						<!-- 내용 -->
						
							<td id=" ${commReList.commReNo}">${commReList.commReText}</td>
						
						
						
						
						
						<!-- 수정일 -->
						<td><fmt:formatDate value="${commReList.commReDate}"
								pattern="MM월 dd일 HH:mm EEE요일" /></td>


						<c:if test="${commReList.commReId == sessionScope.userId}">
						<td>
							<!-- 버튼 --> <input type="button" value="삭제"
							onclick="del(${commReList.commReNo},${commReList.commno})">
						</td>
						</c:if>
				</c:if>

				</tr>
			</c:forEach>
		</table>
	</form>
</body>
</html>