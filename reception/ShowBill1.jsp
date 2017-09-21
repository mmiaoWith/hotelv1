<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage=""%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查询账单信息</title>
</head>
<body>
<%
String nroom=request.getParameter("param1");
try
{
	
	Connection conn=null;
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	conn=DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ghotel","scott","1234");
	Statement smt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	ResultSet rst=smt.executeQuery("select top 1 * from bill where rid='"+nroom+"' order by bid desc");

%>
<h1 align="center">账单信息</h1>
<br>
<table width="100%" border="1" align="center">
<tr>
<th>&nbsp;账单编号</th>
<th>&nbsp;订单编号</th>
<th>&nbsp;房间编号</th>
<th>&nbsp;打折信息</th>
<th>&nbsp;结帐金额</th>
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
<td align="center"><%=rst.getInt(2) %></td>
<td align="center"><%=rst.getInt(3) %></td>
<td align="center"><%=rst.getFloat(4) %></td>
<td align="center"><%=rst.getFloat(5) %></td>
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
</html>