<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DB.*" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Summernote Lite</title>
	
	<!-- js 라이브러리 *필수* -->
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
	
	<!-- 글쓰기 css 부스트랩 *필수* -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.css" rel="stylesheet">
	
	<!-- 글쓰기 js 부스트랩 *필수* -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.js"></script>
	
	<!-- 글쓰기 도구 한글패치 -->
	<script src="summernote/summernote-ko-KR.js"></script>

<!-- 본문 라이브러리 적용 시작ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ-->
	<script>
		$(document).ready(function() {
			//여기 아래 부분 본문 textarea 또는 div의 id값과 동일하게 해줄것.
			$('#summernote').summernote({
				  height: 500,                 // 에디터 높이
				  minHeight: null,             // 최소 높이
				  maxHeight: null,             // 최대 높이
				  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
				  lang: "ko-KR",					// 한글 설정
				  placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
		          
			});
		});
	</script>
	<script>

	function DoSubmit()
	{
		if(document.frm.title.value == "")
		{
			alert("제목을 입력하세요.");
			document.frm.title.focus();
			return;
		}
		if(document.frm.summernote.value == "")
		{
			alert("내용을 입력하세요.");
			document.frm.summernote.focus();
			return;		
		}
		if(document.frm.VIDEO_add.value == "")	{
			alert("동영상 주소를 입력하세요.");
			document.frm.VIDEO_add.focus();
			return;
		}
		document.frm.submit();
	}
	</script>
<!-- 본문 라이브러리 적용 끝ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ-->
	
<!-- 이미지첨부 파일선택 버튼 감추기ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ-->
	<style>
		.note-group-select-from-files { 
			display: none!important; 
		}
	</style>
<!-- 이미지첨부 파일선택 버튼 감추기 적용 끝ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ-->

	
	</head>
	
	
	<body>
	
	<br>
	<%	// 로그인 한 사람의 name을 가져오기 위해 세션영역에 저장되어있는 id를 가져옴
		// id를 활용해 db에서 로그인한 사람의 name을 가져옴.
		
		String SessionID = (String)session.getAttribute("id");
		if(SessionID == null)	{
			%> <script> alert("로그인 후 이용해주세요."); location.href="SignIn.jsp"</script> <%
		}
		String no = request.getParameter("no");
		String name = "";
		String sql = "";
		DBManager dbm = new DBManager();
		try {
			sql = "select name from user where id='" + SessionID + "'";
			dbm.DBOpen();
			dbm.OpenQuery(sql);
			while(dbm.ResultNext())	{
				name = dbm.getString("name");
			}
			dbm.CloseQuery();
			dbm.DBClose();
		} catch(Exception e){
			System.out.println("ERROR:" + e.getMessage());
		}
	%>												<!-- 파라미터로 SessionID넘겨주는 이유는 board테이블에 id를 저장하기 위해서 -->
	<form id="frm" name="frm" action="VIDEO_dapgleok.jsp?no=<%= no %>&id=<%= SessionID %>" method="post" enctype="multipart/form-data">
		<table align="center" width="60%">
<!-- ㅡㅡㅡㅡㅡ 작성자 영역 시작ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ--> 
			<tr>
				<td>
					<input style="width:99%; height:30px" type="text" name="name" class="form-control" id="VIDEO_name" value="<%= name %>" readonly>
				</td>
			</tr>
<!-- ㅡㅡㅡㅡㅡ 제목 작성 영역 끝ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ-->
<!-- ㅡㅡㅡㅡㅡ 제목 작성 영역 시작ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ ㅡㅡㅡㅡㅡㅡㅡㅡㅡ--> 
			<tr>
				<td>
					<input style="width:99%; height:30px" type="text" name="title" class="form-control" id="VIDEO_title" placeholder="제목을 입력해주세요">
				</td>
			</tr>
<!-- ㅡㅡㅡㅡㅡ 제목 작성 영역 끝ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ-->
			
<!-- ㅡㅡㅡㅡㅡ 본문 작성 영역 시작ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ-->
			<tr>
				<td>
					<textarea class="summernote" id="summernote" name="note" placeholder="내용을 입력해주세요"></textarea>
				</td>
			</tr>
<!-- ㅡㅡㅡㅡㅡ 본문 작성 영역 끝ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ-->
			
<!-- ㅡㅡㅡㅡㅡ 파일첨부영역 시작ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ-->
			<tr>
				<td>
					<input type="file" class="form-control-file" id="VIDEO_file" name="file">
				</td>
			</tr>
			<tr>					
				<td>	<!--  동영상 주소 -->
					<input style="width:99%; height:30px" type="text" name="videopath" class="form-control" id="VIDEO_add" placeholder="동영상 주소를 입력해주세요">
				</td>
			</tr>
<!-- ㅡㅡㅡㅡㅡ 파일첨부영역 끝ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ-->
		
		</table>
		
		<br>
		
		<table align="center" width="60%">

<!-- ㅡㅡㅡㅡㅡ 버튼 영역 시작ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ-->
			<tr>
				<td align="center">
					<button type="button" class="btn btn-primary mb-2" onclick="DoSubmit()">등록</button>
					<button type="button" class="btn btn-secondary mb-2" onclick="location.href='VIDEO_list.jsp'">취소</button>
				</td>
			</tr>
<!-- ㅡㅡㅡㅡㅡ 버튼 영역 끝ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ-->
		</table>
	</form>
</body>
</html>
