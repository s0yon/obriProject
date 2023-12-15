<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>커뮤니티</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="http://code.jquery.com/jquery-latest.js"></script>

    <!-- 사용자 정의 스타일 -->
    <link rel="stylesheet" href="./css/viewpage.css">

    <!-- 로그인 확인 -->
    <script>
        var sessionId = '<%=(String) session.getAttribute("userId")%>';
        console.log("세션ID "+sessionId);

        $(document).ready(function() {
            if(sessionId === "null"){
                console.log("여기들감?");
                $("#comReInsert").hide();
                $("#commReSession").hide();
            } else {
                $("#comReInsert").show();
                $("#commReSession").show();
            }
        });
    </script>

    <!-- 글 삭제 confirm 창 띄우기 -->
    <script>
        function deleteCheck() {
            if (confirm("정말로 삭제하시겠습니까?") == true) {
                location.href = "boardDelete.do?commNo=${community.commNo}&page=${page}"
            } else {
                alert("취소되었습니다.");
                return false;
            }
        }
    </script>

    <!-- 좋아요 -->
    <script>
        console.log("session:", '${sessionScope.userId}');
        console.log("userId:", '${community.userId}');

        function commLikeButton(state) {
            if (${empty sessionScope.userId}) {
                alert("로그인이 필요한 서비스입니다!");
                location.href="login.do";
                return false;
            } else if ($.trim('${sessionScope.userId}') == $.trim('${community.userId}')) {
                alert("자신의 글은 선택할 수 없습니다");
                return false;
            } else {
                var result = confirm("좋아요를 선택하시겠습니까?");
                if(result){
                    location.href="comLike.do?commNo=${community.commNo}&pageNum=${pageNum}&state="+state;
                    return false;
                }
            }
        }
    </script>

    <!--  댓글  -->
    <script>
        // 리스트 불러오기
        jQuery(document).ready(function($) {
            $('#commReList').load('commReList.do?commNo=${community.commNo}')

            // 댓글창 유효성 검사
            $('#comReInsert').click(function () {
                if (!comForm.commReText.value) {
                    alert('댓글 입력 후에 클릭하세요');
                    comForm.commReText.focus();
                    return false;
                } else {
                    alert("댓글 작성 완료");
                }

                // 댓글 입력, 입력후
                var formData = $('#comForm').serialize();	    // serialize() : 아래의 form태그를 읽어옴
                $.post('commReInsert.do', formData, function (data) {
                    $('#commReList').html(data);
                    comForm.commReText.value = '';
                });
            });

        });
    </script>

    <!-- 자동 줄바꿈 -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var contentElement = document.querySelector('#consub');
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
        <script>
        document.addEventListener('DOMContentLoaded', function() {
            var contentElement = document.querySelector('#content');
            var contentText = contentElement.innerText || contentElement.textContent;
          
            var formattedContent = formatText(contentText, 82);
            contentElement.innerHTML = formattedContent;

            function formatText(text, length) {
                // 기존 줄바꿈을 유지하도록 수정
                var lines = text.split('\n');
                var result = '';
                for (var i = 0; i < lines.length; i++) {
                    result += lines[i].slice(0, length) + '<br>';
                }
                return result;
            }
        });
    </script>
</head>
<body class="bg-body-tertiary">
    <!-- header -->
    <c:import url="/WEB-INF/views/navbar.jsp" />
    <div class="container-sm">
        <main>
			<div class="d-flex justify-content-between my-3 py-3 border-bottom">
				<h3 class="font-weight-bold text-dark">커뮤니티</h3>
			</div>
			<form method=post action="boardDelete.do">
				<div align="center">
					<table>
					<thead>
						<tr>
							<th class="text-start pl-5" id="consub">${community.commSub }</th>
							<th class="text-end pr-5"><fmt:formatDate
								value="${community.commUpdate }" pattern="yyyy-MM-dd" /></th>
						</tr>
						</thead>
						<tbody>
						<tr>
							<td colspan="2" class="text-start pl-5">작성자 : ${community.userId}</td>
						</tr>
						<tr>
						<td colspan="2" class="text-start pl-5">조회수 : <c:out
								value="${community.commCount}" /></td>
						</tr>
						<tr>
							<td colspan="2" class="text-start pl-5" height="300px" id="content">
							<pre style="white-space: pre-line;">${Content}</pre>
							</td>
						</tr>
						<c:if test="${community.commFile != null}">
						<tr>
							<td colspan="2" class="text-start pl-5"><img
									src="<%=request.getContextPath() %>/upload/${community.commFile}"
									width="200" height="200" /></td>
						</tr>
						</c:if>
						<tr>
							<td colspan="2" class="text-center"> 좋아요 : ${likeCnt} &nbsp;
								<c:if test="${sessionScope.userId == null}">
									<span id="likeCheck" onClick="commLikeButton()"> <i
										class="fa-regular fa-thumbs-up"></i>
									</span>
								</c:if>
								<c:if test="${sessionScope.userId != null}">
									<!-- 좋아요 여부에 따른 이미지 출력 -->
									<c:if test="${state == 'Y' }">
										<span id="likeCheck" onClick="commLikeButton('Y')"> <i
											class="fa-solid fa-thumbs-up"></i>
										</span>
									</c:if>
									<c:if test="${state == 'N' ||  empty state }">
										<span id="likeCheck" onClick="commLikeButton('N')"> <i
											class="fa-regular fa-thumbs-up"></i>
										</span>
									</c:if>
								</c:if></td>
						</tr>
						</tbody>
					</table>
				</div>

				<div id="boardContent_menu" class="body-menu" align="right" style="margin-right:10px;">
						<input type="button" value="목록"
								onClick="location.href='boardList.do?pageNum=${pageNum}'"
								class="btn">
							<c:if
								test="${fn:trim(sessionScope.userId) ==  fn:trim(community.userId) }">
								<input type="button" value="수정" class="btn"
									onClick="location.href='boardUpdateForm.do?commNo=${community.commNo}&pageNum=${pageNum}'">
							<input type="button" class="btn" value="삭제"
									onClick="deleteCheck()">
							</c:if>
				</div>
			</form>
			<br><br>
			
			<div id="commReList" align="center"></div>
			<div align="center" id="commRe">
				<form name="comForm" id="comForm">
					<input type="hidden" name="commReId" value="${sessionScope.userId }">
					<input type="hidden" name="commNo" value="${community.commNo} ">
					<textarea rows="4" cols="80" name="commReText" placeholder="댓글을 작성하세요"></textarea>
					<div id="commReSession">
						<input type="button" value="댓글" id="comReInsert" class="btn">
						&nbsp; 
						<input type="checkbox" name="commSecret" id="commSecret">비밀댓글
					</div>
				</form>
			</div>
		</main>
	</div>
	<c:import url="/WEB-INF/views/footer.jsp" />
</body>
</html>