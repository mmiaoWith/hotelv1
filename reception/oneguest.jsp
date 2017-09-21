<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>按手机号查询客人信息</title>
</head>
<body>
<% if (session.getAttribute("pass")=="1") {%>
<center>
<form method="post" action="oneguestshow.jsp">
<table>
<tr>
<td>手机号：</td>
<td><input type=text name=phone value=""></td>
</tr>
<tr></tr>
<tr></tr>
<tr>
<td><input type=submit value=查询></td>
<td><input type=reset value=重置></td>
</tr>
</table>
</form>
</center>
<% } 
else { %>
<center>
<form method="get" action="..\login.jsp">
<input type=submit value="返回">
</form>
</center>
<% } %>
</body>
</html>