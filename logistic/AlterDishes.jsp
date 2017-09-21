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
String sql="select did from dishes order by did asc";
Statement stmt=conn.createStatement();	
ResultSet rs=stmt.executeQuery(sql);
 %>
<center>
<form  id="form1" name="form1" method="post" action="UpdateDishes.jsp">
请选择你要修改的菜品号
<select name=did>
<%while(rs.next()) {%>
<option><%=rs.getInt("did") %></option>
<%} %>
</select>
<br><br><br>
<input type="submit" name="Submit" value="修改"/>
<input type="reset" name="Submit2" value="重置"/>
</form>
</center>
</body>
</html>