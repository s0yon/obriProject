<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="music.model.jobBoardVO"%>
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

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	var jobFin = '${jobboard.jobFin}'
</script>
<script src="./js/board/job_edit_board.js"></script>
<script>
	$(function() {
		$("#jobFin").click(function() {
			if ($("#jobFin").is(":checked")) {
				$(this).val("Y");
			} else {
				$(this).val("N");
			}
		});
		var jobFinValue = "${jobboard.jobFin}";
		if (jobFinValue == 'Y') {
			$("#jobFin").prop('readonly', true);
			$("#jobFin").prop('checked', true);
			$("#jobFin").prop('disabled', true);
		}
	});
</script>
<script>
	$(function() {
		var jobCdValue = "${jobboard.jobCd}";

		// jobCd에 해당하는 라디오 버튼을 체크
		$("input[name='jobCd'][value='" + jobCdValue + "']").prop('checked',
				true);
	});
</script>
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
			<form method="post" action="edit_ok.do" onSubmit="return check()">
				<input type="hidden" name="userId" value="${jobboard.userId}">
				<input type="hidden" name="jobNo" value="${jobboard.jobNo}">
				<input type="hidden" name="pageNum" value="${pageNum}"> <input
					type="hidden" id="fin" value="${jobboard.jobFin}">
				<table>
					<tr>
						<th colspan="2"><input type="checkbox" id="jobFin"
							name="jobFin1" value="N">&nbsp;행사완료&nbsp;
						</td>
					</tr>
					<tr>
						<th>모집인원</th>
						<td>
							<div class="row">
								<div class="col-sm-7">
									<input type="text" id="jobSpace" name="jobSpace"
										class="form-control" value="${jobboard.jobSpace}">
								</div>
								<div class="col-sm-2">
									<input type="text" readonly class="form-control-plaintext"
										value="명">
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<th>모집 마감일</th>
						<td><input type="date" id="jobEndDate2" name="jobEndDate2"
							class="form-control col-sm-8"></td>
					</tr>
					<tr>
						<th>행사일</th>
						<td><input type="date" id="jobConcert2" name="jobConcert2"
							class="form-control col-sm-8"></td>
					</tr>
					<tr>
						<th>장소</th>
						<td>
							<div class="row">
								<div class="col-sm-8">
									<input type="text" class="form-control" id="jobAddress"
										name="jobAddress" value="${jobboard.jobAddress}">
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
						<td><div class="col-sm-10">
								<input type="text" class="form-control" id="jobSub"
									name="jobSub" value="${jobboard.jobSub}">
							</div></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea cols="60" rows="10" class="form-control"
								id="jobText" name="jobText">${jobboard.jobText}</textarea></td>
					</tr>
				</table>
				<div align="center">
					<tr>
						<td colspan="2" align="center"><input type="submit"
							class="btn" value="수정" id="submitButton">&nbsp;&nbsp;<input
							type="button" value="취소" class="btn" onclick="history.go(-1);"></td>
					</tr>
				</div>
			</form>
		</main>
	</div>
	<!-- footer -->
	<c:import url="/WEB-INF/views/footer.jsp" />
</body>
</html>