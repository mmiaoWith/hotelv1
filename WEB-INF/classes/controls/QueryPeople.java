package controls;

import hote.ConnectDB;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.People;

public class QueryPeople extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public QueryPeople() {
		// TODO 自动生成的构造函数存根
	}

	//查询数据库 得到人员列表
	public ArrayList<People> Query() throws ClassNotFoundException, SQLException {
		ArrayList<People> peoples = new ArrayList<People>();
		People people = null;
		ConnectDB connectDB=new ConnectDB();
		Connection connection=connectDB.getConnection();
		PreparedStatement pStatement=connection.prepareStatement("select pid,position from people");
		ResultSet resultSet=pStatement.executeQuery();
		while(resultSet.next()){
			people=new People();
			people.setPid(resultSet.getString(1));
			people.setPosition(resultSet.getString(2));
			peoples.add(people);
		}
		connectDB.close(connection, pStatement, resultSet);
		return peoples;
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String pid=req.getParameter("id");
		ConnectDB connectDB=new ConnectDB();
		Connection connection = null;
		try {
			connection = connectDB.getConnection();
		} catch (ClassNotFoundException | SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		PreparedStatement pStatement = null;
		try {
			pStatement = connection.prepareStatement("delete from people where pid='"+pid+"'");
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		ResultSet rSet=null;
		if(pid.trim().equals("0001")){//经理不可以被删除
			resp.sendRedirect("QueryPeople.jsp");
		}
		else{
			int raw = 0;
			try {
				raw = pStatement.executeUpdate();
			} catch (SQLException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
			if(1==raw)
				resp.sendRedirect("../success.jsp");
		}
		try {
			connectDB.close(connection, pStatement, rSet);
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
	}

}
