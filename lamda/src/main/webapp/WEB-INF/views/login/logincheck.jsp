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
	
    Class.forName("oracle.jdbc.driver.OracleDriver"); 
	Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.48.128:1521:oraedu", "red_my11", "hardhard");
	Statement stmt = conn.createStatement(); 
	String sql="select seq, errorcnt, (sysdate-banned_date)*24*60 as banned_time from tbl_user where user_id='"+user_id+"'";
	String sql2="select seq from tbl_user where user_id='"+user_id+"' and password='"+password+"'";
	ResultSet rset =stmt.executeQuery(sql);
	
	String m="";
	
	int found = (rset.next())? rset.getInt(1) : 0;
	
	if (found > 0){
		int errorcnt = rset.getInt(2);
		double banned_time = (errorcnt>0)? rset.getDouble(3): 0.0;
		if(errorcnt==3 && banned_time<3.0) {
			m ="차단된 아이디입니다."; 
		}else{
			if(banned_time>=3.0) stmt.executeUpdate("update tbl_user set errorcnt=0, banned_date=null where user_id='"+user_id+"'"); 
			rset =stmt.executeQuery(sql2);
			if(rset.next()) {
				session.setAttribute("seq_user", rset.getInt(1));
				session.setAttribute("user_id", user_id);	
				m="Welcome to LAMDA again!";
				stmt.executeUpdate("update tbl_user set errorcnt=0, banned_date=null where user_id='"+user_id+"'"); 
				out.println("<script>	$(parent.document).find('#welcomelogin').html('welcome! <b>"+user_id+"</b> logout click').show();$(parent.document).find('#motherframe').attr('src','');</script>");
			}else{
				stmt.executeUpdate("update tbl_user set errorcnt=errorcnt+1 where user_id='"+user_id+"'");
				if(errorcnt==2) {
					stmt.executeUpdate("update tbl_user set banned_date=sysdate where user_id='"+user_id+"'");
					m = "입력오류 3회입니다. 해당 아이디는 3분 동안 차단됩니다.";
				}else{
					m="회원정보를 다시 확인하고 시도해주세요. (3회부터 차단)"; 
				}
			}
		}
	}else{ m="회원정보를 다시 확인하고 시도해주세요."; } 
	
rset.close(); stmt.close(); conn.close();
	
%>
<body>
<div align="center">
<h2><%=m%></h2>
<div style="margin: 0 auto; width:115px">
<a href="login.jsp" style="float:left" class="button button--aylen button--round-m button--border-thin button--size-s">로그인 화면으로</a></div>
</div>
</body>
</html>
  
