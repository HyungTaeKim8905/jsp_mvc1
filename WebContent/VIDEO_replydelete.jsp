<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="DB.*" %>
<%
	String no = request.getParameter("no");
	String RNo = request.getParameter("RNo");
	String sql = "";
	DBManager dbm = new DBManager();
	try	{
		sql = "delete from comment where RNo='" + RNo + "'";
		dbm.DBOpen();
		dbm.Excute(sql);
		dbm.DBClose();
	} catch(Exception e){
		System.out.println("ERROR:" + e.getMessage());
	}
%>
<script> alert("댓글을 삭제하였습니다."); location.href="VIDEO_view.jsp?no=<%= no %>"</script>