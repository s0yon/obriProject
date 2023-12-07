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
		var commReNoCheckboxes = document.getElementsByName("commReNo");
		
		for (var i = 0; i < commReNoCheckboxes.length; i++) {
			commReNoCheckboxes[i].checked = selectAllCheckbox.checked;
        }
	}

	function deleteReComm() {
		delReNoList = document.querySelectorAll("[type=checkbox]:checked");
		
	    if (delReNoList.length === 0) {
	        // 체크박스가 선택되지 않았을 경우
	        alert("삭제할 항목을 선택해주세요.");
	        return;
	    }
		
		let commReNo = "";
		delReNoList.forEach((checkbox) => {
			commReNo += checkbox.value + ',';
		});
		
		commReNo = commReNo.substr(0, commReNo.length-1);
		console.log(commReNo);
		
		deleteReplyComm.action = "deleteReplyComm.do";
		deleteReplyComm.commReNo.value = commReNo;
		deleteReplyComm.submit();
	}
</script>
</head>

<div id="wrap">
	<div id="pp_wrap">
		<div class="pp_menu">
			<p class="pp_title">커뮤니티 글 관리</p>
			<ul>
				<li class="pp_position"><a href="commWroteAll.do">작성 글</a></li>
				<li class="pp_proposal"><a href="commReplyWrote.do">작성 댓글</a></li>
				<li class="pp_position"><a href="likeListsComm.do">좋아요 한 글</a></li>
			</ul>
		</div>

		<div class="pp_contents">
			<p class="pp_sub_title">작성 댓글</p>
			<div class="pp_search">
				<form name="searchProposal" action="commReplyWrote.do">
					<input id="keyword" type="text" placeholder="글 제목 검색" name="keyword"
					 value="${sessionScope.referer != null ? sessionScope.referer.keyword : ''}">
					<%-- <input type="hidden" name="id" value="${commReplysVO.id}" /> --%>
					<button class="btn_search" type="submit"></button>
				</form>
			</div>
			
			<!-- 삭제버튼 -->
			<div class="pp_search">
				<div class="cp_item_bot_Left">
					<a href="#" class="cp_wanted_modify" id="deleteReCommBtn" onclick="deleteReComm()">선택 삭제</a>
				</div>			
			</div>

			<div>
				<form action="deleteReplyComm.do" name="deleteReplyComm" id="deleteReplyComm">
					<table class="pp_table">
						<thead>
							<tr>
								<th><input type="checkbox" id="selectAll" onclick="toggleAllCheckboxes()"></th>
								<th>작성한 댓글 내용</th>
								<th>댓글단 글 제목</th>
								<th>댓글수</th>
								<th>댓글 수정(작성)일</th>
								<th>수정</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="commReplyInfoVOs" items="${commReplysVO.commReplyInfoVOs}">
								<tr>
									<td>
										<label>
											<input type="checkbox" name="commReNo" value="${commReplyInfoVOs.commReNo}">
											<span style="font-size: 12px"></span>
										</label>
									</td>								
									<td><a href="?commReNo=${commReplyInfoVOs.commReNo}">${commReplyInfoVOs.commReText}</a></td>
									<td>${commReplyInfoVOs.commSub}</td>
									<td><p class="cnt_highlight">${commReplyInfoVOs.commreplyCnt}</p></td>
									<td>${commReplyInfoVOs.commReUpdate}</td>
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