<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<head>
<%-- <script src="${path}/js/mypage/like.js"></script> --%>

<script>
	var path = "${pageContext.request.contextPath}";
</script>

<script>
		let data = {
		  prcareerCode: "all",
		  prmajorCode: "all",
		  prlocCode: "all",
		  prhashCode: "all",
		  stage: 0,
		};

		$("#btnSearch").click(() => {
		  StringTest();
		});

		function buildWanted(likesWidget) {
		  const pictureSrc = likesWidget.prFile
		    ? `${path}/upload/${likesWidget.prFile}`
		    : "https://picsum.photos/seed/picsum/200/300";

		  return `<div class="wanted">
		  <a href="prDetail.do?prNo=${likesWidget.prNo}">
		        <div class="picture">
		          <img src="${pictureSrc}">
		        </div>
		      <div class="wanted_text">
		          <div class="text">
		              <ul>
		                  <li class="title">
		                      <h2>${likesWidget.prSub}</h2>
		                  </li>
		                  <li class="content">
		                      <p>${likesWidget.prText}</p>
		                  </li>
		              </ul>
		          </div>
		          <div class="company_intro">
		              <p class="company_region">${likesWidget.prCareer}</p>
		              <p class="company_name">${likesWidget.prMajor}</p>
		          </div>
		      </div>
		  </a>
		</div>`;
		}

		function StringTest() {
		  let url = "?";
		  url =
		    url +
		    "prmajorName=" +
		    data.prmajorCode +
		    "&" +
		    "prcareerName=" +
		    data.prcareerCode +
		    "&" +
		    "prlocName=" +
		    data.prlocCode +
		    "&" +
		    "prhashName=" +
		    data.prhashCode;
		  // url 확인 차
		  console.log(1, url);

		  // ajax로 데이터 받음
		  $.ajax("api_likeListsPR.do" + url, {
		    type: "GET",
		    dataType: "json",
		    async: true,
		  }).done((res) => {
		    if (res.code == 1) {
		      console.log(2, res);

		      let likesWidgetList = res.data.likesListPRVOs;
		      $("#wanteds").empty();
		      likesWidgetList.forEach((likesWidget) => {
		        console.log("likesWidgetList for each문 실행");
		        $("#wanteds").prepend(buildWanted(likesWidget));
		      });
		      alert("데이터 검색 성공");
		      //location.href = "/api/wanteds" + queryString;
		    } else {
		      alert("데이터 검색 실패");
		    }
		  });
		}

		function ChangeValue(id) {
		  let element = document.getElementById(id);
		  if (id == "prcareerCode") {
		    data.prcareerCode = element.options[element.selectedIndex].value;
		  }
		  if (id == "prmajorCode") {
		    data.prmajorCode = element.options[element.selectedIndex].value;
		  }
		  if (id == "prlocCode") {
		    data.prlocCode = element.options[element.selectedIndex].value;
		  }
		  if (id == "prhashCode") {
		    data.prhashCode = element.options[element.selectedIndex].value;
		  }
		}
</script>
</head>

<div class="wanteds_page">
	<div class="search_wanted">
		<div class="all_position">
			<div class="select_head">포지션 선택</div>
			<div class="select_all">
				<select class="all" id="positionCode" name="prmajorName" onchange="ChangeValue('positionCode')">
					<option selected >전체 포지션(전공)</option>
					<c:forEach var="PrMajors" items="${PrMajors}">
						<option>${PrMajors.prMajor}</option>
					</c:forEach>
				</select>
			</div>
			<div class="select_position" type="button" id="btnSearch">
				<a><i class="fa fa-search"></i></a>
			</div>
		</div>

		<div class="selects">
			<div class="select_career">
				<select class="career" id="careerCode" name="prcareerName"
						onchange="ChangeValue('careerCode')">
					<option selected>신입/경력</option>
					<c:forEach var="PrCareers" items="${PrCareers}">
						<option>${PrCareers.prCareer}</option>
					</c:forEach>
				</select>
			</div>

			<div class="select_region">
				<select class="region" id="regionCode" name="prlocName"
						onchange="ChangeValue('regionCode')">
					<option selected>지역 선택</option>
					<c:forEach var="PrLocs" items="${PrLocs}">
						<option>${PrLocs.prLoc}</option>
					</c:forEach>
				</select>
			</div>

			<div class="select_skill">
				<select class="skill" id="skillsCode" name="prhashName"
						onchange="ChangeValue('skillsCode')">
					<option selected>해시태그</option>
					<c:forEach var="PrHashes" items="${PrHashes}">
						<option>#${PrHashes.prHash}</option>
					</c:forEach>
				</select>
			</div>

			<div class="selected_skills">
				<ul>
					<li class="selected_skills_items" id="skill1" style="display: none;"><strong class="skill_name" id="skillName1">test1</strong>
						<p class="select_delete" type="button" onclick="hideSkillbutton('skill1')">
							<a>x</a>
						</p></li>
					<li class="selected_skills_items" id="skill2" style="display: none;"><strong class="skill_name" id="skillName2">test2</strong>
						<p class="select_delete" type="button" onclick="hideSkillbutton('skill2')">
							<a>x</a>
						</p></li>
					<li class="selected_skills_items" id="skill3" style="display: none;"><strong class="skill_name" id="skillName3">test3</strong>
						<p class="select_delete" type="button" onclick="hideSkillbutton('skill3')">
							<a>x</a>
						</p></li>
				</ul>
			</div>

			<div class="select_sort">
				<select class="sort">
					<option selected>최신순</option>
					<option>인기순</option>
				</select>
			</div>
		</div>
	</div>

	<div class="overBox">
		<div class="liked">
			<div class="liked_wanted">
				<div class="liked_title">♥ 내가 좋아요한 PR(홍보 글)</div>
				<div class="wanteds">
					<c:forEach var="likesListPRVOs" items="${pagingPrListVO.likesListPRVOs}">
						<div class="wanted">
							<a href="prDetail.do?prNo=${likesListPRVOs.prNo}">
								<div class="picture">
									<c:choose>
										<c:when test="${empty likesListPRVOs.prFile}">
											<img src="https://picsum.photos/seed/picsum/200/300">
										</c:when>
										<c:otherwise>
											<img src="${path}/upload/${likesListPRVOs.prFile}">
										</c:otherwise>
									</c:choose>
								</div>

								<div class="wanted_text">
									<div class="text">
										<ul>
											<li class="title">
												<h2>${likesListPRVOs.prSub}</h2>
											</li>
											<li class="content">
												<p>${likesListPRVOs.prText}</p>
											</li>
										</ul>
									</div>
									<div class="company_intro">
										<p class="company_region">${likesListPRVOs.prCareer}</p>
										<p class="company_name">${likesListPRVOs.prMajor}</p>
									</div>
								</div>
							</a>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>

	<!-- 페이징 설정 -->
	<div class="paging">
		<ul class="pagaination">
			<!-- 맨 처음 페이지로 이동 -->
			<li class="page-item-prev">
				<a href="likeListsPR.do?page=0&prmajorName=${empty param.prmajorName ? 'all' : param.prmajorName}&prcareerName=${empty param.prcareerName ? 'all' : param.prcareerName}&prlocName=${empty param.prlocName ? 'all' : param.prlocName}&prhashName=${empty param.prhashName ? 'all' : param.prhashName}">◀◀</a>
			</li>

			<!-- 첫 페이지 인지 확인 -->
			<c:if test="${pagingPrListVO.pagingVO.currentPage eq 0}">
				<li class="page-item-prev-hidden">이전</li>
			</c:if>
			<c:if test="${pagingPrListVO.pagingVO.currentPage > 0}">
				<li class="page-item-prev"><a
					href="likeListsPR.do?page=${pagingPrListVO.pagingVO.currentPage - 1}&prmajorName=${empty param.prmajorName ? 'all' : param.prmajorName}&prcareerName=${empty param.prcareerName ? 'all' : param.prcareerName}&prlocName=${empty param.prlocName ? 'all' : param.prlocName}&prhashName=${empty param.prhashName ? 'all' : param.prhashName}">이전</a>
				</li>
			</c:if>

			<c:forEach var="num" 
						begin="${pagingPrListVO.pagingVO.startPageNum}" 
						end="${pagingPrListVO.pagingVO.lastPageNum}">
				<c:choose>
					<c:when test="${num == pagingPrListVO.pagingVO.currentPage + 1}">
						<li class="page-item-select">[${num}]</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a href="likeListsPR.do?page=${num-1}&prmajorName=${empty param.prmajorName ? 'all' : param.prmajorName}&prcareerName=${empty param.prcareerName ? 'all' : param.prcareerName}&prlocName=${empty param.prlocName ? 'all' : param.prlocName}&prhashName=${empty param.prhashName ? 'all' : param.prhashName}">[${num}]</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<!-- 마지막 페이지인지 확인 -->
			<c:if test="${pagingPrListVO.pagingVO.totalPage eq pagingPrListVO.pagingVO.currentPage + 1}">
				<li class="page-item-next-hidden">다음</li>
			</c:if>
			<c:if test="${pagingPrListVO.pagingVO.totalPage != pagingPrListVO.pagingVO.currentPage + 1}">
				<li class="page-item-next">
					<a href="likeListsPR.do?page=${pagingPrListVO.pagingVO.currentPage + 1}&prmajorName=${empty param.prmajorName ? 'all' : param.prmajorName}&prcareerName=${empty param.prcareerName ? 'all' : param.prcareerName}&prlocName=${empty param.prlocName ? 'all' : param.prlocName}&prhashName=${empty param.prhashName ? 'all' : param.prhashName}">다음</a>
				</li>
			</c:if>

			<!-- 마지막 페이지로 이동 -->
			<li class="page-item-next">
				<a href="likeListsPR.do?page=${pagingPrListVO.pagingVO.totalPage - 1}&prmajorName=${empty param.prmajorName ? 'all' : param.prmajorName}&prcareerName=${empty param.prcareerName ? 'all' : param.prcareerName}&prlocName=${empty param.prlocName ? 'all' : param.prlocName}&prhashName=${empty param.prhashName ? 'all' : param.prhashName}">▶▶</a>
			</li>
		</ul>
<%-- 		<div>first: ${pagingPrListVO.pagingVO.first ? "-hidden" : "none"}</div>
		<div>last: ${pagingPrListVO.pagingVO.last ? "-hidden" : "none"}</div>
		<div>currentBlock: ${pagingPrListVO.pagingVO.currentBlock}</div>
		<div>startPageNum: ${pagingPrListVO.pagingVO.startPageNum}</div>
		<div>lastPageNum: ${pagingPrListVO.pagingVO.lastPageNum}</div>
		<div>totalCount: ${pagingPrListVO.pagingVO.totalCount}</div>
		<div>totalPage: ${pagingPrListVO.pagingVO.totalPage}</div>
		<div>currentPage: ${pagingPrListVO.pagingVO.currentPage}</div> --%>
	</div>
</div>

<%@ include file="../layout/footer.jsp"%>