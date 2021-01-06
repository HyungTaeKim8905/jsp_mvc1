<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage = "ErrorPage.jsp"%>
<%@ page import="DB.*" %>
<%
	String id = request.getParameter("id");
	DBManager dbm = new DBManager();
	try {
		int result = dbm.CheckID(id);
		if(result == 1){																// result = 1
			%> <script> alert("사용중인 아이디 입니다."); location.href="Registry.jsp?result=<%= result %>&id=<%= id %>" </script> <%
		}
		else {																			// result = 0
			%> <script> alert("사용 가능한 아이디 입니다."); location.href="Registry.jsp?result=<%= result %>&id=<%= id %>" </script> <%
		}
		dbm.CloseQuery();
		dbm.DBClose();
	} catch(Exception e){
		System.out.println("ERROR:" + e.getMessage());
	}
%>