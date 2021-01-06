<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage = "ErrorPage.jsp"%>
	<%
		session.invalidate();
	%>
	<script>
		alert("로그아웃 되었습니다.");
		location.href="ImageBoardList.jsp";
	</script>