<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.io.*, java.sql.*, javax.sql.*, javax.servlet.*" %>
<html ng-app>
<head>
<link rel="stylesheet" type="text/css" href="/css/styles.css"/>
<link rel="stylesheet" href="/css/buttons.css" type="text/css">
<style>
label.error {
    position: absolute;
    border: 1px dotted red;
    background: #EEE;
    padding: 1px;
	font-size:80%;
	color:#F7A363;
}

.myColor1 {color:#F7A363;}
.myColor2 {color:#000000;}
</style>
<script src="/js/html5.js"></script>
<script src="/js/angular.js"></script>
<script src="/js/jquery-3.1.0.min.js"></script>
<script src="/js/jquery.validate.min.js"></script>
<script src="/js/additional-methods.min.js"></script>
<script src="/js/messages_ko.min.js"></script>
</head>
<%
    String user_id = request.getParameter("user_id");    
    
	
    Class.forName("oracle.jdbc.driver.OracleDriver"); 
	Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.48.128:1521:oraedu", "red_my11", "hardhard");
	Statement stmt = conn.createStatement(); 
	String sql="select * from tbl_user where user_id='"+user_id+"'";
	ResultSet rset =stmt.executeQuery(sql);
	
	rset.next();
	%>
<body onload="update_form.email.focus();">
<div align="center">
 <form novalidate action="update_urinfoDB.jsp" method="post" name="update_form" id="update_form" onSubmit="return submitContents(this)">
<table border="0" cellpadding="1" cellspacing="10">
	<tbody>
		<tr height="30px">
			<td bgcolor="2D9AF8" style="width:150px; color:ffffff; font-weight:700"><ul><li>I&nbsp;D</li></ul></td>
			<td style="border-bottom:1px dotted"><input name="user_id" id="user_id" size="20" type="text"  style="border: none; background-color:transparent;" value="<%=user_id%>" readonly></input></td><td width="250px"></td>
		</tr>
		<tr height="30px">
			<td bgcolor="2D9AF8" style="width:150px; color:ffffff; font-weight:700"><ul><li>Password</li></ul></td>
			<td style="border-bottom:1px dotted"><input name="password" id="password" size="20" type="password" style="border: none; background-color:transparent;"  value="<%=rset.getString(3)%>"  onFocus="if(this.value=='<%=rset.getString(3)%>'){this.value=''; this.className='myColor2';}" onBlur="if(this.value==''){this.value='<%=rset.getString(3)%>'; this.className='myColor1';}" ></input></td><td><span style="font-size:80%; color:green">&nbsp;&nbsp;변경을 원할 경우 입력하세요.</span></td>
		</tr>
		<tr height="30px">
			<td bgcolor="2D9AF8" style="width:150px; color:ffffff; font-weight:700"><ul><li>Repeat</li></ul></td>
			<td style="border-bottom:1px dotted"><input name="repassword" id="repassword" size="20" type="password" style="border: none; background-color:transparent;"  value="<%=rset.getString(3)%>" onFocus="if(this.value=='<%=rset.getString(3)%>'){this.value=''; this.className='myColor2';}" onBlur="if(this.value==''){this.value='<%=rset.getString(3)%>'; this.className='myColor1';}"></input></td><td><span style="font-size:80%; color:green">&nbsp;&nbsp;새 비밀번호를 한번 더 입력하세요.</span></td>
		</tr>
		<tr height="30px">
			<td bgcolor="2D9AF8" style="line-height:30px; width:150px; color:ffffff; font-weight:700"><ul><li>E-MAIL</li></ul></td>
			
			<td style="border-bottom:1px dotted"><input name="email" id="email" size="25" type="text" style="text-align:left ;border: none; background-color:transparent;"  value="<%=rset.getString(4)%>" ></input></td><td width="10px"><input onmouseover="($('#email').val()=='<%=rset.getString(4)%>')? $(this).attr('disabled',true): $(this). removeAttr('disabled')" type="button" id="emailcheck" value="중복검사"></input></td>
		</tr>
	</tbody>
</table>

<p/>
<table><tr><td>
<input id="submit" style="margin-left:10px; height:30px; width:250px;"  type="submit" value="저장하기"/></td><td><div style="text-align:center; border: steelblue 2px dotted; height:20px; width:250px; color:steelblue; padding:2px" id="divcheck"></div></td></tr></table>

<input type="hidden" id="emailcheck_hidden" value="<%=rset.getString(4)%>"/>

</form>

<script>
$.validator.setDefaults({
		submitHandler: function() {
			if($("#emailcheck_hidden").val() !=$("#email").val()) {
		alert("중복검사가 필요합니다.");
		return false;
		} else { return true; } 
	}
});

$("#emailcheck").click(function(){	
	var email = $("#email").val();
	$("#divcheck").load("/lamda/login/emailcheck.jsp?email="+email, function(){
		if ($("#emailcheck_value").text()=="이메일을 사용하셔도 좋습니다.")
			$("#emailcheck_hidden").val(email);
		});		
});


$("#update_form").validate({
	errorPlacement: function(error, element) {
	var pos = element.offset();             
	error.css({
		left: pos.right+80,
		top: pos.top
	});             
	error.insertAfter(element);
	},
	rules: {
		password: {
			minlength : 4,
			maxlength : 15,
			pattern : /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{4,15}$/	
		},
		repassword: {
			equalTo : "#password"
		},
		email: {
			required : true,
			minlength : 5,
			pattern :/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/
		}
	 },
	//규칙체크 실패시 출력될 메시지
	messages : {
	   password: {
			minlength : "최소 4글자이상이어야 합니다.",
			maxlength : "최대 15글자까지 허용됩니다.",
			pattern : "영어, 숫자, 특수문자를 모두 사용해야 합니다."
		},
		repassword: {
			equalTo : "비밀번호가 일치하지 않습니다."
		},
		email: {
			required : "필수로입력하세요.",
			minlength : "최소 5글자이상이어야 합니다.",
			pattern : "메일형식에 맞지 않습니다."
		}
	}
});

 </script>
</div>
<% rset.close(); stmt.close(); conn.close(); %>

</body>
</html>
