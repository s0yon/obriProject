<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<title>구인</title>
<meta charset="UTF-8">
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

<style>
.pagination {
    display: flex;
    justify-content: center;
    list-style: none;
    padding: 0;
}

.pagination li {
    margin: 0 5px;
}

.pagination .page-link {
    display: block;
    padding: 8px 16px;
    text-decoration: none;
    color: #333;
    background-color: #eee;
    border: 1px solid #ddd;
    border-radius: 4px;
  }

.pagination .page-link:hover {
    background-color: #ddd;
  }

.pagination .active .page-link {
    background-color: #007bff;
    color: #fff;
    border: 1px solid #007bff;
  }
</style>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="http://maps.googleapis.com/maps/api/js"></script>
<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDEM3FEmY5ecJzAkXH9TDRAs1MaXpSWtME"
	type="text/javascript"></script>
<script>
	var lat = '${lat}'
	var lng = '${lng}'
	var pageGingPage;
	var rowUserId;

	var myCenter = new google.maps.LatLng(lat, lng);
	//var myCenter=new google.maps.LatLng(37.497975, 127.027506);
	var marker;

	function initialize() {
		var mapProp = {
			center : myCenter,
			zoom : 16,
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};

		var map = new google.maps.Map(document.getElementById("googleMap"),
				mapProp);

		var marker = new google.maps.Marker({
			position : myCenter,
		});

		marker.setMap(map);
	}

	google.maps.event.addDomListener(window, 'load', initialize);

	// 댓글
	$(function() {
		console.log("넘버"+${jobboard.jobNo});
// 		console.log("패스"+ ${path});
 		$('#rlist').load('${path}/rlist/jobNo/${jobboard.jobNo}/let.do')
// 		$.get('${path}/rlist/jobNo/${jobBoard.jobNo}/let.do', function(data) {
//      $('#rlist').html(data);
//    	});
 		
 		/* 모달안에 있는 신청자 리스트 .load div = #appList 로 appList에 있는 내용을 가져오기 */
 		// $("#appList").load('${path}/appList/jobNo/${jobBoard.jobNo}/let.do')
 		 		 		
		$('#reInsert').click(function() {
			if(!reform.jobReText.value){
				alert('댓글을 입력해주세요.');
				reform.jobReText.focus();
				return false;
			}
			var reformData = $('form').serialize();
			$.post('${path}/rInsert.do', reformData, function(data) {
				$('#rlist').html(data);
				reform.jobReText.value= '';
			});
		});
 				
	});
</script>
<script>
<!-- 모달 창 뜨고 리스트 조회  -->
function jobAppModalPage(currentPage) {
      console.log("현재페이지 +"+currentPage);
      pageGingPage = currentPage;

      $.get('${path}/jobAppList.do',{ pageNum: pageGingPage, jobNo: '${jobboard.jobNo}' }, function(data){
    	    console.log(data);
    	    console.log(data.pp.currentPage);
    	    console.log(data.pp.rowPerPage);
    	    makeApp(data);   // 리스트 출력   
    	    movePage(data); // 페이지 이동
    	}).fail(function(error) {
    	    console.error('Ajax 요청 실패:', error);
    	});
        
         function makeApp(data){
        	 // 페이지 이동시 내용을 삭제 하기 위한 처리
        	 $('#applist table tr#rowApp').remove();
            $.each(data.appList, function(index, app){
            	
               var row = $('<tr id="rowApp">');
                  row.append('<td>' +app.APPNO+ '</td>');
                  row.append('<td>' +app.USERID+'</td>');
                  row.append('<td>'+app.USERNAME+'</td>');
                  row.append('<td>'+app.USERMAJOR+'</td>');
//                row.append('<td>'+app.APPCHECK+'</td>');
				  row.append("<td><input type=\"button\" value=\"확정\" id=\"appCheck" + app.APPNO + "\" " + (app.APPCHECK === 'Y' ? 'disabled' : '') + " onclick=\"confirmApp(" + app.JOBNO + "," + app.APPNO + ",'" +app.USERID+ "')\"></td>");						  
                  row.append('<td>'+ '<input type="button" value="취소" onclick="cancelApp(' + app.JOBNO + ',' + app.APPNO + ')">' + '</td>');// 	                      
                  row.append("<td><button type=\"button\" id=\"msgModal\" class=\"btn btn-primary\" data-bs-toggle=\"modal\" data-bs-target=\"#appMsgModal\" onclick=\"prepareMessageModal('" +app.USERID+ "', '" +app.USERNAME+ "')\">쪽지</button></td>");

                  $('#applist table').append(row);
                           
            });
         } // end makeApp
         
  function movePage(data){        
        	 
       // 기존 페이지 제거
       	   $('ul').remove();
        	 	
       var mPage = $('<ul class="pagination" id="appPage" >');
          if (data.pp.startPage > data.pp.pagePerBlk) {
             var previousButton = $('<li class="page-item"><a class="page-link" onclick="jobAppModalPage(' + (data.pp.startPage - 1) + ')">Previous</a></li>');
             mPage.append(previousButton);
          }
          for (var i = data.pp.startPage; i <= data.pp.endPage; i++) {
              var pageButton = $('<li class="page-item' + (data.pp.currentPage == i ? ' active' : '') + '"><a class="page-link" href="#" onclick="jobAppModalPage(' + i + ')">' + i + '</a></li>');
              mPage.append(pageButton);
          }

          if (data.pp.endPage < data.pp.totalPage) {
               var nextButton = $('<li class="page-item"><a class="page-link" href="#" onclick="jobAppModalPage(' + (pp.endPage + 1) + ')">Next</a></li>');
               mPage.append(nextButton);
          }
               mPage.append('</ul>');
            // paginationContainer를 적절한 위치에 추가 또는 대체하도록 로직 추가
               $('#modalPage').append(mPage);
            
         }// end movePage
         
  } // end jobAppModalPage 
  
  // 구인 확정
  function confirmApp(jobNo,appNo , appUserId){
	  
	  console.log("아아아 "+appUserId);
		let formData="jobNo="+jobNo+"&appNo="+appNo+"&userId="+appUserId;
		console.log("구인확정"+formData);
  		$.post("${path}/jobApplySend.do",formData,function(data){
  			console.log("성공");
  			$('#appCheck'+appNo).prop('disabled', true); // 해당 버튼 비활성화
		}).fail(function () {
	        console.log("실패");
	    });
	  }
  
  // 구인 취소
  function cancelApp(jobNo,appNo){ 
	let formData="jobNo="+jobNo+"&appNo="+appNo;
		console.log("구인취소"+formData);
  		$.post("${path}/confirmAppCancel.do",formData,function(data){
//  			$('#rlist').html(data);
		console.log("취소 성공");
		// 다시 재조회 해서 취소한 부분이 없어지도록 하기
		jobAppModalPage(pageGingPage);
  		}).fail(function (){
  			console.log("취소 실패");
  		});
	  }
  
// 쪽지 버튼 클릭
  function prepareMessageModal(userId, userName){
   console.log("쪽지 클릭");
   $("#receiver").val(userName);
   rowUserId = userId;
   console.log("줄의 아이디"+rowUserId);
   }
	  function message(){
		  let msgText = $("#msgText").val();
		  
		  if ($.trim($("#msgText").val()) == "") {
			alert("메세지를 입력하세요!");
			$("#msgText").val("").focus();
			return false;
		  }
		  
	console.log(msgText);
//   		  rowUserId = userId; 
	  console.log("정말되요?"+'<%=request.getAttribute("userId")%>');
	  console.log(rowUserId);
		  let jsonData = {
				userId : '<%=request.getAttribute("userId")%>',
				recvId : rowUserId,
				msgText : msgText
		  };
		  
		$.ajax({
			method: "POST",
			url: "msgInsert.do",
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(jsonData),
		
		}).done(function(data) {
		
			console.log(data);
				if(data == 1){
					alert("전송 성공하였습니다.");
					// 쪽지 전송 성공 시 모달 닫기
//					$("#appMsgModal").modal('hide');
					// 위에 $("#appMsgModal").modal('hide'); 안먹혀서 
					document.getElementById('appMsgModal').style.display = 'none';
				document.body.classList.remove('modal-open'); // 배경 어두움 제거
				document.querySelector('.modal-backdrop').remove(); // 배경 요소 제거

				}else {
					alert("전송 실패하였습니다.");
				}
		});
	  }
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
	<c:import url="/WEB-INF/views/navbar.jsp" />
	<div class="container-sm">
		<main>
			<div class="d-flex justify-content-between my-3 py-3 border-bottom">
				<h3 class="font-weight-bold text-dark">구인</h3>
			</div>
			<table>
				<thead>
					<tr class="row">
						<th class="col-7 text-start pl-5" id="consub">${jobboard.jobSub}</th>
						<th class="col-3">작성일 : <fmt:formatDate
								value="${jobboard.jobDate}" pattern="yyyy-MM-dd" /></th>
						<th class="col-2">조회수 : ${jobboard.jobRcount}</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="text-start pl-5">작성자 : ${jobboard.userId}</td>
					</tr>
					<tr>
						<td class="text-start pl-5">모집마감일 : <fmt:formatDate
								value="${jobboard.jobEndDate}" pattern="yyyy-MM-dd" /></td>
					</tr>
					<tr>
						<td class="text-start pl-5">행사일 : <fmt:formatDate
								value="${jobboard.jobConcert}" pattern="yyyy-MM-dd" /></td>
					</tr>
					<tr>
						<td>
							<div class="row">
								<div class="col-sm-10 pl-5 ml-1 align-self-center">모집인원 :
									${jobboard.jobSpace} 명 (${appTotal}/${jobboard.jobSpace})</div>
								<div class="col-sm-1 apply-button">
									<c:if test="${!empty sessionScope.userId}">
										<c:if test="${sessionScope.userId != jobboard.userId}">
											<input type="button" class="btn" data-bs-toggle="modal"
												data-bs-target="#jobApply" value="신청"
												style="font-size: 14px; font-weight: bold;">
										</c:if>
										<c:if test="${sessionScope.userId == jobboard.userId}">
											<input type="button" class="btn" data-bs-toggle="modal"
												data-bs-target="#jobAppModal" onclick="jobAppModalPage(1)"
												value="신청자" style="font-size: 14px; font-weight: bold;">
										</c:if>
									</c:if>

								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td class="text-start pl-5">분류 : ${jobboard.jobCd}</td>
					</tr>
					<tr>
						<td class="text-start pl-5" height="200px" id="content"><pre
								style="white-space: pre-line;">${jobboard.jobText}</pre></td>
					</tr>
					<tr>
						<td class="col d-flex align-items-center flex-column mt-2">
							<div class="row align-self-center">장소 :
								${jobboard.jobAddress}</div>
							<div class="row align-self-center" id="googleMap"
								style="width: 400px; height: 250px; margin-top: 20px; margin-bottom: 20px;">
							</div>
						</td>
					</tr>
					<tr>
						<td class="text-center"><c:if
								test="${sessionScope.userId == jobboard.userId && !empty sessionScope.userId}' ">
								<div id="jobboard_menu" class="menu-buttons mb-3">
									<div class="menu-button-group=">
										<input type="button" value="수정" class="btn"
											onClick="location='job_board_view.do?jobNo=${jobboard.jobNo}&pageNum=${pageNum}&state=edit'">
										<input type="button" class="btn" value="삭제"
											data-bs-toggle="modal" data-bs-target="#jobDel">
									</div>
								</div>
							</c:if></td>
					</tr>
				</tbody>
			</table>
			<div align="right">
				<input type="button" value="목록" class="btn"
					style="margin-right: 10px;"
					onClick="location='joblist.do?pageNum=${pageNum}'">
			</div>

			<!-- 쪽지 모달 -->
			<div class="modal fade" id="appMsgModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true"
				style="z-index: 1055;">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">New message</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form>
								<div class="mb-3">
									<label for="recipient-name" class="col-form-label">수신자:</label>
									<input type="text" class="form-control" id="receiver" readonly>
								</div>
								<div class="mb-3">
									<label for="message-text" class="col-form-label">Message:</label>
									<textarea class="form-control" id="msgText"></textarea>
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Close</button>
							<button type="button" class="btn btn-primary" id="msgSend"
								onclick="message()">쪽지 보내기</button>
						</div>
					</div>
				</div>
			</div>

			<!-- 신청자 보기 모달 -->
			<!-- Modal -->
			<div class="modal fade" id="jobAppModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true"
				style="z-index: 1050;">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">신청자 목록</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div id="applist" align="center">
								<table>
									<tr>
										<td>신청번호</td>
										<td>신청자ID</td>
										<td>신청자이름</td>
										<td>전공</td>
									</tr>
								</table>
							</div>

							<!-- pagination -->
							<div class="pageDiv my-custom-page">
								<!-- Pagination -->
								<nav aria-label="Page navigation example" class="pagination" id="modalPage"></nav>
							</div>
							<!-- pagination 끝 -->
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>

			<!-- 삭제 모달 -->
			<!-- Modal -->
			<div class="modal fade" id="jobDel" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">삭제하시겠습니까?</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">이 작업은 되돌릴 수 없습니다.</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-danger"
								onclick="location.href='job_board_del.do?jobNo=${jobboard.jobNo}&pageNum=${pageNum}'">삭제</button>
						</div>
					</div>
				</div>
			</div>

			<!-- 신청 모달 -->
			<!-- Modal -->
			<div class="modal fade" id="jobApply" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">해당 구인글에
								신청하시겠습니까?</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							신청후 취소할 수 없습니다. <br> 신청하시려면 아래 신청 버튼을 눌러주세요.
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-lg btn-primary"
								onclick="location.href='jobApplySend.do?jobNo=${jobboard.jobNo}&userId=${sessionScope.userId}&pageNum=${pageNum}'">신청</button>
						</div>
					</div>
				</div>
			</div>
			<br> <br>

			<div id="rlist" align="center"></div>
			<div align="center" id="commRe">
				<form id="reform" name="reform">
					<input type="hidden" name="userId" value="${sessionScope.userId}">
					<input type="hidden" name="jobNo" value="${jobboard.jobNo}">
					<textarea rows="4" cols="80" name="jobReText" id="jobReText"
						placeholder="댓글을 작성하세요"></textarea>
					<div id="jobReSession">
						<c:if test="${!empty sessionScope.userId}">
							<input type="button" value="댓글" class="btn" id="reInsert">
						</c:if>
					</div>
				</form>
			</div>
		</main>
	</div>
	<!-- footer -->
	<c:import url="/WEB-INF/views/footer.jsp" />
</body>
</html>