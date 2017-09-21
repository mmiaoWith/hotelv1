<%@page import="beans.People"%>
<%@page import="java.util.ArrayList"%>
<%@page import="controls.QueryPeople"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage=""%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查询员工的信息</title>
</head>
<% if (session.getAttribute("pass")=="1") {
//分页功能
int pageSize=3;//一页有几条记录
int pageNow=1;//当前是第几页
int pageCount=0;//一共几页
int rowCount=0;//共有几条记录
String pageNowok=request.getParameter("pageNowok");
if(pageNowok!=null){
	pageNow=Integer.parseInt(pageNowok);
}
System.out.println(pageNow);
%>
<body>
<center>
<%
try
{
	QueryPeople qPeople=new QueryPeople();
	ArrayList<People> peoples=qPeople.Query();
	rowCount=peoples.size();
	//计算共有多少页
	if(rowCount%pageSize==0){
		pageCount=rowCount/pageSize;
	}else
		pageCount=rowCount/pageSize+1;
%>
<br>
<table width="100%" border="1" align="center">
<tr>
<th>&nbsp;员工编号</th>
<th>&nbsp;员工职务</th>
<th>&nbsp;</th>
</tr>
<%
int begin=(pageNow-1)*pageSize;
System.out.println("b"+begin);
int end=begin+pageSize;
if(end>rowCount)
	end=rowCount;
System.out.println("e"+end);
for(int i=begin;i<end;i++)
{
People p=new People();
p=peoples.get(i);
%>
<tr>
<td align="center" id="number"><%=p.getPid()%></td>
<td align="center"><%=p.getPosition()%></td>
<td><a href="DelPeople?id=<%=p.getPid()%>">删除</a></td>
</tr>
<%} %>
</table><p>
<% if(pageNow!=1){%>
<a href="QueryPeople.jsp?pageNowok=<%=pageNow-1%>">上一页</a>
<%} 
int i=0;
int e=pageNow+3;
if(e>pageCount)
e=pageCount;
for(i=pageNow;i<e;i++){
%>
<a href="QueryPeople.jsp?pageNowok=<%=i%>"><%=i %></a>
<% }if(pageNow!=pageCount){%>
<a href="QueryPeople.jsp?pageNowok=<%=pageNow+1%>">下一页</a>
<%} %>

<br>
<br>

<%
}
catch(SQLException SE)
{
out.println();
SE.printStackTrace();
}
%>
</center></body>
<% } 
else { %>
<center>
<form method="post" action="..\login.jsp">
<input type=submit value="返回">
</form>
</center>
<% } %>
</html>