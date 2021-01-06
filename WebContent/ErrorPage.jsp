<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<!--  isErrorPage="true" 써줘야 다른페이지에서 발생한 에러대신 현재 페이지를 띄어준다. -->
<%@ include file="Header.jsp" %>

<!--  -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	*	{
		text-align: center;
	}		
		
	section	{
		height : 90vh;
		overflow:auto;
	}
	
	h1, h5 {
		color:gray;
	}
</style>
<body>
	<section>
		<article style="margin-top:13%">
			<h1>페이지를 찾을 수 없습니다.</h1>
			<h5>요청하신 페이지가 제거되었거나,</h5>
			<h5>이름이 변경되었거나,</h5>	
			<h5>일시적으로 사용이 중단되었습니다.</h5>
			<button type="button" onclick="location.href='ImageBoardList.jsp'">메인 페이지로 이동</button><br/>
			에러 타입 : <%= exception.getClass().getName() %></br>
			에러 메세지 : <%= exception.getMessage() %>	
		</article>
	</section>
</body>
</html>
<%@ include file="Footer.jsp" %>