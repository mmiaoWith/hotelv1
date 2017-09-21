<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<title>经理权限</title>
</head>
<link rel="StyleSheet" href="dtree.css" type="text/css"/>
<script type="text/javascript" src="dtree.js"></script>
<% if (session.getAttribute("pass")=="1") {%>
<body>
<div class="dtree">
<script type="text/javascript">
function opena(url){
self.parent.frames['list'].location=url;
}
d=new dTree('d');
d.add(0,-1,'酒店餐饮管理系统');
d.add(1,0,'经理权限');
d.add(10,1,'添加员工','javascript:opena(\'manager/AddPeople.jsp\')');
d.add(11,1,'删除员工','javascript:opena(\'manager/QueryPeople.jsp\')');
d.add(2,0,'客人管理');
d.add(12,2,'客人登记','');
d.add(7,2,'网上订房');
d.add(13,2,'查询客人信息','');
d.add(16,2,'修改客人信息','');
d.add(3,0,'房间管理');
d.add(17,3,'设置房间信息','');
d.add(18,3,'查询房间信息','');
d.add(19,3,'修改房间信息','');
d.add(4,0,'菜品管理');
d.add(20,4,'设置菜品信息','');
d.add(21,4,'查询菜品信息','');
d.add(22,4,'修改菜品信息','');
d.add(30,0,'点餐');
d.add(31,30,'查询菜品信息','');
d.add(32,30,'点餐','');
d.add(5,0,'业务管理');
d.add(23,5,'结账功能(退房)','');
d.add(24,5,'订单管理(续住)','');
d.add(6,0,'财务管理');
d.add(25,6,'财务报表','javascript:opena(\'finance/FinChart.jsp\')');
d.add(26,6,'客房使用情况分析','javascript:opena(\'finance/trend.jsp\')');
d.add(27,6,'菜品销售情况分析','javascript:opena(\'finance/dishestrend.jsp\')');
document.write(d);
</script>
</div>
</body>
<% } 
else { %>
<center>
<form method="post" action="login.jsp">
<input type=submit value="返回">
</form>
</center>
<% } %>
</html>