<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage=""%>
<%@ page import="java.sql.*" import="java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>确认预订</title>
</head>
<body>
<%
String guestname=request.getParameter("gname1");
guestname=new String(guestname.getBytes("8859_1"),"utf-8");
String phone=request.getParameter("phone1");
phone=new String(phone.getBytes("8859_1"),"utf-8");
String id=request.getParameter("id");
id=new String(id.getBytes("8859_1"),"utf-8");
String ordermore=request.getParameter("more1");
ordermore=new String(ordermore.getBytes("8859_1"),"utf-8");
String rid1=request.getParameter("param1");
String intime1=request.getParameter("param3");
String outtime1=request.getParameter("param4");
//获得系统时间
java.util.Date date=new java.util.Date();
String datestr=java.text.DateFormat.getDateTimeInstance().format(date);
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
Statement smt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
ResultSet rst2=smt.executeQuery("select * from orde");
rst2.last();
int total1=rst2.getRow();
total1++;//自动生成orde编号
int mrs=0;
try{
	Statement stmt=conn.createStatement();
	ResultSet rs=stmt.executeQuery("select gname from guest where phone='"+session.getAttribute("currentGuest")+"'");
	mrs=rs.getRow();
}
catch(Exception e)
{
out.print(e);
}
if(0==mrs){
try
{
    String sql1="update guest set gname='"+guestname+"',gid='"+id+"' where phone='"+phone+"'";
    Statement stmt=conn.createStatement();	
    stmt.executeUpdate(sql1);
}
catch(Exception e)
{
out.print(e);
}
}
try
{
	//押金100元
    String sql="insert into orde(oid,rid,phone,intime,outime,money,more,ostate) values('"+total1+"','"+rid1+"','"+phone+"','"+intime1+"','"+outtime1+"','100','"+ordermore+"',0)";
    Statement stmt=conn.createStatement();	
    stmt.executeUpdate(sql);
}
catch(Exception e)
{
out.print(e);
}
try
{
String sql0="update room set rstate=1 where rid='"+rid1+"'";
Statement stmt0=conn.createStatement();	
stmt0.executeUpdate(sql0);
}
catch(Exception e)
{
out.print(e);
}
%>
<%
try
{
	String sql="select * from orde where oid='"+total1+"'"	;
	Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);	
    ResultSet rs1=stmt.executeQuery(sql);
%>
    <%
//移动指针到第一条记录之前
rs1.beforeFirst();
//移动记录指针到下一条记录
while(rs1.next())
{
%>
<p align="right">
<%
String phone1=(String)session.getAttribute("currentGuest");
if(phone1==null) {
  	out.println("你还未");
%>
<a href="guestlogin.jsp">登录</a>|<a href="signup.jsp">注册</a>
<%}else {    	
   out.println("欢迎你,"+phone+"!");%>
<a href="esc.jsp">退出</a>
<%}%>
</p>
<center>
预订成功！订单详细信息如下：
<br><br>
<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0"  >
<tr>
<td align="right">订单号：</td><td><%=rs1.getInt(1) %></td>
</tr>
<tr>
<td align="right">房间号：</td><td><%=rs1.getInt(2) %></td>
</tr>
<tr>
<td align="right">手机号：</td><td><%=rs1.getString(3) %></td>
</tr>
<tr>
<td align="right">入住时间：</td><td><%=rs1.getString(4) %></td>
</tr>
<tr>
<td align="right">退房时间：</td><td><%=rs1.getString(5) %></td>
</tr>
<tr>
<td align="right">押金：</td><td><%=rs1.getString(6) %></td>
</tr>
<tr>
<td align="right">备注信息：</td><td><%=rs1.getString(7) %></td>
</tr>
<tr>
<td align="right">交易成功时间：</td><td><%=datestr %></td>
</tr>
</table>
</center>
<% 
//rs1.close();
//stmt.close();
}%>
<%}
catch(Exception e)
{
out.print(e);
}
//out.println("预订成功！订单详细信息为：");
%>
<center>
<br><br>
<form  id="form1" name="form1" method="post" action="WebContinue.jsp">
<input type="submit" name="Submit" value="网上支付"/>
<input type="button" name="Submit2" onclick="window.location.href='index.jsp'" value="取消">
</form>
</center>


</body>
</html>