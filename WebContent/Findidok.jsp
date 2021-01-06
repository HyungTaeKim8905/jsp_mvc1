<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage = "ErrorPage.jsp"%>
<%@ page import="DB.*" %>
<%
	String phone = request.getParameter("phone");
	String id = null;
	String sql = "";
	
	DBManager dbm = new DBManager();
	try {
		dbm.FindID(phone); //아이디 찾기 함수	
		if (dbm.ResultNext()) {
			id = dbm.getString("id");
		} else {
	%>
	<script>
		alert("전화번호를 잘못 입력하였습니다.");
		history.back();
	</script>
	<%
		}
	/*
		insert, update, delete 쿼리를 날릴 때는 executeUpdate() 함수를 사용한다.왜냐하면 결과 값이 없기 때문에.
		select 쿼리를 날릴 때는	executeQuery() 함수를 사용한다.왜냐하면 결과 값을 받아와야 하기 때문에.
	*/
	dbm.CloseQuery();
	dbm.DBClose();
	} catch (Exception e) {
	out.println("ERROR:" + e.getMessage());
	}
%>
아이디 : <%= id %>