<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage = "ErrorPage.jsp"%>
<%@ page import="DB.*" %>
<!--  ȸ������ ó�����ִ� ���μ��� -->
<%
	request.setCharacterEncoding("UTF-8");	//ȸ������ ������ �Ķ���ͷ� ���۵� �����͸� ���� �� �ѱ� �����Ͱ� ������ �ʵ��� ó���ϴ� �κ�
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
			%> <script> alert("<%= name %>�� ȸ�������� ���ϵ帳�ϴ�."); location.href="ImageBoardList.jsp"</script> <%
		}
		else	{
			%> <script> alert("ȸ�����Կ� �����߽��ϴ�."); history.back(); </script> <%
		}
	dbm.DBClose();
	} catch(Exception e){
		System.out.println("ERROR:" + e.getMessage());
	}
%>
