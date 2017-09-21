<%@page import="controls.CheckAddPeople"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage=""%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<title>添加员工</title>
</head>
<body>
<% if (session.getAttribute("pass")=="1") {
	CheckAddPeople checkAddPeople=new CheckAddPeople();
	int pid=checkAddPeople.getTopId();
 %>
<center>
<form method="post" action=caddpeople>
请输入新员工的信息
<table  align="center" width=100% border="0">
<tr><td align="right">&nbsp;员工编号：</td>
<td align="left"><input align="right" name="id" type="text" value=<%=pid+1 %> onkeyup="value=value.replace(/[^\d]/g,'')" maxlength='4'></td>
</tr>
<tr></tr>
<tr><td align="right">&nbsp;员工密码：</td>
<td align="left"><input align="right" name="password" type="password" maxlength='4'></td>
</tr>
<tr></tr>
<tr><td align="right">&nbsp;员工职务：</td>
<td align="left">
<select name=position>
<option value="前台" selected>前台</option>
<option value="财务">服务员</option>
<option value="后勤">财务</option>
<option value="财务">后勤</option>
<option value="财务">经理</option>
</select>
</td>
</tr>
<tr></tr>
<tr><td align="right"><input type="submit" name="Submit" value="提交"/></td>
<td align="left"><input type="reset" name="Submit2" value="重置"></td>
</tr>
</table>
</form>
</center>
<% } 
else { %>
<center>
<form method="post" action="..\login.jsp">
<input type=submit value="返回">
</form>
</center>
<% } %>
</body>
</html>
