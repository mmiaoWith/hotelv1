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
String did=request.getParameter("did");
did=new String(did.getBytes("8859_1"),"utf-8");
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
String sql="select * from dishes where did='"+did+"'";
Statement stmt=conn.createStatement();	
ResultSet rs=stmt.executeQuery(sql);
while(rs.next())
{%>
<center>
<form  id="form1" name="form1" method="post" action="UpdateDishesql.jsp">
要修改的菜品信息：
<table>
<tr>
<td>菜品编号：</td>
<td><input name="did" type="text" id="did" readonly="readonly" value=<%=rs.getInt("did")%>></td>
</tr>
<tr>
<td>菜品名称：</td>
<td><input name="dname" type="text" id="dname" value=<%=rs.getString("dname").trim()%>></td>
</tr>
<tr>
<td>菜品价格：</td>
<td><input name="price" type="text"  id="dprice" value=<%=rs.getDouble("dprice") %> onkeyup="value=value.replace(/[^\d]/g,'')"></td>
</tr>
</table>
<input type="submit" name="Submit" value="提交"/>
<input type="reset" name="Submit2" value="重置"/>
</form>
</center>
<% }%>
<%conn.close();
stmt.close();
rs.close();  %>
</body>
</html>