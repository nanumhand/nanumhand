<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.io.*, java.sql.*, javax.sql.*, javax.servlet.*" %>
<%

	String user_id= request.getParameter("user_id");
	
	Class.forName("oracle.jdbc.driver.OracleDriver"); 
	Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.48.128:1521:oraedu", "red_my11", "hardhard");
	Statement stmt = conn.createStatement(); 
	String sql="select user_id from tbl_user where user_id='"+user_id+"'";
	ResultSet rset =stmt.executeQuery(sql);
	String m="";
	if(rset.next()) m="중복 아이디입니다.";
	else m="아이디를 사용하셔도 좋습니다.";
	
%>
<html>
<body>
<span id="idcheck_value" style="font-size:80%;"><%=m%></span>
</body>
</html>