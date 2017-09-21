<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>点餐页面</title>
</head>
<body>
<center>
<h4>请输入点餐手机号</h4>
<form method="post" action="Session.jsp">
<table>
<tr><td>
<input type="text" name="phone" id="phone" onkeyup="value=value.replace(/[^\d]/g,'')">
</td>
</tr>
<tr>
<td><input type=submit value="提交"></td>
<td><input type=reset value="重置"></td>
</tr>
</table>
</form>
</center>
</body>
</html>