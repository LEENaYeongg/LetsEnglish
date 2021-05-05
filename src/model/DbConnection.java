package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DbConnection {
	private DbConnection() {} //생성자.
	// 연결 객체를 리턴.
	static Connection getConnection() {
		Connection conn = null;
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mariadb://localhost:3307/lny","scott","1234");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	static void close(Connection conn, Statement stmt, ResultSet rs) {
		try{
		if(rs != null) rs.close();
		if(stmt != null) stmt.close();
		if(conn != null)conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
