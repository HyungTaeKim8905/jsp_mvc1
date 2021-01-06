<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="DB.*" %>
<%
String id = null;
//세션에 id라는 이름의 속성 값이 저장되어 있지 않거나 id 이름의 속성 값이 admin이 아니라면 로그인 페이지로(login.jsp) 강제이동 시킴
if((session.getAttribute("id") == null) || !((String)session.getAttribute("id")).equals("admin"))	{
	%> <script> alert("권한이 없습니다."); location.href="login.jsp";</script><%
}

String infoid = request.getParameter("id");
String sql = "";
DBManager dbm = new DBManager();

try
{	
	
	dbm.MemberInfo(infoid);
	while(dbm.ResultNext())	{
	%>

	<!-- ********************************* 회원 정보 출력하는 부분 *****************************-->
<body>
	<h3>관리자 페이지</h3>
	<table>
		<tr>
			<td>아이디 : </td>
			<td><%= dbm.getString("id") %></td>
		</tr>
		<tr>
			<td>비밀번호 : </td>
			<td><%= dbm.getString("password") %></td>
		</tr>
		<tr>
			<td>이름 : </td>
			<td><%= dbm.getString("name") %></td>
		</tr>
		<tr>
			<td>생년월일 : </td>
			<td><%= dbm.getString("birth") %></td>
		</tr>
		<tr>
			<td>성별 : </td>
			<td><%= dbm.getString("gender") %></td>
		</tr>
		<tr>
			<td>이메일 : </td>
			<td><%= dbm.getString("email") %></td>
		</tr>
		<tr>
			<td>주소 : </td>
			<td><%= dbm.getString("address") %></td>
		</tr>
		<tr>
			<td>전화번호 : </td>
			<td><%= dbm.getString("phone") %></td>
		</tr>
		<tr>
			<td><a href="Main.jsp">메인 페이지로 이동</a></td>
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