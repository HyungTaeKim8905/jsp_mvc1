<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@page import="java.io.File"%> 
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ include file="Header.jsp"%>
<body>
	
<%
	request.setCharacterEncoding("UTF-8");

	int no = Integer.parseInt(request.getParameter("no"));
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String uploadPath = request.getRealPath("/upload");		//파일을 업로드할 서버상의 폴더명을 지정
	int size 			= 1024*1024*1;						// 파일 크기 제한 1메가
	String filename	    = "";								// 폼에서 선택한 원본 파일명
	String filerealname = "";								// 서버에 실제로 저장된 파일의 이르
	String filepath     = uploadPath;						// 저장될 파일의 경로
	
	ResultSet rs = null;
	try {
		MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());

		Enumeration files = multi.getFileNames();		//폼에서 전송되어온 파일 타입의 입력상자의 이름을 반환한다.
		String file2 = (String)files.nextElement();		//파일을 업로드 했을 때 첫번째 입력상자의 이름을 얻어온다.
		filerealname = multi.getFilesystemName(file2);	//업로드된 파일의 서버 상에 업로드된 실제 파일명을 얻어온다.
		filename = multi.getOriginalFileName(file2);
		
		String jdbcDriver = "jdbc:apache:commons:dbcp:mboard";
		String query = "update qnaboard set QNAtitle=?, QNAcontent=?, filename=?, filerealname=?, filepath=? "; 
		query += "where QNAno='"+ no + "' ";
		conn = DriverManager.getConnection(jdbcDriver);
		
		pstmt = conn.prepareStatement(query);
		
		pstmt.setString(1, multi.getParameter("QNAtitle"));
		pstmt.setString(2, multi.getParameter("summernote"));
		pstmt.setString(3, filename);
		pstmt.setString(4, filerealname);
		pstmt.setString(5, filepath);
		
		pstmt.executeUpdate();
	}finally {
		if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
%>
글작성 완료
<meta http-equiv="refresh" content="0;./QNAlist.jsp" ></meta>

</body>
<%@ include file="Footer.jsp"%>