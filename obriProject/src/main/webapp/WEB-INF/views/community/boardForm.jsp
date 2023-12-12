<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"   uri="http://java.sun.com/jsp/jstl/functions"%>


<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>커뮤니티 게시판 글 작성</title>

<link rel="stylesheet" href="./css/nav.css">
<link rel="stylesheet" href="./css/header.css">


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
 <%@include file="../navbar.jsp" %>
	
	<main style="padding-top: 80px; padding-bottom: 80px">

		<!-- header start -->
		<section class="header">
			<div class="title">
				<h1>
					연주자를 위한 커뮤니티,<br> 오브리
				</h1>
			</div>
		</section>
		<!-- header end -->
 

        <h2 id="title"  align=center>글작성</h2>
        <form method=post  action="boardWrite.do"  enctype="multipart/form-data" >
            <table border=1  align=center  width=800  height=400 >
                <tr>
                    <th>작성자</th>
                    <td><input type="text"  name="userId"   value="${fn:trim(sessionScope.userId)}"   readonly="readonly"></td>
                </tr>
                <tr>
                    <th>제목</th>
                    <td><input type=text  name="commSub"  required></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea  cols=100 rows=20  name="commText"  id="commText"  required></textarea>
                        <br><br>
                    </td>
				</tr>
				<tr>
                    <th>첨부파일</th>
                    <td><input type=file  name="com_file1" ></td>
                </tr>
            </table>
            <div align="center">
            	<tr>
            		<td colspan=2  align=center>
                		<input type=submit  value="글올리기"  id="submitButton">
                		<input type="button"  value="목록으로"  onclick="location.href='boardList.do' ">
           			</td>
           		</tr>
           	</div>
        </form>
   </main>     
  <%@include file="../footer.jsp" %>
		
		
</body>
</html>

