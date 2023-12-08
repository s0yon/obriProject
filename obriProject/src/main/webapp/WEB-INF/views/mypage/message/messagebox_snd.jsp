<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp"%>

<head>
<link href="${path}/css/mypage/proposal.css?after" rel="stylesheet">

<!-- 메시지 관련 js파일 -->
<script src="${path}/js/mypage/message.js"></script>

<script type="text/javascript">
	function toggleAllCheckboxes() {
		var selectAllCheckbox = document.getElementById("selectAll");
		var msgNoCheckboxes = document.getElementsByName("msgNo");
		
		for (var i = 0; i < msgNoCheckboxes.length; i++) {
			msgNoCheckboxes[i].checked = selectAllCheckbox.checked;
        }
	}

	function deleteMsgRcv() {
		delRcvMsgNoList = document.querySelectorAll("[type=checkbox]:checked");
		
	    if (delRcvMsgNoList.length === 0) {
	        // 체크박스가 선택되지 않았을 경우
	        alert("삭제할 항목을 선택해주세요.");
	        return;
	    }
		
		let msgNo = "";
		delRcvMsgNoList.forEach((checkbox) => {
			msgNo += checkbox.value + ',';
		});
		
		msgNo = msgNo.substr(0, msgNo.length-1);
		console.log(msgNo);
		
		deleteMsgRcv.action = "deleteMsg.do";
		deleteMsgRcv.msgNo.value = msgNo;
		deleteMsgRcv.submit();
	}
</script>

<style type="text/css">
.cp_item_bot {
	width: 100%;
	text-align: center;
}

.cp_item_bot_Left {
	width: 100%;
	text-align: left;
}

.cp_item_bot .cp_wanted_modify {
	font-size: 12px;
	color: rgb(64, 64, 64);
	line-height: 2em;
	text-align: center;
	border: 1px solid rgb(190, 190, 190);
	border-radius: 4px;
	padding: 5px;
	box-sizing: border-box;
}

.cp_item_bot_Left .cp_wanted_modify {
	font-size: 12px;
	color: rgb(64, 64, 64);
	line-height: 2em;
	text-align: center;
	border: 1px solid rgb(190, 190, 190);
	border-radius: 4px;
	padding: 5px;
	box-sizing: border-box;
}
</style>
</head>

<div id="wrap">
	<div id="pp_wrap">
		<div class="pp_menu">
			<p class="pp_title">쪽지함</p>
			<ul>
				<li class="pp_position"><a href="messagebox_rcv.do">받은 쪽지</a></li>
				<li class="pp_proposal"><a href="messagebox_snd.do">보낸 쪽지</a></li>
			</ul>
		</div>


		<div class="pp_contents">
			<p class="pp_sub_title">보낸 쪽지함</p>
			<!-- 내용 검색창 -->
			<div class="pp_search">
				<form name="searchProposal" action="messagebox_snd.do">
					<input id="keyInTxt" type="text" placeholder="쪽지내용 검색"
						name="keyInTxt"
						value="${sessionScope.referer != null ? sessionScope.referer.keyInTxt : ''}">
					<button class="btn_search" type="submit"></button>
				</form>
			</div>

			<!-- 삭제버튼 -->
			<div class="pp_search">
				<div class="cp_item_bot_Left">
					<a href="#" class="cp_wanted_modify" id="deleteReCommBtn"
						onclick="deleteReComm()">선택 삭제</a>
				</div>
			</div>

			<div>
				<table class="pp_table">
					<thead>
						<tr>
							<th><input type="checkbox" id="selectAll"
								onclick="toggleAllCheckboxes()"></th>
							<th>받는 사람</th>
							<th>쪽지 내용</th>
							<th>보낸 날짜</th>
							<th>수신 확인/미확인</th>
							<th>삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="messageInfoVOs"
							items="${pagingMsgSndListVO.messageInfoVOs}">
								<tr>
									<td><label> <input type="checkbox" name="check_msgno"
											value="${messageInfoVOs.msgNo}"> <span
											style="font-size: 12px"></span>
									</label></td>
										<td>${messageInfoVOs.rcvUserId}</td>
										<td>${messageInfoVOs.msgContents}</td>
									<td>${messageInfoVOs.msgDate}</td>
									<td><c:choose>
											<c:when test="${messageInfoVOs.isCheck == 0}">
												<p class="notyet">미확인</p>
											</c:when>
											<c:when test="${messageInfoVOs.isCheck == 1}">
												<p class="checked">확인</p>
											</c:when>
											<c:otherwise>
												<p class="notyet">미확인</p>
											</c:otherwise>
										</c:choose></td>
									<td>
										<div class="cp_item_bot">
											<a href="#" class="cp_wanted_modify">삭제</a>
										</div>
									</td>
								</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			<!-- 페이징 설정 -->
			<div class="paging">
				<ul class="pagaination">
					<!-- 맨 처음 페이지로 이동 -->
					<li class="page-item-prev"><a
						href="messagebox_snd.do?page=0&keyInTxt=${empty param.keyInTxt ? '' : param.keyInTxt}">◀◀</a>
					</li>
	
					<!-- 첫 페이지 인지 확인 -->
					<c:if test="${pagingMsgSndListVO.pagingVO.currentPage eq 0}">
						<li class="page-item-prev-hidden">이전</li>
					</c:if>
					<c:if test="${pagingMsgSndListVO.pagingVO.currentPage > 0}">
						<li class="page-item-prev"><a
							href="messagebox_snd.do?page=${pagingMsgSndListVO.pagingVO.currentPage - 1}&keyInTxt=${empty param.keyInTxt ? '' : param.keyInTxt}">이전</a>
						</li>
					</c:if>
	
					<c:forEach var="num" begin="${pagingMsgSndListVO.pagingVO.startPageNum}"
						end="${pagingMsgSndListVO.pagingVO.lastPageNum}">
						<c:choose>
							<c:when test="${num == pagingMsgSndListVO.pagingVO.currentPage + 1}">
								<li class="page-item-select">[${num}]</li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a
									href="messagebox_snd.do?page=${num-1}&keyInTxt=${empty param.keyInTxt ? '' : param.keyInTxt}"">[${num}]</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
	
					<!-- 마지막 페이지인지 확인 -->
					<c:if
						test="${pagingMsgSndListVO.pagingVO.totalPage eq pagingMsgSndListVO.pagingVO.currentPage + 1}">
						<li class="page-item-next-hidden">다음</li>
					</c:if>
					<c:if
						test="${pagingMsgSndListVO.pagingVO.totalPage != pagingMsgSndListVO.pagingVO.currentPage + 1}">
						<li class="page-item-next"><a
							href="messagebox_snd.do?page=${pagingMsgSndListVO.pagingVO.currentPage + 1}&keyInTxt=${empty param.keyInTxt ? '' : param.keyInTxt}">다음</a>
						</li>
					</c:if>
	
					<!-- 마지막 페이지로 이동 -->
					<li class="page-item-next"><a
						href="messagebox_snd.do?page=${pagingMsgSndListVO.pagingVO.totalPage - 1}&keyInTxt=${empty param.keyInTxt ? '' : param.keyInTxt}">▶▶</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>


<%@ include file="../layout/footer.jsp"%>