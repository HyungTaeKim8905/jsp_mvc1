<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage = "ErrorPage.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<form id="board" name="board" method="post" action="filestest.jsp" enctype="multipart/form-data">		<!--  submit() 함수가 호출됐을때 insertok로 데이터를 보내라 -->
		파일 :  <input type="file"  style="width:100px" id="file" name="file[]" multiple>
		<input type="submit" value="전송">
	</form>
</body>
</html>