<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" %>

<c:set var="loginOutLink"
	value="${sessionScope.userId==null ? 'login.do' : 'logout.do'}" />
<c:set var="loginOut"
	value="${sessionScope.userId==null ? '로그인' : '로그아웃'}" />
<c:set var="myPageLink"
	value="${sessionScope.userId==null ? 'join.do' : 'editCheck.do'}" />
<c:set var="myPage"
	value="${sessionScope.userId==null ? '회원가입' : '마이페이지'}" />

<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>커뮤니티 게시판 글 수정</title>

<link rel="stylesheet" href="./css/nav.css">
<link rel="stylesheet" href="./css/header.css">
<link rel="stylesheet" href="./css/animation.css">
<link rel="stylesheet" href="./css/intro.css">

<script src="https://kit.fontawesome.com/8c929515d1.js"
	crossorigin="anonymous"></script>



<style>
        /* 버튼을 원하는 위치로 이동 */
        #submitButton {
            margin-top: 20px; /* 상단 여백 조정 */
            margin-left: 10px; /* 왼쪽 여백 조정 */
            background-color:purple;
            color:white;
        }
        
        #title{
        color:purple;
        } 
    </style>

</head>

<body>
 <!-- navbar start -->
	<nav class="navbar">
		<div class="navbar_logo" id="navbar_logo">
			<a href="<c:url value='/home.do'/>"><img src="./images/184.png"></a>
		</div>
		<ul class="navbar_menu" id="navbar_menu">
			<li><a href="boardListShow.do">구인</a></li>
			<li><a href="prCardList.do">홍보</a></li>
			<li><a href="boardList.do">커뮤니티</a></li>
			<li><a href="notice_list.do">공지</a></li>
		</ul>
		<ul class="navbar_icons" id="navbar_icons">
			<li><a href="<c:url value='${loginOutLink}'/>"> <i
					class="fa-solid fa-user"></i>&nbsp;&nbsp;${loginOut}
			</a></li>
			<li><a href="<c:url value='${myPageLink}'/>"> <i
					class="fa-solid fa-right-to-bracket"></i>&nbsp;&nbsp;${myPage}
			</a></li>
		</ul>
		<a href="#" class="navbar_toggle_btn" id="navbar_toggle_btn"> <i
			class="fa-solid fa-bars"></i>
		</a>
	</nav>
	<!-- navbar end -->


        <h2 id="title"  align=center>글수정</h2>
        <form method=post  action="boardUpdate.do"  enctype="multipart/form-data" >
        <input type="hidden"  name="commNo"  value="${community.commNo}">
		<input type="hidden"  name="pageNum"  value="${pageNum}">
            <table border=1  align=center >
                <tr>
                    <th>작성자</th>
                    <td><input type=text  name="userId"   value=" ${community.userId}"  readonly></td>
                </tr>
                <tr>
                    <th>제목</th>
                    <td><input type=text  name="commSub"  required value=" ${community.commSub } "></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea cols=40 rows=10  name="commText"   id="commText"  required>${community.commText} </textarea>
                        <br><br>
                    </td>
				</tr>
				<tr>
                    <th>첨부파일</th>
                    <td><input type=file   name="com_file1" ></td>
                </tr>
            </table>
            <div align="center">
            	<tr>
            		<td colspan=2  align=center>
                		<input type=submit  value="글 수정"  id="submitButton">
                		<input type="button"  value="목록으로"  onclick="location.href='boardList.do' ">
           			</td>
           		</tr>
           	</div>
        </form>
  

<!-- footer start -->
	<footer class="nav_foot">
		<div class="nav_container">
			<h2>오브리</h2>
			<p>O&nbsp;B&nbsp;R&nbsp;I&nbsp;&nbsp;&copy;2023.1조</p>
		</div>
		<ul class="nav_menu">
			<li><a href="notice_list.do">공지사항</a></li>
			<li><a href="qna_form.do">문의하기</a></li>
			<li><a href="">개인정보 처리방침</a></li>
			<li><a href="">서비스 이용약관</a></li>
		</ul>
		<div class="btn_up" onclick="window.scrollTo(0,0)">
			<span class="fa-solid fa-circle-up fa-2xl"></span>
		</div>
	</footer>
	<!-- footer end -->
		
		
</body>
</html>

