<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage = "ErrorPage.jsp"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="DB.*" %>

<%
	String uploadPath = request.getRealPath("/upload"); // 파일을 업로드할 서버상의 폴더명을 지정함.
	int size = 1024*1024*15;		// 15메가로 지정 15메가를 넘을 경우 예외 발생
	String filename = "";	    	// 폼에서 선택한 원본 파일명
	String filerealname = "";		//서버에 실제로 저장된 파일의 이름
	String filepath = uploadPath; 	//저장될 파일의 경로
	
	try {
	MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
	String file[] = multi.getParameterValues("file");
	for(int i = 0; i < file.length; i++){
		out.println(file[i]);
	}
	} catch(Exception e){
		System.out.println("ERROR: " + e.getMessage());
	}
%>