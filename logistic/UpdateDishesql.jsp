<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page import="java.sql.*" %>
<title>修改菜品信息</title>
</head>
<body>
<%
String did0=request.getParameter("did");
int did=Integer.parseInt(did0);
if(did<0)
{
response.sendRedirect("AlterDishes.jsp");
}
String dname=request.getParameter("dname");
dname=new String(dname.getBytes("8859_1"),"utf-8");
String rprice=request.getParameter("price");
double price=Double.parseDouble(rprice);
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
String sql1="delete from dishes where did='"+did+"'";
Statement stmt=conn.createStatement();	
stmt.executeUpdate(sql1);
}
catch(Exception e)
{
out.print("1"+e);
}
try
{
String sql="insert into dishes(did,dname,dprice) values ('"+did+"','"+dname+"','"+price+"')";

Statement stmt=conn.createStatement();	
stmt.executeUpdate(sql);
}
catch(Exception e)
{
out.print("2"+e);
}
 %>
<center>
<h2>修改菜品信息成功！</h2>
</center>
</body>
</html>