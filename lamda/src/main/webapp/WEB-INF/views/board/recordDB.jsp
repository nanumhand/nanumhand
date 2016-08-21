<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.io.*, java.sql.*, javax.sql.*" %>
<%
	String parent=request.getParameter("parent");
	int seq_user = (Integer) session.getAttribute("seq_user");
	String title=request.getParameter("title");
	String category=request.getParameter("category");
	String content=request.getParameter("textAreaContent");
	title= new String(title.getBytes("8859_1"), "utf-8");
	category= new String(category.getBytes("8859_1"), "utf-8");
	content= new String(content.getBytes("8859_1"), "utf-8");

	Class.forName("oracle.jdbc.driver.OracleDriver"); 
	Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.48.128:1521:oraedu", "red_my11", "hardhard");
	Statement stmt = conn.createStatement(); 
	
	stmt.execute("insert into tbl_board(seq, seq_user, parent, title, category, content) values(tbl_board_seq.nextval,"+seq_user+",'"+parent+"','"+title+"','"+category+"','"+content+"')");
	
	ResultSet rset =stmt.executeQuery("select seq from tbl_board where seq_user="+seq_user+" order by create_date desc");
	rset.next();
	
	int seq_board=rset.getInt(1);
		
	rset.close();
	stmt.close();
	conn.close();
		
%>
<script src="/js/html5.js"></script>
<script src="/js/jquery-3.1.0.min.js"></script>
<script type="text/javascript">
	$(parent.document).find("#board_list").attr("src","/lamda/board/boardlist.jsp?seq_user=0&pageNum=1");
     $(parent.document).find("#board_contents").attr("src","/lamda/board/board_selectOne.jsp?hit_view=0&seq_board=<%=seq_board%>");
</script>