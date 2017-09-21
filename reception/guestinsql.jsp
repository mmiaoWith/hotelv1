<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page import="java.sql.*" %>
<title>客人登记写入数据库</title>
</head>
<body>
<center>
<%
String gname=request.getParameter("gname");
gname=new String(gname.getBytes("8859_1"),"utf-8");
String gid=request.getParameter("gid");
gid=new String(gid.getBytes("8859_1"),"utf-8");
String phone=request.getParameter("phone");
phone=new String(phone.getBytes("8859_1"),"utf-8");
String rid=request.getParameter("rid");
rid=new String(rid.getBytes("8859_1"),"utf-8");
String money=request.getParameter("money");
money=new String(money.getBytes("8859_1"),"utf-8");
String intime=request.getParameter("intime");
intime=new String(intime.getBytes("8859_1"),"utf-8");
String outime=request.getParameter("outime");
outime=new String(outime.getBytes("8859_1"),"utf-8");
String more=request.getParameter("more");
more=new String(more.getBytes("8859_1"),"utf-8");
if(gname.length()<=0||gid.length()!=18||phone.length()!=11||rid.length()==0)
{	
	response.sendRedirect("guestin.jsp");
}
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
String sql="insert into guest(gname,gid,phone) values ('"+gname+"','"+gid+"','"+phone+"')";
Statement stmt=conn.createStatement();	
stmt.executeUpdate(sql);
}
catch(Exception e)
{
out.print(e);
}
try
{
String sql="update room set rstate=1 where rid='"+rid+"'";
Statement stmt=conn.createStatement();	
stmt.executeUpdate(sql);
}
catch(Exception e)
{
out.print(e);
}
try
{
String sql1="select count(oid)+1 as ordeid from orde";
Statement stmt1=conn.createStatement();	
ResultSet rs=stmt1.executeQuery(sql1);
int oid=0;
while(rs.next())
{
	oid=rs.getInt("ordeid");
}
String sql="insert into orde(oid,rid,phone,intime,outime,money,more,ostate) values ('"+oid+"', '"+rid+"','"+phone+"','"+intime+"','"+outime+"','"+money+"','"+more+"',1)";
Statement stmt=conn.createStatement();	
stmt.executeUpdate(sql);
}
catch(Exception e)
{
out.print(e);
response.sendRedirect("guestin.jsp");
}
 %>
 <h2>客人登记成功！</h2>
 </center>
</body>
</html>