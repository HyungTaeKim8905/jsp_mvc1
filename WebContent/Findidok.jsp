<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage = "ErrorPage.jsp"%>
<%@ page import="DB.*" %>
<%
	String phone = request.getParameter("phone");
	String id = null;
	String sql = "";
	
	DBManager dbm = new DBManager();
	try {
		dbm.FindID(phone); //���̵� ã�� �Լ�	
		if (dbm.ResultNext()) {
			id = dbm.getString("id");
		} else {
	%>
	<script>
		alert("��ȭ��ȣ�� �߸� �Է��Ͽ����ϴ�.");
		history.back();
	</script>
	<%
		}
	/*
		insert, update, delete ������ ���� ���� executeUpdate() �Լ��� ����Ѵ�.�ֳ��ϸ� ��� ���� ���� ������.
		select ������ ���� ����	executeQuery() �Լ��� ����Ѵ�.�ֳ��ϸ� ��� ���� �޾ƿ;� �ϱ� ������.
	*/
	dbm.CloseQuery();
	dbm.DBClose();
	} catch (Exception e) {
	out.println("ERROR:" + e.getMessage());
	}
%>
���̵� : <%= id %>