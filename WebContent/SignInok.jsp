<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="DB.*" %>
<!--  �α��� ó�����ִ� ���μ��� -->
<%
//**********************login.jsp(�α��� ������)���� ����� �Ķ���Ͱ����� �޾ƿ�********************************************************************

String id = request.getParameter("id");				// login.jsp���� �Ķ���ͷ� �Ѿ���� ���� id�� password�� ������ id, password������ ��������
String password = request.getParameter("password");
String checkbox = request.getParameter("checkbox");
// üũ���Ǿ������� checkbox = true check�� �ȵ������� false�� �ƴ� null�� �ȴ�.


//******************��Ű ����*************************************************************************************************************

Cookie cookie = new Cookie("id", id);	//��Ű ��ü�� �����ϰ� id�� ��Ű �̸��� id���� ������.
if(checkbox != null)	{ 				// üũ�ڽ��� üũ��  �Ǿ��ִٸ�(���̵� ����)
	cookie.setMaxAge(60*60*24);				//��Ű�� ��ȿ�ð��� 24�ð����� �����Ѵ�.
	response.addCookie(cookie);				//Ŭ���̾�Ʈ�� ��Ű���� �����Ѵ�.
}
else	{	// üũ�ڽ��� ���� �Ǿ�����
	cookie.setMaxAge(0);		// ��Ű ��ȿ�ð� 0���� �ؼ� ���������� �����ϰ� �Ѵ�.
	response.addCookie(cookie);
}

//*************************************************************************************************************************************
String sql = "";
DBManager dbm = new DBManager();
try {

	int result = dbm.LoginCheck(id, password);
	if(result == 1)	{
		session.setAttribute("id", id);			// �α����� �Ǿ����� id��� �̸��� �Ӽ� ���� ���� ������ �����Ѵ�
		session.setMaxInactiveInterval(60*60);  // �� ����(1�ð�)
		String name = dbm.getString("name");
		if(id.equals("admin"))	{
			%> <script> alert("�����ڴ� ȯ���մϴ�."); location.href="Manager.jsp";</script> <%
		}
		%><script>alert("<%= name %>�� ȯ���մϴ�."); location.href="ImageBoardList.jsp";</script> <% 		// �α��� ����
	} else if(result == 0)	{
		%> <script>alert("��й�ȣ�� ��ġ�����ʽ��ϴ�."); history.back();</script> <%	//��й�ȣ ����ġ
	} else if(result == -1)	{
		%> <script>alert("�������� �ʴ� ���̵��Դϴ�."); history.back();</script> <%  // �������� �ʴ� ���̵��Դϴ�.
	}

	
	String sessionID = null;
	if (session.getAttribute("id") != null) { ///���ǿ� ���̵� ����Ǿ������� �� �α����� ���¶�� ���ǿ� ����� ���̵� ���� ������ �����Ѵ�.
		sessionID = (String) session.getAttribute("id"); //�ش� ȸ���� ���̵� ���ǰ����� �־���.
	}
	else	{
		%> <script>location.href="SignIn.jsp";</script> <% //���ǿ� ���̵� ��ϵǾ����� ���� ��� �� �α����� �ȵ� ���¶�� �α��� ������(login.jsp)�� �̵��Ѵ�.
	}
	if (sessionID != null) {
		%><script>alert("�̹� �α����� �Ǿ��ֽ��ϴ�."); location.href="ImageBoardList.jsp";</script><%
	}
	
	dbm.CloseQuery();
	dbm.DBClose();
}
catch (Exception e)
{
	out.println("ERROR:" + e.getMessage());
	return;
}
%>