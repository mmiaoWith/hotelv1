<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>客人登记</title>
<script language="javascript" type="text/javascript">
function getVal(id)
{
if (document.getElementById("phone").value != ""){
var mobile=document.getElementById("phone").value;
//alert("长度："+mobile.value.length);
var reg0 = /^13\d{5,9}$/;    
var reg1 = /^15[0-35-9]\d{4,8}$/;    
var reg2 = /^18[0-9]\d{4,8}$/;     
var reg3 = /^0\d{10,11}$/;  
var my = false;
if (reg0.test(mobile)) my=true;    

if (reg1.test(mobile)) my=true;    
if (reg2.test(mobile)) my=true;    
if (reg3.test(mobile)) my=true;    
if (!my){    
   document.getElementById("phone").value='';    
   alert('对不起，您输入的手机号码有错误。');    
   document.getElementById("phone").focus();    
   return false;    
}else if(document.getElementById("phone").value.length!=11)
	{
	alert('对不起，您输入的手机号码不够11位。');    
	   document.getElementById("phone").focus();    
	   return false;    
	}

else
{
if(document.getElementById('StripImg').value=='')
{
$('#CreateStripImg').click(function(){CreateStripImg();});
$('#CreateStripImg').click();
}
}
return true;    
}
}

function getVal1(id)
{
if (document.getElementById("gid").value != ""){
var shenfenzheng1=document.getElementById("gid").value;
var reg=/^((\d{18})|(\d{17}[Xx]))$/;
var my = false;
//var a=shenfenzheng1.substring(0, 17);
//var b=shenfenzheng1.substring(17,18); 
if(reg.test(shenfenzheng1)) my=true;
/*
var c=a.match(reg1);
alert("c="+c);
if(c==null)
 alert('前17位必须是数字');
var d=a.match(reg2);
if(d==null)
 alert('最后一位必须是数字或X');
 */
if (!my){    
   document.getElementById("gid").value='';    
   alert('对不起，您输入的身份证号有错误。');    
   document.getElementById("gid").focus();    
   return false;    
}
else if(document.getElementById("gid").value.length!=18)
	{
	alert('对不起，您输入的身份证号不够18位。');    
	   document.getElementById("gid").focus();    
	   return false;    
	}

else
{
if(document.getElementById('StripImg').value=='')
{
$('#CreateStripImg').click(function(){CreateStripImg();});
$('#CreateStripImg').click();
}
}
return true;    
}
}
</script>
</head>
<body>
<% if (session.getAttribute("pass")=="1") {%>
<center>
<form method="get" action="guestinsql.jsp">
<table>
<tr>
<td>姓名：</td>
<td><input type=text name=gname></td>
</tr>
<tr>
<td>身份证号：</td>
<td><input type=text name=gid maxlength='18' onBlur="getVal1(this.id)"></td>
</tr>
<tr>
<td>手机号：</td>
<td><input type=text name=phone onBlur="getVal(this.id)" onkeyup="value=value.replace(/[^\d]/g,'')" maxlength='11'></td>
</tr>
<tr>
<%
String sql="select rid from room where rstate=0";
Connection conn=null;
try
{
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	System.out.println("加载驱动成功！");
}catch(Exception e){
	out.print(e);
	System.out.println("加载驱动失败！");
}
conn=DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ghotel","scott","1234");
System.out.println("连接数据库成功！");
Statement smt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
ResultSet rs=smt.executeQuery(sql);
 %>
<tr>
<td>房间号：</td>
<td><select name=rid>
<option value='' selected></option>
<%while(rs.next()){%> 
<option><%=rs.getInt("rid")%></option>
<%
} 
rs.close(); %>
</select></td>
</tr>
<tr>
<td>入住时间：</td>
<%java.util.Date dtime=new java.util.Date(); 
String time=java.text.DateFormat.getDateTimeInstance().format(dtime);
%>
<td><input type=text name=intime value=<%=time %>></td>
</tr>
<tr>
<td>退房时间：</td>
<td><input type=text name=outime></td>
</tr>
<tr>
<td>押金：</td>
<td><input type=text name=money onkeyup="value=value.replace(/[^\d]/g,'')" value=100></td>
</tr>
<tr>
<td>备注：</td>
<td><input type=text name=more></td>
</tr>
<tr>
<td><input type=submit value=提交></td>
<td><input type=reset value=重置></td>
</tr>
</table>
</form>
</center>
<% } 
else { %>
<center>
<form method="get" action="..\login.jsp">
<input type=submit value="返回">
</form>
</center>
<% } %>
</body>
</html>