<%@page import="java.text.ParseException"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage="errorPage.jsp"%>
<%@ page import="java.sql.*" import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat" import="java.text.DateFormat" %>
      
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>网上订房</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/My97DatePicker/WdatePicker.js" charset="utf-8"></script>

<script language="javascript">
	function initVal(obj){//获得房间号
   		var str=obj.innerHTML;
   		var s=str.substring(0,4);
	 	document.getElementById("rid").value=s;
	 }
</script>

<script type="text/javascript">
function showRoom(str)
{
var xmlhttp;    
if (str=="")
  {
  document.getElementById("d11").innerHTML="";
  return;
  }
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    document.getElementById("txtHint").innerHTML=xmlhttp.responseText;
    }
  };
xmlhttp.open("GET","/ajax/getRoom.jsp?q="+str,true);
xmlhttp.send();
}
</script>
</head>
<body>
<%
//获得系统时间
java.util.Date date=new java.util.Date();
String datestr=java.text.DateFormat.getDateInstance().format(date);
String star=request.getParameter("d11");
if(star==null) star=datestr;
java.util.GregorianCalendar now = new java.util.GregorianCalendar();
SimpleDateFormat fmtrq = new SimpleDateFormat("yyyy-MM-dd HH:mm");
now.add(java.util.GregorianCalendar.DATE,1);
String str=fmtrq.format(now.getTime()).substring(0,10);

String star1=request.getParameter("d12");
if(star1==null) star1=str;
%>
<!-- 判断登录状态 -->
<p align="right">
<%
String phone=(String)session.getAttribute("currentGuest");
if(phone==null) {
  	out.println("你还未");
%>
<a href="guestlogin.jsp">登录</a>|<a href="signup.jsp">注册</a>
<%}else {    	
   out.println("欢迎你,"+phone+"!");%>
<a href="esc.jsp">退出</a>
<%}%>
</p>
<center><h2>欢迎使用网上订房</h2></center>
<%@include file="../slide/slide_img.html" %>
<form  id="form1" name="form1" method="get" action="">
 请选择入住日期：<br><br>
 <input id="d11" name="d11" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'%y-%M-{%d}',maxDate:'%y-%M-{%d+180}',isShowClear:false,readOnly:true,doubleCalendar:true})" value="<%=star %>" class="Wdate"/>
  到
  <input id="d12" name="d12" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'%y-%M-{%d+1}',maxDate:'%y-%M-{%d+180}',isShowClear:false,readOnly:true,doubleCalendar:true})" value="<%=star1 %>" class="Wdate"/>&nbsp;&nbsp;
  <input  type="submit" name="Submit" value="查询" />
</form>
<br>
<br>
<% 
String intime=request.getParameter("d11");
String outtime=request.getParameter("d12");
String t=" 11:59";
String t1=" 14:00";
String t2=" 23:59";
if(intime==null){
	intime=datestr;
}
if(outtime==null){
	outtime=fmtrq.format(now.getTime());
}
String intime1=intime+t1;
String intime2=intime+t2;
String outtime1=outtime+t;

//日期转换（string转化为sql的datetime类型）
SimpleDateFormat sdf =   new SimpleDateFormat( "yyyy-MM-dd HH:mm" );//24小时制 
SimpleDateFormat sdf1 =   new SimpleDateFormat( "yyyy-MM-dd" );
java.util.Date timeDatein2 = null;
java.util.Date timeDatein1 = null;
java.util.Date timeDateout = null;
java.util.Date timeDateout1 = null;
try {
 timeDatein1=sdf.parse(intime1);
 timeDatein2 = sdf.parse(intime2);
 timeDateout=sdf1.parse(outtime);
 timeDateout1 = sdf.parse(outtime1);
} catch (ParseException e) {
 // TODO 自动生成 catch 块
 e.printStackTrace();
}//util类型
java.sql.Timestamp dateTimein1 = new java.sql.Timestamp(timeDatein1.getTime());
java.sql.Timestamp dateTimein2 = new java.sql.Timestamp(timeDatein2.getTime());
java.sql.Timestamp dateTimeout = new java.sql.Timestamp(timeDateout.getTime());
java.sql.Timestamp dateTimeout1 = new java.sql.Timestamp(timeDateout1.getTime());
%>
<table border="0" >
<tr>
<td height=20 width=30 align="center" bgcolor=pink></td>
<td></td>
<td align="right">不可预订</td>
<td height=20 width=30 align="center" bgcolor=lightgreen></td>
<td></td>
<td align="right">可预订</td>
</tr>
</table>
<br>
<%
try
{
	Connection conn=null;
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	conn=DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ghotel","scott","1234");
	Statement smt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	ResultSet rst=smt.executeQuery("SELECT a.rid,case rtype when 1 then '单人间' when 2 then '双人间' else '三人间' end as rtype,case rsta when 1 then '海景房' else '普通房' end as rata,rprice,case rstand when 1 then'无独卫' else '设备齐全' end as rstand,case when exists(select 1 from orde b where a.rid=b.rid and( intime between '"+dateTimein1+"' and '"+dateTimein2+"' or outime between '"+dateTimeout+"' and '"+dateTimeout1+"' or(outime>'"+dateTimein1+"' and intime<'"+dateTimeout1+"'))   ) then '不可订' else '可订' end as rstate from room a,roomdesign where a.rid=roomdesign.rid order by a.rid");
	%> 
	<table width="80%" border="1" align="center"  > 
	<%int j=1; %>
	<%
	//移动指针到第一条记录之前
	rst.beforeFirst();
	//移动记录指针到下一条记录
	while(rst.next()&&j<=15)
	{
	%>
	<%if(j%5==1){ %>
	<tr>
	<%} %>
	<%
	String s1=rst.getString(6);
	//out.println("s1: "+s1);
	if(s1.equals("不可订"))
	{		
	%>
	<td align="center" bgcolor=pink><%=rst.getInt(1) %><br><%=rst.getString(2)%><br><%=rst.getString(3) %><br><%=rst.getInt(4) %>元<br><%=rst.getString(5)%></td>
	<% }
	else {%>
	<td onClick="initVal(this)" align="center" bgcolor=lightgreen><%=rst.getInt(1) %><br><%=rst.getString(2)%><br><%=rst.getString(3) %><br><%=rst.getInt(4) %>元<br><%=rst.getString(5)%></td>
	<% } %>
	<%  if(j%5==0){%>
	</tr>
	<%}
	j++;%>
	<%} %>
	</table><p>
	<br>

<% }
catch(SQLException SE)
{
out.println();
SE.printStackTrace();
} %>


<form id="form2" name="form2" method="post" action="WebCheckinHotel.jsp?param1=<%=dateTimein1 %>&amp;param2=<%=dateTimeout1 %>">
您所选择的房间为：<br><br>
 <input type="text" name="rid" id="rid" value="" border="0">&nbsp;&nbsp;
<input type="submit" name="Submit" value="预订"> 
</form><br><br>
</body>
</html>