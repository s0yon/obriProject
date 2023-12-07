<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<head>
<link href="${path}/css/mypage/proposal.css?after" rel="stylesheet">

<script src="${path}/js/mypage/commWroteList.js"></script>

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

<script type="text/javascript">
	function toggleAllCheckboxes() {
		var selectAllCheckbox = document.getElementById("selectAll");
		var commNoCheckboxes = document.getElementsByName("commNo");
		
		for (var i = 0; i < commNoCheckboxes.length; i++) {
            commNoCheckboxes[i].checked = selectAllCheckbox.checked;
        }
	}

	function deleteComm() {
		delNoList = document.querySelectorAll("[type=checkbox]:checked");
		
	    if (delNoList.length === 0) {
	        // 체크박스가 선택되지 않았을 경우
	        alert("삭제할 항목을 선택해주세요.");
	        return;
	    }
		
		let commNo = "";
		delNoList.forEach((checkbox) => {
			commNo += checkbox.value + ',';
		});
		
		commNo = commNo.substr(0, commNo.length-1);
		console.log(commNo);
		
		deleteComm.action = "deleteComm.do";
		deleteComm.commNo.value = commNo;
		deleteComm.submit();
	}
</script>

</head>

<div id="wrap">
	<div id="pp_wrap">
		<div class="pp_menu">
			<p class="pp_title">커뮤니티 글 관리</p>
			<ul>
				<li class="pp_proposal"><a href="commWroteAll.do">작성 글</a></li>
				<li class="pp_position"><a href="commReplyWrote.do">작성 댓글</a></li>
				<li class="pp_position"><a href="likeListsComm.do">좋아요 한 글</a></li>
			</ul>
		</div>

		<div class="pp_contents">
			<p class="pp_sub_title">작성 글</p>
			<div class="pp_search">
				<form name="searchProposal" action="commWroteAll.do">
					<input id="keyword" type="text" placeholder="글 제목 검색" name="keyword" value="${sessionScope.referer != null ? sessionScope.referer.keyword : ''}">
					<%-- <input type="hidden" name="id" value="${commsVO.id}" /> --%>
					<button class="btn_search" type="submit"></button>
				</form>
			</div>
			
			<!-- 삭제버튼 -->
			<div class="pp_search">
				<div class="cp_item_bot_Left">
					<a href="#" class="cp_wanted_modify" id="deleteCommBtn" onclick="deleteComm()">선택 삭제</a>
				</div>			
			</div>

			<div>
				<form action="deleteComm.do" name="deleteComm" id="deleteComm">
					<table class="pp_table">
						<thead>
							<tr>
								<th><input type="checkbox" id="selectAll" onclick="toggleAllCheckboxes()"></th>
								<th>글 제목</th>
								<th>글 내용</th>
								<th>조회수</th>
								<th>댓글수</th>
								<th>좋아요 수</th>
								<th>글 수정일</th>
								<th>수정</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="commInfoVOs" items="${commsVO.commInfoVOs}">
								<tr>
									<td><label> <input type="checkbox" name="commNo" value="${commInfoVOs.commNo}"> <span style="font-size: 12px"></span>
									</label></td>
									<td><a href="#?commNo=${commInfoVOs.commNo}">${commInfoVOs.commSub}</a></td>
									<td>${commInfoVOs.commText}</td>
									<td>${commInfoVOs.commCount}</td>
									<td><p class="cnt_highlight">${commInfoVOs.replyCnt}</p></td>
									<td><p class="cnt_highlight">${commInfoVOs.likeCnt}</p></td>
									<td>${commInfoVOs.commUpdate}</td>
									<td>
										<div class="cp_item_bot">
											<a href="#" class="cp_wanted_modify">수정</a>
										</div>
									</td>
									<td>
										<div class="cp_item_bot">
											<a href="#" class="cp_wanted_modify">삭제</a>
										</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</form>
			</div>
		</div>
	</div>
</div>

<%@ include file="../layout/footer.jsp"%>