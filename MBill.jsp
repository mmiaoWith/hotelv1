<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>账单管理</title>
</head>
<% if (session.getAttribute("pass")=="1") {%>
<frameset cols="35%,65%" frameborder="YES" border="3">
<frame src="ReceptionTree.jsp" name="leftFrame">
<frame src="ShowBill.jsp" name=mainFrame>
 </frameset>
 <% } 
else { %>
<center>
<form method="post" action="login.jsp">
<input type=submit value="返回">
</form>
</center>
<% } %>
<body>

</body>
</html>