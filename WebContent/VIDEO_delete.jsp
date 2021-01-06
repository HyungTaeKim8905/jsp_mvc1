<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="DB.*" %>
<%	//게시글 삭제 해주는 로직
	String no  = request.getParameter("no");
	String sql = "";
	DBManager dbm = new DBManager();
	
	try {
		sql = "delete from board where no='" + no + "'";
		dbm.DBOpen();
		dbm.Excute(sql);
		dbm.DBClose();
	} catch(Exception e)	{
		System.out.println("ERROR: " + e.getMessage());
	}
%>
<script> alert("게시글을 삭제하였습니다."); location.href="VIDEO_list.jsp"</script>