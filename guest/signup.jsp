<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户注册</title>
<%
	String phone=(String)session.getAttribute("currentGuest");
    if(phone!=null) {
 %>
 <jsp:forward page="index.jsp"></jsp:forward>
 <%} %>
<script language="javascript" type="text/javascript">
function CheckMobile(id)
{
	if (document.getElementById("phone").value != ""){
	var mobile=document.getElementById("phone").value;
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
	}else if(document.getElementById("phone").value.length!=11){
		alert('对不起，您输入的手机号码不够11位。');    
      	document.getElementById("phone").focus();    
      	return false;    
	}else{
		if(document.getElementById('StripImg').value==''){
			$('#CreateStripImg').click(function(){CreateStripImg();});
			$('#CreateStripImg').click();
		}
	}
	return true;    
	}
}
</script>
<script language="javascript"> 
function loadimage(){ 
document.getElementById("randImage").src = "image.jsp?"+Math.random(); 
} 
</script> 
<!-- <%//String rand = (String)session.getAttribute("rand"); %>
<script type="text/javascript">
function CheckImg(rand){ 
	var input = document.getElementById("rand").value; 
	if(rand==input){ 
		alert('验证通过！');
		return true;
	}else{ 
		alert('请输入正确的验证码！');
		document.getElementById("rand").focus(); 
		return false;
	}
}
</script> -->


<script type="text/javascript">
function CheckPsw(){
	var psw1=document.getElementById("psw1").value;
	var psw2=document.getElementById("psw2").value;
	if(psw2==0){
		alert("密码不能为空！");
		return false;
	}
	else if(psw1!=psw2){
		alert("两次输入的密码不一致！");
		return false;
	}
	return true;
}
</script>
</head>
<body>
<center>
<h2>注册</h2>	
<form method="post" action=Checksignup.jsp>
<table>
<tr>
<td>手机号：</td><!-- 只能输入11位的数字 -->
<td><input name=phone id =phone type="text" onkeyup="value=value.replace(/[^\d]/g,'')" onBlur="CheckMobile(this.id)"  maxlength=11></td>
</tr>
<tr>
<td>输入密码：</td><!-- 只能输入字母和数字 -->
<td><input type=password name=psw1 id="psw1" onkeyup="value=value.replace(/[^\w\.\/]/ig,'')"></td>
</tr>
<tr>
<tr>
<td>再次确认密码：</td>
<td><input type=password name=psw2 id="psw2" onblur="return CheckPsw();" onkeyup="value=value.replace(/[^\w\.\/]/ig,'')"></td>
</tr>
<tr> 
<td width="118" height="22" valign="middle" align="left"><input type="text" name=rand id=rand value="验证码"></td> 
<td width="138" valign="middle" align="left"><img alt="code..." name="randImage" id="randImage" src="guest/../image.jsp" width="60" height="20" border="1" align="middle"><a href="javascript:loadimage();">换一张</a> 
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