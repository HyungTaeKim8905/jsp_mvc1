<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="DB.*"%>
<%@ page import="java.util.*" %>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%
	
	request.setCharacterEncoding("UTF-8");
	String no   = request.getParameter("no");
	String id   = request.getParameter("id");
	String note = request.getParameter("note");
	DBManager dbm = new DBManager();
	boolean result = dbm.commentok(no, id, note);
	if(result == true)	{
		%> <script> alert("����� �Է��Ͽ����ϴ�."); location.href="VIDEO_view.jsp?no=<%= no %>" </script> <%
	}
	else	{
		%> <script> alert("����Է¿� �����Ͽ����ϴ�."); location.href="VIDEO_view.jsp?no=<%= no %>" <%
	}
%>
