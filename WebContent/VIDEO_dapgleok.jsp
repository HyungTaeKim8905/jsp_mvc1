<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="DB.*" %>

<% 	//*****************************파일 처리****************************************
	String uploadPath = request.getRealPath("/upload");		//파일을 업로드할 서버상의 폴더명을 지정
	int size 			= 1024*1024*15;						// 15메가로 지정함. 15메가를 넘을 경우 예외 발생
	String filename	    = "";								// 폼에서 선택한 원본 파일명
	String filerealname = "";								// 서버에 실제로 저장된 파일의 이르
	String filepath     = uploadPath;						// 저장될 파일의 경로
	
	int ref     = 0;		//관련글 번호(부모의 글번호를 저장하는 컬럼)
	int indent  = 0;		//답글 레벨(원글의 답글인지 답글의 답글인지를 구분하기위한 들여쓰기
	int step    = 0;		//관련글 중 출력 순서(같은 답글끼리의 출력순서를 위한 필드)3
	
	try {
		MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());

		request.setCharacterEncoding("UTF-8");	//insert.jsp에서 넘어오는 데이터를 깨지지않게 받아옴
		String no    	  = multi.getParameter("no");
		String id    	  = multi.getParameter("id");
		String title 	  = multi.getParameter("title");
		String name  	  = multi.getParameter("name");		// user 테이블에있는 name을 얻어옴 그래서 board테이블의 name에 저장함.
		String note  	  = multi.getParameter("note");
		String videopath  = multi.getParameter("videopath");
		
		Enumeration files = multi.getFileNames();		//폼에서 전송되어온 파일 타입의 입력상자의 이름을 반환한다.
		String file1 = (String)files.nextElement();		//파일을 업로드 했을 때 첫번째 입력상자의 이름을 얻어온다.
		filerealname = multi.getFilesystemName(file1);	//업6+`로드된 파일의 서버 상에 업로드된 실제 파일명을 얻어온다.
		filename = multi.getOriginalFileName(file1);	//업로드된 파일의 처음에 폼에서 선택한 원본 파일명을 얻어온다.
		
		String sql = "";
		int    max = 0;	// ref가 0으로 들어가지 않게하기 위해 변수 하나 만듬
		DBManager dbm = new DBManager();
		
		sql= "select ref, indent, step from board where no='" + no + "'";
		dbm.DBOpen();
		dbm.OpenQuery(sql);
		while(dbm.ResultNext()){		//현재의 ref, indent, step를 받아옴
			ref = dbm.getInt("ref");
			indent = dbm.getInt("indent");
			step = dbm.getInt("step");
		}
		
		//update문을 이용해서 ref값이 불러온 ref와 같고 step이 불러온 step값보다 큰 자료들의 step을 +1 시킨다.
		sql="update board set step = step+1 where ref="+ref+" and step>" + step;
		dbm.Excute(sql);
		
		sql = "insert into board ";			//videopath
		sql = sql + "(id, title, note, name, wdate,videopath, filename, filerealname, filepath, ref, indent, step) ";
		sql = sql + "values ";
		sql = sql + "('" + id + "', '" + title + "','" + note + "','" + name + "',now(),'" + videopath + "','" + filename + "','" + filerealname + "','" + filepath + "', " + ref + ", " + (indent + 1) + ", " + (step + 1) + ")";
		dbm.Excute(sql);
		dbm.CloseQuery();
		dbm.DBClose();
	} catch(Exception e)	{		//파일이 날라갔을때(하드디스크가 꽉 찼을때) 오류문도 생각해줘야한다
		System.out.println("ERROR:" + e.getMessage());
	}
%>
<script>alert("답글을 작성하였습니다."); location.href="VIDEO_list.jsp"</script>