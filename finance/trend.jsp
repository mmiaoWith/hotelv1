<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page import="java.sql.*,
java.awt.Font,
org.jfree.chart.ChartFactory,
org.jfree.chart.JFreeChart,
org.jfree.chart.StandardChartTheme,
org.jfree.data.general.DefaultPieDataset, 
org.jfree.chart.ChartUtilities,
org.jfree.chart.plot.PiePlot,
org.jfree.chart.labels.StandardPieSectionLabelGenerator;"
%>
<title>显示统计客房使用情况</title>
</head>
<% if (session.getAttribute("pass")=="1") {%>
<body>
<center>
<%!String typeadd=null; 
double roomcount=0;%>
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
Statement stmt=conn.createStatement();		
ResultSet rs=null;
String sql="select rtype,count(room.rid) from room,roomdesign where roomdesign.rid=room.rid and rstate=1 group by rtype";
rs=stmt.executeQuery(sql); 
StandardChartTheme sct = new StandardChartTheme("CN");
sct.setExtraLargeFont(new Font("隶书", Font.BOLD, 20));
sct.setRegularFont(new Font("隶书", Font.BOLD, 20));
sct.setLargeFont(new Font("隶书", Font.BOLD, 20));
ChartFactory.setChartTheme(sct);
DefaultPieDataset dataset = new DefaultPieDataset();
while(rs.next())
{
String type=rs.getString(1);
if(type.equals("1")){type="单人间";}
if(type.equals("2")){type="双人间";}
else if(type.equals("3")){type="三人间";}
typeadd=rs.getString(2);
roomcount=Double.parseDouble(typeadd);
dataset.setValue(type,roomcount);
}
JFreeChart jfreechart = ChartFactory.createPieChart("入房比例图", dataset,true, true, true);
PiePlot plot=(PiePlot)jfreechart.getPlot();
plot.setLegendLabelGenerator( new StandardPieSectionLabelGenerator( "{2}" ));  // 设置标签显示数值， {1} 为数值， {2} 为百分比
ChartUtilities.writeChartAsJPEG(response.getOutputStream(),jfreechart,600,500,null);
%> 
</center>
</body>
<% } 
else { %>
<center>
<form method="get" action="..\login.jsp">
<input type=submit value="返回"></form>
</center>
<% } %>
</html>