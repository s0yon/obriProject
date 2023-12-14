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
<script src="./js/job_edit_board.js"></script>
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
<!-- <style>
table tr td {
	text-overflow: ellipsis;
	white-space: nowrap;
	max-width: 140px;
}

table {
	margin-left: auto;
	margin-right: auto;
}

textarea {
	width: 98%;
	border: none;
	resize: none;
}
</style>
 -->
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
						<td colspan="2"><input type="checkbox" id="jobFin"
							name="jobFin1" value="N">공연후 체크</td>
					</tr>
					<tr>
						<th width="40px">모집인원</th>
						<td width="480px"><input type="text" id="jobSpace"
							name="jobSpace" class="form-control" size="4"
							value="${jobboard.jobSpace}">명</td>
					</tr>
					<tr>
						<th width="40px">모집 마감일</th>
						<td width="480px"><input type="date" id="jobEndDate2"
							name="jobEndDate2"></td>
					</tr>
					<tr>
						<th width="40px">행사일</th>
						<td width="480px"><input type="date" id="jobConcert2"
							name="jobConcert2"></td>
					</tr>
					<tr>
						<th width="40px">장소</th>
						<td width="480px"><input type="text" id="jobAddress"
							name="jobAddress" value="${jobboard.jobAddress}"> <input
							type="button" value="주소검색" onClick="openDaumPostcode()">
						</td>
					</tr>
					<tr>
						<th width="40px">분류</th>
						<td width="480px"><input type="radio" name="jobCd" id="e1"
							value="결혼식">결혼식<input type="radio" name="jobCd" id="e2"
							value="종교행사">종교행사<input type="radio" name="jobCd"
							id="e3" value="공연">공연<input type="radio"
							name="jobCd" id="e4" value="기타">기타</td>
					</tr>
					<tr>
						<th width="40px">제목</th>
						<td width="480px"><textarea class="form-control" rows="3"
								cols="500" width="140px" id="jobSub" name="jobSub">${jobboard.jobSub}</textarea></td>
					</tr>
					<tr>
						<th width="40px">내용</th>
						<td width="480px"><textarea class="form-control" rows="20"
								cols="4000" width="140px" id="jobText" name="jobText">${jobboard.jobText}</textarea>
						</td>
					</tr>
				</table>
				<div align="center">
					<tr>
						<td colspan="2" align="center"><input type="submit"
							class="btn" value="수정"> <input type="button" class="btn"
							value="취소" onClick="history.go(-1);"></td>
					</tr>
				</div>
			</form>
		</main>
	</div>
	<!-- footer -->
	<c:import url="/WEB-INF/views/footer.jsp" />
</body>
</html>