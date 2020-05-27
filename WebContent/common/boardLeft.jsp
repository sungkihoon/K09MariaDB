<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- boardLeft.jsp --%>
<%
String uri = request.getRequestURI();
String a1 = "", a2 = "", a3 = "";
if(uri.indexOf("08Board2") >= 0) {
	a1 = "active";
}
else if(uri.indexOf("Dataroom") >= 0) {
	a2 = "active";
}
else {
	a3 = "active";
}
%>
<div class="col-3">
	
	<div style="height: 100px; line-height: 100px; margin:10px 0; text-align: center; 
		color:#ffffff; background-color:rgb(133, 133, 133); border-radius:10px; font-size: 1.5em;">
		웹사이트제작
	</div>
	
	<div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
		
		<a class="nav-link <%=a1 %>" id="v-pills-home-tab" href="../08Board2/BoardList.jsp?bname=freeboard" role="tab" 
			aria-controls="v-pills-home" aria-selected="true">자유게시판</a>
		<a class="nav-link " id="v-pills-home-tab" href="../08Board2/BoardList.jsp?bname=notice" role="tab" 
			aria-controls="v-pills-home" aria-selected="true">공지사항</a>
		<a class="nav-link " id="v-pills-home-tab" href="../08Board2/BoardList.jsp?bname=qna" role="tab" 
			aria-controls="v-pills-home" aria-selected="true">질문과답변</a>
		<a class="nav-link " id="v-pills-home-tab" href="../08Board2/BoardList.jsp?bname=faq" role="tab" 
			aria-controls="v-pills-home" aria-selected="true">FAQ</a>
		
	</div>
	
</div>