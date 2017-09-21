 <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page import="java.sql.*" %>
<title>显示统计总收入</title>
</head>
<% if (session.getAttribute("pass")=="1") {%>
<body>
<%
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

Statement stmt1=conn.createStatement();		
ResultSet rs=null;
Statement stmt2=conn.createStatement();
Statement stmt3=conn.createStatement();
String sql1="drop view pfchart";
String sql2="create view pfchart as select substring(convert(varchar(12),outime,112),1,6) month,sum money from bill,orde where orde.oid=bill.oid";
String sql3="select month 月份,sum(money) 收入 from pfchart group by month order by month asc";
stmt1.execute(sql1);
stmt2.execute(sql2);
rs=stmt3.executeQuery(sql3);
%>
<center>
<table width=100% border=1>
<tr>
<td>月份</td><td>总收入</td>
</tr>
<tr>
<%
while(rs.next())
{
%>
<td><%=rs.getString(1) %></td><td><%=rs.getString(2) %></td>
</tr>
<%
}
 %>
 </table>
 </center>
 <center>
<form method="post" action="DownLoadChart.jsp">
<input type=submit value="打印报表">
</form>
</center>
</body>
<%
conn.close();
stmt1.close();
stmt2.close();
stmt3.close();
rs.close();  
%>
<% } 
else { %>
<center>
<form method="get" action="..\login.jsp">
<input type=submit value="返回">
</form>
</center>
<% } %>
</html>