<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.io.*, java.sql.*, javax.sql.*" %>

<html ng-app>
<head>
<link rel="stylesheet" href="/css/buttons.css" type="text/css">
<script src="/js/html5.js"></script>
<script src="/js/angular.js"></script>
<script src="/js/jquery-3.1.0.min.js"></script>

</head>
<body>
<div align="center">
 <form novalidate action="logincheck.jsp" method="post" name="registerForm" id="registerForm">
<table border="0" cellpadding="1" cellspacing="10">
	<tbody>
		<tr height="30px">
			<td bgcolor="2D9AF8" style="width:150px; color:ffffff; font-weight:700"><ul><li>I&nbsp;D</li></ul></td>
			<td style="border-bottom:1px dotted"><input name="user_id" id="user_id" size="20" type="text" ng-model="user_id" style="border: none; background-color:transparent;" ng-pattern="/^[0-9A-Za-z]{5,15}$/" required ng-maxlength="15" ng-minlength="5"></input></td><td width="250px"><span style="font-size:80%; color:green" ng-show="registerForm.user_id.$error.required || registerForm.user_id.$error.pattern || registerForm.user_id.$error.maxlength || registerForm.user_id.$error.minlength">&nbsp;&nbsp;영문과 숫자만 허용됩니다. (5~15자이내)</span></td>
		</tr>
		<tr height="30px">
			<td bgcolor="2D9AF8" style="width:150px; color:ffffff; font-weight:700"><ul><li>PASSWORD</li></ul></td>
			<td style="border-bottom:1px dotted"><input name="password" id="password" size="20" type="password" style="border: none; background-color:transparent;" ng-model="password" ng-pattern="/^[a-zA-Z0-9]{4,15}$/" required ng-maxlength="15" ng-minlength="4"></input></td><td><span style="font-size:80%; color:orange" ng-show="registerForm.password.$error.required || registerForm.password.$error.pattern || registerForm.password.$error.maxlength || registerForm.password.$error.minlength">&nbsp;&nbsp;영문과 숫자만 허용됩니다. (4~15자이내)</span></td>
		</tr>
		
	</tbody>
</table>

<p><input style="margin-left:10px; height:30px; width:250px;" ng-disabled="(user_id&&password)? false : true" type="submit" value="Login to LAMDA"/>&nbsp;&nbsp;<input style="border: blue 2px dotted; height:30px; width:250px; color:steelblue" type="button" id="register" value="Easy Register" onclick="location.href='/lamda/login/register.jsp'"/></p>

</form>
</div>
</body>
</html>

