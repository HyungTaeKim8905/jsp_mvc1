<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="DB.*" %>
<%
String id = null;
//���ǿ� id��� �̸��� �Ӽ� ���� ����Ǿ� ���� �ʰų� id �̸��� �Ӽ� ���� admin�� �ƴ϶�� �α��� ��������(login.jsp) �����̵� ��Ŵ
if((session.getAttribute("id") == null) || !((String)session.getAttribute("id")).equals("admin"))	{
	%> <script> alert("������ �����ϴ�."); location.href="login.jsp";</script><%
}

String deleteid = request.getParameter("id");
DBManager dbm = new DBManager();
try
{
	dbm.MemberDelete(deleteid);
	dbm.DBClose();
}
catch (Exception e)
{	
	out.println("ERROR:" + e.getMessage());
	return;
}


 %>
 <script>alert("ȸ�������� �����Ǿ����ϴ�."); history.back();</script>