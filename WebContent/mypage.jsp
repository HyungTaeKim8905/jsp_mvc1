<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="DB.*" %>
<%
	String id = request.getParameter("id");
	String password = "";
	String name     = "";
	String birth    = ""; 
	String gender   = "";
	String email    = "";
	String address  = "";
	String phone    = "";
	String sql      = "";
	
	DBManager dbm = new DBManager();
	
	sql += "select * from user where id=" + "'" + id + "'";
	try	{
		dbm.DBOpen();
		dbm.OpenQuery(sql);
		while(dbm.ResultNext())	{
			password = dbm.getString("password");
			name = dbm.getString("name");
			birth = dbm.getString("birth");
			gender = dbm.getString("gender");
			email = dbm.getString("email");
			address = dbm.getString("address");
			phone = dbm.getString("phone");
		}
		dbm.CloseQuery();
		dbm.DBClose();
	} catch(Exception e) {
		System.out.println("ERROR:" + e.getMessage());
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�� ����</title>
<script>
	function ChangePassword()	{
		window.open("Changepassword.jsp?id=<%= id %>" ,"��й�ȣ ã��","width=600px,height=400px");
	}
</script>
</head>
<body>
	<table  width="700"  class="table table-hover" border="1">
		<tr>
			<th>���̵�</th>
			<td><%= id %></td>
		</tr>
		
		<tr>	
			<th align="center">��й�ȣ</th>
			<td><%= password %>&nbsp<button type="button" onclick="ChangePassword()">����</button></td>
		</tr>
		
		<tr>	
			<th align="center">�̸�</th>
			<td><%= name %></td>
		</tr>
		
		<tr>	
			<th align="center">���� ����</th>
			<td><%= birth %></td>
		</tr>
		
		<tr>	
			<th align="center">����</th>
			<td><%= gender %></td>
		</tr>
		
		<tr>	
			<th align="center">�̸���</th>
			<td><%= email %></td>
		</tr>
		
		<tr>	
			<th align="center">�ּ�</th>
			<td><%= address %></td>
		</tr>
		
		<tr>	
			<th align="center">����ȣ</th>
			<td><%= phone %></td>
		</tr>
		<tr>	
			<td><button  type="button" onclick="button_del();">ȸ�� Ż��</button></td>
			<script type="text/javascript">
					function button_del(){
					if (confirm("Ż���Ͻðڽ��ϱ�?\n�ۼ��� �۰� ����� ��� �����˴ϴ�.") == true){    //Ȯ��
						location.href='Withdrawal.jsp?id=<%= id %>';
					}else{   //���
					    return;
					}
					}
			</script>
			<td><button type="button" onclick="location.href='ImageBoardList.jsp'">���� Ȩ�������� �̵�</button></td>
		</tr>
</table>
</body>
</html>