<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page import="java.sql.*,
org.jfree.chart.*,
org.jfree.chart.plot.*,
org.jfree.chart.labels.*,
org.jfree.data.category.*,
java.awt.*,org.jfree.ui.*,
org.jfree.chart.renderer.category.BarRenderer3D,
org.jfree.chart.plot.PlotOrientation,
org.jfree.data.general.DatasetUtilities"
%>
<title>显示菜品销售情况统计</title>
</head>
<% if (session.getAttribute("pass")=="1") {%>
<body>
<center>
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
Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);	
ResultSet rs=null;
String sql="select dname,count(dnum) from dishes a,dishesorde b where a.did=b.did and state=1 group by dname";
rs=stmt.executeQuery(sql); 
StandardChartTheme sct = new StandardChartTheme("CN");
sct.setExtraLargeFont(new Font("隶书", Font.BOLD, 20));
sct.setRegularFont(new Font("隶书", Font.BOLD, 20));
sct.setLargeFont(new Font("隶书", Font.BOLD, 20));
ChartFactory.setChartTheme(sct);
//根据数据库数据动态生成柱状图
int length=0;
while(rs.next())	length++;
double[][] data = new double[length][1];
String[] rowKeys = new String[length];
String[] columnKeys = {""};
//指针移到结果集的最前面
rs.beforeFirst();
int i=0;
while(rs.next()){
	data[i][0]=(double)rs.getInt(2);
	rowKeys[i]=rs.getString(1);
	i++;
}

CategoryDataset dataset = DatasetUtilities.createCategoryDataset(rowKeys,columnKeys,data);

JFreeChart chart = ChartFactory.createBarChart("菜品销量统计图", 
                  "菜品",
                  "销量",
                  dataset,
                  PlotOrientation.VERTICAL,
                  true,
                  false,
                  false);
CategoryPlot plot = chart.getCategoryPlot();  
//设置网格背景颜色
plot.setBackgroundPaint(Color.white);
//设置网格竖线颜色
plot.setDomainGridlinePaint(Color.pink);
//设置网格横线颜色
plot.setRangeGridlinePaint(Color.pink);
//显示每个柱的数值，并修改该数值的字体属性
BarRenderer3D renderer = new BarRenderer3D();
renderer.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
renderer.setBaseItemLabelsVisible(true);

//设置柱体的大小
renderer.setMaximumBarWidth(0.08);

//通过如下两句可调整数字的显示
//显示数字
renderer.setBasePositiveItemLabelPosition(new ItemLabelPosition(ItemLabelAnchor.OUTSIDE12, TextAnchor.BASELINE_LEFT));
renderer.setItemLabelAnchorOffset(10D);

//设置每个菜品所在的平行柱的之间距离
renderer.setItemMargin(0.2);
plot.setRenderer(renderer);

ChartUtilities.writeChartAsJPEG(response.getOutputStream(),chart,600,500,null);

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