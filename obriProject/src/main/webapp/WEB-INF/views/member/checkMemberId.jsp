<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="music.dao.*" %>
<%
 request.setCharacterEncoding("utf-8");
 
 String userId = request.getParameter("memid");
 System.out.println("userId="+userId);
 
 memberDaoImpl md = new memberDaoImpl();

 int re = md.checkMemberId(userId);
 //1: 중복, -1: 사용가능

 out.println(re);
%>