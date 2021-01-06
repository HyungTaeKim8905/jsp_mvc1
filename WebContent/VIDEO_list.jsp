<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="DB.*" %>
<%@ include file="Header.jsp"%>
<%
	String curpage = request.getParameter("page");
	String text = (String)request.getParameter("text");
	if(text == null)	{
		text = "";
	}
%>

<script src="jquery-3.5.1.min.js"></script> 

<style>
.pagination a {
	color: black;
	float: left;
	padding: 8px 16px;
	text-decoration: none;
	transition: background-color .3s;
}

.pagination a.active {
	background-color: dodgerblue;
	color: white;
}

.pagination a:hover:not(.active) {background-color: #ddd;}
</style>
<body>
	<div class="row">
		<div class="col-2"></div>
		<div class="col-8">
		<h1><br>&nbsp;동영상 게시판</h1>
		<br><br>
			<!-- 검색창 시작 -->
			<div class="row float-right">
				<nav class="navbar navbar-light " style="background-color: white;">
					<form id="form" name="form" method="get" action="VIDEO_list.jsp?" class="form-inline">
						<input class="form-control mr-sm-2" type="text" id="text" name="text" placeholder="Search">
						<button class="btn btn-primary mb-2" type="submit">검색</button>
					</form>
				</nav>
			</div>
			<br> <br>
			<!-- 검색창 끝 -->
			<!-- 리스트 시작 -->
			<div class="row-cols-1">
				<table class="table table-borderless mx-auto" style="color: rgb(2, 2, 2);">
					<thead>
						<tr style="font-weight: bolder; text-align: center;">
							<th style="width: 10%;">번호</th>
							<th style="width: 50%;">제목</th>
							<th style="width: 10%;">작성자</th>
							<th style="width: 12%;">게시일</th>
							<th style="width: 8%;">조회수</th>
						</tr>
					</thead>
						<tbody id="tbody" style="text-align: center;">
						<%
							int recordTotal = 0;	// 전체 데이터 갯수 
							String count = "";
							int pageno  = 0; 
							int perpage = 0;        //페이지당 가져올 목록 개수
							int startno = 0; 
							sql = "";
							
							String no    = "";
							String title = "";
							String wdate = "";
							String hit   = "";
							name  = "";			//Header.jsp에서 name을 선언함.
							sql = "";			//Header.jsp에서 name을 선언함.
							try {
								// 112번째 줄에서 페이지 수 출력하고 출력된 페이지를 누르면 전송되는 파라미터의 값을 request객체의 getParameter() 메서드로 받아주고 curpage변수에 저장
								if(curpage == null) {
									curpage = "1";
								}
								
								dbm.DBOpen();
								if(text.equals(""))	{	// 만약에 text가 공백이라면 총 데이터의 개수를 가져옴
									sql = "select count(*) as cnt from board ";		// 데이터의 개수 출력해주는 sql 구문
								}
								else	{	// text가 null이 아니라면 즉 검색창에 검색 문구를 썻다면 그 검색 결과의 총 데이터 개수를 가져옴
									sql = "select count(*) as cnt from board where title like '%" + text + "%' or NAME like '%" + text + "%'";
								}
								dbm.OpenQuery(sql);
								while(dbm.ResultNext())	{
									recordTotal = dbm.getInt("cnt");
								}
								
								pageno  = Integer.parseInt(curpage); //페이지 번호를 String 자료형에서 int 자료형으로 바꿈
								perpage = 10;						 //페이지당 가져올 목록 개수     만약 perpage=10이라면 10개를 화면에 출력 20이면 20개를 출력
								startno = ((pageno - 1) * perpage);  //만약 pageno = 1이라면 startno=0 이이다 따라서 DB의 테이블에 목록이 0~10 번째 까지 출력이 된다는 뜻| startno=1(pageno = 2) 이라면 DB의 테이블에 목록이10~19 번째 까지 
								if(text.equals(""))	{
									sql = "select no,title,name,wdate,hit,indent from board order by ref desc, step asc ";
									sql += "limit " + startno + "," + perpage;		// 0번째부터 9번째까지 출력하라는 sql 구문
								}
								else	{
									sql = "select no,title,name,wdate,hit,indent from board where title like '%" + text + "%' or NAME like '%" + text + "%' order by ref desc, step asc ";
									sql += "limit " + startno + "," + perpage;		// 0번째부터 9번째까지 출력하라는 sql 구문
								}
								dbm.OpenQuery(sql);
								int i = recordTotal - ((pageno - 1) * perpage);		//글 번호
								
								dbm.OpenQuery(sql);
								while(dbm.ResultNext())	{
									no    = dbm.getString("no");
									title = dbm.getString("title");
									name = dbm.getString("name");
									wdate = dbm.getString("wdate");
									hit   = dbm.getString("hit");
									int indent = dbm.getInt("indent");
									%>
									<tr>
										<td><%= i-- %></td>
										<td class='left'><a href='VIDEO_view.jsp?no=<%= no %>'>
										<%
										for(int j = 0; i <indent; i++)	{
											%>&nbsp&nbsp&nbsp<%
										}
										if(indent != 0)	{
										%>			->
										<% 
										}
										%>
										<%= title %></a></td>
										<td><%= name %></td>
										<td><%= wdate %></td>
										<td><%= hit %></td>
									</tr>
									<%
								}
								dbm.CloseQuery();
								dbm.DBClose();
							} catch(Exception e)	{
								System.out.println("ERROR:" + e.getMessage());
							}
						%>
						</tbody>
				</table>
			</div>
			<!-- 리스트 끝 -->
			<!-- 페이지 시작 -->
			<% 		// 최대 페이지 수 = 전체 데이터의 개수  /  페이지당 가져올 목록 개수
				int maxPage = recordTotal / perpage;		// 최대 페이지 수
				if( (recordTotal % perpage ) != 0)
				{
					maxPage++;		// 만약 전체 데이터의 개수에서 페이지당 가져올 목록의 개수를 나누었을때 나머지가 0이 아니라면 출력되어야 할 목록의 수가 남아있기 때문에 
									// 나머지 목록을 출력하려면 maxPage 변수를 하나더 추가 해준줌으로써 최대 페이지 수를 하나 더 늘려줌
				}
			%>
			<div class="row justify-content-center" style="text-align: center;">
				<div class="pagination">
					
					
					<%
						for(int j=1; j <= maxPage; j++)		// 최대 페이지 수만큼 루프문을 도는데 이때 1 2 3 4 5 6 7 8 9 10 이 화면에 출력 되고, 각각의 숫자에 링크를 걸고
						{									// 숫자를 누르면 다음페이지로 이동  
							%><a href="VIDEO_list.jsp?page=<%= j %>&text=<%= text %>"><%= j %></a>&nbsp;&nbsp;<% // 넘기면서 페이지를 넘겨줌
							// HTTP Request헤더에 page=1 or page=2 라는 파라미터를 붙여 데이터를 전송 하면 => 36번째줄로 넘어감
						}
					%>
					
					
				</div>

			</div>
			<!-- 페이지 끝 -->
			<!-- 글쓰기 버튼 -->
			<div class="row float-right">
			 <%  String SessionId = (String)session.getAttribute("id");
				if(SessionId == null){
					
				}
				else {
			 %>
				<button type="button" class="btn btn-primary mb-2" onclick="location.href='VIDEO_write.jsp'">글쓰기</button>
				<% } %>
			</div>
		</div>
		<div class="col-2"></div>
	</div>
</body>
<%@ include file="Footer.jsp"%>