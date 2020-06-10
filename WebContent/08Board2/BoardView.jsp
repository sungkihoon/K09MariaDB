<%@page import="model.BbsDTO"%>
<%@page import="model.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/isFlag.jsp" %> 

<%
/*
검색 후 파라미터 처리를 위한 추가부분
	: 리스트에서 검색 후 상세보기, 그리고 다시 리스트 보기를
	눌렀을 때 검색이 유지되도록 처리하기 위한 코드 삽입.
*/
String queryStr = "bname="+bname+"&";
String searchColumn = request.getParameter("searchColumn");
String searchWord = request.getParameter("searchWord");
if(searchWord != null) {
	queryStr += "searchColumn=" + searchColumn 
					+ "&searchWord=" + searchWord + "&";
}
//3페이지에서 상세보기 했다면 리스트로 돌아갈때도 3페이지로 가야한다.
String nowPage = request.getParameter("nowPage");
if(nowPage == null || nowPage.equals("")) {
	nowPage = "1";
}
queryStr += "&nowPage=" + nowPage;

//폼값 받기 - 파라미터로 전달된 게시물의 일련번호
String num = request.getParameter("num");
BbsDAO dao = new BbsDAO(application);

//게시물의 조회수 +1증가
dao.updateVisitCount(num);

//게시물을 가져와서 DTO객체로 반환
BbsDTO dto = dao.selectView(num);

dao.close();
%>

<!DOCTYPE html>
<html lang="en">
<jsp:include page="../common/boardHead.jsp" />
<body>
<div class="container">
	<jsp:include page="../common/boardTop.jsp" />
	<div class="row">		
		<jsp:include page="../common/boardLeft.jsp" />
		<div class="col-9 pt-3">
			<h3><%=boardTitle %> 게시판 - <small>View(상세보기)</small></h3>
						
			<div class="row mt-3 mr-1">
				<table class="table table-bordered">
				<colgroup>
					<col width="20%"/>
					<col width="30%"/>
					<col width="20%"/>
					<col width="*"/>
				</colgroup>
				<tbody>
					<tr>
						<th class="text-center table-active align-middle">아이디</th>
						<td><%=dto.getId() %></td>
						<th class="text-center table-active align-middle">작성일</th>
						<td><%=dto.getPostDate() %></td>
					</tr>
					<tr>
						<th class="text-center table-active align-middle">작성자</th>
						<td><%=dto.getName() %></td>
						<th class="text-center table-active align-middle">조회수</th>
						<td><%=dto.getVisitcount() %></td>
					</tr>
					<tr>
						<th class="text-center table-active align-middle">제목</th>
						<td colspan="3">
							<%=dto.getTitle() %>
						</td>
					</tr>
					<tr>
						<th class="text-center table-active align-middle">내용</th>
						<td colspan="3" class="align-middle" style="height:200px;">
							<%--
							textarea에서 엔터키로 줄바꿈을 한 후 DB에 저장하면 \r\n으로
							저장되므로, HTML 페이지에서 출력할 때는 <br>태그로 문자열을
							변경해야 한다.
							--%>
							<%=dto.getContent().replace("\r\n", "<br>") %>
						</td>
					</tr>
					<!-- 
					<tr>
						<th class="text-center table-active align-middle">첨부파일</th>
						<td colspan="3">
							파일명.jpg <a href="">[다운로드]</a>
						</td>
					</tr>
					 -->
				</tbody>
				</table>
			</div>
			<div class="row mb-3">
				<div class="col-6">
				<%
				/* 
				로그인이 완료된 상태이면서, 동시에 해당 게시물의 작성자라면
				수정, 삭제 버튼을 보이게 처리한다.
				*/
				if(session.getAttribute("USER_ID") != null && 
					session.getAttribute("USER_ID").toString().equals(dto.getId())) {
				%>
					<!-- 수정, 삭제의 경우 특정게시물에 대해 수행하는 작업이므로 반드시
					게시물의 일련번호(PK)가 파라미터로 전달되어야 한다. -->
					<button type="button" class="btn btn-secondary"
						onclick="location.href='BoardEdit.jsp?num=<%=dto.getNum()%>&bname=<%=bname%>';">
						수정하기</button>
					<!-- 회원제게시판에서 삭제처리는 별도의 폼이 필요없이, 사용자에 대한
					인증처리만 되면 즉시 삭제처리한다. -->
					<button type="button" class="btn btn-success"
						onclick="isDelete();">삭제하기</button>
				<%
				}
				%>
				</div>
				<div class="col-6 text-right pr-5">
					<button type="button" class="btn btn-warning" onclick="location.href='BoardList.jsp?<%=queryStr %>';">리스트보기</button>
				</div>
			</div>
			
			<!-- 
			게시물 삭제의 경우 로그인 된 상태이므로 해당 게시물의 일련번호만 
			서버로 전송하면 된다. 이 때 hidden폼을 사용하고, JS의 submit()
			함수를 이용해서 폼 값을 전송한다. 해당 form태그는 HTML문서 어디든지
			위치할 수 있다.
			 -->
			<form name="deleteFrm">
				<input type="hidden" name="num" value="<%=dto.getNum() %>" />
				<input type="hidden" name="bname" value="<%=bname %>" />
			</form>
			<script>
				function isDelete() {
					var c = confirm("삭제할까요?");
					if(c) {
						var f = document.deleteFrm;
						f.method = "post";
						f.action = "DeleteProc.jsp";
						f.submit();
					}
				}
			</script>
			
		</div>
	</div>
	<jsp:include page="../common/boardBottom.jsp" />
</div>
</body>
</html>

<!-- 
	<i class='fas fa-edit' style='font-size:20px'></i>
	<i class='fa fa-cogs' style='font-size:20px'></i>
	<i class='fas fa-sign-in-alt' style='font-size:20px'></i>
	<i class='fas fa-sign-out-alt' style='font-size:20px'></i>
	<i class='far fa-edit' style='font-size:20px'></i>
	<i class='fas fa-id-card-alt' style='font-size:20px'></i>
	<i class='fas fa-id-card' style='font-size:20px'></i>
	<i class='fas fa-id-card' style='font-size:20px'></i>
	<i class='fas fa-pen' style='font-size:20px'></i>
	<i class='fas fa-pen-alt' style='font-size:20px'></i>
	<i class='fas fa-pen-fancy' style='font-size:20px'></i>
	<i class='fas fa-pen-nib' style='font-size:20px'></i>
	<i class='fas fa-pen-square' style='font-size:20px'></i>
	<i class='fas fa-pencil-alt' style='font-size:20px'></i>
	<i class='fas fa-pencil-ruler' style='font-size:20px'></i>
	<i class='fa fa-cog' style='font-size:20px'></i>
	아~~~~힘들다...ㅋ
 -->