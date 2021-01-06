<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>
<%@ include file="Header.jsp"%>

<style>
span { background-color: yellow;}
.accordion {
  background-color: white;
  cursor: pointer;
  width: 100%;
  border: none;
  text-align: left;
  outline: none;
  transition: 0.4s;
}
.accordion.active, .accordion:hover {
  background-color: #ccc; 
}
.panel {
  display: none;
  background-color: rgba(255, 255, 255, 0);;
  overflow: hidden;
  position: absolute;
  width: 60%;
  padding : 5px 0px;
}
.lpanel {
  display: none;
  background-color: rgba(255, 255, 255, 0);;
  overflow: hidden;
  position: absolute;
  width: 60%;
  right:0%;
  padding : 5px 0px;
}
</style>

<%
	//글번호 받아오기
	String no = request.getParameter("no");
	int hitp = Integer.parseInt(no);
	
	//ID세션 확인
	String SessionID = (String)session.getAttribute("id");
  	if(SessionID == null)	{	
 		SessionID = "1";
 	}
	
	//검색어 받아오기
	String sch = "";
	if(request.getParameter("search") != null){
		sch = request.getParameter("search");
	}
	
	String QNAid = "" ;
	String REid = "" ;
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try {
		String jdbcDriver = "jdbc:apache:commons:dbcp:mboard";
		String query = "select QNAno, QNAtitle, QNAwriter, QNAwdate, QNAhit, QNAcontent, ";
		query += "id, filename, downloadcount, filerealname ";   
		query += "from qnaboard where QNAno='"+no+"'";
		conn = DriverManager.getConnection(jdbcDriver);
		pstmt = conn.prepareStatement(query);
		
		rs = pstmt.executeQuery();
		rs.next();
		
		String num = rs.getString(1);
		String title = rs.getString(2);
		String writer = rs.getString(3);
		String wdate = rs.getString(4); 
		String hit = rs.getString(5); 
		String content = rs.getString(6);
		QNAid = rs.getString(7); 
		String filename = rs.getString(8);
		String downloadcount = rs.getString(9);
		String filerealname = rs.getString(10);
		
		
		if(sch!=""){
		if(title.contains(sch)){
			title = title.replace(sch, "<span>" + sch + "</span>");
		}
		if(writer.contains(sch)){
			writer = writer.replace(sch, "<span>" + sch + "</span>");
		}
		if(content.contains(sch)){
			content = content.replace(sch, "<span>" + sch + "</span>");
		}
		}
%>

<div class="row">
	<div class="col-2"></div>

	<div class="col-8">
		<h1>
			<br>&nbsp;질답게시판
		</h1>
		<!-- 헤드 영역 시작-->
		<div class="row-cols-1">
			<br>
			<table class="table table-borderless">
				<thead>
					<tr>
						<th  style="text-align: left;">제목</th>
						<td colspan="1" style="text-align: left;"><%= title %></td>
					</tr>
						
				</thead>
				<tbody>
					<tr>
						<th scope="row" style="text-align: left; width: 20%;">작성자</th>
						<td style="width: 35%;"><%= writer %></td>
						<td style="width: 25%;"><%= wdate %></td>
						<td style="width: 20%;"><%= hit %></td>
					</tr>
					<tr>
	                        	<th width="20%">첨부파일</th>
	                        	<td id="file" width="20%">
	                        	<% if(filename!=null){ %>
	                        	<a href="QNAfiledownload.jsp?filedownload=<%= filerealname %>">
	                        	<%= filename %></a><%} %></td>
	                        	<th width="20%">첨부파일 다운로드 횟수</th>
	                        	<td id="filedowncount" width="20%"> <% if(filename!=null){ %><%= downloadcount %><%} %></td>
	                        </tr>
				</tbody>
			</table>
		</div>
		<!-- 헤드 영역 끝 -->
		<!-- 본문 영역 시작 -->
		<div class="row-cols-1" style="min-height:200px; padding : 10px; z-index:5;">
			<%= content %>
		</div>
		<!-- 본문 영역 끝 -->
		<!-- 댓글 영역 시작 -->
		<div class="row-cols-1">
			<table style="width: 100%;">
<% 
	pstmt.close();
	
	//댓글 불러오기
	
	query = "select QNArecontent, id, QNArewdate, QNAno, QNAreno, QNAredep from qnareply where QNAno='"+no+"' order by repano, QNAreno";
	
	pstmt = conn.prepareStatement(query);
	
	rs = pstmt.executeQuery();
	while(rs.next()){
	
	String recontent = rs.getString(1);	
	id = rs.getString(2);
	String rewdate = rs.getString(3); 
	String reno = rs.getString(4);
	String rereno = rs.getString(5);
	int redep = Integer.parseInt(rs.getString(6));
%>
				<tr>
					<th scope="row" style="text-align: left; width: 15%;"><%=id %></th>
					
					<% if(redep == 1){ %>
					<td style="width: 55%;" >
					<!-- 대댓글 폼 -->
					<button class="accordion" id="QNArere<%= rereno %>"><%= recontent %></button>
					<div class="panel">
					  <form name="QNArere" id= "QNArere" 
					  action="QNAreplyOK.jsp"
					  method="post"  accept-charset="UTF-8">
					  		<input type="hidden" id="no" name="no" value="<%=no %>">
					  		<input type="hidden" id="redep" name="redep" value="2">
					  		<input type="hidden" id="rereno" name="rereno" value="<%=rereno %>">
					  		<input type="hidden" id="id" name="id" value="<%=SessionID %>">
							<table style="width: 100%;">
								<tr>
									<td style="width : 85%">
										<textarea class="form-control" style="resize: none;"
										 rows="2" placeholder="댓글 입력" name="QNArecontent" id="QNArecontent"></textarea>
									</td>
									<td style="width : 15%">
										<button type="submit" class="btn btn-primary" style="height:64px !important;">
											&nbsp;&nbsp; 등록 &nbsp;&nbsp;</button>
									</td>
								</tr>
							</table>
						</form>
					</div>
					</td>
					<% }else if(redep == 2){%>
					<td style="width: 55%; background-color: rgb(218, 213, 213);">└ &nbsp;<%= recontent %></td><%} %>
					<td style="width: 20%;"><%=rewdate %></td>
					<td style="width: 10%;">
					<!-- 수정버튼 -->
                   	<% 
                  	// 로그인 한 사람의 아이디와 댓글을 쓴 사람의 id를 비교함.
                  	if(SessionID.equals(id))	{ %>
                   	<button type="button" 
                   	class="btn btn-secondary mb-2" onclick="MODIFY(<%= rereno %>)">수정</button>
                   <button type="button" class="btn btn-secondary mb-2"
					onclick="button_reevent();">삭제</button>
	
				<script type="text/javascript">

						function button_reevent(){
						if (confirm("삭제하시겠습니까?") == true){    //확인
							location.href="./QNAredelete.jsp?no=<%=no%>&RNo=<%=rereno%>";
						}else{   //취소
						    return;
						}
						}
				</script>
                  <% } %>
                   <% } %>
                   
				</tr>
			</table>
			<% if(SessionID != "1")	 { %>
			<form name="QNAre" id= "QNAre" action="QNAreplyOK.jsp?no=<%=no %>&redep=1&id=<%=SessionID %>" method="post" accept-charset="UTF-8">
				<table style="width: 100%;">
					<tr>
						<td style="width : 85%">
							<textarea class="form-control" style="resize: none;"
							 rows="2" placeholder="댓글 입력" name="QNArecontent" id="QNArecontent"></textarea>
						</td>
						<td style="width : 15%">
							<button type="submit" class="btn btn-primary" style="height:64px !important;">
								&nbsp;&nbsp; 등록 &nbsp;&nbsp;</button>
						</td>
					</tr>
				</table>
			</form>
			<%} %>
		</div>
		<br>
		<!-- 댓글 영역 끝 -->
		<!-- 버튼 영역 시작 -->
		<div class="row-cols-2">
			<div class="float-left">
				<button type="button" class="btn btn-secondary mb-2"
					onclick="location.href='QNAlist.jsp'">목록</button>
			</div>
		</div>
		
		<div class="row-cols-2">
			<div class="float-right">
				<button type="button" class="btn btn-secondary mb-2"
				
					onclick="location.href='QNAmodify.jsp?no=<%=num%>'">수정</button>
				<button type="button" class="btn btn-secondary mb-2"
					onclick="button_event();">삭제</button>
	
				<script type="text/javascript">

						function button_event(){
						if (confirm("삭제하시겠습니까?") == true){    //확인
							location.href="./QNAdelete.jsp?no=<%= no%>";
						}else{   //취소
						    return;
						}
						}
				</script>	
			<% if(SessionID != "1")	 { %>
				<button type="button" class="btn btn-info mb-2"
					onclick="location.href='QNAanswer.jsp?no=<%=num%>'">답변</button>
				<button type="button" class="btn btn-primary mb-2"
					onclick="location.href='QNAwrite.jsp'">글쓰기</button>
			<%} %>
			</div>
		</div>
		<!-- 버튼 영역 끝 -->
	</div>
	<div class="col-2"></div>
</div>
<%
	pstmt.close();
	
	//조회수 증가
	query = "UPDATE qnaboard SET QNAhit = QNAhit + 1 WHERE QNAno = '"+ hitp + "'; ";
	pstmt = conn.prepareStatement(query);
	
	pstmt.executeUpdate();

	}finally {
	if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	if (conn != null) try { conn.close(); } catch(SQLException ex) {}
} 
%>


<script>

//대댓글 스크립트문
var acc = document.getElementsByClassName("accordion");
var i;

for (i = 0; i < acc.length; i++) {
  acc[i].addEventListener("click", function() {
    this.classList.toggle("active");
    var panel = this.nextElementSibling;
    if (panel.style.display === "block") {
      panel.style.display = "none";
    } else {
      panel.style.display = "block";
    }
  });
}

//댓글 수정
function MODIFY(num)	{ 
	var output = "";
	var data = $("#QNArere"+num).text();
	output += "<form id='formreply' name='formreply' method='post' action='QNAreplyMOK.jsp?no=<%= no %>&RNo="+num+"''>"
	output += " <input type='text' value='"+data+"' id='commentreply' name='commentreply' size='70'>";
	output += "	<input type='button' class='btn btn-primary' value='저장' onclick='SaveFn()'>";
	output += "</form>";
	$("#QNArere"+ num).html(output);
}

function SaveFn()	{
	if(document.formreply.commentreply.value == "")
	{
		alert("댓글을 입력하세요.");
		document.formreply.commentreply.focus();
		return;
	}
	document.formreply.submit();
}

</script>
<%@ include file="Footer.jsp"%>