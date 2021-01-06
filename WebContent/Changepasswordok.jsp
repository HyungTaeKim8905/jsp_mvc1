<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="DB.*" %>
<%
	String id = request.getParameter("id");
	String newpassword = request.getParameter("newpassword");
	
	DBManager dbm = new DBManager();
	String sql = "";
	
	try {
		dbm.DBOpen();
		sql += "update user set password = '"+ newpassword  +"' where id='"+id+"'";
		dbm.Excute(sql);
		dbm.DBClose();
	}catch(Exception e)	{
		System.out.println("DB오류");
	}
%>
<script>alert("비밀번호가 변경 되었습니다."); window.close();</script>