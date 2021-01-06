<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="ErrorPage.jsp" %>
<%@ page import="DB.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    <title>Ezenflix</title>
    <nav class="navbar navbar-expand-lg navbar-light bg-light" style="background-color: #e3f2fd!important;">
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <a class="navbar-brand" href="ImageBoardList.jsp" style="color: crimson;"><h1>Ezenflix</h1></a>
      
        <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
          <ul class="navbar-nav mr-auto mt-2 mt-md-0">
            <li class="nav-item active">
              <a class="nav-link font-weight-bolder" href="ImageBoardList.jsp">현재 개봉작 <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item active">
              <a class="nav-link font-weight-bolder" href="QNAlist.jsp">질답 게시판</a>
            </li>
            <li class="nav-item active">
             <a class="nav-link font-weight-bolder" href="VIDEO_list.jsp">동영상 게시판</a>
            </li>
          </ul>
          
         <%	//해당 사용자의 name값을 가져옴
         String id   = (String)session.getAttribute("id");
         String sql  = "";
         String name = "";
         
         DBManager dbm = new DBManager();
         try{
        	 sql += "select name from user where id='"+id+"'";
        	 dbm.DBOpen();
        	 dbm.OpenQuery(sql);
        	 while(dbm.ResultNext()){
        		 name = dbm.getString("name");
        	 }
        	 dbm.CloseQuery();
        	 dbm.DBClose();
         } catch(Exception e){
        	 System.out.println("ERROR:" + e.getMessage());
         }
         if(id == null)	{
         %>
	          <button type="button" class="btn btn-outline-dark float-right" onclick="location.href='Registry.jsp' ">회원가입</button>
	          &nbsp;
	          <button type="button" class="btn btn-outline-dark float-right" onclick="location.href='SignIn.jsp' ">로그인</button>
      <% }else {
	    	  if(id.equals("admin"))	{
	      %>       <h6><%= name %>님 환영합니다.</h6></br>
	      		   <button type="button" onclick="location.href='Manager.jsp'" class="btn btn-outline-dark float-right">관리자 페이지</button>
	      		   <button type="button" class="btn btn-outline-dark float-right" onclick="location.href='SignOut.jsp' ">로그아웃</button>      <% 	
	      	  }else {
	      		  %> <h6><%= name %>님 환영합니다.</h6></br>
	      		  	 <button type="button" class="btn btn-outline-dark float-right" onclick="location.href='mypage.jsp?id=<%= id %>'">내정보</button>
	      		  	 <button type="button" class="btn btn-outline-dark float-right" onclick="location.href='SignOut.jsp' ">로그아웃</button>      <%
	      	  }
	      } 
	      %>
        </div>
      </nav>
</head>