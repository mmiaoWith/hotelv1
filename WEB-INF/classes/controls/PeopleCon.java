package controls;
/*
 * Peopleҵ���߼�������
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
	
	//��֤�û����
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
		
		//�����������
		resp.setContentType("text/html;charset=gbk");
		
		//���ʴ�����1,��servletContext�ж�Ӧ��visitTime��1
		String numVal=this.getServletContext().getAttribute("visitTime").toString();
		int times=Integer.parseInt(numVal)+1;
		this.getServletContext().setAttribute("visitTime", ""+times);
		
		//��ȡ���ݵĲ���
		String id=req.getParameter("name").trim();
		id=new String(id.getBytes("8859_1"),"utf-8");
		String password=req.getParameter("password").trim();
		password=new String(password.getBytes("8859_1"),"utf-8");
		String position=req.getParameter("identity").trim();
		position=new String(position.getBytes("8859_1"),"utf-8");
		//����People����
		People p=new People();
		p.setPid(id);
		p.setPassword(password);
		p.setPosition(position);
		//����Peoplecon�����Ա����Check(people)����
		PeopleCon peopleCon=new PeopleCon();
		try {
			if(peopleCon.Check(p)){
				HttpSession session=req.getSession();
				session.setAttribute("pass", "1");
				if (position.equals("����")) {
					resp.sendRedirect("manager.jsp?user="+id+"");
				} else if (position.equals("ǰ̨")) {
					resp.sendRedirect("reception.jsp?user="+id+"");
				} else if (position.equals("����")) {
					resp.sendRedirect("logistic.jsp?user="+id+"");
				} else if (position.equals("����")) {
					resp.sendRedirect("finance.jsp?user="+id+"");
				} else {
					resp.sendRedirect("waiter.jsp?user="+id+"");
				} 
			}
			else {
				resp.sendRedirect("login.jsp?name="+id+"");
			}
		} catch (ClassNotFoundException e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
	}
	
	@Override
	public void destroy() {	
		System.out.println("destroy......");
		//д�ظ��µ�����
		FileWriter fileWriter = null;
		try {
			fileWriter = new FileWriter(file);
		} catch (IOException e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
		BufferedWriter bufferedWriter=new BufferedWriter(fileWriter);
		try {
			bufferedWriter.write(this.getServletContext().getAttribute("visitTime").toString());
		} catch (IOException e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
		try {
			bufferedWriter.close();
		} catch (IOException e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
		
	}
	
	@Override
	public void init() throws ServletException {
		System.out.println("init.......");
		//��ȡ�ļ�����
		FileReader fileReader=null;
		String numVal=null;
		try {
			fileReader = new FileReader(file);
		} catch (FileNotFoundException e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
		BufferedReader bufferedReader=new BufferedReader(fileReader);
		//��ȡһ������
		try {
			numVal=bufferedReader.readLine().toString();
		} catch (IOException e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
		try {
			bufferedReader.close();
		} catch (IOException e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
		if(numVal!=null){
			this.getServletContext().setAttribute("visitTime", numVal);
		}
	}
}
