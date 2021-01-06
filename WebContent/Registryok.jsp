<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage = "ErrorPage.jsp"%>
<%@ page import="DB.*" %>
<!--  회원가입 처리해주는 프로세스 -->
<%
	request.setCharacterEncoding("UTF-8");	//회원가입 폼에서 파라미터로 전송된 데이터를 얻어올 때 한글 데이터가 깨지지 않도록 처리하는 부분
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	String email = request.getParameter("email");
	String address = request.getParameter("address");
	String phone = request.getParameter("phone");
	
	String sql = "";
	DBManager dbm = new DBManager();
	
	try {
		int result = dbm.Join(id, password, name, birth, gender, email, address, phone);
		if(result != 0){
			%> <script> alert("<%= name %>님 회원가입을 축하드립니다."); location.href="ImageBoardList.jsp"</script> <%
		}
		else	{
			%> <script> alert("회원가입에 실패했습니다."); history.back(); </script> <%
		}
	dbm.DBClose();
	} catch(Exception e){
		System.out.println("ERROR:" + e.getMessage());
	}
%>
