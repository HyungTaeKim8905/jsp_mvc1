<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="DB.*" %>
<%
	String no = request.getParameter("no");
	String RNo = request.getParameter("RNo");
	String Reply = request.getParameter("commentreply");
	String sql = "";
	DBManager dbm = new DBManager();
	try	{
		sql = "update comment set Reply='"+Reply+"' where RNo='"+RNo+"'";
		dbm.DBOpen();
		dbm.Excute(sql);
		dbm.DBClose();
	} catch(Exception e)	{
		System.out.println("ERROR" + e.getMessage());
	}
%>
<script>alert("����� �����Ͽ����ϴ�."); location.href="VIDEO_view.jsp?no=<%= no %>"</script>