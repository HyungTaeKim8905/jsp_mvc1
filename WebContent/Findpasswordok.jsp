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
			 %> <script> alert("���̵� �߸� �Է��Ͽ����ϴ�."); history.back();</script> <%
		 }
		dbm.CloseQuery();
		dbm.DBClose();
	}catch(Exception e)
	{
		out.println("ERROR:" + e.getMessage());
	}
%>
��й�ȣ : <%= password %>
<!DOCTYPE html>
<html>
	<head>
		<title>��й�ȣ ã��</title>
	</head>
	<script src="jquery-3.5.1.min.js"></script>
</html>
<body>									<!-- ã�� �н����带 �Ķ���ͷ� �Ѱ��� -->
	<button type="button" onclick="location.href='Changepassword.jsp?id=<%= id %>'">��й�ȣ ����</button>&nbsp<button type="button" onclick="window.close()">���</button>
	<div id="div1">
		
	</div>
</body>