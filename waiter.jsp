<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>服务员界面</title>
</head>
<% if (session.getAttribute("pass")=="1") {%>
<frameset rows="100,*" cols="*" frameborder="yes" border="3">
<frame src="top.html" name="topFrame">
<frameset rows="*" cols="300,*" frameborder="yes" border="0">
<frame src="WaiterTree.jsp" name="leftFrame">
<frame name="list" id="list">
</frameset>
</frameset>
<% } 
else { %>
<center>
<form method="get" action="login.jsp">
<input type=submit value="返回">
</form>
</center>
<% } %>
 <body>
</body>
</html>