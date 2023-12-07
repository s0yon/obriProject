<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="music.dao.*" %>
<%
 request.setCharacterEncoding("utf-8");
 
 String userId = request.getParameter("memid");
 
 memberDaoImpl md = new memberDaoImpl();

 int re = md.checkMemId(userId);

 out.println(re);
%>