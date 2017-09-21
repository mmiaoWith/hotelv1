<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page import="java.sql.*" %>
<title>修改房间信息</title>
</head>
<body>
<%
String rid0=request.getParameter("rid");
int rid=Integer.parseInt(rid0);
if(rid<0)
{
response.sendRedirect("AlterRoom.jsp");
}
String type=request.getParameter("rtype");
int rtype=Integer.parseInt(type);
String state=request.getParameter("rstate");
int rstate=Integer.parseInt(state);
String rprice=request.getParameter("price");
int price=Integer.parseInt(rprice);
String stand=request.getParameter("rstand");
int rstand=Integer.parseInt(stand);
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
String sql1="delete from roomdesign where rid='"+rid+"'";
Statement stmt=conn.createStatement();	
stmt.executeUpdate(sql1);
}
catch(Exception e)
{
out.print("1"+e);
}
try
{
String sql="insert into roomdesign(rid,rtype,rsta,rprice,rstand) values ('"+rid+"','"+rtype+"','"+rstate+"','"+price+"','"+rstand+"')";

Statement stmt=conn.createStatement();	
stmt.executeUpdate(sql);
}
catch(Exception e)
{
out.print("2"+e);
}
 %>
<center>
<h2>修改房间信息成功！</h2>
</center>
</body>
</html>