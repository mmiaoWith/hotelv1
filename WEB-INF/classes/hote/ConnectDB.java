package hote;

import java.sql.*;
public class ConnectDB {
	public ConnectDB(){
		
	}
	
	private Connection connection=null;
	public  Connection getConnection() throws ClassNotFoundException, SQLException {
		String driverName="com.microsoft.sqlserver.jdbc.SQLServerDriver";
		String dbURL="jdbc:sqlserver://localhost:1433;DatabaseName=ghotel";
		String userName="scott";
		String userPwd="1234";
		Class.forName(driverName);
		connection=DriverManager.getConnection(dbURL,userName,userPwd);
		return connection;
	}
	public void close(Connection connection,PreparedStatement pStatement,ResultSet rSet) throws SQLException {
		if(rSet!=null){
			rSet.close();
			rSet=null;
		}
		if(pStatement!=null){
			pStatement.close();
			pStatement=null;
		}
		if(connection!=null){
			connection.close();
			connection=null;
		}
	}
}
