<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage=""%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>网上订房</title>

<style type="text/css">.con { width:600px; height:auto; margin:0 auto; background:#fff; border:solid 1px #ccc; font-size:14px; font-family:Arial, Helvetica, sans-serif; }
  .input_div{width:100%;}
  //.input_div label{width:200px;float:left;text-align:left;}
  .input_div input{width:200px;float:center;}
</style>

<script language="javascript" type="text/javascript">

function getVal1(id){
	if (document.getElementById("Idp").value != ""){
		var shenfenzheng1=document.getElementById("Idp").value;
		var reg=/^((\d{18})|(\d{17}[Xx]))$/;
		var my = false;
		if(reg.test(shenfenzheng1)) my=true;
		if (!my){    
   			document.getElementById("Idp").value='';    
   			alert('对不起，您输入的身份证号有错误。');    
   			document.getElementById("Idp").focus();    
   			return false;    
		}
		else if(document.getElementById("Idp").value.length!=18){
			alert('对不起，您输入的身份证号不够18位。');    
	    	document.getElementById("Idp").focus();    
	    	return false;    
		}
		else{
			if(document.getElementById('StripImg').value==''){
				$('#CreateStripImg').click(function(){CreateStripImg();});
				$('#CreateStripImg').click();
		}
	}
	return true;    
	}
}


</script>
</head>
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
<%
String roomId=request.getParameter("rid");
//String intime1=request.getParameter("d11");
//获得上一个页面传来的入离时间
String intime=request.getParameter("param1");
String outtime=request.getParameter("param2");
//out.println("intime1="+intime);
//out.println("outtime1="+outtime);
try
{
	Connection conn=null;
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	conn=DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ghotel","scott","1234");
	Statement smt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	ResultSet rst=smt.executeQuery("select rid,case rtype when 1 then '单人间' when 2 then '双人间' else '三人间' end as rtype,case rsta when 1 then '海景房' else '普通房' end as rata,rprice,case rstand when 1 then'无独卫' else '设备齐全' end as rstand from roomdesign where rid like '%"+roomId +"%' ");
	rst.last();
	
	Connection conn1=null;
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	conn1=DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ghotel","scott","1234");
	Statement smt1=conn1.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	ResultSet rs=smt1.executeQuery("select * from guest where phone='"+session.getAttribute("currentGuest")+"'");
	rs.last();
%>
 
<center>
<%
//移动指针到第一条记录之前
rst.beforeFirst();
//移动记录指针到下一条记录
while(rst.next())
{
%>
<form  id="form1" name="form1" method="post" action="WebCheckinHotel1.jsp?param1=<%=roomId %>&param3=<%=intime %>&param4=<%=outtime%>">
<%
//request.setAttribute("name",roomId);
%>

<br>
尊敬的顾客，您好，您所选择的房间信息如下：
<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0"  >
<tr>
<td align="center" >房间号: <%=rst.getInt(1) %></td>
</tr>
<tr>
<td align="center"><%=rst.getString(2) %>&nbsp;&nbsp;</td>
</tr>
<tr>
<td align="center"><%=rst.getString(3) %>&nbsp;&nbsp;</td>
</tr>
<tr>
<td align="center">房价：<%=rst.getString(4) %>元&nbsp;&nbsp;</td>
</tr>
<tr>
<td align="center"><%=rst.getString(5) %>&nbsp;&nbsp;</td>
</tr>
</table>
<br>
<br>
如果信息无误，请完善如下信息：<br><br>
<div class="input_div">
<%if(null==rs.getString(1)) {%>
请输入您的姓名：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input name="gname1" type="text" value="张三" align="middle">
<br> 
<br>
请输入您的身份证号:
<input name="id" id ="Idp" type="text" maxlength='18'  value="" onBlur="getVal1(this.id)" align="middle"  />
<%}else{ %>
请输入您的姓名：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input name="gname1" type="text" value="<%=rs.getString(1) %>" align="middle">
<br> 
<br>
请输入您的身份证号:
<input name="id" id ="Idp" type="text" maxlength='18'  value="<%=rs.getString(2) %>" align="middle"  />

<%} %>
<br> 
<br>
请输入您的手机号：&nbsp;
<input name="phone1" id ="Mobile" type="text" maxlength='11'  value="<%=session.getAttribute("currentGuest") %>" onBlur="getVal(this.id)" align="middle"  onkeyup="value=value.replace(/[^(\d)]/g,'')"/>
<br> 
<br>
请输入备注信息：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input name="more1" type="text" value=" " align="middle"/>
<br>
<br>
<br>
</div>
<input type="submit" name="Submit" value="提交"/>
<input type="button" name="Submit2" onClick="window.location.href='index.jsp'" value="取消">
</form>
</center>
<%} %>


<%
rst.close();
smt.close();
conn.close();
rs.close();
smt1.close();
conn1.close();
}
catch(SQLException SE)
{
out.println();
SE.printStackTrace();
}
%>

</body>
</html>
