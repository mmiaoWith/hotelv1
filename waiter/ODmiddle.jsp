<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage=""%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="refresh" content="5;url=OrdeDishes.jsp">
<title>点餐</title>
</head>
<body>
<%
try
{
	String phone=(String)session.getAttribute("cGuest");
	String did=request.getParameter("did");
	did=new String(did.getBytes("8859_1"),"utf-8");
	Connection conn=null;
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	conn=DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ghotel","scott","1234");
	Statement smt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	String sql="insert into dishesorde values('"+phone+"','"+did+"',1,0)";
	smt.execute(sql);
	%>
	<center>
	<h2>点餐成功！</h2>
	</center>
	<%
	smt.close();
	conn.close();
}
catch(SQLException SE)
{
out.println();
SE.printStackTrace();
}
%>
