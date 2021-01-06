<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage = "ErrorPage.jsp"%>
<%@ page import = "java.sql.*" %>
<%@ include file="Header.jsp"%>
<body>
<%
	String no = request.getParameter("no");
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try {
		String jdbcDriver = "jdbc:apache:commons:dbcp:mboard";
		String query = "delete from qnaboard where QNAno='"+no+"' ;";
		
		conn = DriverManager.getConnection(jdbcDriver);
		
		pstmt = conn.prepareStatement(query);
		
		pstmt.executeUpdate();
	}finally {
		if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
%>
글삭제 완료
<meta http-equiv="refresh" content="0;./QNAlist.jsp" ></meta>

</body>
<%@ include file="Footer.jsp"%>