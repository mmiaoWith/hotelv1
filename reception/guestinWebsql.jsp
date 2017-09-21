<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page import="java.sql.*" %>
<title>客人入住写入数据库</title>
</head>
<body>
<center>
<%
String phone=request.getParameter("phone");
phone=new String(phone.getBytes("8859_1"),"utf-8");
if(phone.length()!=11)
{	
	response.sendRedirect("guestinWeb.jsp");
}
String driverName="com.microsoft.sqlserver.jdbc.SQLServerDriver";
String dbURL="jdbc:sqlserver://localhost:1433;DatabaseName=ghotel";
String userName="scott";
String userPwd="1234";
 try{
	Class.forName(driverName);
	System.out.println("加载驱动成功！");
}catch(Exception e){
	out.print(e);
	System.out.println("加载驱动失败！");
}
Connection conn=DriverManager.getConnection(dbURL,userName,userPwd);
System.out.println("连接数据库成功！");
try{//订单orde状态ostate=1代表客人入住成功
	String sql="update orde set ostate=1 where phone='"+phone+"'";
	Statement stmt=conn.createStatement();	
	stmt.executeUpdate(sql);
}catch(Exception e){
	out.print("1"+e);
}
try{//修改房间状态
	String sql="update room set rstate=1 where rid=(select top 1 rid from orde where phone='"+phone+"' order by oid desc)";
	Statement stmt=conn.createStatement();	
	stmt.executeUpdate(sql);
}
catch(Exception e){
out.print(e);
}
 %>
 <h2>客人入住成功！</h2>
 </center>
</body>
</html>