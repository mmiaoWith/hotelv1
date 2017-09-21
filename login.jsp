<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="hote.ConnectDB"%>
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page import="java.sql.*" %>
<title>酒店餐饮管理系统登录</title>
</head>
<body>
<%
ConnectDB connectDB=new ConnectDB();
Connection conn=connectDB.getConnection();
String sql="select distinct position from people";
PreparedStatement stmt=conn.prepareStatement(sql);
ResultSet rs=stmt.executeQuery();
 %>
<center>
<h1><font color=blue>欢迎使用酒店餐饮管理系统</font></h1>
<form method="post" action=check>
<table>
<tr>
<td>输入员工号：</td>
<td><input type=text name=name onkeyup="value=value.replace(/[^\d]/g,'')" value=<%=request.getParameter("name") %>></td>
</tr>
<tr>
<td>输入密码：</td>
<td><input type=password name=password onkeyup="value=value.replace(/[^\d]/g,'')"></td>
</tr>
<tr>
<tr>
<td>身份：</td>
<td>
<select name=identity>
<%while(rs.next()) {%>
<option><%=rs.getString("position").trim() %></option>
<%} %>
</select>
</td>
</tr>
<tr>
<td><input type=submit value=提交></td>
<td><input type=reset value=重置></td>
</tr>
</table>
</form>
<%connectDB.close(conn,stmt,rs); %>
<%="访问次数："+this.getServletContext().getAttribute("visitTime").toString() %>
</center>
</body>
</html>