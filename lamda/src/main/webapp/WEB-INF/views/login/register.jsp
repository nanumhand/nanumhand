<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.io.*, java.sql.*, javax.sql.*, javax.servlet.*" %>
<html ng-app>
<head>
<link rel="stylesheet" href="/css/buttons.css" type="text/css">
<script src="/js/html5.js"></script>
<script src="/js/angular.js"></script>
<script src="/js/jquery-3.1.0.min.js"></script>
<style>
#absolute1, #absolute2, #absolute3
{ position: absolute; }
#absolute1{ z-index: 1;}
#absolute2 { z-index: 2;}
#absolute3 { z-index: 3;}
#absolute4 { z-index: 4;}

.myColor1 {color:#F7A363;}
.myColor2 {color:#000000;}

.center {
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  width: 48%;
  height: 59%;
}
.background {
    background: rgba(0, 0, 0, 0.1);
}
</style>
</head>
<body>
<div align="center">
 <form novalidate action="registerDB.jsp" method="post" name="registerForm" id="registerForm" onSubmit="return submitContents(this)">
<table border="0" cellpadding="1" cellspacing="10">
	<tbody>
		<tr height="30px">
			<td bgcolor="2D9AF8" style="width:150px; color:ffffff; font-weight:700"><ul><li>I&nbsp;D</li></ul></td>
			<td style="border-bottom:1px dotted"><input name="user_id" id="user_id" size="20" type="text" ng-model="user_id" style="border: none; background-color:transparent;" ng-pattern="/^[0-9A-Za-z]{5,15}$/" required ng-maxlength="15" ng-minlength="5"></input></td><td width="10px"><input type="button" id="idcheck" ng-disabled="(user_id)? false : true" value="중복검사"></input></td><td width="250px"><span style="font-size:80%; color:blue" ng-show="registerForm.user_id.$error.required || registerForm.user_id.$error.pattern || registerForm.user_id.$error.maxlength || registerForm.user_id.$error.minlength">&nbsp;&nbsp;영문과 숫자만 허용됩니다. (5~15자이내)</span></td>
		</tr>
		<tr height="30px">
			<td bgcolor="2D9AF8" style="width:150px; color:ffffff; font-weight:700"><ul><li>PASSWORD</li></ul></td>
			<td style="border-bottom:1px dotted"><input name="password" size="20" type="password" style="border: none; background-color:transparent;" ng-model="password" ng-pattern="/^[a-zA-Z0-9]{4,15}$/" required ng-maxlength="15" ng-minlength="4"></input></td><td></td><td><span style="font-size:80%; color:green" ng-show="registerForm.password.$error.required || registerForm.password.$error.pattern || registerForm.password.$error.maxlength || registerForm.password.$error.minlength">&nbsp;&nbsp;영문과 숫자만 허용됩니다. (4~15자이내)</span></td>
		</tr>
		<tr height="30px">
			<td bgcolor="2D9AF8" style="width:150px; color:ffffff; font-weight:700"><ul><li>E-MAIL</li></ul></td>
			
			<td style="border-bottom:1px dotted"><input name="email" id="email" size="25" type="text" style="border: none; background-color:transparent;" ng-model="email" ng-pattern="/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/" required></input></td><td width="10px"><input type="button" id="emailcheck" ng-disabled="(email)? false : true" value="중복검사"></input></td><td width="230px"><span style="font-size:80%; color:orange" ng-show="registerForm.email.$error.required || registerForm.email.$error.pattern">&nbsp;&nbsp;형식에 맞지 않습니다.</span></td>
		</tr>
	</tbody>
</table>

<p/>
<table><tr><td>
<input style="margin-left:10px; height:30px; width:250px;" ng-disabled="(user_id&&password&&email)? false : true" type="submit" value="Register into LAMDA"/></td><td><div style="text-align:center; border: steelblue 2px dotted; height:20px; width:250px; color:steelblue; padding:2px" id="divcheck"></div></td></tr></table>
<input type="hidden" id="idcheck_hidden" value=""/>
<input type="hidden" id="emailcheck_hidden" value=""/>

</form>


<script>
$("#idcheck").click(function(){	
	var id = $("#user_id").val();
	$("#divcheck").load("idcheck.jsp?user_id="+id, function(){
		if ($("#idcheck_value").text()=="아이디를 사용하셔도 좋습니다.")
			$("#idcheck_hidden").val(id);
		});	
});

$("#emailcheck").click(function(){	
	var email = $("#email").val();
	$("#divcheck").load("emailcheck.jsp?email="+email, function(){
		if ($("#emailcheck_value").text()=="이메일을 사용하셔도 좋습니다.")
			$("#emailcheck_hidden").val(email);
		});	
});

function submitContents(c) {
	if(c.idcheck_hidden.value !=c.user_id.value||c.emailcheck_hidden.value !=c.email.value) {
                alert("중복검사가 필요합니다.");
                return false;
	} 
}
</script>
</div>
</body>
</html>