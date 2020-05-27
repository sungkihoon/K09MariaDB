<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CommonLink.jsp</title>
</head>
<body>

	<h2>공통링크</h2>
	<table border="1" width="90%"> 
		<tr>
			<td>
				<% if(session.getAttribute("USER_ID") == null) { %>
					<a href="../06Session/Login.jsp">로그인</a>
				<% } else { %>
					<a href="../06Session/Logout.jsp">로그아웃</a>
				<% } %>
				&nbsp;&nbsp;&nbsp;
				<a href="../08Board2/BoardList.jsp?bname=freeboard">회원제게시판2[Page0]</a>
			</td>
		</tr>
	</table>

</body>
</html>