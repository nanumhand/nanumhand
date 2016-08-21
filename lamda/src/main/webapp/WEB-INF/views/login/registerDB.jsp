<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.io.*, java.sql.*, javax.sql.*" %>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/css/styles.css"/>
<link rel="stylesheet" href="/css/buttons.css" type="text/css">
<script src="/js/html5.js"></script>
<script src="/js/jquery-3.1.0.min.js"></script>
</head>
<%
String msg=""; String link="";
try{
	String user_id= request.getParameter("user_id");
	String password= request.getParameter("password");
	String email= request.getParameter("email");

	Class.forName("oracle.jdbc.driver.OracleDriver"); 
	Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.48.128:1521:oraedu", "red_my11", "hardhard");
	Statement stmt = conn.createStatement(); 
	stmt.execute("insert into tbl_user(seq, user_id, password, email) values(tbl_user_seq.nextval,'"+user_id+"','"+password+"','"+email+"')");
	
	stmt.close();
	conn.close();
	msg="오늘부터 당신은 LAMDA의 회원이십니다.";
	link="Login";
	
} catch(Exception e){	
	msg="회원가입을 완료하지 못했습니다. ";
	link="되돌아가기";
}		
%>

<body>
<p><p>
<div style="margin-left:100px; font-weight:1000; font-size:25px"><%=msg %></div>
<button id="login" class="button button--aylen button--round-m button--border-thin button--size-s"><%=link%></button>
<script>
$("#login").click(function(){
	$(parent.document).find("#logo_big").fadeTo("fast",1);
	$(parent.document).find("#motherframe").attr("src","/lamda/login/login.jsp");
});
</script>
</body>
</html>