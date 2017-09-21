<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
 <%@ page import="java.sql.*" %>
<title>修改订单信息</title>
</head>
<body>
<% 
String rid0=request.getParameter("rid");
rid0=new String(rid0.getBytes("8859_1"),"utf-8");
int rid=Integer.parseInt(rid0);
String day0=request.getParameter("day");
day0=new String(day0.getBytes("8859_1"),"utf-8");
int day=Integer.parseInt(day0);
//out.print("<script>alert('"+day+"');</script>"); 
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
//续住
String sql1="update orde set outime=dateadd(day,"+day+",outime) where rid="+rid+"";
Statement stmt=conn.createStatement();	
stmt.executeUpdate(sql1);

}
catch(Exception e)
{
out.print(e);
response.sendRedirect("MOrder.jsp");
}
 %><center>
<h2>续住房间成功！</h2>
</center>
</body>
</html>