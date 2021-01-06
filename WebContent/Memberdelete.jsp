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
 <script>alert("회원정보가 삭제되었습니다."); history.back();</script>