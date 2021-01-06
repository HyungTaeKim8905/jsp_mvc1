<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="DB.*" %>

<%	//*****************************파일 처리****************************************
	String uploadPath = request.getRealPath("/upload");		//파일을 업로드할 서버상의 폴더명을 지정
	int size 			= 1024*1024*15;						// 15메가로 지정함. 15메가를 넘을 경우 예외 발생
	String filename	    = "";								// 폼에서 선택한 원본 파일명
	String filerealname = "";								// 서버에 실제로 저장된 파일의 이르
	String filepath     = uploadPath;						// 저장될 파일의 경로
	
	try {
		MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());

		request.setCharacterEncoding("UTF-8");	//insert.jsp에서 넘어오는 데이터를 깨지지않게 받아옴
		String no		  = multi.getParameter("no");
		String title 	  = multi.getParameter("title");
		String note  	  = multi.getParameter("note");
		String videopath  = multi.getParameter("videopath");
		
		Enumeration files = multi.getFileNames();		//폼에서 전송되어온 파일 타입의 입력상자의 이름을 반환한다.
		String file1 = (String)files.nextElement();		//파일을 업로드 했을 때 첫번째 입력상자의 이름을 얻어온다.
		filerealname = multi.getFilesystemName(file1);	//업로드된 파일의 서버 상에 업로드된 실제 파일명을 얻어온다.
		filename = multi.getOriginalFileName(file1);	//업로드된 파일의 처음에 폼에서 선택한 원본 파일명을 얻어온다.
		
		String sql = "";
		DBManager dbm = new DBManager();

		dbm.DBOpen();
		sql = "update board set title = '" + title + "', note = '" + note + "', videopath = '" + videopath + "', filename = '" + filename + "', filerealname = '" + filerealname + "', filepath = '" + filepath + "' where no='"+no+"'";
		dbm.Excute(sql);
		dbm.DBClose();
	} catch(Exception e)	{		//파일이 날라갔을때(하드디스크가 꽉 찼을때) 오류문도 생각해줘야한다
		System.out.println("ERROR:" + e.getMessage());
	}
%>
<script> alert("글을 수정하였습니다."); location.href="VIDEO_list.jsp" </script>
