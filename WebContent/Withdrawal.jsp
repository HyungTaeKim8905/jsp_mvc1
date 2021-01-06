<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="DB.*" %>
<% // 회원탈퇴를 처리해주는 프로세스 %>

<%
	String id = request.getParameter("id");
	String sql = "";
	
	
	try{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
			
		String jdbcDriver = "jdbc:apache:commons:dbcp:mboard";
		conn = DriverManager.getConnection(jdbcDriver);
		String query = "delete from qnaboard where id =? ;";
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		
		query = "delete from qnareply where id =? ;";
		pstmt = conn.prepareStatement(query);
		pstmt.executeUpdate();
		pstmt.setString(1, id);
		pstmt.close();
		conn.close();
	
	}catch(Exception e)	{
		System.out.println("ERROR:" + e.getMessage());
	}
	
	
	DBManager dbm = new DBManager();
	try	{
		dbm.DBOpen();
		sql = "delete from comment where id ='" + id + "'";
		dbm.Excute(sql);
		sql = "delete from board where id ='" + id + "'";
		dbm.Excute(sql);
		sql = "delete from user where id = '" + id + "'";
		dbm.Excute(sql);
		dbm.DBClose();
	} catch(Exception e)	{
		System.out.println("ERROR:" + e.getMessage());
	}
	session.invalidate();		//세션 종료
%>
<script> alert("정상적으로 회원탈퇴가 되었습니다."); location.href="ImageBoardList.jsp"</script>