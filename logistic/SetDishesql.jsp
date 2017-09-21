<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page import="java.sql.*" %>
<title>设置菜品写入数据库</title>
</head>
<body>
<center>
<%
String did=request.getParameter("did");
did=new String(did.getBytes("8859_1"),"utf-8");
String dname=request.getParameter("dname");
dname=new String(dname.getBytes("8859_1"),"utf-8");
String price=request.getParameter("dprice");
price=new String(price.getBytes("8859_1"),"utf-8");
String driverName="com.microsoft.sqlserver.jdbc.SQLServerDriver";
String dbURL="jdbc:sqlserver://localhost:1433;DatabaseName=ghotel";
String userName="scott";
String userPwd="1234";
 try
{
	Class.forName(driverName);
	System.out.println("加载驱动成功！");
}catch(Exception e){
	out.print(e);
	System.out.println("加载驱动失败！");
}
Connection conn=DriverManager.getConnection(dbURL,userName,userPwd);
System.out.println("连接数据库成功！");
try
{
String sql0="select * from dishes where did='"+did+"'";
Statement stmt0=conn.createStatement();	
ResultSet rs0=stmt0.executeQuery(sql0);
int count=0;
while(rs0.next())
{
count++;
}
if(0==count)
{
try{
	String sql="insert into dishes values ('"+did+"','"+dname+"','"+price+"')";
	Statement stmt=conn.createStatement();	
	stmt.executeUpdate(sql);
	}
catch(Exception e)
	{
	out.print(e);
	response.sendRedirect("SetDishes.jsp");
	}
}
else
	{
	response.sendRedirect("SetDishes.jsp");
	}
}
catch(Exception e)
	{
	out.print("输入信息有误！");
	response.sendRedirect("SetDishes.jsp");
	}
 %>
 <h2>设置菜品信息成功！</h2>
 </center>
</body>
</html>