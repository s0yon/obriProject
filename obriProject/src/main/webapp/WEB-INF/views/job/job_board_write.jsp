<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>구인</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- 사용자 정의 스타일 -->
<link rel="stylesheet" href="./css/viewpage.css">

<script src="./js/board/job_write_board.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	function openDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				document.getElementById('jobAddress').value = data.address;
			}
		}).open();
	}
</script>
</head>
<body class="bg-body-tertiary">
	<c:import url="/WEB-INF/views/navbar.jsp" />
	<div class="container-sm">
		<main>
			<div class="d-flex justify-content-between my-3 py-3 border-bottom">
				<h3 class="font-weight-bold text-dark">구인</h3>
			</div>
			<form method="post" action="write_ok.do" onSubmit="return check()">
				<input type="hidden" name="userId" value="${userId}">
				<table>
					<tr>
						<th>모집인원</th>
						<td>
							<div class="row">
								<div class="col-sm-7">
									<input type="text" name="jobSpace" class="form-control"
										placeholder="숫자만 입력">
								</div>
								<div class="col-sm-2">
									<input type="text" readonly class="form-control-plaintext"
										value="명">
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<th>모집마감일</th>
						<td><input type="date" name="jobEndDate1"
							class="form-control col-sm-8"></td>
					</tr>
					<tr>
						<th>행사일</th>
						<td><input type="date" name="jobConcert1"
							class="form-control col-sm-8"></td>
					</tr>
					<tr>
						<th>장소</th>
						<td>
							<div class="row">
								<div class="col-sm-8">
									<input type="text" class="form-control" id="jobAddress"
										name="jobAddress" placeholder="'주소찾기'를 통해 입력해주세요">
								</div>
								<div class="col-sm-2">
									<input type="button" class="btn" value="주소찾기"
										style="font-size: 14px; font-weight: bold;"
										onClick="openDaumPostcode()">
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<th>분류</th>
						<td><input type="radio" name="jobCd" id="e1" value="결혼식">&nbsp;결혼식&nbsp;&nbsp;
							<input type="radio" name="jobCd" id="e2" value="종교행사">&nbsp;종교행사&nbsp;&nbsp;
							<input type="radio" name="jobCd" id="e3" value="공연">&nbsp;공연&nbsp;&nbsp;
							<input type="radio" name="jobCd" id="e4" value="기타">&nbsp;기타&nbsp;&nbsp;
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input type="text" class="form-control col-sm-10"
							id="jobSub" name="jobSub"></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea cols="60" rows="10" class="form-control"
								id="jobText" name="jobText"></textarea></td>
					</tr>
				</table>
				<div align="center">
					<tr>
						<td colspan="2" align="center"><input type="submit"
							class="btn" value="작성" id="submitButton">&nbsp;&nbsp;<input
							type="button" value="목록" class="btn"
							onclick="location.href='joblist.do'"></td>
					</tr>
				</div>
			</form>
		</main>
	</div>
	<!-- footer -->
	<c:import url="/WEB-INF/views/footer.jsp" />
</body>
</html>