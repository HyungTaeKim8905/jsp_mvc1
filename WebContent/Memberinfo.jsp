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

String infoid = request.getParameter("id");
String sql = "";
DBManager dbm = new DBManager();

try
{	
	
	dbm.MemberInfo(infoid);
	while(dbm.ResultNext())	{
	%>

	<!-- ********************************* ȸ�� ���� ����ϴ� �κ� *****************************-->
<body>
	<h3>������ ������</h3>
	<table>
		<tr>
			<td>���̵� : </td>
			<td><%= dbm.getString("id") %></td>
		</tr>
		<tr>
			<td>��й�ȣ : </td>
			<td><%= dbm.getString("password") %></td>
		</tr>
		<tr>
			<td>�̸� : </td>
			<td><%= dbm.getString("name") %></td>
		</tr>
		<tr>
			<td>������� : </td>
			<td><%= dbm.getString("birth") %></td>
		</tr>
		<tr>
			<td>���� : </td>
			<td><%= dbm.getString("gender") %></td>
		</tr>
		<tr>
			<td>�̸��� : </td>
			<td><%= dbm.getString("email") %></td>
		</tr>
		<tr>
			<td>�ּ� : </td>
			<td><%= dbm.getString("address") %></td>
		</tr>
		<tr>
			<td>��ȭ��ȣ : </td>
			<td><%= dbm.getString("phone") %></td>
		</tr>
		<tr>
			<td><a href="Main.jsp">���� �������� �̵�</a></td>
		</tr>
	</table>
</body>	
</html>
	<%
	}
	dbm.CloseQuery();
	dbm.DBClose();
}
catch (Exception e)
{	
	out.println("ERROR:" + e.getMessage());
	return;
}


 %>