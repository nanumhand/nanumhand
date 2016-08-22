<%@ page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.io.*, java.sql.*, javax.sql.*" %>
<%@ page session="false" %>
<% 
Class.forName("oracle.jdbc.OracleDriver"); // 자바 DB connect 드라이버 클래스
Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.105:33060/koposw11", "root", "koposw11");
//(root사용자/koposw11암호)로 mysql DB에 접속한다.
Statement stmt = conn.createStatement(); //connection 객체 conn에 statement 메소드를 만들고, stmt로 객체로 받는다.
ResultSet rset=stmt.executeQuery("show databases;"); // stmt객체의 executeQuery메소드를 실행시켜 결과값을 rset에 넣는다.
while(rset.next()){ //rset에 입력되는 값이 null이면 while문을 탈출
	out.println("값 : "+rset.getString(1)); //getString("칼럼명" 또는 칼럼index) : 1은 첫번째 칼럼
}
rset.close(); //반드시 닫아줘야한다.
stmt.close();//반드시 닫아줘야한다.
conn.close();//반드시 닫아줘야한다.


%>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello 현 수 !  
</h1>

<P>  The time on the server is ${serverTime}. </P>
<P>  The connection is ${conn}. </P>
<p> The stock predict1 is ${stock1}.</p>
<p> The stock predict1 is ${stock_predict1}.</p>
<p> The stock predict2 is ${stock_predict2}.</p>
<p> The stock predict3 is ${stock_predict3}.</p>
<p> The stock is ${stockall.price}.</p>
</body>
</html>
