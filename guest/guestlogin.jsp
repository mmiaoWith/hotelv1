<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户登录</title>
<%
	String phone=(String)session.getAttribute("currentGuest");
    if(phone!=null) {
 %>
 <jsp:forward page="index.jsp"></jsp:forward>
 <%} %>
<script language="javascript">
function CheckPhone(n){
	if(n.length!=11){
		alert("手机号码必须是11位！");
	}
}
</script>
<script language="javascript"> 
function loadimage(){ 
document.getElementById("randImage").src = "image.jsp?"+Math.random(); 
} 
</script> 
</head>
<body>
<center>
<h2>登录</h2>
<form method="post" action=Checkguestlogin.jsp>
<table>
<tr>
<td>手机号：</td><!-- 只能输入11位的数字 -->
<td><input type=text name=phone onkeyup="value=value.replace(/[^\d]/g,'')" maxlength=11></td>
</tr>
<tr>
<td>输入密码：</td><!-- 只能输入字母和数字 -->
<td><input type=password name=psw onkeyup="value=value.replace(/[^\w\.\/]/ig,'')"></td>
</tr>
<tr> 
<td width="118" height="22" valign="middle" align="left"><input type="text" name="rand" id="rand" value="验证码" onfocus="if (value =='验证码'){value ='';}" onblur="if (value ==''){value='验证码';}"></td> 
<td width="138" valign="middle" align="left"><img alt="code..." name="randImage" id="randImage" src="silde/../image.jsp" width="60" height="20" border="1" align="middle"><a href="javascript:loadimage();">换一张</a> 
</tr> 
<tr>
<td><input type=submit value=提交 ></td>
<td><input type=reset value=重置 ></td>
</tr>
</table>
</form>
</center>
</body>
</html>