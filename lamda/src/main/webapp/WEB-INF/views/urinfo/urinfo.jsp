<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.io.*, java.sql.*, javax.sql.*, java.util.*" %>
<%
String m = "";
if(session != null && session.getAttribute("user_id") != null && !session.getAttribute("user_id").equals("")){
	String user_id=(String) session.getAttribute("user_id");
	m="value='"+user_id+"' readonly";
} else {}
%>

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
</style>
</head>
<body>
<script>
function submitForm(mode){
	if(mode=="update"){
		urinfo_check.action = "urinfo_check.jsp?mode=update";
		urinfo_check.submit();
	} else if(mode=="delete"){
		urinfo_check.action = "urinfo_check.jsp?mode=delete";
		urinfo_check.submit();
	}
}
</script>
<div align="center">
 <form novalidate method="post" name="urinfo_check" id="urinfo_check">
<table border="0" cellpadding="1" cellspacing="10">
	<tbody>
	

		<tr height="30px">
			<td bgcolor="2D9AF8" style="width:150px; color:ffffff; font-weight:700"><ul><li>I&nbsp;D</li></ul></td>
			<td style="border-bottom:1px dotted"><input name="user_id" id="user_id" size="20" type="text"  style="border: none; background-color:transparent;" ng-pattern="/^[0-9A-Za-z]{5,15}$/" required ng-maxlength="15" ng-minlength="5" <%=m%>></input></td>
		</tr>
		<tr height="30px">
			<td bgcolor="2D9AF8" style="width:150px; color:ffffff; font-weight:700"><ul><li>PASSWORD</li></ul></td>
			<td style="border-bottom:1px dotted"><input name="password" id="password" size="20" type="password" style="border: none; background-color:transparent;" ng-model="password" ng-pattern="/^[a-zA-Z0-9]{4,15}$/" required ng-maxlength="15" ng-minlength="4"></input></td>
		</tr>
		
	</tbody>
</table>

<p><button style="margin-left:10px; height:30px; width:250px;" ng-disabled="(password)? false : true" onclick="submitForm('update');">회원정보 수정하기</button>&nbsp;&nbsp;<button style="border: blue 2px dotted; height:30px; width:250px; color:steelblue" ng-disabled="(password)? false : true" onclick="submitForm('delete');">회원 탈퇴하기</button></p>
</form>
</div>
</body>
</html>

