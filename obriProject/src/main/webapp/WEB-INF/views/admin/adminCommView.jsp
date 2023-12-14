<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>커뮤니티</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/admin/adminNav.css"
	type="text/css">
<style>
body {
    display: flex;
	justify-content: center;
	font-family: Arial, sans-serif;
	background-color: #F8F9FA;
	color: #444;
	padding-top: 80px;
	padding-bottom: 80px;
}
td {
	height: 400px;
}

.container input[type="button"] {
	margin-bottom: 10px;
	margin-left: 5px;
	float: right;
}
</style>
    <!-- 자동 줄바꿈 -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var contentElement = document.querySelector('#consub');
            var contentText = contentElement.innerText || contentElement.textContent;
          
            var formattedContent = formatText(contentText, 60);
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
    <!-- 자동 줄바꿈 -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var contentElement = document.querySelector('#content');
            var contentText = contentElement.innerText || contentElement.textContent;
          
            var formattedContent = formatText(contentText, 90);
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
	<div class="container-fluid">
		<div class="row">
			<!-- 사이드바 부분 -->
			<c:import url="/WEB-INF/views/admin/adminsidenav.jsp" />

			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
			<div class="container-sm">
				<h2 class="qnatitle">커뮤니티</h2>
				<br> <br>
				<table id="qnatable" class="table">
					<tr class="table-active">
						<th scope="col" style="width: 60%" id="consub">
						<c:out value="${map['COMMSUB']}" /></th>
						<th scope="col" style="width: 40%" class="text-right">
								조회수 : <c:out value="${map['COMMRCOUNT']}" />
						</th>
					</tr>
					<tr class="table-active">
						<th scope="col" style="width: 60%" id="consub">
						<c:out value="${map['USERNAME']}(${map['USERID']})" /></th>
						<th scope="col" style="width: 40%" class="text-right">
								<fmt:formatDate value="${map['COMMDATE']}" pattern="yyyy-MM-dd" />
						</th>
					</tr>
					<tr>
						<td colspan=2 id="content">${map['COMMTEXT']}</td>
					</tr>
				</table>

				<div id="menu">
					<input type="button" value="삭제" class="btn btn-outline-secondary"
						data-bs-toggle="modal" data-bs-target="#commDelete" /> <input
						type="button" value="목록" class="btn btn-outline-secondary"
						onclick="location='admin_comm.do?pageNum=${pageNum}'" />
				</div>
				</div>
			</main>
		</div>
	</div>

	<!-- 모달 -->
	<!-- Modal -->
	<div class="modal fade" id="commDelete" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">삭제 하시겠습니까?</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">이 작업은 되돌릴 수 없습니다.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger"
						onclick="location.href='admin_job_delete.do?commNo=${commNo}&pageNum=${pageNum}'">처리완료</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>