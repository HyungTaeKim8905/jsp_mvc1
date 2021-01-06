<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="DB.*" %>

<% 	//*****************************���� ó��****************************************
	String uploadPath = request.getRealPath("/upload");		//������ ���ε��� �������� �������� ����
	int size 			= 1024*1024*15;						// 15�ް��� ������. 15�ް��� ���� ��� ���� �߻�
	String filename	    = "";								// ������ ������ ���� ���ϸ�
	String filerealname = "";								// ������ ������ ����� ������ �̸�
	String filepath     = uploadPath;						// ����� ������ ���
	
	int ref     = 0;		//���ñ� ��ȣ(�θ��� �۹�ȣ�� �����ϴ� �÷�)
	int indent  = 0;		//��� ����(������ ������� ����� ��������� �����ϱ����� �鿩����
	int step    = 0;		//���ñ� �� ��� ����(���� ��۳����� ��¼����� ���� �ʵ�)3
	
	try {
		MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());

		request.setCharacterEncoding("UTF-8");	//insert.jsp���� �Ѿ���� �����͸� �������ʰ� �޾ƿ�
		String no    	  = multi.getParameter("no");
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
		
		sql= "select ref, indent, step from board where no='" + no + "'";
		dbm.DBOpen();
		dbm.OpenQuery(sql);
		while(dbm.ResultNext()){		//������ ref, indent, step�� �޾ƿ�
			ref = dbm.getInt("ref");
			indent = dbm.getInt("indent");
			step = dbm.getInt("step");
		}
		
		//update���� �̿��ؼ� ref���� �ҷ��� ref�� ���� step�� �ҷ��� step������ ū �ڷ���� step�� +1 ��Ų��.
		sql="update board set step = step+1 where ref="+ref+" and step>" + step;
		dbm.Excute(sql);
		
		sql = "insert into board ";			//videopath
		sql = sql + "(id, title, note, name, wdate,videopath, filename, filerealname, filepath, ref, indent, step) ";
		sql = sql + "values ";
		sql = sql + "('" + id + "', '" + title + "','" + note + "','" + name + "',now(),'" + videopath + "','" + filename + "','" + filerealname + "','" + filepath + "', " + ref + ", " + (indent + 1) + ", " + (step + 1) + ")";
		dbm.Excute(sql);
		dbm.CloseQuery();
		dbm.DBClose();
	} catch(Exception e)	{		//������ ��������(�ϵ��ũ�� �� á����) �������� ����������Ѵ�
		System.out.println("ERROR:" + e.getMessage());
	}
%>
<script>alert("����� �ۼ��Ͽ����ϴ�."); location.href="VIDEO_list.jsp"</script>