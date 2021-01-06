<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage = "ErrorPage.jsp"%>
<%@ page import = "java.sql.*" %>
	
<%
	request.setCharacterEncoding("UTF-8");
	
	//글 번호 받아오기
	String no = request.getParameter("no");
	//댓글 깊이 받아오기
	String redep = request.getParameter("redep");
	int redepin = Integer.parseInt(redep);
	//아이디 받아오기
	String id = request.getParameter("id");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try {
		String jdbcDriver = "jdbc:apache:commons:dbcp:mboard";
		conn = DriverManager.getConnection(jdbcDriver);
		
		if(redepin==1){
		//작성
		String query = "insert into qnareply(QNArecontent, QNAno, QNArewdate, id) values(?, ?, now(), ?) ;";
		
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, request.getParameter("QNArecontent"));
		pstmt.setString(2, request.getParameter("no"));
		pstmt.setString(3, id);
				
		pstmt.executeUpdate();
		pstmt.close();
		
		//수정
		query = "update qnareply set repano = QNAreno where repano = 0 order by QNAreno desc limit 5";
		pstmt = conn.prepareStatement(query);
		pstmt.executeUpdate();
		}
		if(redepin==2){
			//작성
			String query = "insert into qnareply(QNArecontent, QNAno, QNArewdate, QNAredep, repano, id) values(?, ?, now(), ?, ?, ?) ;";
			
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, request.getParameter("QNArecontent"));
			pstmt.setString(2, request.getParameter("no"));
			pstmt.setInt(3, redepin);
			pstmt.setString(4, request.getParameter("rereno"));
			pstmt.setString(5, id);
			
			pstmt.executeUpdate();
		}
	}finally {
		if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
%>
댓글작성 완료


<!-- 보고 있던 글로 가기 -->
<meta http-equiv="refresh" content="0;./QNAview.jsp?no=<%=no %>" ></meta>

</body>
<%@ include file="Footer.jsp"%>