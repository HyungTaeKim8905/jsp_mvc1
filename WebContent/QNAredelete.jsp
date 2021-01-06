<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage = "ErrorPage.jsp"%>
<%@ page import = "java.sql.*" %>
<%
	String no = request.getParameter("no");
	String RNo = request.getParameter("RNo");
	String sql = "";
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try	{
		String jdbcDriver = "jdbc:apache:commons:dbcp:mboard";
		conn = DriverManager.getConnection(jdbcDriver);
		
		sql = "delete from qnareply where QNAreno='" + RNo + "'";
		pstmt = conn.prepareStatement(sql);
				
		pstmt.executeUpdate();
		pstmt.close();
	} catch(Exception e){
		System.out.println("ERROR:" + e.getMessage());
	}
%>
<script> alert("댓글을 삭제하였습니다."); location.href="QNAview.jsp?no=<%= no %>"</script>