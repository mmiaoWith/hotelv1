<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page import="java.sql.*" %>
<title>修改客人信息的中间页面</title>
</head>
<% if (session.getAttribute("pass")=="1") {%>
<body>
<% 
String phone=request.getParameter("phone");
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
Statement stmt=conn.createStatement();		
ResultSet rs=null;
if(!phone.equals("")){
try{
rs=stmt.executeQuery("select * from guest where phone = '"+phone+"'");
}
catch(Exception e){
out.print(e+"<>");
}
%>
<%
while(rs.next()){
%>
<center>
<form method="get" action="changeguestshow.jsp">
<h4>要修改的客人信息如下：</h4>
<table>
<tr>
<td>姓名：</td>
<td><input type=text name=name value=<%=rs.getString(1) %>></td>
</tr>
<tr>
<td>身份证号：</td>
<td><input type=text name=id value=<%=rs.getString(2)%>></td>
</tr>
<tr>
<td>电话：</td>
<td><input type=text name=pnum value=<%=phone%>></td>
</tr>
<tr></tr>
<tr></tr>
<tr>
<td><input type=submit value=提交></td>
<td><input type=reset value=重置></td>
</tr>
</table>
</form>
</center>
<%
}
%>
</body>
<%
} else { %>
<center>
<form method="get" action="..\login.jsp">
<input type=submit value="返回">
</form>
</center>
<% } }%>
</html>