<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- Logout.jsp --%> 
  
<%
	session.removeAttribute("USER_ID");
	session.removeAttribute("USER_PW");
	
	session.invalidate();
	
	response.sendRedirect("Login.jsp");
%>
