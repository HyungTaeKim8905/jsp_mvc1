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
  		$("form").submit(function(){		// true면 전송이 되고 false면 전송 안되고?
			return true;
  		});
  	});
  </script>
</head>
<body>
	<form id="board" name="board" method="post" action="Findpasswordok.jsp">		<!--  submit() 함수가 호출됐을때 insertok로 데이터를 보내라 -->
	아이디 : <input type="text" style="width:100px" id="id" name="id">
	<input type="submit" value="아이디 찾기">
</body>
</html>