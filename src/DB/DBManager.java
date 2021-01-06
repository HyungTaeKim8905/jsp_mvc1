package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/*
insert, update, delete 쿼리를 날릴 때는 executeUpdate() 함수를 사용한다.왜냐하면 결과 값이 없기 때문에.
select 쿼리를 날릴 때는	executeQuery() 함수를 사용한다.왜냐하면 결과 값을 받아와야 하기 때문에.
*/
public class DBManager {		//타임을 인식하지 못하기 때문에 serverTimezone=UTC 써준다.
	protected String m_DBMS = "jdbc:mysql://127.0.0.1/project?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	protected String m_UserID = "root";
	protected String m_UserPass = "mySQL1234";
	// Statement 객체는 SQL문을 데이터베이스로 전송하는데 사용한다.
	Connection m_Connection;
	PreparedStatement m_SelectStatment; // Statement로 부터 상속받음  동적인 쿼리에 사용되며 하나의 객체로 여러번의 쿼리를 실행할 수 있다.
	ResultSet m_ResultSet;
	
	public PreparedStatement getPreparedStatement()	{
		return m_SelectStatment;
	}
	
	public String getVersion() {
		return "Java Beans Board v1.0";
	}

	public void setUserID(String id) {
		m_UserID = id;
	}

	public void setPassword(String pw) {
		m_UserPass = pw;
	}

	// MySQL 연결을 위한 라이브러리를 로딩한다.
	protected boolean LoadDriver() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // com.mysql.cj.jdbc 의 클래스에 있는 Driver클래스를 쓰겠다는 뜻
		} catch (Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
		return true;
	}

	// MySQL에 접속한다.
	public boolean DBOpen() {
		if (LoadDriver() == false) {
			return false;
		}
		try {
			m_Connection = DriverManager.getConnection(m_DBMS, m_UserID, m_UserPass);
		} // DriverManager.getConnection() 메소드를 호출하여 데이터베이스에 연결하고 Connection 객체를 반환
		catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
		return true;
	}

	// MySQL 접속을 종료한다.
	public void DBClose() {
		try {
			m_Connection.close(); // db 연결 종료
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage()); // 오류 발생시 캐치문
			return;
		}
	}

	// Query를 수행한다.			
	public boolean OpenQuery(String pSQL) {
		try {
			//select(조회)문을 전송할 떄 사용하는 메서드로, ResultSet 객체를 반환한다.
			//이 때, ResultSet이란 select를 실행하여 테이블로부터 얻은 결과를 저장하고있는 저장소라고 생각
			m_SelectStatment = m_Connection.prepareStatement(pSQL, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			
			m_ResultSet = m_SelectStatment.executeQuery();
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
		return true;
	}

	// Query를 종료한다.
	public void CloseQuery() {
		try {
			// 검색된 결과를 닫는다.
			m_ResultSet.close();

			// stmt 를 닫는다.
			m_SelectStatment.close();
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return;
		}
	}

	// 다음 레코드로 이동한다. 다음 줄로 넘어가는 메소드
	public boolean ResultNext() {// 결과값(DB에 저장되어있는 데이터의 총 개수)을 얻어옴
		try {
			return m_ResultSet.next();
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
	}

	// 레코드의 값을 얻는다.
	public String getString(String pName) {
		try {
			return m_ResultSet.getString(pName);
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return null;
		}
	}

	// 레코드의 값을 얻는다.
	public int getInt(String pName) {
		try {
			return Integer.parseInt(m_ResultSet.getString(pName));
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return 0;
		}
	}

	// Insert, Delete, Update 처리용 함수
	public boolean Excute(String pSQL) // 불린 타입의 값을 반환
	{
		try { //// 커서이동방법 //수정가능한 모드
			m_SelectStatment = m_Connection.prepareStatement(pSQL, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.executeUpdate(); // 쿼리실행하면 실행 결과를 java.sql.ResultSet형으로 리턴한다.
			// m_SelectStatment 를 닫는다.
			m_SelectStatment.close();
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
		return true;
	}
	
	public boolean Excutee(String pSQL) // 불린 타입의 값을 반환
	{
		try { //// 커서이동방법 //수정가능한 모드
			m_SelectStatment = m_Connection.prepareStatement(pSQL, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.executeUpdate(); // 쿼리실행하면 실행 결과를 java.sql.ResultSet형으로 리턴한다.
			// m_SelectStatment 를 닫는다.
			//m_SelectStatment.close();
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
		return true;
	}
	
	//***************************아이디 및 비밀번호 찾기 및 비밀번호 재설정 메서드************************************************************
	
	// 아이디 찾기 메서드
	public boolean FindID(String phone)	{
		try {
			String sql = "select id from user where phone = ?";
			DBOpen();
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.setString(1, phone);
			m_ResultSet = m_SelectStatment.executeQuery();
			return true;
		}
		catch(Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
	}
	
	// 비밀번호 찾기 메서드
	public boolean FindPassWord(String id)	{
		try {
			String sql = "select password from user where id = ?";
			DBOpen();
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.setString(1, id);
			m_ResultSet = m_SelectStatment.executeQuery();
			return true;
		}
		catch(Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
	}
	
//*************************************************************************************************************************************

//***************************회원가입 메서드******************************************************************************************************
	
	public int Join(String id, String password, String name, String birth, String gender, String email, String address, String phone)	{
		try {
			// 회원가입페이지(join.jsp)에서 파라미터로 전송된 데이터들을 user테이블의 새로운 레코드로 삽입하는 부분이다.
			String sql = "insert into user (id, password, name, birth, gender, email, address, phone) values (?,?,?,?,?,?,?,?)";
			DBOpen();
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.setString(1, id);
			m_SelectStatment.setString(2, password);
			m_SelectStatment.setString(3, name);
			m_SelectStatment.setString(4, birth);
			m_SelectStatment.setString(5, gender);
			m_SelectStatment.setString(6, email);
			m_SelectStatment.setString(7, address);
			m_SelectStatment.setString(8, phone);
			m_SelectStatment.executeUpdate(); // 쿼리실행하면 실행 결과를 java.sql.ResultSet형으로 리턴한다.
			// m_SelectStatment 를 닫는다.
			m_SelectStatment.close();
			return 1;		//회원가입 성공하면 1 반환
		}
		catch(Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return 0;		//실패하면 0 반환
		}
	}
	
	//***********************************************************************************************************************************
	
	//********************************// 로그인 처리 메서드**********************************************************************************
	
	//DB에서 가져온 비밀번호와 클라이언트가 입력한 비밀번호를 비교하는 부분
	public int LoginCheck(String id, String password)	{
		try {
			String sql = "select * from user where id = ?";// 클라이언트가 입력한 아이디를 가지고 있는 회원의 정보를 조회하는 sql문
			DBOpen();
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.setString(1, id); 
			m_ResultSet = m_SelectStatment.executeQuery(); //결과값 리턴
			if(ResultNext())	{
				if(password.equals(m_ResultSet.getString("password")))	{//getString함수는 해당 순서의 열에있는 데이터를 String형으로 받아온단 뜻이다.
					return 1;											 //예를들어 mResultSet.getString(2)를 하게되면 2번째 열에있는 데이터를 가져오게 된다. 즉 컬럼이 name 과 num만 있다고 가정하면
				}				//로그인 성공								// ㅣ--------consol------------------ㅣ
				else	{												// ㅣ김형태      111000				ㅣ
					return 0;	//비밀번호 틀림							    // ㅣ--------------------------------ㅣ
				}				 	 	 
			}											 	     	
				else {
					return -1;	// 존재하지 않는 아이디
				}
			}
			catch(Exception e) {
				System.out.println("ERROR:" + e.getMessage());
				return -2;		//db 오류
			}
		}
	
	//*************************************************************************************************************************************
	
	//****************************************아이디 중복확인 검사 메서드************************************************************************
	
	public int CheckID(String id)	{
		try {
			String sql ="select * from user where id=?";
			DBOpen();
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.setString(1, id); 
			m_ResultSet = m_SelectStatment.executeQuery(); //결과값 리턴
			if(ResultNext())	{	//id가 있으면 1 
				return 1;
			}
			else	{				//id가 없으면 0
				return 0;
			}
		} catch(Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return -2;		//db 오류
		}
	}
	
	//***************************관리자 페이지에서 클라이언트 목록 보여주는 메서드**************************************************
	
	public boolean ClientList()	{
		try {
			String sql = "select * from user";
			DBOpen();
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			m_ResultSet = m_SelectStatment.executeQuery(); //결과값 리턴
			return true;
		} catch(Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;		//db 오류
		}
	}
	//***********************관리자가 클라이언트 정보 삭제하는 메서드********************************************************************************
	
	public boolean MemberDelete(String deleteid)	{
		try {
			String sql = "delete from user where id=?";
			DBOpen();
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.setString(1, deleteid);
			m_SelectStatment.executeUpdate(); // 쿼리실행하면 실행 결과를 java.sql.ResultSet형으로 리턴한다.
			// m_SelectStatment 를 닫는다.
			m_SelectStatment.close();
			return true;
		} catch(Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;		//db 오류
		}
	}
	//********************회원 정보를 보여주는 메서드(관리자만 볼 수있음)****************************************************************************************************
	
	public boolean MemberInfo(String infoid)	{
		try {//user 테이블에서 정보를 확인할 아이디를 가지고 있는 회원 정보를 user 테이블에서 조회*********
			String sql = "select * from user where id=?";
			DBOpen();
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.setString(1, infoid);
			m_ResultSet = m_SelectStatment.executeQuery();
			return true;
		} catch(Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;		//db 오류
		}
	}
	//*********************************************************************************************************************
	
	//**********************첨부파일을 다운로드 할 때마다 다운로드 횟수를 증가시켜주는 메서드********************************************	
	
	public void downloadcount(String filedownload)	{
		String sql = "update board set downloadcount = downloadcount + 1 where filerealname='" + filedownload +"'";
		try {
			DBOpen();
			Excute(sql);
			DBClose();
		}catch(Exception e) {
			System.out.println("첨부파일 카운트를 증가하는데 있어 오류");
			System.out.println("ERROR:" + e.getMessage());
		}
	}
	
	//*******************************************************************************************************************

	
	//*************************************댓글 등록 해주는 메서드*****************************************************************
	
	public boolean commentok(String no, String id, String note)	{
		String sql = "insert into comment (no, id, Reply, Rdate) values ('"+ no +"', '"+ id +"', '"+ note +"', now())";
		try	{				// 작성자, 내용, 작성일
			DBOpen();	
			Excute(sql);
			DBClose();
			return true;	//댓글을 등록하면 true 반환
		} catch(Exception e)	{
			System.out.println("ERROR : " + e.getMessage());	//실패하면 false 
			return false;
		}
	}
	
	//*******************************************************************************************************************
	
	
	
	
	
	
	
	
//*******************************************************************************************************************
	
	
}
