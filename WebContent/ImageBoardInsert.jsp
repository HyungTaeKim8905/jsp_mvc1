<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% String curpage = request.getParameter("page"); // HTTP Request헤더에 page=1 or page=2 라는 파라미터를 붙여 데이터를 전송하면 request객체의 getParameter() 메서드로 데이터를 받은 후 curpage에 저장%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<script src="jquery-3.5.1.min.js"></script>
<script>
	function DoSubmit()
	{
		//alert(document.board.title.value);
		//document.board.title.value.trim(); 해주는 이유는 공백을 넣을수 있기 떄문이다.
		if(document.board.name.value == "")
		{
			alert("작성자를 입력하세요.");
			document.board.name.focus();
			return;
		}
		if(document.board.title.value == "")
		{
			alert("제목을 입력하세요.");
			document.board.title.focus();
			return;
		}
		if(document.board.note.value == "")
		{
			alert("내용을 입력하세요.");
			document.board.note.focus();
			return;
		}
		document.board.submit();
	}
		function readInputFile(input) {
					if(input.files && input.files[0]) { 	//파일이 선택된 상태라면
						var reader = new FileReader();		// 파일을 읽기 위해서 객체 생성
						reader.onload = function (e) {		// 파일을 읽어들이기를 성공했을때 호출되는 이벤트
							$('#pic').html("<img src="+ e.target.result +" width='200px'><button type='button' id='del'>삭제</button>");
						}
						reader.readAsDataURL(input.files[0]);
						  
					}
				}
				
				$(document).ready(function() 	{
					$("input[type=file]").on('change', function(){
					readInputFile(this);
				});
					
					$(document).on("click","#del",function(){
						$("#pic").html("");
						$("input:file").val("");
					});
				});
				
				function readInputFile(input) {
					if(input.files && input.files[0]) { 	//파일이 선택된 상태라면
						var reader = new FileReader();		// 파일을 읽기 위해서 객체 생성
						reader.onload = function (e) {		// 파일을 읽어들이기를 성공했을때 호출되는 이벤트
							$('#pic').html("<img src="+ e.target.result +" width='200px'><button type='button' id='del'>삭제</button>");
						}
						reader.readAsDataURL(input.files[0]);
						  
					}
				}
				
				$(document).ready(function() 	{
					$("input[type=file]").on('change', function(){
					readInputFile(this);
				});
					
					$(document).on("click","#del",function(){
						$("#pic").html("");
						$("input:file").val("");
					});
				});
</script>
<title>글 등록</title>
</head>
<body>
	<section>
			<article>
				<h2>글 작성</h2>
				<form id="board" name="board" action="insertok.jsp" method="post">
					<fieldset>
						<div id="form">
							<h3>
								작성자 <span>*</span><br>
								<input type="text" name="name" id="name">
							</h3>
							<h3>
								제목 <span>*</span><br> 
								<input type="password" name="title" id="title">
							</h3>
							<h3>
								줄거리 <span>*</span><br>
								<textarea>
									
								</textarea>
							</h3>		
							<h3>
								 <div id="pic" name="pic" style="text-align:left;"></div>
								첨부파일 <input type="file" id="rePic" name="rePic" style="padding:5px;">
							</h3>		
						</div>
					</fieldset>
					<br>
					<a href="javascript:DoSubmit();">저장하기</a>
					<a href="list.jsp">취소</a>
				</form>
				<br>
			</article>
		</section>
</body>
</html>