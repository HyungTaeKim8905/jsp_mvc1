<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage = "ErrorPage.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<form id="board" name="board" method="post" action="filestest.jsp" enctype="multipart/form-data">		<!--  submit() �Լ��� ȣ������� insertok�� �����͸� ������ -->
		���� :  <input type="file"  style="width:100px" id="file" name="file[]" multiple>
		<input type="submit" value="����">
	</form>
</body>
</html>