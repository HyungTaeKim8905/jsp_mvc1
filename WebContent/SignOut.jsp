<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage = "ErrorPage.jsp"%>
	<%
		session.invalidate();
	%>
	<script>
		alert("�α׾ƿ� �Ǿ����ϴ�.");
		location.href="ImageBoardList.jsp";
	</script>