<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" %>

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

헤더

<hr>

        <h2 id="title"  align=center>글작성</h2>
        <form method=post  action="boardWrite.do"  enctype="multipart/form-data" >
            <table border=1  align=center >
                <tr>
                    <th>작성자</th>
                    <td><input type=text  name="userId"  value=" ${sessionScope.userId} "></td>
                </tr>
                <tr>
                    <th>제목</th>
                    <td><input type=text  name="commSub"  required></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea cols=40 rows=10 name="commText"  id="commText"  required></textarea>
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
  <hr>
  푸터

