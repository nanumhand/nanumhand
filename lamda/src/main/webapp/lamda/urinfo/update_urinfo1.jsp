
<html ng-app>
<head>
<link rel="stylesheet" type="text/css" href="/css/styles.css"/>
<link rel="stylesheet" href="/css/buttons.css" type="text/css">
<style>
.myColor1 {color:#F7A363;}
.myColor2 {color:#000000;}
</style>
<script src="/js/html5.js"></script>
<script src="/js/angular.js"></script>
<script src="/js/jquery-3.1.0.min.js"></script>
</head>

<body>
<div align="center">
 <form novalidate action="update_urinfoDB.jsp" method="post" name="registerForm" id="registerForm" onSubmit="return submitContents(this)">
<table border="0" cellpadding="1" cellspacing="10">
	<tbody>
		<tr height="30px">
			<td bgcolor="2D9AF8" style="width:150px; color:ffffff; font-weight:700"><ul><li>I&nbsp;D</li></ul></td>
			<td style="border-bottom:1px dotted"><input name="user_id" id="user_id" size="20" type="text"  style="border: none; background-color:transparent;"  required ng-maxlength="15" ng-minlength="5" value="김현수" readonly></input></td><td width="10px"><input type="hidden" id="idcheck" ng-disabled="(user_id)? false : true" value="중복검사"></input></td><td width="250px"><span style="font-size:80%; color:blue" ng-show="registerForm.user_id.$error.required || registerForm.user_id.$error.pattern || registerForm.user_id.$error.maxlength || registerForm.user_id.$error.minlength"></span></td>
		</tr>
		<tr height="30px">
			<td bgcolor="2D9AF8" style="width:150px; color:ffffff; font-weight:700"><ul><li>New PASSWORD</li></ul></td>
			<td style="border-bottom:1px dotted"><input name="password" size="20" type="text" style="border: none; background-color:transparent;" ng-model="passwords" ng-pattern="/^[a-zA-Z0-9]{4,15}$/" required ng-maxlength="15" ng-minlength="4" onFocus="if(this.value=='변경을 원할 때만.'){this.value=''; this.className='myColor2';}" 
	onBlur="if(this.value==''){this.value='변경을 원할 때만.'; this.className='myColor1';}" 
	class="myColor1"></input></td><td></td><td><span style="font-size:80%; color:green" ng-show="registerForm.password.$error.required || registerForm.password.$error.pattern || registerForm.password.$error.maxlength || registerForm.password.$error.minlength">&nbsp;&nbsp;영문과 숫자만 허용됩니다. (4~15자이내)</span></td>
		</tr>
		<tr height="30px">
			<td bgcolor="2D9AF8" style="width:150px; color:ffffff; font-weight:700"><ul><li>E-MAIL</li></ul></td>
			
			<td style="border-bottom:1px dotted"><input name="email" id="email" size="25" type="text" class="myColor1" style="text-align:left ;border: none; background-color:transparent;" ng-model="emails" ng-pattern="/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/" required value="이메일"></input></td><td width="10px"><input type="button" id="emailcheck" ng-disabled="(email)? false : true" value="중복검사"></input></td><td width="230px"><span style="font-size:80%; color:orange" ng-show="registerForm.email.$error.required || registerForm.email.$error.pattern">&nbsp;&nbsp;형식에 맞지 않습니다.</span></td>
		</tr>
	</tbody>
</table>

<p/>
<table><tr><td>
<input style="margin-left:10px; height:30px; width:250px;" ng-disabled="(user_id&&password&&email)? false : true" type="submit" value="Register into LAMDA"/></td><td><div style="text-align:center; border: steelblue 2px dotted; height:20px; width:250px; color:steelblue; padding:2px" id="divcheck"></div></td></tr></table>



</form>


<script>

$("#emailcheck").click(function(){	
	var email = $("#email").val();
	$("#divcheck").load("emailcheck.jsp?email="+email, function(){
		if ($("#emailcheck_value").text()=="이메일을 사용하셔도 좋습니다.")
			$("#emailcheck_hidden").val(email);
		});	
});

function submitContents(c) {
	if(c.emailcheck_hidden.value !=c.email.value) {
                alert("중복검사가 필요합니다.");
                return false;
	} 
}
</script>
</div>
</body>
</html>
