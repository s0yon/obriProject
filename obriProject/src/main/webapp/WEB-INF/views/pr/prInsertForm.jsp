<%@page import="org.springframework.web.context.annotation.SessionScope"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%
// 세션에서 userId 속성 가져오기
String userId = (String) session.getAttribute("userId");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.84.0">

<title>홍보</title>

<link rel="canonical"
	href="https://getbootstrap.com/docs/5.0/examples/checkout/">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<!-- Bootstrap core CSS -->
<%-- 	<link href="${path}/css/bootstrap.min.css" rel="stylesheet"> --%>
<!-- 사용자 정의 스타일 -->
<link rel="stylesheet" href="./css/prwrite.css">
<script type="text/javascript">
	function inputNumberOnly(el) {
		el.value = el.value.replace(/[^0-9]/g, '');
	}

	// 	validation check
	function pr_check() {

		// 글제목 validation		
		if ($.trim($("#prSub").val()) == "") {
			alert("글제목이 비어있습니다.");
			$("#prSub_span").hide();
			$("#prSub").focus();
			return false;
		}

		// 해쉬태그 validation
		if ($.trim($("#prHash").val()) != "") {

			const hash = $.trim($("#prHash").val());
			const hashNumber = hash.split('#').length - 1;
			const first = hash.substr(0, 1);
			const last = hash.substr(-1);

			if (first != "#") {
				$("#hashTagSpan").text("처음에 #을 붙이셔야 합니다.");
				$("#prHash").focus();
				return false;
			} else if (last == "#") {
				$("#hashTagSpan").text("해쉬태그를 입력하시거나 지우셔야 합니다.");
				$("#prHash").focus();
				return false;
			} else if (hashNumber > 3) {
				$("#hashTagSpan").text("해쉬태그는 최대 3개 까지만 가능합니다.");
				$("#prHash").focus();
				return false;
			}
		}

		// 글 내용 validation
		if ($.trim($("#prText").val()) == "") {
			$("#prText").focus();
			$("label[for='floatingTextarea2']").text("글내용이 비었습니다.").css(
					"color", "#ff0000");
			return false;
		}

		if ($.trim($("#prVideo").val()) != "") {
			let url = $("#prVideo").val();
			console.log(url);

			// YouTube 동영상 URL에 대응하는 정규표현식
			let regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;

			// 정규표현식과 매칭하여 결과를 match 배열에 저장
			let match = url.match(regExp);

			console.log("매치" + match);
			console.log("매치2" + match[2]);
			// 매칭이 성공하고 비디오 ID가 11자인 경우 ID를 반환, 그렇지 않으면 false
			if (match && match[2].length == 11) {
				console.log(match[2]);
				$("#prVideo").val(match[2]);
			} else {
				alert("유튜브링크가 올바르지 않습니다. 다시확인해주세요.");
				$("#prVideo").focus();
				return false;
			}
		}
	}
</script>
</head>
<body class="bg-body-tertiary">
	<!-- header -->
	<c:import url="/WEB-INF/views/navbar.jsp" />
	<div class="container-sm">
		<main>
			<div class="d-flex justify-content-between my-3 py-3 border-bottom">
				<h3 class="font-weight-bold text-dark">나만의 커리어로 자신을 알리세요.</h3>
			</div>
			<div class="my-3 py-3">
				<div>
					<form action="pr_insert_ok.do" method="post"
						onsubmit="return pr_check()" enctype="multipart/form-data">
						<input type="hidden" name="userId" value="<%=userId%>" />
						<div class="row g-3">
							<div class="container">
								<label for="pr_subLabel" class="form-label">글제목</label><input
									type="text" class="form-control" id="prSub" name="prSub"
									placeholder="나를 한마디로 표현하세요">
							</div>
							<div class="col-sm-6">
								<label for="pr_careerLabel" class="form-label">경력(년)</label> <input
									type="text" class="form-control" id="prCareer" name="prCareer"
									oninput="inputNumberOnly(this)">
								<!--               <div class="invalid-feedback"> -->
								<!--                 Valid first name is required. -->
								<!--               </div> -->
							</div>
							<div class="col-sm-6">
								<label for="pr_locLabel" class="form-label">지역</label> <input
									type="text" class="form-control" id="prLoc" name="prLoc">
							</div>
							<div class="col-12">
								<!-- mb-3 -->
								<label for="formFile" class="form-label pr_fileImage">이미지
									업로드</label> <input class="form-control pr_file1" type="file"
									id="prFile1" name="prFile1">
							</div>
							<div class="col-12">
								<div class="form-floating">
									<textarea class="form-control"
										placeholder="Leave a comment here" id="prText" name="prText"
										style="height: 250px"></textarea>
									<label for="floatingTextarea2">자기소개 글</label>
								</div>
							</div>
							<div class="col-12">
								<label for="hashTag" class="form-label pr_fileImage">해쉬태그</label>
								<span class="pr_span" id="hashTagSpan"></span>
								<div class="input-group has-validation">
									<span class="input-group-text">#</span> <input type="text"
										class="form-control" id="prHash" name="prHash"
										placeholder="해쉬태그는 최대 3개까지 등록 가능합니다">
								</div>
							</div>
							<div class="col-12">
								<label for="youtube" class="form-label">유튜브링크</label> <input
									type="text" class="form-control" id="prVideo" name="prVideo"
									placeholder="ex) https://www.youtube.com/watch?v=7ou0pne7EfY 링크를 넣습니다">
								<!--               <div class="invalid-feedback"> -->
								<!--                 Please enter a valid email address for shipping updates. -->
								<!--               </div> -->
							</div>

							<button type="submit" class="btn mt-5 mx-auto" >등록</button>

						</div>
					</form>
				</div>
			</div>
		</main>
	</div>
	<!-- footer -->
	<c:import url="/WEB-INF/views/footer.jsp" />
</body>
</html>