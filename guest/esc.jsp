<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="refresh" content="3;url=index.jsp">
<title>退出登录</title>
</head>
<body>
<%
session.invalidate();
 %>
<center>
	<h2>退出登录成功！</h2>
	<h3>3秒后将自动跳转到首页......</h3>
	</center>
</body>
</html>