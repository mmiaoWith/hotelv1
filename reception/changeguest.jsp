<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>修改客人信息</title>
</head>
<% if (session.getAttribute("pass")=="1") {%>
<body>
<form method="post" action="changeguestmiddle.jsp">
<center>
<table>
<tr>
<td>手机号：</td>
<td><input type=text name=phone value="13523425490"></td>
</tr>
<tr></tr>
<tr></tr>
<tr>
<td><input type=submit value=修改></td>
<td><input type=reset value=重置></td>
</tr>
</table>
</center>
</form>
<% } 
else { %>
<center>
<form method="get" action="..\login.jsp">
<input type=submit value="返回">
</form>
</center>
<% } %>
</html>