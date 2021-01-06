<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="DB.*" %>
<!--  로그인 처리해주는 프로세스 -->
<%
//**********************login.jsp(로그인 페이지)에서 날라온 파라미터값들을 받아옴********************************************************************

String id = request.getParameter("id");				// login.jsp에서 파라미터로 넘어오는 값인 id와 password를 각각의 id, password변수에 저장해줌
String password = request.getParameter("password");
String checkbox = request.getParameter("checkbox");
// 체크가되어있으면 checkbox = true check가 안되있으면 false가 아닌 null이 된다.


//******************쿠키 설정*************************************************************************************************************

Cookie cookie = new Cookie("id", id);	//쿠키 객체를 생성하고 id란 쿠키 이름에 id값을 저장함.
if(checkbox != null)	{ 				// 체크박스에 체크가  되어있다면(아이디 저장)
	cookie.setMaxAge(60*60*24);				//쿠키의 유효시간을 24시간으로 설정한다.
	response.addCookie(cookie);				//클라이언트로 쿠키값을 전송한다.
}
else	{	// 체크박스가 해제 되었으면
	cookie.setMaxAge(0);		// 쿠키 유효시간 0으로 해서 브라우저에서 삭제하게 한다.
	response.addCookie(cookie);
}

//*************************************************************************************************************************************
String sql = "";
DBManager dbm = new DBManager();
try {

	int result = dbm.LoginCheck(id, password);
	if(result == 1)	{
		session.setAttribute("id", id);			// 로그인이 되었을때 id라는 이름의 속성 값을 세션 영역에 생성한다
		session.setMaxInactiveInterval(60*60);  // 초 단위(1시간)
		String name = dbm.getString("name");
		if(id.equals("admin"))	{
			%> <script> alert("관리자님 환영합니다."); location.href="Manager.jsp";</script> <%
		}
		%><script>alert("<%= name %>님 환영합니다."); location.href="ImageBoardList.jsp";</script> <% 		// 로그인 성공
	} else if(result == 0)	{
		%> <script>alert("비밀번호가 일치하지않습니다."); history.back();</script> <%	//비밀번호 불일치
	} else if(result == -1)	{
		%> <script>alert("존재하지 않는 아이디입니다."); history.back();</script> <%  // 존재하지 않는 아이디입니다.
	}

	
	String sessionID = null;
	if (session.getAttribute("id") != null) { ///세션에 아이디가 저장되어있으면 즉 로그인인 상태라면 세션에 저장된 아이디 값을 변수에 저장한다.
		sessionID = (String) session.getAttribute("id"); //해당 회원의 아이디를 세션값으로 넣어줌.
	}
	else	{
		%> <script>location.href="SignIn.jsp";</script> <% //세션에 아이디가 등록되어있지 않은 경우 즉 로그인이 안된 상태라면 로그인 페이지(login.jsp)로 이동한다.
	}
	if (sessionID != null) {
		%><script>alert("이미 로그인이 되어있습니다."); location.href="ImageBoardList.jsp";</script><%
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