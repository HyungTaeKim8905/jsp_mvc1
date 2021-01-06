<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="Header.jsp"%>

<%
	//DB에서 불러온 데이터들을 저장하기 위해 각각의 변수들을 공백으로 저장.
	String no 				= request.getParameter("no");
	String title 			= "";
	String wdate 			= "";
	String hit 				= "";
	String note 			= "";
	String videopath 		= "";
	String filename 		= "";
	String downloadcount 	= "";
	String filerealname 	= "";
	name = "";
	try {
		sql = "select no, title, name, note, id, wdate, hit, videopath, filename, downloadcount, filerealname from board where no = " + no;
		dbm.DBOpen();
		dbm.OpenQuery(sql);
		while(dbm.ResultNext())	{
			no 				= dbm.getString("no");
			title 			= dbm.getString("title");
			name 			= dbm.getString("name");
			note 			= dbm.getString("note");
			wdate 			= dbm.getString("wdate");
			id 				= dbm.getString("id");
			hit 			= dbm.getString("hit");
			videopath 		= dbm.getString("videopath");
			filename 		= dbm.getString("filename");
			downloadcount   = dbm.getString("downloadcount");
			filerealname    = dbm.getString("filerealname");
			//DB
		}
		
		sql =  "update board set hit = hit+1 where no=" + no;	// 조회수 ++1
		dbm.Excute(sql);
	} catch(Exception e) {
		System.out.println("ERROR:" + e.getMessage());
	}
%>
<body>

<script>

	function Check()	{
		if(document.form.note.value == "")
		{
			alert("댓글을 입력하세요.");
			document.form.note.focus();
			return;
		}
		$.ajax({
			url:"VIDEO_commentok.jsp",
			type:"post",
			data:$("form").serialize(),
			success:function()	{
				alert("댓글을 입력하였습니다.");
				location.reload();
			}
		});
	}
</script>
                <div class="row">
		<div class="col-2"></div>
	
                <div class="col-8">
                  <!-- 헤드 영역 시작-->
                  <div class="row-cols-1">
                  <br><br>
                    <table class="table table-borderless">
                          <tr>
                            <th colspan="1" style="text-align: left;">제목</th>
                            <td colspan="5" id="title" style="text-align:left;"><%= title %></td>
                          </tr>
	                        <tr>
			                    <th width="10%">작성자</th>
								<td id="writer" width="20%"><%= name %></td>
								<th width="10%">작성일</th>
								<td id="date" width="20%"><%= wdate %></td>
								<th width="10%">조회수</th>
								<td id="count"><%= hit %></td>
	                        </tr>
	                        <tr>
	                        	<th width="20%">첨부파일</th>
	                        	
	                        	
	                        	<% 
	                        	if(!filerealname.equals("null"))	{ //파일이 업로드가 된 상태라면
	                        	%>
	                        	<td id="file" width="20%"><a href="VIDEO_filedownload.jsp?filedownload=<%= filerealname %>"><%= filename %></a></td>
	                        	<% } else {
	                        		filerealname = "없음";
	                        		%><td id="file" width="20%"><%= filerealname %></td><%
	                        	%>
	                        	<% } %>
	                        	<th width="20%">첨부파일 다운로드 횟수</th>
	                        	<td id="filedowncount" width="20%"> <%= downloadcount %></td>
	                        </tr>
	                        <br>
	                        <tr height="450px">
								<th width="5%">내용</th>
								<td colspan="5" id="video" style="text-align:left;"><%= videopath %></td>
							</tr>
                      </table>
                  </div>
                  <!-- 헤드 영역 끝 -->
                  <!-- 본문 영역 시작 -->
                	
                  <!-- 본문 영역 끝 -->
                  <!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 댓글 영역 시작 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
                  <div class="row-cols-1">
                    <table style="width:100%;">
                          <tr>
                            <th scope="row" style="text-align: left;width: 15%;">작성자</th>
                            <td style="width: 55%;">내용</td>
                            <td style="width: 15%;">작성일</td>
                            
                          </tr>
                          <%
                          	//RNo(댓글번호)를 DB에서 가져오는 이유는 댓글을 수정/삭제를 하기 위함이다.
                          	String RNo = "";
                          	String Rid = "";
                          	String Reply = "";
                          	String Rdate = "";
                          	String SessionID = (String)session.getAttribute("id"); // 세션 영역에서 id를 가져옴
                          	if(SessionID == null)	{	//비로그인 상태라면 SessionID를 문자열1로 저장
                         		SessionID = "1";
                         	}
                          	try {			//게시글에 대한 댓글작성자, 댓글내용, 댓글쓴날짜를 가져오는데 RNo(댓글번호)를 내림차순함.
                          		sql = "select id, RNo, Reply, Rdate from comment where no="+no+" order by RNo desc";
                          		dbm.OpenQuery(sql);                          		
                    			while(dbm.ResultNext())	{ // 결과값 즉 DB에 저장되어있는 데이터를 얻어옴
                    				RNo   = dbm.getString("RNo");
	                    			Rid   = dbm.getString("id");	// 댓글작성자 아이디
	                    			Reply = dbm.getString("Reply");
	                    			Rdate = dbm.getString("Rdate");
	                    	%>
	                    		  <tr id="tr"> <!--  댓글 여기다 출력되게 할거임 -->
	                              	<td><%= Rid %></td>	<!--  작성자 -->
	                              	<td id="Comment_td<%= RNo %>"><%= Reply %></td>	<!--  내용 -->	<!-- Comment_td1, Comment_td2, Comment_td3  -->
	                              	<td><%= Rdate %></td>	<!--  작성일 -->
	                             <% 
	                             	// 로그인 한 사람의 아이디와 댓글을 쓴 사람의 id를 비교하는데 SessionID가 Rid와 같거나 SessionID가 admin(관리자)이라면 수정/삭제버튼을 보여주게 한다.
	                             	if(SessionID.equals(Rid) || SessionID.equals("admin"))	{ %>
	                              	<td><button type="button" class="btn btn-secondary mb-2" onclick="MODIFY(<%= RNo %>)">수정</button><a href="VIDEO_replydelete.jsp?RNo=<%= RNo %>&no=<%= no %>" class="btn btn-secondary mb-2">삭제</a></td>	<!--  수정/삭제 -->
	                             <% } %>
	                              </tr>
	                              
	                        <%
                    			}
                    		%>	
                          <% if(SessionID != "1")	 { %>	<!-- 1이면 비로그인 상태 -->
                          <tr>
                            <td colspan="3">
                            	<form id="form" name="form">
                            		<input class="form-control" type="text" name="note" placeholder="댓글 입력">
                            		<input type="hidden" name="no" value="<%= no %>">
                            		<input type="hidden" name="id" value="<%= SessionID %>">
                            </td>
                            <td>
                              <button type="button" class="btn btn-primary" onclick="Check()"> &nbsp;&nbsp; 등록 &nbsp;&nbsp;</button>
                              </form>
                            </td>
                          <% } %>  
                          </tr>
                      </table>
                  </div>
                  <br>
                  <!-- 댓글 영역 끝 -->
                  <!-- 버튼 영역 시작 -->
                  <div class="row-cols-2">
                    <div class="float-left">
                        <button type="button" class="btn btn-secondary mb-2" onclick="location.href='VIDEO_list.jsp'">목록</button>
                    </div>
                  </div>
                  <!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
                  <div class="row-cols-2">
                    <div class="float-right" style="position:relative;top:20px;left:11%; width:400px; margin-bottom:10px;">
                    	<% 
                    		String BoardId = "";
                    		sql = "select id from board where no='" + no + "'";
                    		dbm.OpenQuery(sql);
                    		while(dbm.ResultNext())	{
                    			BoardId = dbm.getString("id");
                    		}
                    		
                    		if(SessionID.equals(BoardId) || SessionID.equals("admin"))	{
                    	%>
                        <button type="button" class="btn btn-secondary mb-2" onclick="location.href='VIDEO_modify.jsp?no=<%= no %>'">수정</button>
                        <button type="button" class="btn btn-secondary mb-2" onclick="location.href='VIDEO_delete.jsp?no=<%= no %>'">삭제</button>
                        <% } 
                            if(!(SessionID.equals("1")))	{
                        %>
                        <button type="button" class="btn btn-info mb-2" onclick="location.href='VIDEO_dapgle.jsp?no=<%= no %>'">답변</button>
                        <button type="button" class="btn btn-primary mb-2" onclick="location.href='VIDEO_write.jsp'">글쓰기</button>
                        <% } %>
					</div>
                  </div>
                  <!-- 버튼 영역 끝 -->
                </div>
               <div class="col-2"></div>
              </div>
              </body>
						  <%  dbm.CloseQuery();
						  	  dbm.DBClose();
                          	} catch(Exception e)	{
                          		System.out.println("ERROR:" + e.getMessage());
                          	}
                          %>
<%@ include file="Footer.jsp"%>
<script>
	function MODIFY(num)	{	// num  = RNo
		var output = "";
		var data = $("#Comment_td"+num).text();	//파라미터로 글번호(no)와 댓글번호(RNo)를 넘겨주는 이유는 댓글번호(RNo)로 댓글을 수정하기 위함이고 글번호(no)는 뒤로 돌아가려고
		output += "<form id='formreply' name='formreply' method='post' action='VIDEO_replymodify.jsp?no=<%= no %>&RNo="+num+"''>"
		output += " <input type='text' value='"+data+"' id='commentreply' name='commentreply' size='70'>";
		output += "	<input type='button' class='btn btn-primary' value='저장' onclick='SaveFn()'>";
		output += "</form>";
		$("#Comment_td"+ num).html(output);
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





