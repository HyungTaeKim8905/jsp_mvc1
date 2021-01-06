<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ include file="Header.jsp"%>
<style>
	
    .note-group-select-from-files { display: none!important; }
</style>
<%
	String no = request.getParameter("no");
String title = "";
String writer = "";
String wdate = "";
String hit = "";
String content = "";

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try {
		String jdbcDriver = "jdbc:apache:commons:dbcp:mboard";
		String query = "select QNAtitle, QNAwriter, QNAwdate, QNAhit, QNAcontent from qnaboard where QNAno='"+no+"'";
		conn = DriverManager.getConnection(jdbcDriver);
		pstmt = conn.prepareStatement(query);
		
		rs = pstmt.executeQuery();
		rs.next();
		title = rs.getString(1);
		writer = rs.getString(2);
		wdate = rs.getString(3); 
		hit = rs.getString(4); 
		content = rs.getString(5);
		 }finally {
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		} 
%>
<body>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>

<div class="row">
		<div class="col-2"></div>
		<div class="col-8">
			<!-- 제목 작성 영역 시작-->
			<div class="row-cols-1">
			<br><br>
			<form name="QNAw" id= "QNAw" action="QNAanswerOK.jsp?no=<%=no %>&dep=2&id=<%= id %>" method="post" accept-charset="UTF-8" enctype="multipart/form-data">
				<div class="row">
				<input style="width:99%; height:30px" type="text" name="name" class="form-control" id="VIDEO_name" value="<%= name %>" readonly>
				</div>
				<br>
					<input type="text" class="form-control" name="QNAtitle" id="QNAtitle"
						placeholder="제목을 입력해주세요" value="<%= title%>"required autofocus>
			</div>
			<!-- 제목 작성 영역 끝 -->
			<!-- 본문 작성 영역 시작 -->
			<br>
			 <textarea id="summernote" name="summernote" >질문 내용 :<%=content%></textarea>
		    <script>
		      $('#summernote').summernote({
		        placeholder: '내용을 입력해주세요',
		        tabsize: 2,
		        height: 250
		      });
		    </script>
			
			<!-- 본문 작성 영역 끝 -->
			<!-- 파일첨부영역 시작 -->
			<br>
			<div class="row-cols-1">
				<h5>
					<input type="file" class="form-control-file" id="QNAfile" name="file">
				</h5>
			</div>
			<!-- 파일첨부영역 끝 -->
			<!-- 버튼 영역 시작 -->
			
			<div class="row-cols-1">
				<div class="float-right">
					<button type="submit" class="btn btn-primary mb-2">등록</button>
					<button type="button" class="btn btn-secondary mb-2"
						onclick="location.href='QNAlist.jsp'">취소</button>
				</div>
			</div>
			</form>
			<!-- 버튼 영역 끝 -->
		</div>
		<div class="col-2"></div>
	</div>


</body>


<%@ include file="Footer.jsp"%>