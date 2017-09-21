package controls;

import hote.ConnectDB;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CheckAddPeople extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	//�õ����Ա�����
	public int getTopId() throws ClassNotFoundException, SQLException{
		int id=0;
		ConnectDB connectDB=new ConnectDB();
		PreparedStatement pStatement;
		ResultSet rSet;
		Connection connection=connectDB.getConnection();
		pStatement=connection.prepareStatement("select top 1 pid from people order by pid desc");
		rSet=pStatement.executeQuery();
		while (rSet.next()) {
			id=rSet.getInt(1);
		}
		connectDB.close(connection, pStatement, rSet);
		return id;
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
		pid=new String(pid.getBytes("8859_1"),"utf-8");
		String password=req.getParameter("password");
		password=new String(password.getBytes("8859_1"),"utf-8");
		String position=req.getParameter("position");
		position=new String(position.getBytes("8859_1"),"utf-8");
		if(position=="����")//��֤����Ψһ
		{
			resp.sendRedirect("AddPeople.jsp");
		}
		ConnectDB connectDB=new ConnectDB();
		PreparedStatement pStatement = null;
		ResultSet rSet = null;
		Connection connection = null;
		try {
			connection = connectDB.getConnection();
		} catch (ClassNotFoundException | SQLException e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
		try {
			pStatement=connection.prepareStatement("select * from people where pid='"+pid+"'");
		} catch (SQLException e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
		try {
			rSet=pStatement.executeQuery();
		} catch (SQLException e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
		int num=0;
		try {
			while (rSet.next()) {
				num++;
			}
		} catch (SQLException e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
		//Ա������Ѵ���
		if(1<num){
			resp.sendRedirect("AddPeople.jsp");
		}
		String sql="insert into people(pid,password,position) values('"+pid+"','"+password+"','"+position+"')";
		try {
			pStatement=connection.prepareStatement(sql);
			pStatement.executeUpdate();
		} catch (SQLException e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}finally{
			try {
				connectDB.close(connection, pStatement, rSet);
			} catch (SQLException e) {
				// TODO �Զ����ɵ� catch ��
				e.printStackTrace();
			}
		}
		resp.sendRedirect("../success.jsp");
	}

}
