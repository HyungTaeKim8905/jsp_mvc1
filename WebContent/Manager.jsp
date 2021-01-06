<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="DB.*" %>
<!--  *********************************************관리자 페이지****************************************************************** -->
<%
String id = null;
//세션에 id라는 이름의 속성 값이 저장되어 있지 않거나 id 이름의 속성 값이 admin이 아니라면 로그인 페이지로(login.jsp) 강제이동 시킴
if((session.getAttribute("id") == null) || !((String)session.getAttribute("id")).equals("admin"))	{
	%> <script> alert("권한이 없습니다."); location.href="login.jsp";</script><%
}

DBManager dbm = new DBManager();

try
{	
	dbm.ClientList();
	%>
	<!-- ********************************* user 테이블에 존재하는 레코드 수만큼 회원 정보를 출력하는 부분 *****************************-->
	<h3>관리자 페이지</h3>
	<table>
		<tr>
			<td colspan="2" class="td_title">회원목록</td>
		</tr>
		<% while(dbm.ResultNext())	{ %>
		<tr>
			<td><a href="Memberinfo.jsp?id=<%= dbm.getString("id") %>"><%= dbm.getString("id") %></a></td>
			<td><a href="Memberdelete.jsp?id=<%= dbm.getString("id") %>">삭제</a></td>
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
 <a href="ImageBoardList.jsp">메인페이지로이동</a>