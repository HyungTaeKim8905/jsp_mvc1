<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage = "ErrorPage.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="jquery-3.5.1.min.js"></script>
  <script>
  	$(document).ready(function()	{
  		$("form").submit(function(){		// true�� ������ �ǰ� false�� ���� �ȵǰ�?
			return true;
  		});
  	});
  </script>
</head>
<body>
	<form id="board" name="board" method="post" action="Findpasswordok.jsp">		<!--  submit() �Լ��� ȣ������� insertok�� �����͸� ������ -->
	���̵� : <input type="text" style="width:100px" id="id" name="id">
	<input type="submit" value="���̵� ã��">
</body>
</html>