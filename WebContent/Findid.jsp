<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" errorPage = "ErrorPage.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="jquery-3.5.1.min.js"></script>
<script>
	$(document).ready(function()	{
			$("form").submit(function(){		// true면 전송이 되고 false면 전송 안되고?
			var phone1 = $("#phone1").val();
			var phone2 = $("#phone2").val();
			var phone3 = $("#phone3").val();
			var result1 = phone1.concat("-", phone2,"-", phone3);
			$("#phone").val(result1);
			return true;
			});
		});
</script>
</head>
<body>
	<form  id="board" name="board" method="post" action="Findidok.jsp">
		전화번호를 입력하세요 :<select name="phone1" id="phone1">	<!--  input hidden  -->
							<option value="010" selected>010</option>
							<option value="011">011</option>
							<option value="016">016</option>
						  </select> 
					     	<input type="text" name="phone2" id="phone2" size="5" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">-<input type="text" name="phone3" id="phone3" size="5" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"></h3>
					    	<input type="hidden" id="phone" name="phone" value="">
							<input type="submit" value="아이디 찾기">
	</form>
</body>
</html>