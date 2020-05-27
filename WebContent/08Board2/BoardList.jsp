<%@page import="util.JavascriptUtil"%>
<%@page import="util.PagingUtil"%>
<%@page import="model.BbsDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 필수 파라미터 체크 로직 -->
<%@ include file="../common/isFlag.jsp" %>

<%-- boardList.jsp --%>
<%
//한글깨짐처리 - 검색폼에서 입력된 한글이 전송되기 때문
request.setCharacterEncoding("UTF-8");

//web.xml에 저장된 컨텍스트 초기화 파라미터를 application객체를 통해 가져옴
String drv = application.getInitParameter("MariaJDBCDriver");
String url = application.getInitParameter("MaiaConnectURL");

//DAO객체 생성 및 DB커넥션
BbsDAO dao = new BbsDAO(drv, url);

/* 
파라미터를 저장 할 용도로 생성한 Map컬렉션. 여러개의 파라미터가
있는 경우 한꺼번에 저장한 후 DAO로 전달할것임.
*/
Map<String, Object> param = new HashMap<String, Object>();



//필수파라미터인 bname을 DAO로 전달하기 위해 Map컬렉션에 저장한다.
param.put("bname", bname);



//폼값을 받아서 파라미터를 저장할 변수 생성
String queryStr = ""; //검색시 페이지번호로 쿼리스트링을 넘겨주기 위한 용도



//필수파라미터에 대한 쿼리스트링 처리
queryStr = "bname=" + bname + "&";




//검색어 입력시 전송된 폼값을 받아 Map에 저장
String searchColumn = request.getParameter("searchColumn");
String searchWord = request.getParameter("searchWord");
if(searchWord != null) {
 //검색어를 입력한 경우 Map에 값을 입력함.
 param.put("Column", searchColumn);
 param.put("Word", searchWord);
 //검색어가 있을 때 쿼리스트링을 만들어 준다.
 queryStr += "searchColumn=" + searchColumn + "&searchWord=" + searchWord + "&";
}

//board테이블에 입력된 전체 레코드 갯수를 카운트하여 반환받음
int totalRecordCount = dao.getTotalRecordCount(param);

 
/*** 페이지처리 ***/
//web.xml의 초기화 파라미터 가져와서 정수로 변경 후 저장
int pageSize = Integer.parseInt(application.getInitParameter("PAGE_SIZE"));
int blockpage = Integer.parseInt(application.getInitParameter("BLOCK_PAGE"));

//전체페이지수 계산 => 105개 / 10 => 10.5 => ceil(10.5) => 11
int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);

/*
현재 페이지 번호 : 파라미터가 없을 때는 무조건 1페이지로 지정하고, 있을때는 해당 값을
	얻어와서 지정한다. 즉, 리스트에 처음 진입했을때는 1페이지가 된다.
*/
int nowPage = (request.getParameter("nowPage") == null
		 		|| request.getParameter("nowPage").equals("")) 
	? 1 : Integer.parseInt(request.getParameter("nowPage"));


//MariaDB를 통해 한 페이지에 출력할 게시물의 범위를 결정한다.
//limit의 첫번째 인자 : 시작인덱스
int start = (nowPage - 1) * pageSize;
//limit의 두번째 인자 : 가져올 레코드의 갯수
int end = pageSize;


//게시물의 범위를 Map컬렉션에 저장하고 DAO로 전달한다.
param.put("start", start);
param.put("end", end);
/*** 페이지처리 end ***/


 
//조건에 맞는 레코드를 select하여 결과셋을 List컬렉션으로 반환받음.
List<BbsDTO> bbs = dao.selectListPage(param);
 
//DB연결해제
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
			<h3><%=boardTitle %> 게시판 - <small>이런저런 기능이 있는 게시판입니다.</small></h3>
			
			<div class="row">
				<!-- 검색부분 -->
				<form class="form-inline ml-auto" name="searchFrm" method="get">
				
				<!-- 검색시 필수파라미터인 bname이 전달되야 한다. -->
				<input type="hidden" name="bname" value="<%=bname %>"  />	
					
					<div class="form-group">
						<select name="searchColumn" class="form-control">
							<option value="title">제목</option>
							<option value="content">내용</option>
						</select>
					</div>
					<div class="input-group">
						<input type="text" name="searchWord"  class="form-control"/>
						<div class="input-group-btn">
							<button type="submit" class="btn btn-warning">
								<i class='fa fa-search' style='font-size:20px'></i>
							</button>
						</div>
					</div>
				</form>	
			</div>
			<div class="row mt-3">
				<!-- 게시판리스트부분 -->
				<table class="table table-bordered table-hover table-striped">
				<colgroup>
					<col width="60px"/>
					<col width="*"/>
					<col width="120px"/>
					<col width="120px"/>
					<col width="80px"/>
					<col width="60px"/>
				</colgroup>				
				<thead>
				
				<tr style="background-color: rgb(133, 133, 133); " class="text-center text-white">
					<th width="10%">번호</th>
					<th width="50%">제목</th>
					<th width="15%">작성자</th>
					<th width="15%">작성일</th>
					<th width="10%">조회수</th>
					<!-- <th>첨부</th> -->
				</tr>
				</thead>				
				<tbody>
			<%
			//List컬렉션에 입력된 데이터가 없을 때 true를 반환
			if(bbs.isEmpty()) {
			%>
				<tr>
					<td colspan="5" align="center" height="100">
						등록된 게시물이 없습니다.
					</td>
				</tr>
			<% 
			}
			else {
				//게시물의 가상번호로 사용할 변수
				int vNum = 0;
				int countNum = 0;
				/*
				컬렉션에 입력된 데이터가 있다면 저장된 BbsDTO의 갯수만큼
				즉, DB가 반환해준 레코드릐 갯수 만큼 반복하면서 출력한다.
				*/
				for(BbsDTO dto : bbs) {
					
					vNum = totalRecordCount - 
							(((nowPage - 1) * pageSize) + countNum++);
					
					/* 
					전체게시물 수 : 107개
					페이지사이즈 : 10
					
					현재페이지 1
						첫번째게시물 : 107 - (((1 - 1) * 10) + 0) = 107
						두번째게시물 : 107 - (((1 - 1) * 10) + 1) = 106
					현재페이지 2
						첫번째게시물 : 107 - (((2 - 1) * 10) + 0) = 97
						두번째게시물 : 107 - (((2 - 1) * 10) + 1) = 96
					*/
			%>
				<!-- 리스트반복 start -->
				<tr>
					<td class="text-center"><%=vNum %></td>
					
					<td class="text-left">
						
						<a href="BoardView.jsp?num=<%=dto.getNum() %>
							&nowPage=<%=nowPage %>&<%=queryStr %>">
							<%=dto.getTitle() %></a></td>
							
					<td class="text-center"><%=dto.getId() %></td>
					<td class="text-center"><%=dto.getPostDate() %></td>
					<td class="text-center"><%=dto.getVisitcount() %></td>
					<!-- <td class="text-center"><i class="material-icons" 
						style="font-size:20px">attach_file</i>
					</td> -->
				</tr>
				<!-- 리스트반복 end -->
			<%
				} //for-each end
			}//if end
			%>
				</tbody>
				</table>
			</div>
			<div class="row">
				<div class="col text-right">
					<!-- 자유게시판과 질문과답변에서만 글쓰기버튼 보임처리 -->
					<% if(bname.equals("freeboard") || bname.equals("qna")){ %>
					
					<button type="button" class="btn btn-primary" onclick="location.href='BoardWrite.jsp?bname=<%=bname%>';">글쓰기</button>
					
					<% } %>
				</div>
			</div>
			<div class="row mt-3">
				<div class="col">
					<!-- 페이지번호 부분 -->
					<ul class="pagination justify-content-center">
						<%=PagingUtil.pagingBS4(totalRecordCount, 
								pageSize, blockpage, nowPage, 
								"BoardList.jsp?" + queryStr) 
						%>
					</ul>
					<!-- 
					<ul class="pagination justify-content-center">
						<li class="page-item"><a href="#" class="page-link"><i class="fas fa-angle-double-left"></i></a></li>
						<li class="page-item"><a href="#" class="page-link"><i class="fas fa-angle-left"></i></a></li>
						<li class="page-item"><a href="#" class="page-link">1</a></li>		
						<li class="page-item active"><a href="#" class="page-link">2</a></li>
						<li class="page-item"><a href="#" class="page-link">3</a></li>
						<li class="page-item"><a href="#" class="page-link">4</a></li>		
						<li class="page-item"><a href="#" class="page-link">5</a></li>
						<li class="page-item"><a href="#" class="page-link"><i class="fas fa-angle-right"></i></a></li>
						<li class="page-item"><a href="#" class="page-link"><i class="fas fa-angle-double-right"></i></a></li>
					</ul>
					 -->
				</div>
			</div>
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