<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage=""%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查询单个订单的信息</title>
</head>
<% if (session.getAttribute("pass")=="1") {%>
<body>
<%
try
{
	String oid=request.getParameter("oid");
	oid=new String(oid.getBytes("8859_1"),"utf-8");
	Connection conn=null;
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	conn=DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ghotel","scott","1234");
	Statement smt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	ResultSet rst=smt.executeQuery("select * from orde where oid='"+oid+"'");

%>
<h1 align="center">订单信息</h1>
<br>
<table width="100%" border="2" align="center">
<tr>
<th>&nbsp;订单编号</th>
<th>&nbsp;房间号</th>
<th>&nbsp;手机号</th>
<th>&nbsp;入住时间</th>
<th>&nbsp;退房时间</th>
<th>&nbsp;押金</th>
<th>&nbsp;备注</th>
</tr>
<%
//移动指针到第一条记录之前
//rst.beforeFirst();
//移动记录指针到下一条记录
while(rst.next())
{
%>

<tr>
<td align="center" ><%=rst.getInt(1) %></td>
<td align="center"><%=rst.getInt(2) %></td>
<td align="center"><%=rst.getString(3) %></td>
<td align="center"><%=rst.getDate(4) %></td>
<td align="center"><%=rst.getDate(5) %></td>
<td align="center"><%=rst.getDouble(6) %></td>
<td align="center"><%=rst.getString(7) %></td>
</tr>
<%} %>
</table><p>
<br>
<br>
<center>
<form  id="form1" name="form1" method="post" action="UpdateOder.jsp">
<table>
<tr><td>确认房间号</td><td><input type=text name=rid ></td>
<tr><td>请输入续住天数</td><td><input type=text name=day value="1"></td>
</tr>
<tr>
<td></td><td><input type="submit" name="Submit" value="续住"/></td>
</tr>
</table>
</form>
</center>
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
<% } 
else { %>
<center>
<form method="get" action="login.jsp">
<input type=submit value="返回">
</form>
</center>
<% } %>
</body>
</html>