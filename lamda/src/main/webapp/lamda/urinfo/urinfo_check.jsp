<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.io.*, java.sql.*, javax.sql.*, javax.servlet.*" %>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/css/styles.css"/>
<link rel="stylesheet" href="/css/buttons.css" type="text/css">
<script src="/js/html5.js"></script>
<script src="/js/jquery-3.1.0.min.js"></script>
</head>
<%
    String user_id = request.getParameter("user_id");    
    String password = request.getParameter("password");
	String mode = request.getParameter("mode");
	
    Class.forName("oracle.jdbc.driver.OracleDriver"); 
	Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.48.128:1521:oraedu", "red_my11", "hardhard");
	Statement stmt = conn.createStatement(); 
	String sql="select * from tbl_user where user_id='"+user_id+"' and password='"+password+"'";
	ResultSet rset =stmt.executeQuery(sql);
	String m="";
	if(rset.next()) {
		response.sendRedirect(mode+"_urinfo.jsp?user_id="+user_id);
	}
	else m="회원정보를 다시 한 번 확인하고 시도해주십시오."; 	
	rset.close(); stmt.close(); conn.close();
%>

<body>
<h2><%=m%></h2>
<a href="urinfo.jsp" class="button button--aylen button--round-m button--border-thin button--size-s">Ur Info 화면으로</a>
</body>
</html>