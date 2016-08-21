<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.io.*, java.sql.*, javax.sql.*, javax.servlet.*" %>
<%

	String email= request.getParameter("email");
	
	Class.forName("oracle.jdbc.driver.OracleDriver"); 
	Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.48.128:1521:oraedu", "red_my11", "hardhard");
	Statement stmt = conn.createStatement(); 
	String sql="select email from tbl_user where email='"+email+"'";
	ResultSet rset =stmt.executeQuery(sql);
	String m="";
	if(rset.next()) m="중복 이메일 주소입니다.";
	else m="이메일을 사용하셔도 좋습니다.";
	
%>
<html>
<body>
<span id="emailcheck_value" style="font-size:80%;"><%=m%></span>
</body>
</html>