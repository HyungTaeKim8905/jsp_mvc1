<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="Header.jsp" %>
<!--  로그인 페이지 -->
<%
	String sessionID = null;
	String firstYn = request.getParameter("notFt");
	if (session.getAttribute("id") != null) { //세션에 아이디가 저장되어있으면 즉 로그인인 상태라면 세션에 저장된 아이디 값을 변수에 저장한다.
		sessionID = (String) session.getAttribute("id"); //해당 회원의 아이디를 세션값으로 넣어줌.
	}
	if (sessionID != null) {
		%><script>alert("이미 로그인이 되어있습니다."); location.href="ImageBoardList.jsp";</script><%
	}
%>
<script src="jquery-3.5.1.min.js"></script>
<script>
	function FindId()	{		// 함수 호출시 Findid.jsp가 팝업창으로 뜸
		window.open("Findid.jsp","아이디 찾기","width=600px,height=400px");
	}
	
	function FindPassword()	{	// 함수 호출시 Findpassword.jsp가 팝업창으로 뜸
		window.open("Findpassword.jsp","비밀번호 찾기","width=600px,height=400px")
	}

	$(document).ready(function(){
		$("form").submit(function(){
			if($("input:text").val() == ""){
				alert("아이디를 입력하세요.");
				$("input:text").focus();
				return false;
			}else if($("input:password").val() == ""){
				alert("비밀번호를 입력하세요.");
				$("input:password").focus();
				return false;
			}else{
				return true;
			}
		});
	});
</script>
<style>
	*{
				text-align: center;
				
			}
			
			section{
				height : 90vh;
				overflow:auto;
			}
			footer > div {           
				padding:25px;
				font-size:small;
			}
			.login{
				position:absolute;
				top:10px;
				right:10px;
			}
			.login a{
				padding:10px;
			}
			input{
				margin:10px;
				height:30px;
				width: 300px;
				cursor:pointer;
				text-align:left;
			}
			button{
				background-color: #e3f2fd!important;
				height:40px;
				width: 310px;
				border: none;
				color:black;
				font-size:18px;
				cursor:pointer;
			}
			a{
				color:black;
				text-decoration:none;
			}
</style>
<body>
<%
//*************** 쿠키값 가져오기 **********************************************************************************
String cookie = "";
String check = request.getHeader("cookie"); 
// out.println("getHeader : " + check);
Cookie[] cookies = null;
if(check != null){	
	cookies = request.getCookies();	// getCookies() 메서드를 사용해서 쿠키 정보를 배열에 저장한다.(HTTP 요청 메세지의 헤더에 포함된 쿠키를 javax.servlet.http.Cookie 배열로 리턴)		
}

if((cookies != null) && (cookies.length > 0))	{	// cookies == null 이면 쿠키가 존재하지 않는다.
	for(int i = 0; i < cookies.length; i++)		{
		if(cookies[i].getName().equals("id"))	{	// getName()메서드를 이용하여 쿠키 이름을 가져와 id와 비교 일치한다면
			cookie = cookies[i].getValue();			// getValue()메서드를 이용하여 쿠키 값을 cookie에 저장.
			//out.println(cookies[i].getName());	
			//out.println(cookies[i].getValue());
			//id test111 JSESSIONID 8F42460C22C1AFC2DB20558D9CF664B2
		}	
	}
}
/*
이와 같이 톰켓은 사용자가 로그인을 하지 않아도 최초 접속 시 JSESSIONID 쿠키 값을 브라우저에 내려주는 것을 알 수 있다.
그럼 왜 쿠키 값을 내려주는 걸까? HTTP 프로토콜은 stateless의 특징을 가지고 있기 때문에 사용자와 서버는 단 한번의 
요청과 응답으로 연결이 끊어진다. 그렇기 때문에 서버에서는 사용자의 로그인 인증 여부를 확인할 수 있도록 key 값 
처럼 사용할 수 있는 JSESSIONID 값을 클라이언트로 내려줌으로써 이를 이용하여 로그인 처리를 할 수 있는 것이다.
*/
//************************************************************************************************************
%>
	<section>
		<article style="margin-top:13%">
			<h2>로그인</h2>
			<form id="form" name="form" action="SignInok.jsp" method="post">
				<input type="text"  id="id" name="id" value="<%= cookie %>"><br>
				<input type="password" id="password" name="password"></br>
				<input type = "checkbox" name="checkbox" value = "true"><h6>아이디 저장</h6></br>
				<button type="submit">로그인</button>
			</form>
			<br>
			<a href="#" onclick="FindId()">아이디 찾기</a>&nbsp;|&nbsp;<a href="#" onclick="FindPassword();">비밀번호 찾기</a>&nbsp;|&nbsp;<a href="Registry.jsp">회원가입</a>
		</article>
	</section>
</body>
</html>
