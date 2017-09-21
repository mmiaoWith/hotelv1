package controls;
/*
 * People业务逻辑处理类
 */
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hote.ConnectDB;
import beans.People;
public class PeopleCon extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Connection connection;
	private PreparedStatement pStatement;
	private ResultSet rSet;
	private String file="D:/hotel/visitCount.txt";
	
	//验证用户身份
	public boolean Check(People people) throws ClassNotFoundException, SQLException{
		boolean b=false;
		ConnectDB connectDB=new ConnectDB();
		connection=connectDB.getConnection();
		pStatement=connection.prepareStatement("select * from people where pid="+people.getPid()+"");
		rSet=pStatement.executeQuery();
		if(rSet.next()){
			String psw=rSet.getString(2).trim();
			String position=rSet.getString(3).trim();
			if(psw.equals(people.getPassword())&&position.equals(people.getPosition()))
				b=true;
		}
		connectDB.close(connection, pStatement, rSet);
		return b;
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		//解决中文乱码
		resp.setContentType("text/html;charset=gbk");
		
		//访问次数加1,将servletContext中对应的visitTime加1
		String numVal=this.getServletContext().getAttribute("visitTime").toString();
		int times=Integer.parseInt(numVal)+1;
		this.getServletContext().setAttribute("visitTime", ""+times);
		
		//获取传递的参数
		String id=req.getParameter("name").trim();
		id=new String(id.getBytes("8859_1"),"utf-8");
		String password=req.getParameter("password").trim();
		password=new String(password.getBytes("8859_1"),"utf-8");
		String position=req.getParameter("identity").trim();
		position=new String(position.getBytes("8859_1"),"utf-8");
		//生成People对象
		People p=new People();
		p.setPid(id);
		p.setPassword(password);
		p.setPosition(position);
		//生成Peoplecon对象，以便调用Check(people)方法
		PeopleCon peopleCon=new PeopleCon();
		try {
			if(peopleCon.Check(p)){
				HttpSession session=req.getSession();
				session.setAttribute("pass", "1");
				if (position.equals("经理")) {
					resp.sendRedirect("manager.jsp?user="+id+"");
				} else if (position.equals("前台")) {
					resp.sendRedirect("reception.jsp?user="+id+"");
				} else if (position.equals("后勤")) {
					resp.sendRedirect("logistic.jsp?user="+id+"");
				} else if (position.equals("财务")) {
					resp.sendRedirect("finance.jsp?user="+id+"");
				} else {
					resp.sendRedirect("waiter.jsp?user="+id+"");
				} 
			}
			else {
				resp.sendRedirect("login.jsp?name="+id+"");
			}
		} catch (ClassNotFoundException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
	}
	
	@Override
	public void destroy() {	
		System.out.println("destroy......");
		//写回更新的数据
		FileWriter fileWriter = null;
		try {
			fileWriter = new FileWriter(file);
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		BufferedWriter bufferedWriter=new BufferedWriter(fileWriter);
		try {
			bufferedWriter.write(this.getServletContext().getAttribute("visitTime").toString());
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		try {
			bufferedWriter.close();
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		
	}
	
	@Override
	public void init() throws ServletException {
		System.out.println("init.......");
		//读取文件数据
		FileReader fileReader=null;
		String numVal=null;
		try {
			fileReader = new FileReader(file);
		} catch (FileNotFoundException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		BufferedReader bufferedReader=new BufferedReader(fileReader);
		//读取一行数据
		try {
			numVal=bufferedReader.readLine().toString();
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		try {
			bufferedReader.close();
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		if(numVal!=null){
			this.getServletContext().setAttribute("visitTime", numVal);
		}
	}
}
