<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="Header.jsp"%>
<%@ page import="java.sql.*"%>
<style>
.pagination a {
	color: black;
	float: left;
	padding: 8px 16px;
	text-decoration: none;
	transition: background-color .3s;
}
span {
	background-color: yellow;
}
</style>

<body>
	<div class="row">
		<div class="col-2"></div>
		<div class="col-8">
			<h1>
				<br>&nbsp;질답 게시판
			</h1>
			<br> <br>
			<%
				String SessionID = (String)session.getAttribute("id");
				if(SessionID == null)	{	
		 			SessionID = "1";
		 		}
				//페이지 받아오기
				String get = "1";
				if(request.getParameter("page") != null){
					get = request.getParameter("page");
				}
				int p = Integer.parseInt(get);
				
				//검색어 받아오기
				String sch = "";
				if(request.getParameter("search") != null){
					sch = request.getParameter("search");
				}
				
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;

				int tot = 0; //총 글 수
				int countpage = 0;  //총 글 수 나누기 10의 몫
				int lastpage = 0;   //총 글 수 나누기 10의 나머지
				
				try {
					String jdbcDriver = "jdbc:apache:commons:dbcp:mboard";
					
					//검색어가 있을 때 페이지 수 구하기
					if(sch!=""){
						String query = "select count(*) from qnaboard ";
						query += "where QNAtitle like '%"+sch+"%' or ";
						query += "QNAwriter like '%"+sch+"%' or ";
						query += "QNAcontent like '%"+sch+"%' ";
						
						conn = DriverManager.getConnection(jdbcDriver);

						pstmt = conn.prepareStatement(query);

						rs = pstmt.executeQuery();
						rs.next();
						tot = rs.getInt(1);
						
						//마지막 페이지의 글 수가 0이 아니면 1을 더함
						if(tot%10 != 0){
							lastpage = 1;
						}
						countpage = tot/10 + lastpage;
					}
					//검색어가 없을 때 페이지 수 구하기
					else{
					String query = "select count(*) from qnaboard; ";
					conn = DriverManager.getConnection(jdbcDriver);

					pstmt = conn.prepareStatement(query);

					rs = pstmt.executeQuery();
					rs.next();
					tot = rs.getInt(1);
					
					//마지막 페이지의 글 수가 0이 아니면 1을 더함
					if(tot%10 != 0){
						lastpage = 1;
					}
					countpage = tot/10 + lastpage;
				}
				} finally {
					if (pstmt != null)
						try {
							pstmt.close();
						} catch (SQLException ex) {
						}
					if (conn != null)
						try {
							conn.close();
						} catch (SQLException ex) {
						}
				}
			%>
			<!-- 검색창 시작 -->
			<div class="row float-right">
				<nav class="navbar navbar-light " style="background-color: white;">
					<form class="form-inline">
						<input class="form-control mr-sm-2" type="text" name="search"
							id="search" value="<%=sch%>">
						<button class="btn btn-outline-secondary my-2 my-sm-0"
							type="submit">검색</button>
					</form>
				</nav>
			</div>
			<br> <br>
			<!-- 검색창 끝 -->
			<!-- 리스트 시작 -->
			<div class="row-cols-1">
				<table class="table table-borderless mx-auto"
					style="color: rgb(2, 2, 2);">
					<thead>
						<tr style="font-weight: bolder; text-align: center;">
							<th style="width: 10%;">번호</th>
							<th style="width: 40%;">제목</th>
							<th style="width: 10%;">작성자</th>
							<th style="width: 22%;">게시일</th>
							<th style="width: 8%;">조회수</th>
						</tr>
					</thead>
				</table>
				<table class="table table-borderless mx-auto"
					style="color: rgb(2, 2, 2);">
					<tbody>
						<%
						try {
							String jdbcDriver = "jdbc:apache:commons:dbcp:mboard";
							
							//검색 시 목록 가져오기
							if(sch!=""){
								String query = "select QNAno, QNAtitle, QNAwriter, QNAwdate, QNAhit, dep from qnaboard ";
								//검색은 like 문 이용
								query += "where QNAtitle like '%"+sch+"%' or ";
								query += "QNAwriter like '%"+sch+"%' or ";
								query += "QNAcontent like '%"+sch+"%' ";
								query += "order by pano desc, QNAno ";
								//10개씩 가져오기
								query += "limit "+ (p-1)*10 +", 10;";
								conn = DriverManager.getConnection(jdbcDriver);
								pstmt = conn.prepareStatement(query);
								
								rs = pstmt.executeQuery();
								while (rs.next()) {
									int num = rs.getInt(1);
									String title = rs.getString(2);
									String writer = rs.getString(3);
									String date = rs.getString(4);
									String hit = rs.getString(5);
									int dep = Integer.parseInt(rs.getString(6));
									
									if(title.contains(sch)){
										title = title.replace(sch, "<span>" + sch + "</span>");
									}
									if(writer.contains(sch)){
										writer = writer.replace(sch, "<span>" + sch + "</span>");
									}
									%> 
						<tr>	
							<td style="width: 10%; text-align: center;"><%=num%></td>
							<td style="width: 40%;"><a
								href="QNAview.jsp?search=<%= sch%>&no=<%=num%>"><% if(dep==2){ %>└답변<%}%><%=title%></a></td>
							<td style="width: 10%; text-align: center;"><%=writer%></td>
							<td style="width: 22%; text-align: center;"><%=date%></td>
							<td style="width: 8%; text-align: center;"><%=hit%></td>
						</tr>
						<%
								}
							}
							//검색어 없을 때 목록 가져오기
							else{
							String query = "select QNAno, QNAtitle, QNAwriter, QNAwdate, QNAhit, dep from qnaboard ";
							query += " order by pano desc, QNAno ";
							//10개씩 가져오기
							query += "limit "+ (p-1)*10 +", 10;";
							conn = DriverManager.getConnection(jdbcDriver);
							pstmt = conn.prepareStatement(query);
							
							rs = pstmt.executeQuery();
							
							while (rs.next()) {
								int num = rs.getInt(1);
								String title = rs.getString(2);
								String writer = rs.getString(3);
								String date = rs.getString(4);
								String hit = rs.getString(5);
								int dep = Integer.parseInt(rs.getString(6));
					%>
						<tr>
							<td style="width: 10%; text-align: center;"><%=num%></td>
							<td style="width: 40%;"><a href="QNAview.jsp?no=<%=num%>"><% if(dep==2){ %>└<%}%><%=title%></a></td>
							<td style="width: 10%; text-align: center;"><%=writer%></td>
							<td style="width: 22%; text-align: center;"><%=date%></td>
							<td style="width: 8%; text-align: center;"><%=hit%></td>
						</tr>
						<%
						}
							}
						} finally {
							if (pstmt != null)
								try {
									pstmt.close();
								} catch (SQLException ex) {
								}
							if (conn != null)
								try {
									conn.close();
								} catch (SQLException ex) {
								}
						}
				
					%>
					</tbody>
				</table>
			</div>
			<!-- 리스트 끝 -->
			<!-- 페이지 시작 -->
			<div class="row justify-content-center" style="text-align: center;">
				<div class="pagination">


					<%
					//이전 페이지 버튼
					if (p>1){ 
					if(sch !=""){
					%>
					<a href="QNAlist.jsp?search=<%=sch %>&page=<%=(p-1)%>">&laquo;</a>

					<%}else{
						
					%>
					<a href="QNAlist.jsp?page=<%=(p-1)%>">&laquo;</a>
					<%}}
					//1페이지일때 페이징
					if(p<2){
						for(int i = 1; i <= 3; i++){
								if(sch != ""){
									if(i==p){
										
						%>
						<!-- 검색어가 있을 때 "search=" 유지 -->
						<a href="QNAlist.jsp?search=<%=sch %>&page=<%=i%>"><strong><%=i %></strong></a>
						<%}else{%>

						<a href="QNAlist.jsp?search=<%=sch %>&page=<%=i%>"><%=i %></a>
						<%}
								//검색어 없을 때
								}else{
									if(i==p){
						%>
						<a href="QNAlist.jsp?page=<%=i%>"><strong><%=i %></strong></a>
						<%}else{%>
						<a href="QNAlist.jsp?page=<%=i%>"><%=i %></a>
						<%}}}}
					//2~마지막 페이지 전까지 페이징
						else if(p>1&&p<countpage){
					for(int i = p-1; i <= p+1; i++){
							if(sch != ""){
								if(i==p){
									
					%>
					<!-- 검색어가 있을 때 "search=" 유지 -->
					<a href="QNAlist.jsp?search=<%=sch %>&page=<%=i%>"><strong><%=i %></strong></a>
					<%}else{%>

					<a href="QNAlist.jsp?search=<%=sch %>&page=<%=i%>"><%=i %></a>
					<%}
							//검색어 없을 때
							}else{
								if(i==p){
					%>
					<a href="QNAlist.jsp?page=<%=i%>"><strong><%=i %></strong></a>
					<%}else{%>
					<a href="QNAlist.jsp?page=<%=i%>"><%=i %></a>
					<%}}}} 
					//마지막 페이지일때 페이징
					else if(p==countpage){
						for(int i = p-2; i <= p; i++){
								if(sch != ""){
									if(i==p){
										
						%>
						<!-- 검색어가 있을 때 "search=" 유지 -->
						<a href="QNAlist.jsp?search=<%=sch %>&page=<%=i%>"><strong><%=i %></strong></a>
						<%}else{%>

						<a href="QNAlist.jsp?search=<%=sch %>&page=<%=i%>"><%=i %></a>
						<%}
								//검색어 없을 때
								}else{
									if(i==p){
						%>
						<a href="QNAlist.jsp?page=<%=i%>"><strong><%=i %></strong></a>
						<%}else{%>
						<a href="QNAlist.jsp?page=<%=i%>"><%=i %></a>
						<%}}}} %>
					<% 
					//다음 페이지 버튼
					if (p<countpage){ 
					if(sch !=""){
					%>
					<a href="QNAlist.jsp?search=<%=sch %>&page=<%=(p+1)%>">&raquo;</a>
					<%}else{
					%>
					<a href="QNAlist.jsp?page=<%=(p+1)%>">&raquo;</a>
					<%}} %>
				</div>

			</div>
			<!-- 페이지 끝 -->
			<!-- 글쓰기 버튼 -->
			<% if(SessionID != "1")	 { %>
			<div class="row float-right">
				<button type="button" class="btn btn-outline-secondary"
					onclick="location.href='QNAwrite.jsp'">글쓰기</button>
				&nbsp;&nbsp;&nbsp;
			</div>
			<%} %>
			<!-- 글쓰기 버튼 끝 -->
		</div>
		<div class="col-2"></div>
	</div>


</body>
<%@ include file="Footer.jsp"%>