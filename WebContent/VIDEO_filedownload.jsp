<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.*"%>
<%@ page import="DB.*" %>
<%@ page import="java.sql.*" %>
<% // ÷�������� �ٿ�ε� ���ִ� ������ %>
<%
	String filedownload = request.getParameter("filedownload");	//Ŭ���̾�Ʈ���� �Ķ���ͷ� ���۵Ǿ� ���� �ٿ�ε��� ���� �̸��� �޴� �κ�
	DBManager dbm = new DBManager();
	try{
		dbm.downloadcount(filedownload);  //DBManager�� �ִ� �ٿ�ε� �� ���� ����
	} catch(Exception e){
		System.out.println("ERROR:" + e.getMessage());
	}
	String savePath = "upload";	// ������ ������ ���ε�� �������� �����ϴ� �κ�
	ServletContext context = getServletContext();
	String sDownloadPath = context.getRealPath(savePath);	//upload������ ���� ���� ���� �������� ��θ� ������ �κ��̴�.
	String sFilePath = sDownloadPath + "\\" + filedownload;	//�ٿ�ε� �� ������ ��ο� ������ �̸��� ��ħ
	byte b[] = new byte[4096];
	FileInputStream in = new FileInputStream(sFilePath);	//�ٿ�ε��� ������ ��θ� ���ڷ� �����ϸ鼭 FileInputStream��ü�� ����
	String sMimeType = getServletContext().getMimeType(sFilePath);	//�ٿ�ε��� ������ ����Ÿ���� ����
	System.out.println("sMimeType>>>" + sMimeType);	

	if (sMimeType == null)	//�ٿ�ε��� ������ ���� Ÿ���� ����� ��ȯ���� ������ �⺻ ����Ÿ���� �����ϴ� �κ��̴�.
		sMimeType = "application/octet-stream";

	response.setContentType(sMimeType);	//������ �������� ���� Ÿ���� �ٿ�ε� �� ������ ���� Ÿ������ �����ϴ� �κ��̴�.
	String agent = request.getHeader("User-Agent");
	boolean ieBrowser = (agent.indexOf("MSIE") > -1) || (agent.indexOf("Trident") > -1);//Ŭ���̾�Ʈ�� ����ϴ� ������ ������ internet explorer������ �Ǵ��ϴ� �κ��̴�.

	if (ieBrowser) {	//���� ��� �������� ������ internet explorer�ΰ�� �ٿ�ε� �� �ѱ� ���ϸ��� ������ �ʵ��� ó���ϴ� �κ� 
						//���� ��� �������� ������ internet explorer�� ��� ���� �κ��� "+"���ڷ� ����ǹǷ� "+"���ڸ� �ٽ�
						//���� ����("%20")���� ������ �ְ� �ִ�.
		filedownload = URLEncoder.encode(filedownload, "UTF-8").replaceAll("\\+", "%20");
	} else {	//��� �������� ������ internet explorer�� �ƴѰ�� �ٿ�ε� �� �ѱ� ���ϸ��� ������ �ʵ��� ó���ϴ� �κ��̴�.
		filedownload = new String(filedownload.getBytes("UTF-8"), "iso-8859-1");
	}

	response.setHeader("Content-Disposition", "attachment; filename= " + filedownload);
	//���������� �ؼ��Ǵ� Ȯ������ ���ϵ� �ٿ�ε� �ڽ��� ����ǰ� ó���ϴ� �κ��̴�. ��� ���� ���� �� Content-Disposition���� attachment��
	//�����ϸ� ��� ���Ͽ� ���ؼ� �ٿ�ε� �ڽ��� ����ȴ�.
	ServletOutputStream out2 = response.getOutputStream();
	//���� �ٿ�ε� ������ �ϴ� ����Ʈ ��� ��� ��Ʈ�� ��ü�� �����ϴ� �κ��̴�. jsp��ü���� out�̶�� ���ڱ��
	//��� ��Ʈ���� �����ϹǷ� ��� ��Ʈ�� ��ü���� out2��� �����Ͽ���.
	int numRead;

	while ((numRead = in.read(b, 0, b.length)) != -1) {	// b ����Ʈ �迭 ��ü ������ �ٿ�ε� �� ���� ������ �о ���信 ���
														// �Ͽ� �ٿ�ε� ó���� �ϴ� �κ��̴�.
		out2.write(b, 0, numRead);
	}
	out2.flush();
	out2.close();
	in.close();
%>