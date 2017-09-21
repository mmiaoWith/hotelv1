<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page import="java.sql.*" %>
<title>修改客人信息的显示界面</title>
</head>
<% if (session.getAttribute("pass")=="1") {%>
<body>
<center>
<%
String guestname=request.getParameter("name");
guestname=new String(guestname.getBytes("8859_1"),"utf-8");
String guestid=request.getParameter("id");
guestid=new String(guestid.getBytes("8859_1"),"utf-8");
String phone=request.getParameter("pnum");
phone=new String(phone.getBytes("8859_1"),"utf-8");
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
String sql1="delete from guest where gname like '%"+guestname+"%'";
Statement stmt=conn.createStatement();	
stmt.executeUpdate(sql1);
}
catch(Exception e)
{
out.print(e);
}
try
{
String sql="insert into guest(gname,gid,phone) values ('"+guestname+"','"+guestid+"','"+phone+"')";
Statement stmt=conn.createStatement();	
stmt.executeUpdate(sql);
}
catch(Exception e)
{
out.print(e);
}
out.println("修改客人信息成功！");
 %>
 </center>
</body>
<% } 
else { %>
<center>
<form method="get" action="..\login.jsp">
<input type=submit value="返回">
</form>
</center>
<% } %>
</html>