<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>客人入住</title>
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

</script>
</head>
<body>
<% if (session.getAttribute("pass")=="1") {%>
<center>
<form method="get" action="guestinWebsql.jsp">
<table>
<tr>
<td>姓名：</td>
<td><input type=text name=gname></td>
</tr>
<tr>
<td>手机号：</td>
<td><input type=text name=phone onBlur="getVal(this.id)" onkeyup="value=value.replace(/[^\d]/g,'')" maxlength='11'></td>
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