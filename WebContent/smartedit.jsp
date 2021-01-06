<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage = "ErrorPage.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="./se/js/HuskyEZCreator.js" charset="utf-8"></script>
	
</head>
<body>
<textarea rows="10" cols="30" id="ir1" name="content" style="width:100%px; height:350px; "></textarea>

<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
 oAppRef: oEditors,
 elPlaceHolder: "ir1",
 sSkinURI: "./se/SmartEditor2Skin.html",
 fCreator: "createSEditor2"
});
</script>
</body>

</html>