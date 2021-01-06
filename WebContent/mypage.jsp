<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="DB.*" %>
<%
	String id = request.getParameter("id");
	String password = "";
	String name     = "";
	String birth    = ""; 
	String gender   = "";
	String email    = "";
	String address  = "";
	String phone    = "";
	String sql      = "";
	
	DBManager dbm = new DBManager();
	
	sql += "select * from user where id=" + "'" + id + "'";
	try	{
		dbm.DBOpen();
		dbm.OpenQuery(sql);
		while(dbm.ResultNext())	{
			password = dbm.getString("password");
			name = dbm.getString("name");
			birth = dbm.getString("birth");
			gender = dbm.getString("gender");
			email = dbm.getString("email");
			address = dbm.getString("address");
			phone = dbm.getString("phone");
		}
		dbm.CloseQuery();
		dbm.DBClose();
	} catch(Exception e) {
		System.out.println("ERROR:" + e.getMessage());
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>내 정보</title>
<script>
	function ChangePassword()	{
		window.open("Changepassword.jsp?id=<%= id %>" ,"비밀번호 찾기","width=600px,height=400px");
	}
</script>
</head>
<body>
	<table  width="700"  class="table table-hover" border="1">
		<tr>
			<th>아이디</th>
			<td><%= id %></td>
		</tr>
		
		<tr>	
			<th align="center">비밀번호</th>
			<td><%= password %>&nbsp<button type="button" onclick="ChangePassword()">변경</button></td>
		</tr>
		
		<tr>	
			<th align="center">이름</th>
			<td><%= name %></td>
		</tr>
		
		<tr>	
			<th align="center">생년 월일</th>
			<td><%= birth %></td>
		</tr>
		
		<tr>	
			<th align="center">성별</th>
			<td><%= gender %></td>
		</tr>
		
		<tr>	
			<th align="center">이메일</th>
			<td><%= email %></td>
		</tr>
		
		<tr>	
			<th align="center">주소</th>
			<td><%= address %></td>
		</tr>
		
		<tr>	
			<th align="center">폰번호</th>
			<td><%= phone %></td>
		</tr>
		<tr>	
			<td><button  type="button" onclick="button_del();">회원 탈퇴</button></td>
			<script type="text/javascript">
					function button_del(){
					if (confirm("탈퇴하시겠습니까?\n작성된 글과 댓글은 모두 삭제됩니다.") == true){    //확인
						location.href='Withdrawal.jsp?id=<%= id %>';
					}else{   //취소
					    return;
					}
					}
			</script>
			<td><button type="button" onclick="location.href='ImageBoardList.jsp'">메인 홈페이지로 이동</button></td>
		</tr>
</table>
</body>
</html>