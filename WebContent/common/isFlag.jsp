<%@page import="util.JavascriptUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%-- isFlag.jsp --%>

<%
request.setCharacterEncoding("UTF-8");

//멀티게시판 구현을 위한 파라미터 처리
String bname = request.getParameter("bname");
if(bname == null || bname.equals("")) {
	//만약 bname의 값이 없다면 로그인 화면으로 강제이동시킨다.
	JavascriptUtil.jsAlertLocation("필수파라미터 누락됨", "../06Session/Login.jsp", out);
	return;
}

String boardTitle ="";
switch(bname){
case "freeboard":
	boardTitle = "자유게시판";
	break;
case "qna":
	boardTitle = "질문과답변";
	break;
case "notice":
	boardTitle = "공지사항";
	break;
case "faq":
	boardTitle = "자주묻는질문";
	break;
}

%>