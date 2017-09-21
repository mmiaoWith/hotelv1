<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="refresh" content="1;url=OrdeDishes.jsp">
<title>Session存储</title>
</head>
<body>
<%
String phone=request.getParameter("phone");
session.setAttribute("cGuest",phone);
 %>
</body>
</html>