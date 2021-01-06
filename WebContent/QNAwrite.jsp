<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="Header.jsp"%>

<style>
	
    .note-group-select-from-files { display: none!important; }
</style>

<body>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
	<div class="row">
		<div class="col-2"></div>
		<div class="col-8">
			<!-- 제목 작성 영역 시작-->
			<div class="row-cols-1">
			<br><br>
			<form name="QNAw" id= "QNAw" action="QNAwriteOK.jsp?id=<%= id %>" method = "post" accept-charset="UTF-8" enctype="multipart/form-data">
				<div class="row">
					<input style="width:99%; height:30px" type="text" name="name" class="form-control" id="VIDEO_name" value="<%= name %>" readonly>
				</div>
				<br>
					<input type="text" class="form-control" name="QNAtitle" id="QNAtitle"
						placeholder="제목을 입력해주세요" required autofocus>
			</div>
			<!-- 제목 작성 영역 끝 -->
			<!-- 본문 작성 영역 시작 -->
			<br>
			 <textarea id="summernote" name="summernote"></textarea>
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
					<button type="submit" class="btn btn-primary mb-2"
					onclick="location.href='QNAwriteOK.jsp'">등록</button>
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