<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="http://code.jquery.com/jquery-latest.js"></script>

<script type="text/javascript">
console.log("왜안돼??");
console.log("여기 들어왔나요???");

	$(function(){
		// 수정 버튼 클릭
		// .load 모든것을 가져오는것
		$('.redit').click(function(){
			console.log("클릭할때 떠야해");
			var id = $(this).attr('id');
			var jobNo = $(this).attr('data-jobNo');

			var text = $('#td_'+id).text();
			$('#td_'+id).html("<textarea rows='5' cols='60' id='tt_"+id+"'>"
							  			 +text+"</textarea>");
			$('#btn_'+ id).html( // 안의 내용을 바꾸는거 .html은
				"<input type='button' value='확인' onclick='reUp("+id+","+jobNo+")'> "
			   +"<input type='button' value='취소' onclick='rstop("+jobNo+")'>");	
		});
	});
	
	function reUp(id,jobNo){  // 수정 버튼
		console.log("수정은 들어왔니?");
		var jobReText = $('#tt_'+ id).val();
		var formData = "jobReNo="+id+'&jobReText='+jobReText
			+"&jobNo="+jobNo;
			$.post('${path}/reUpdate.do',formData, function(data) {
				$('#rlist').html(data);
			});
	}
	function rstop(jobNo) { // 취소 버튼
		$('#rlist').load('${path}/rlist/jobNo/'+jobNo+'/let.do');
	}
	function del(jobReNo,jobNo){ // 댓글 삭제
		var formData="jobReNo="+jobReNo+"&jobNo="+jobNo;
		$.post("${path}/reDelete.do",formData,function(data){
			$('#rlist').html(data);
		});
	}		
</script>

<style>
#date_tr1 {
	border-top: 2px solid black;
	border-bottom: 1px solid black;
}

#date_tr2 {
	border-bottom: 1px solid black;
}

.link-style {
	font-size: 13px;
	text-decoration: none;
}

</style>
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
</head>
<body>
	<div class="container" align="center">
		<c:if test="${not empty rlist}">
		</c:if>
		
		
		<table width="650px" cellpadding="10">
			<c:forEach var="jrb" items="${rlist}">
				<tr>
					<td>${jrb.userId}&nbsp;
					<c:if test="${jrb.userId == sessionScope.userId}">
							<a href="#" class="redit link-style" id="${jrb.jobReNo}"
								data-jobNo="${jrb.jobNo}">수정</a> | 
							<a href="#" onclick="del(${jrb.jobReNo},${jrb.jobNo})"
								class="link-style">삭제</a>
					</c:if>
					</td>
					<td class="text-right">
						<fmt:formatDate value="${jrb.jobReUpdate}"    pattern="yyyy.MM.dd HH:mm" />
					</td>					
				</tr>
				<tr>
					<td colspan="2" id="retext">${jrb.jobReText}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>