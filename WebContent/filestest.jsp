<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage = "ErrorPage.jsp"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="DB.*" %>

<%
	String uploadPath = request.getRealPath("/upload"); // ������ ���ε��� �������� �������� ������.
	int size = 1024*1024*15;		// 15�ް��� ���� 15�ް��� ���� ��� ���� �߻�
	String filename = "";	    	// ������ ������ ���� ���ϸ�
	String filerealname = "";		//������ ������ ����� ������ �̸�
	String filepath = uploadPath; 	//����� ������ ���
	
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