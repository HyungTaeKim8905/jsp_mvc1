<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="DB.*" %>
<%	//�Խñ� ���� ���ִ� ����
	String no  = request.getParameter("no");
	String sql = "";
	DBManager dbm = new DBManager();
	
	try {
		sql = "delete from board where no='" + no + "'";
		dbm.DBOpen();
		dbm.Excute(sql);
		dbm.DBClose();
	} catch(Exception e)	{
		System.out.println("ERROR: " + e.getMessage());
	}
%>
<script> alert("�Խñ��� �����Ͽ����ϴ�."); location.href="VIDEO_list.jsp"</script>