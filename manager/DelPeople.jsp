<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage=""%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>删除员工</title>
</head>
<body>
<%
try
{
	String pid=request.getParameter("id");
	Connection conn=null;
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	conn=DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ghotel","scott","1234");
	Statement smt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	if(pid.trim().equals("0001")){//经理不可以被删除
		response.sendRedirect("QueryPeople.jsp");
	}
	else{
		String sql="delete from people where pid='"+pid+"'";
		smt.execute(sql);	
	}
	%>
	<center>
	<h2>删除员工<%out.println(pid); %>成功！</h2>
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
