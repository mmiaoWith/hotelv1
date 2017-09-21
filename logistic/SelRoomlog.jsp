<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage=""%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查询全部房间的信息</title>
</head>
<% if (session.getAttribute("pass")=="1") {%>
<body>
<%
try
{
	
	Connection conn=null;
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	conn=DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ghotel","scott","1234");
	Statement smt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	ResultSet rst=smt.executeQuery("select * from roomdesign order by rid asc");

%>
<br>
<table width="100%" border="2" align="center">
<tr>
<th>&nbsp;房间号</th>
<th>&nbsp;房间类型</th>
<th>&nbsp;房间位置</th>
<th>&nbsp;房间单价</th>
<th>&nbsp;房间标准</th>
</tr>
<%
//移动指针到第一条记录之前
rst.beforeFirst();
//移动记录指针到下一条记录
while(rst.next())
{
%>
<tr>
<td align="center"><%=rst.getInt(1) %></td>
<%if(1==rst.getInt(2)){ %>
<td align="center">单人间</td>
<%} else if(2==rst.getInt(2)){%>
<td align="center">双人间</td>
<%} else if(3==rst.getInt(2)){%>
<td align="center">三人间</td>
<%} %>
<%if(1==rst.getInt(3)){ %>
<td align="center">海景房</td>
<%}else{ %>
<td align="center">普通房</td>
<%} %>
<td align="center"><%=rst.getInt(4) %></td>
<%if(1==rst.getInt(5)){ %>
<td align="center">无独卫</td>
<%}else{ %>
<td align="center">设备齐全</td>
<%} %>
</tr>
<%} %>
</table><p>
<br>
<br>

<%
rst.close();
smt.close();
conn.close();
}
catch(SQLException SE)
{
out.println();
SE.printStackTrace();
}
%>
</body>
<% } 
else { %>
<center>
<form method="get" action="../login.jsp">
<input type=submit value="返回">
</form>
</center>
<% } %>
</html>