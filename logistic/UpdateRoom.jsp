<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page import="java.sql.*" %>
<title>修改房间信息</title>
</head>
<body>
<%
String rid=request.getParameter("rid");
rid=new String(rid.getBytes("8859_1"),"utf-8");
String driverName="com.microsoft.sqlserver.jdbc.SQLServerDriver";
String dbURL="jdbc:sqlserver://localhost:1433;DatabaseName=ghotel";
String userName="scott";
String userPwd="1234";
 try
{
	Class.forName(driverName);
	System.out.println("加载驱动成功！");
}catch(Exception e){
	out.print(e);
	System.out.println("加载驱动失败！");
}
Connection conn=DriverManager.getConnection(dbURL,userName,userPwd);
System.out.println("连接数据库成功！");
String sql="select * from roomdesign where rid='"+rid+"'";
Statement stmt=conn.createStatement();	
ResultSet rs=stmt.executeQuery(sql);
while(rs.next())
{%>
<center>
<form  id="form1" name="form1" method="post" action="UpdateRoomsql.jsp">
要修改的房间信息：
<table>
<tr><td>房间编号：</td>
<td><input name="rid" type="text" id="rid" readonly="readonly" value=<%=rs.getInt("rid")%>></td>
<tr><td>房间类型：</td>
<!-- 房间类型的自动填充 -->
<td><select name=rtype>
<%
int type=rs.getInt("rtype");
 if(1==type){%>
<option value='1' selected>单人间</option>
<option value='2'>双人间</option>
<option value='3'>三人间</option>
<%} else if(2==type){ %>
<option value='1'>单人间</option>
<option value='2' selected>双人间</option>
<option value='3'>三人间</option>
<%} else {%>
<option value='1'>单人间</option>
<option value='2'>双人间</option>
<option value='3' selected>三人间</option>
<%} %>
</select></td>
</tr>
<tr>
<td>房间位置：</td>
<td><select name=rstate>
<%
int state=rs.getInt("rsta");
if(1==state){%>
<option value='1' selected>海景房</option>
<option value='0'>普通房</option>
<%} else{ %>
<option value='1'>海景房</option>
<option value='0' selected>普通房</option>
<%} %>
</select></td>
</tr>
<tr>
<td>房间价格：</td>
<td><input name="price" type="text"  id="rprice" onkeyup="value=value.replace(/[^\d]/g,'')" value=<%=rs.getInt("rprice") %>>
</td></tr>
<tr>
<td>房间标准：</td>
<td>
<select name=rstand>
<%
int stand=rs.getInt("rstand");
if(1==stand){%>
<option value='1' selected>普通</option>
<option value='2'>标准</option>
<%} else{ %>
<option value='1'>普通</option>
<option value='2' selected>标准</option>
<%} %>
</select>
</td>
</tr>
</table>
<input type="submit" name="Submit" value="提交"/>
<input type="reset" name="Submit2" value="重置"/>
</form>
</center>
<% }%>
<%conn.close();
stmt.close();
rs.close();  %>
</body>
</html>