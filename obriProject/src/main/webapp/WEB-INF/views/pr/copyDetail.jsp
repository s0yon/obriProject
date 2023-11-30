<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE HTML>
<%

%>
<html>
<head>
<title>홍보 상세 페이지</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<%-- 		<link rel="stylesheet" href="${path}/assets/css/main.css" /> --%>
<%-- <script src="${path}/assets/js/jquery.min.js"></script> --%>

<!-- 기존에 건 -->
<!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->

<!-- 추가를 위한것 -->

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
	
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>

<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script> -->

<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css"> -->



<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>


<!-- 검색한 버전  -->
</head>

<style>
.innerPrDetailInner {
	padding: 0 6em 0.1em 6em;
	margin: 0 auto;
	max-width: 70em;
	margin-top: 50px;
	background-color: #E6E6FA;
}

.prDetailImage {
	margin-left: 20px;
	background-color: #FFFFFF; /* 배경색을 하얀색으로 지정 */
	border-radius: 8px; /* 모서리를 8px만큼 둥글게 만듭니다. */
	/*      	position: relative; */
}

.prDetailImage .imga {
	/*     	position: absolute; */
	width: 100%;
	height: 100%;
	object-fit: cover; /* 이미지 비율 유지 및 부모 요소에 꽉 차게 표시 */
	border-radius: 8px; /* 이미지 모서리 둥글게 만들기 */
	padding-right: 20px; /* 오른쪽에만 20px의 패딩 추가 */
}

.prDetailSub {
	margin-left: 40px;
	background-color: #FFFFFF; /* 배경색을 하얀색으로 지정 */
	border-radius: 8px; /* 모서리를 8px만큼 둥글게 만듭니다. */
	position: relative;
}

.prDetailSub>h3 {
	padding-top: 20px;
}

.prDetailSub>h3>span {
	float: right;
	margin-right: 20px;
}

.chatBtn {
	background-color: purple; /* 보라색 배경색 */
	width: 200px; /* 원하는 가로 크기(px로 지정) */
	color: white; /* 글자색을 흰색으로 지정 (선택 사항) */
}

.col {
	background-color: #FFFFFF; /* 배경색을 하얀색으로 지정 */
	border-radius: 8px; /* 모서리를 8px만큼 둥글게 만듭니다. */
}

.basic {
	background-color: #FFFFFF; /* 배경색을 하얀색으로 지정 */
	border-radius: 8px; /* 모서리를 8px만큼 둥글게 만듭니다. */
}

.basicYoutube {
	background-color: #FFFFFF; /* 배경색을 하얀색으로 지정 */
	border-radius: 8px; /* 모서리를 8px만큼 둥글게 만듭니다. */
}
</style>

<script>
	/* 콘트롤러에서 가져온 데이터들은 jquery 안에서 선언해주면 안된다. 다른되서 못쓴다. */
	let sessionId = '<%=request.getAttribute("id")%>';
	let userId = '${map['USERID']}';
	let PageNum = '${pageNum}';
	let prLikeStatus = '${prLikeStatus}';
	
	$(document).ready(function() {
		if(sessionId == userId){ // 로그인 아이디와 상세페이지 등록자 아이디가 같으면
			$("#updelButton").show();
		} else {
			console.log("들어왔나?1");
			$("#updelButton").hide();
		}
		
		console.log("라이크status"+ prLikeStatus);
		console.log(${map['PRNO']});
		console.log("세션IDID"+ sessionId);
		
		let likeImageEle = $("#likeImage");
		
		 if (prLikeStatus == 'N') {
			 	console.log("여기가 NN");
			 	likeImageEle.attr("src", "${path}/images/pr/prLikeBlack.png");
		    } else {
		    	console.log("여기가 YY");
		    	likeImageEle.attr("src", "${path}/images/pr/prLikeColor.png");
		    }
	
	});
	
	function prDelete(prNo){
		
		console.log("번호"+ prNo);
		
		if(confirm("삭제 하시겠습니까??") == true){
			location.href = '${path}/prDetailDelete.do?pageNum=${pageNum}&prNo='+prNo;
		}else {
			return false;
		}
	}
	
 	function prLike(){
 		//likeImage
 		  let likePrNo = ${map['PRNO']};
 	      let likeUserId = sessionId;
  	  	  let jsonData = { prNo : likePrNo,
 					       userId : likeUserId 
	 				     };
 		
	  $.ajax({
			method: "POST",
			url: "prLike.do",
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(jsonData),
			
		}).done(function(data) {
			 let likeImageElement = $("#likeImage");

			 if (data.prLike == 'Y') { // Y 이면 좋아요
			      likeImageElement.attr("src", "${path}/images/pr/prLikeColor.png");
			 } else { // N 이면 좋아요 취소
			      likeImageElement.attr("src", "${path}/images/pr/prLikeBlack.png");
			 }
		});
	}
 	
		
	</script>

<body class="is-preload">
	페이지 : ${pageNum}

	<!-- Wrapper -->
	<div id="wrapper">
		<input type="hidden" value="${map['PRNO']}" /> <input type="hidden"
			value="${map['USERID']}" id="detailId" />
		<!-- 				Main -->
		<div id="main">
			<div class="innerPrDetailInner">

				<!-- 							Content -->
				<section>
					<header class="main" style="padding-top: 20px;">
						<h1>Elements</h1>
					</header>

					<div class="row">
						<div class="col-6 col-12-small prDetailImage">
							<img src="<%=request.getContextPath() %>/upload/${map['PRFILE']}"
								class="imga" alt="사진들어갈곳" />
						</div>
						<div class="col-5 col-11-small prDetailSub">

							<h3>${map['USERNM']}<span><img id="likeImage"
									class="likeImage" src="${path}/images/pr/prLikeBlack.png"
									onclick="prLike()"> </span>
							</h3>

							<div>활동지역 : ${map['PRLOC']}</div>
							<br>
							<div>좋아요수 : 오브레수 :</div>
							<br>
							<br>
							<br>
							<div>
								<button class="chatBtn" type="button" data-toggle="modal" data-target="#myModal">쪽지보내기</button>
							</div>

						</div>
					</div>

					<hr>

					<div class="box basic">
						<h3>기본 정보</h3>
						<div class=row>
							<p>경력</p>
							<p>${map['PRCAREER']}</p>
						</div>
						<div class=row>
							<p>세부 분야</p>
							<p>${map['USERMAJOR']}</p>
						</div>

					</div>

					<hr>

					<h3>동영상</h3>
					<div class="box basic">
						<div style="width: 100%;">
							<iframe src="https://www.youtube.com/embed/${map['PRVIDEO']}"
								frameborder="0"
								allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
								allowfullscreen style="width: 100%; height: 340px;"></iframe>
						</div>
					</div>

					<hr>

					<div class="box basic">
						<h3>글 내용</h3>
						<div class=row>
							<p>${map['PRTEXT']}</p>
						</div>
					</div>

					<div class="row justify-content-around" id="updelButton">
						<div class="col-4 text-center">
							<a href="prUpdateForm.do?prNo=${map['PRNO']}"
								class="button primary">수정</a>
						</div>
						<div class="col-4 text-center delete">

							<button type="button" class="button"
								onclick="prDelete(${map['PRNO']})">삭제</button>
						</div>
					</div>

				</section>
			</div>
		</div>
	</div>
	
	<!-- Modal -->
	<div class="modal fade" id="myModal" data-backdrop="static"
		data-keyboard="false">
		<div class="modal-dialog modal-xl modal-dialog-centered">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">사진제목</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<img class="card-img-top rounded img-fluid"
						src="images/research/research-1.jpg">
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>

	<!-- modal start -->
	
	<div class="modal fade" id="myModal" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-xl modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">사진제목</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
            <img class="card-img-top rounded img-fluid" src="images/research/research-1.jpg">
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
</div>
	
	<!-- modal end -->

	<!-- Scripts -->

	<script src="${path}/assets/js/browser.min.js"></script>
	<script src="${path}/assets/js/breakpoints.min.js"></script>
	<script src="${path}/assets/js/util.js"></script>
	<script src="${path}/assets/js/main.js"></script>

</body>
</html>