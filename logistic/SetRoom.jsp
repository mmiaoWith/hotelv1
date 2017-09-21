<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>设置房间信息</title>
</head>
<body>
<% if (session.getAttribute("pass")=="1") {%>
<center>
<form method="get" action="SetRoomsql.jsp">
<table>
<tr>
<td>房间号：</td>
<td><input type=text name=rid onkeyup="value=value.replace(/[^\d]/g,'')"></td>
</tr>
<!-- 房间类型以选择列表的方式展示 -->
<tr>
<td>房间类型：</td>
<td>
<select name=type>
<option value='' selected></option>
<option value='1'>单人间</option>
<option value='2'>双人间</option>
<option value='3'>三人间</option>
</select>
</td>
</tr>
<tr>
<td>房间位置：</td>
<td>
<select name=station>
<option value='' selected></option>
<option value='' >普通房</option>
<option value='1'>海景房</option>
</select>
</td>
</tr>
<tr>
<td>房间价格：</td>
<td>
<select name=price>
<option value='' selected></option>
<option value='130'>130</option>
<option value='150'>150</option>
<option value='160'>160</option>
<option value='210'>210</option>
<option value='230'>230</option>
<option value='255'>255</option>
<option value='280'>280</option>
<option value='300'>300</option>
</select>
</td>
</tr>
<tr>
<td>房间标准：</td>
<td>
<select name=stand>
<option value='' selected></option>
<option value='1'>普通</option>
<option value='2'>标准</option>
</select>
</td>
</tr>
<tr>
<td><input type=submit value=提交></td>
<td><input type=reset value=重置></td>
</tr>
</table>
</form>
</center>
<% } 
else { %>
<center>
<form method="get" action="../login.jsp">
<input type=submit value="返回">
</form>
</center>
<% } %>
</body>
</html>