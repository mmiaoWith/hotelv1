<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage=""%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="refresh" content="5;url=index.jsp">
<title>登录验证</title>
</head>
<body>
<% 
String phone=request.getParameter("phone");
phone=new String(phone.getBytes("8859_1"),"utf-8");
String psw=request.getParameter("psw");
psw=new String(psw.getBytes("8859_1"),"utf-8");
String rand=request.getParameter("rand");
rand=new String(rand.getBytes("8859_1"),"utf-8");
String r=session.getAttribute("rand").toString();
if(rand.equals(r)){
try
{	
	Connection conn=null;
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	conn=DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ghotel","scott","1234");
	Statement smt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	ResultSet rst=smt.executeQuery("select * from guest where phone ='"+phone+"' and password='"+psw+"'");
	int raw=0;
	while(rst.next())
	{
		raw++;
	}
	if(1==raw)//手机号唯一
	{ 	
		session.setAttribute("currentGuest", phone);
		}
	%>	
	<center>
	<h2>登录成功！</h2>
	<h3>5秒后将自动跳转到首页......</h3>
	</center>
	</body>
	<% 
rst.close();
smt.close();
conn.close();
}
catch(SQLException SE)
{
out.println();
SE.printStackTrace();
}
}else{
%>
<jsp:forward page="guestlogin.jsp"></jsp:forward>
<%
} %>
