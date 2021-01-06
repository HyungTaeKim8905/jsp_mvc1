package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/*
insert, update, delete ������ ���� ���� executeUpdate() �Լ��� ����Ѵ�.�ֳ��ϸ� ��� ���� ���� ������.
select ������ ���� ����	executeQuery() �Լ��� ����Ѵ�.�ֳ��ϸ� ��� ���� �޾ƿ;� �ϱ� ������.
*/
public class DBManager {		//Ÿ���� �ν����� ���ϱ� ������ serverTimezone=UTC ���ش�.
	protected String m_DBMS = "jdbc:mysql://127.0.0.1/project?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	protected String m_UserID = "root";
	protected String m_UserPass = "mySQL1234";
	// Statement ��ü�� SQL���� �����ͺ��̽��� �����ϴµ� ����Ѵ�.
	Connection m_Connection;
	PreparedStatement m_SelectStatment; // Statement�� ���� ��ӹ���  ������ ������ ���Ǹ� �ϳ��� ��ü�� �������� ������ ������ �� �ִ�.
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

	// MySQL ������ ���� ���̺귯���� �ε��Ѵ�.
	protected boolean LoadDriver() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // com.mysql.cj.jdbc �� Ŭ������ �ִ� DriverŬ������ ���ڴٴ� ��
		} catch (Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
		return true;
	}

	// MySQL�� �����Ѵ�.
	public boolean DBOpen() {
		if (LoadDriver() == false) {
			return false;
		}
		try {
			m_Connection = DriverManager.getConnection(m_DBMS, m_UserID, m_UserPass);
		} // DriverManager.getConnection() �޼ҵ带 ȣ���Ͽ� �����ͺ��̽��� �����ϰ� Connection ��ü�� ��ȯ
		catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
		return true;
	}

	// MySQL ������ �����Ѵ�.
	public void DBClose() {
		try {
			m_Connection.close(); // db ���� ����
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage()); // ���� �߻��� ĳġ��
			return;
		}
	}

	// Query�� �����Ѵ�.			
	public boolean OpenQuery(String pSQL) {
		try {
			//select(��ȸ)���� ������ �� ����ϴ� �޼����, ResultSet ��ü�� ��ȯ�Ѵ�.
			//�� ��, ResultSet�̶� select�� �����Ͽ� ���̺�κ��� ���� ����� �����ϰ��ִ� ����Ҷ�� ����
			m_SelectStatment = m_Connection.prepareStatement(pSQL, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			
			m_ResultSet = m_SelectStatment.executeQuery();
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
		return true;
	}

	// Query�� �����Ѵ�.
	public void CloseQuery() {
		try {
			// �˻��� ����� �ݴ´�.
			m_ResultSet.close();

			// stmt �� �ݴ´�.
			m_SelectStatment.close();
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return;
		}
	}

	// ���� ���ڵ�� �̵��Ѵ�. ���� �ٷ� �Ѿ�� �޼ҵ�
	public boolean ResultNext() {// �����(DB�� ����Ǿ��ִ� �������� �� ����)�� ����
		try {
			return m_ResultSet.next();
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
	}

	// ���ڵ��� ���� ��´�.
	public String getString(String pName) {
		try {
			return m_ResultSet.getString(pName);
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return null;
		}
	}

	// ���ڵ��� ���� ��´�.
	public int getInt(String pName) {
		try {
			return Integer.parseInt(m_ResultSet.getString(pName));
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return 0;
		}
	}

	// Insert, Delete, Update ó���� �Լ�
	public boolean Excute(String pSQL) // �Ҹ� Ÿ���� ���� ��ȯ
	{
		try { //// Ŀ���̵���� //���������� ���
			m_SelectStatment = m_Connection.prepareStatement(pSQL, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.executeUpdate(); // ���������ϸ� ���� ����� java.sql.ResultSet������ �����Ѵ�.
			// m_SelectStatment �� �ݴ´�.
			m_SelectStatment.close();
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
		return true;
	}
	
	public boolean Excutee(String pSQL) // �Ҹ� Ÿ���� ���� ��ȯ
	{
		try { //// Ŀ���̵���� //���������� ���
			m_SelectStatment = m_Connection.prepareStatement(pSQL, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.executeUpdate(); // ���������ϸ� ���� ����� java.sql.ResultSet������ �����Ѵ�.
			// m_SelectStatment �� �ݴ´�.
			//m_SelectStatment.close();
		} catch (SQLException e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
		return true;
	}
	
	//***************************���̵� �� ��й�ȣ ã�� �� ��й�ȣ �缳�� �޼���************************************************************
	
	// ���̵� ã�� �޼���
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
	
	// ��й�ȣ ã�� �޼���
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

//***************************ȸ������ �޼���******************************************************************************************************
	
	public int Join(String id, String password, String name, String birth, String gender, String email, String address, String phone)	{
		try {
			// ȸ������������(join.jsp)���� �Ķ���ͷ� ���۵� �����͵��� user���̺��� ���ο� ���ڵ�� �����ϴ� �κ��̴�.
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
			m_SelectStatment.executeUpdate(); // ���������ϸ� ���� ����� java.sql.ResultSet������ �����Ѵ�.
			// m_SelectStatment �� �ݴ´�.
			m_SelectStatment.close();
			return 1;		//ȸ������ �����ϸ� 1 ��ȯ
		}
		catch(Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return 0;		//�����ϸ� 0 ��ȯ
		}
	}
	
	//***********************************************************************************************************************************
	
	//********************************// �α��� ó�� �޼���**********************************************************************************
	
	//DB���� ������ ��й�ȣ�� Ŭ���̾�Ʈ�� �Է��� ��й�ȣ�� ���ϴ� �κ�
	public int LoginCheck(String id, String password)	{
		try {
			String sql = "select * from user where id = ?";// Ŭ���̾�Ʈ�� �Է��� ���̵� ������ �ִ� ȸ���� ������ ��ȸ�ϴ� sql��
			DBOpen();
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.setString(1, id); 
			m_ResultSet = m_SelectStatment.executeQuery(); //����� ����
			if(ResultNext())	{
				if(password.equals(m_ResultSet.getString("password")))	{//getString�Լ��� �ش� ������ �����ִ� �����͸� String������ �޾ƿ´� ���̴�.
					return 1;											 //������� mResultSet.getString(2)�� �ϰԵǸ� 2��° �����ִ� �����͸� �������� �ȴ�. �� �÷��� name �� num�� �ִٰ� �����ϸ�
				}				//�α��� ����								// ��--------consol------------------��
				else	{												// �ӱ�����      111000				��
					return 0;	//��й�ȣ Ʋ��							    // ��--------------------------------��
				}				 	 	 
			}											 	     	
				else {
					return -1;	// �������� �ʴ� ���̵�
				}
			}
			catch(Exception e) {
				System.out.println("ERROR:" + e.getMessage());
				return -2;		//db ����
			}
		}
	
	//*************************************************************************************************************************************
	
	//****************************************���̵� �ߺ�Ȯ�� �˻� �޼���************************************************************************
	
	public int CheckID(String id)	{
		try {
			String sql ="select * from user where id=?";
			DBOpen();
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.setString(1, id); 
			m_ResultSet = m_SelectStatment.executeQuery(); //����� ����
			if(ResultNext())	{	//id�� ������ 1 
				return 1;
			}
			else	{				//id�� ������ 0
				return 0;
			}
		} catch(Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return -2;		//db ����
		}
	}
	
	//***************************������ ���������� Ŭ���̾�Ʈ ��� �����ִ� �޼���**************************************************
	
	public boolean ClientList()	{
		try {
			String sql = "select * from user";
			DBOpen();
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			m_ResultSet = m_SelectStatment.executeQuery(); //����� ����
			return true;
		} catch(Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;		//db ����
		}
	}
	//***********************�����ڰ� Ŭ���̾�Ʈ ���� �����ϴ� �޼���********************************************************************************
	
	public boolean MemberDelete(String deleteid)	{
		try {
			String sql = "delete from user where id=?";
			DBOpen();
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.setString(1, deleteid);
			m_SelectStatment.executeUpdate(); // ���������ϸ� ���� ����� java.sql.ResultSet������ �����Ѵ�.
			// m_SelectStatment �� �ݴ´�.
			m_SelectStatment.close();
			return true;
		} catch(Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;		//db ����
		}
	}
	//********************ȸ�� ������ �����ִ� �޼���(�����ڸ� �� ������)****************************************************************************************************
	
	public boolean MemberInfo(String infoid)	{
		try {//user ���̺��� ������ Ȯ���� ���̵� ������ �ִ� ȸ�� ������ user ���̺��� ��ȸ*********
			String sql = "select * from user where id=?";
			DBOpen();
			m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			m_SelectStatment.setString(1, infoid);
			m_ResultSet = m_SelectStatment.executeQuery();
			return true;
		} catch(Exception e) {
			System.out.println("ERROR:" + e.getMessage());
			return false;		//db ����
		}
	}
	//*********************************************************************************************************************
	
	//**********************÷�������� �ٿ�ε� �� ������ �ٿ�ε� Ƚ���� ���������ִ� �޼���********************************************	
	
	public void downloadcount(String filedownload)	{
		String sql = "update board set downloadcount = downloadcount + 1 where filerealname='" + filedownload +"'";
		try {
			DBOpen();
			Excute(sql);
			DBClose();
		}catch(Exception e) {
			System.out.println("÷������ ī��Ʈ�� �����ϴµ� �־� ����");
			System.out.println("ERROR:" + e.getMessage());
		}
	}
	
	//*******************************************************************************************************************

	
	//*************************************��� ��� ���ִ� �޼���*****************************************************************
	
	public boolean commentok(String no, String id, String note)	{
		String sql = "insert into comment (no, id, Reply, Rdate) values ('"+ no +"', '"+ id +"', '"+ note +"', now())";
		try	{				// �ۼ���, ����, �ۼ���
			DBOpen();	
			Excute(sql);
			DBClose();
			return true;	//����� ����ϸ� true ��ȯ
		} catch(Exception e)	{
			System.out.println("ERROR : " + e.getMessage());	//�����ϸ� false 
			return false;
		}
	}
	
	//*******************************************************************************************************************
	
	
	
	
	
	
	
	
//*******************************************************************************************************************
	
	
}
