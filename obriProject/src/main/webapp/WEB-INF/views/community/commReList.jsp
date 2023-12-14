<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<!-- 글 삭제 confirm 창 띄우기 -->
<script>
	
	function del(commReNo, commNo) {
		if(confirm("댓글을 삭제 하시겠습니까?") == true){
			alert("댓글이 삭제 되었습니다");
		var formData = "commReNo=" + commReNo + "&commNo=" + commNo;
		$.post("commReDelete.do", formData, function(data) {
			$('#commReList').html(data);				
	});
		}else{
			alert("취소되었습니다");
			return false;
		}
			
	}
</script>
    <!-- 자동 줄바꿈 -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var contentElement = document.querySelector('#retext');
            var contentText = contentElement.innerText || contentElement.textContent;
          
            var formattedContent = formatText(contentText, 70);
            contentElement.innerHTML = formattedContent;

            function formatText(text, length) {
                var result = '';
                for (var i = 0; i < text.length; i += length) {
                    result += text.slice(i, i + length) + '<br>';
                }
                return result;
            }
        });
    </script>
<style>
.link-style {
	font-size: 13px;
	text-decoration: none;
}

</style>


<script src="http://code.jquery.com/jquery-latest.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form>
		<table>
		<caption class="text-start pl-5">댓글 갯수 : ${reTotal}</caption>
	
			<c:forEach var="commReList" items="${commReList}">
				<c:if test="${commReList.commReDelYn  != 'Y'}">
				
				<!-- 1.비로그인 상태 -->
				<!--  sessionScope.userId != commReList.commReId && sessionScope.userId !=sessionScope.adminId && -->
					<c:if test="${commReList.commSecret  == 'Y' &&  empty sessionScope.userId}">
						<tr>	
							<td colspan="2">
									<img src="images/secret.png"  width="25" height="25">비밀댓글입니다
							</td>
						</tr>
					</c:if>
					
					<!--2. 로그인(작성자 or 관리자)  -->
  					<c:if test="${commReList.commSecret  == 'Y' &&  sessionScope.userId == commReList.commReId  &&  !empty sessionScope.userId}"> 
							<tr>	 
									<td><img src="images/secret.png"  width="20" height="20">
									${commReList.commReId}&nbsp;
									<c:if test="${commReList.commReId == sessionScope.userId}"> 
									<a href="#" class="redit link-style" onclick="del(${commReList.commReNo},${commReList.commNo})">삭제</a>
 									</c:if> 
									</td> 
									<td class="text-right">
									<fmt:formatDate value="${commReList.commReDate}"  pattern="yyyy.MM.dd HH:mm" />
									</td>
							</tr>
							<tr>
									<td colspan="2" id=" ${commReList.commReNo}">${commReList.commReText}</td>
							</tr> 
 					</c:if> 

					<!-- 3.로그인(작성자, 관리자가 아닌 경우) -->
					<c:if test="${commReList.commSecret  == 'Y'  &&  sessionScope.userId  != commReList.commReId &&  !empty sessionScope.userId}">
						<tr>	
							<td colspan="2">
									<img src="images/secret.png"  width="25" height="25">비밀댓글입니다
							</td>
						</tr>
					</c:if>
					
					<!-- 4. 비밀글이 아닌경우 -->										
					<c:if test="${commReList.commSecret != 'Y'}">
					<tr>
						<td>${commReList.commReId}&nbsp;
						<c:if test="${commReList.commReId == sessionScope.userId}">
						<a href="#" class="redit link-style" onclick="del(${commReList.commReNo},${commReList.commNo})">삭제</a>
						</c:if>
						</td>
						<td class="text-right">
						<fmt:formatDate value="${commReList.commReDate}"    pattern="yyyy.MM.dd HH:mm" /></td><!-- 수정일 -->					
						</tr>
						<tr>
						<td colspan="2" id=" retext">${commReList.commReText}&nbsp;&nbsp;</td><!-- 내용 -->
					</tr>					
				</c:if>
				
 			</c:if> 
			</c:forEach>
		</table>
	</form>
</body>
</html>