<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="DB.*" %>
<!--  *********************************************������ ������****************************************************************** -->
<%
String id = null;
//���ǿ� id��� �̸��� �Ӽ� ���� ����Ǿ� ���� �ʰų� id �̸��� �Ӽ� ���� admin�� �ƴ϶�� �α��� ��������(login.jsp) �����̵� ��Ŵ
if((session.getAttribute("id") == null) || !((String)session.getAttribute("id")).equals("admin"))	{
	%> <script> alert("������ �����ϴ�."); location.href="login.jsp";</script><%
}

DBManager dbm = new DBManager();

try
{	
	dbm.ClientList();
	%>
	<!-- ********************************* user ���̺� �����ϴ� ���ڵ� ����ŭ ȸ�� ������ ����ϴ� �κ� *****************************-->
	<h3>������ ������</h3>
	<table>
		<tr>
			<td colspan="2" class="td_title">ȸ�����</td>
		</tr>
		<% while(dbm.ResultNext())	{ %>
		<tr>
			<td><a href="Memberinfo.jsp?id=<%= dbm.getString("id") %>"><%= dbm.getString("id") %></a></td>
			<td><a href="Memberdelete.jsp?id=<%= dbm.getString("id") %>">����</a></td>
		</tr>
		<% } %>
	</table>
	
	<%
	
	dbm.CloseQuery();
	dbm.DBClose();
}
catch (Exception e)
{	
	out.println("ERROR:" + e.getMessage());
	return;
}


 %>
 <a href="ImageBoardList.jsp">�������������̵�</a>