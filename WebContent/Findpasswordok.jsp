<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage = "ErrorPage.jsp"%>
<%@ page import="DB.*" %>
<%
	String id = request.getParameter("id");
	String password = null;
	DBManager dbm = new DBManager();
	
	try
	{
		 dbm.FindPassWord(id);
		 if(dbm.ResultNext()){
			 password = dbm.getString("password");
		 }
		 else	{
			 %> <script> alert("아이디를 잘못 입력하였습니다."); history.back();</script> <%
		 }
		dbm.CloseQuery();
		dbm.DBClose();
	}catch(Exception e)
	{
		out.println("ERROR:" + e.getMessage());
	}
%>
비밀번호 : <%= password %>
<!DOCTYPE html>
<html>
	<head>
		<title>비밀번호 찾기</title>
	</head>
	<script src="jquery-3.5.1.min.js"></script>
</html>
<body>									<!-- 찾은 패스워드를 파라미터로 넘겨줌 -->
	<button type="button" onclick="location.href='Changepassword.jsp?id=<%= id %>'">비밀번호 변경</button>&nbsp<button type="button" onclick="window.close()">취소</button>
	<div id="div1">
		
	</div>
</body>