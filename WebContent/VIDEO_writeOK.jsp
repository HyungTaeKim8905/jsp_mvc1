<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="DB.*" %>

<%	//*****************************���� ó��****************************************
	String uploadPath = request.getRealPath("/upload");		//������ ���ε��� �������� �������� ����
	int size 			= 1024*1024*15;						// 15�ް��� ������. 15�ް��� ���� ��� ���� �߻�
	String filename	    = "";								// ������ ������ ���� ���ϸ�
	String filerealname = "";								// ������ ������ ����� ������ �̸�
	String filepath     = uploadPath;						// ����� ������ ���
	
	try {
		MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());

		request.setCharacterEncoding("UTF-8");	//insert.jsp���� �Ѿ���� �����͸� �������ʰ� �޾ƿ�
		String id    	  = multi.getParameter("id");
		String title 	  = multi.getParameter("title");
		String name  	  = multi.getParameter("name");		// user ���̺��ִ� name�� ���� �׷��� board���̺��� name�� ������.
		String note  	  = multi.getParameter("note");
		String videopath  = multi.getParameter("videopath");
		
		Enumeration files = multi.getFileNames();		//������ ���۵Ǿ�� ���� Ÿ���� �Է»����� �̸��� ��ȯ�Ѵ�.
		String file1 = (String)files.nextElement();		//������ ���ε� ���� �� ù��° �Է»����� �̸��� ���´�.
		filerealname = multi.getFilesystemName(file1);	//��6+`�ε�� ������ ���� �� ���ε�� ���� ���ϸ��� ���´�.
		filename = multi.getOriginalFileName(file1);	//���ε�� ������ ó���� ������ ������ ���� ���ϸ��� ���´�.
		
		String sql = "";
		int    max = 0;	// ref�� 0���� ���� �ʰ��ϱ� ���� ���� �ϳ� ����
		DBManager dbm = new DBManager();
		dbm.DBOpen();
		sql = "select ifnull(max(no), 0) as 'max' from board";		// ifnull�޼��带 ������� ������ max�� null�� ��ȯ�Ѵ�.
		dbm.OpenQuery(sql);
		while(dbm.ResultNext())	{
			max = dbm.getInt("max");
		}
		// int max��� ������ �����߰�
		// select������ Num�� max���� �޾ƿԽ��ϴ�. �ֳ��ϸ� �۹�ȣ�� ������ ���� ���� ��ȣ���� +1�� �Ǿ� ��������� ������ 
		// �ڽ��� �۹�ȣ�� ref�ֱ� ���� ����Դϴ�.
		
		sql = "insert into board ";
		sql = sql + "(id,title,note,name,wdate,videopath, filename, filerealname, filepath, ref) ";
		sql = sql + "values ";
		sql = sql + "('" + id + "', '" + title + "','" + note + "','" + name + "',now(),'" + videopath + "','" + filename + "','" + filerealname + "','" + filepath + "', " + (max + 1) + ")";
		dbm.Excute(sql);
		dbm.CloseQuery();
		dbm.DBClose();
	} catch(Exception e)	{		//������ ��������(�ϵ��ũ�� �� á����) �������� ����������Ѵ�
		System.out.println("ERROR:" + e.getMessage());
	}
%>
<script> alert("���� ����Ͽ����ϴ�."); location.href="VIDEO_list.jsp" </script>
