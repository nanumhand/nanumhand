<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.io.*, java.sql.*, javax.sql.*, javax.servlet.*" %>
<html ng-app>
<head>
<link rel="stylesheet" type="text/css" href="/css/styles.css"/>
<link rel="stylesheet" href="/css/buttons.css" type="text/css">
<script src="/js/html5.js"></script>
<script src="/js/angular.js"></script>
<script src="/js/jquery-3.1.0.min.js"></script>
</head>
<%
    String user_id = request.getParameter("user_id");    
    
	
    Class.forName("oracle.jdbc.driver.OracleDriver"); 
	Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.48.128:1521:oraedu", "red_my11", "hardhard");
	Statement stmt = conn.createStatement(); 
	stmt.executeUpdate("update tbl_user set drop_date=sysdate where user_id='"+user_id+"'");
	
	%>

<body>
<h2>탈퇴처리 되었습니다. 또 방문해주십시오.</h2>
<span id="close" class="button button--aylen button--round-m button--border-thin button--size-s">close</span>
<script>
$("#close").click(function(){
	$(parent.document).find("#logo_big").fadeTo("fast",1);
	$(parent.document).find("iframe").hide();	
});
</script>
</body>
</html>