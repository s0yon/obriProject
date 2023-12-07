<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<head>
<link href="${path}/css/mypage/likes.css" rel="stylesheet" />

<script src="${path}/js/mypage/like.js"></script>
</head>

<div class="container">
	<div class="photosetting">
		<div class="liketitle">♥ 커뮤니티 좋아요한 글</div>

		<c:forEach var="likesComm" items="${likesListComm}">
			<div class="replay_box">
				<div class="full_setting">
					<div class="photocompany">
						<c:choose>
							<c:when test="${empty likesComm.commFile}">
								<a href="comDetail.do?commNo=${likesComm.commNo}"><img class="companyphoto" src='https://picsum.photos/250/250' alt="커뮤니티 첨부 이미지"></a>
							</c:when>
							<c:otherwise>
								<a href="comDetail.do?commNo=${likesComm.commNo}"><img class="companyphoto" src="${path}/upload/${likesComm.commFile}" alt="커뮤니티 첨부 이미지"></a>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="company_story">
						<div class="contect_title">${likesComm.commSub}</div>
						<div class="explanation">
							<div class="explanation_text">${likesComm.commText}</div>
						</div>

						<div class="company_image">
							<div class="test">
								<c:choose>
									<c:when test="${empty likesComm.prFile}">
										<a href="comList.do?id=${likesComm.writerId}"><img class="conpany_min_iphoto" src='https://picsum.photos/250/250' alt="작성자 프로필 이미지"
											width="25" height="25"></a>
									</c:when>
									<c:otherwise>
										<a href="comList.do?id=${likesComm.writerId}"><img class="conpany_min_iphoto" src="${path}/upload/${likesComm.prFile}" alt="작성자 프로필 이미지" width="25" height="25"></a>
									</c:otherwise>
								</c:choose>
								
								<a class="test2">${likesComm.writerName}(${likesComm.writerId})</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>

<%@ include file="../layout/footer.jsp"%>