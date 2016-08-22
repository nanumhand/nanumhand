<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.io.*, java.sql.*, javax.sql.*" %>
<%
	
	int parent= Integer.parseInt(request.getParameter("parent"));
	int seq_board= Integer.parseInt(request.getParameter("seq_board"));
	int seq_user = (Integer) session.getAttribute("seq_user");
	String memo=request.getParameter("memo");
	
	memo= new String(memo.getBytes("8859_1"), "utf-8");
	

	Class.forName("oracle.jdbc.driver.OracleDriver"); 
	Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.48.128:1521:oraedu", "red_my11", "hardhard");
	Statement stmt = conn.createStatement(); 
	
	stmt.execute("insert into tbl_comment(seq, seq_user, parent, memo, seq_board) values(tbl_comment_seq.nextval,"+seq_user+","+parent+",'"+memo+"',"+seq_board+")");
	
	String sql="select count(seq) from tbl_comment where seq_board="+seq_board; 
	ResultSet rset =stmt.executeQuery(sql);
	rset.next();
	int count_comment=rset.getInt(1);
		
	rset.close();
	stmt.close();
	conn.close();
		
%>
<script src="/js/html5.js"></script>
<script src="/js/jquery-3.1.0.min.js"></script>
<script type="text/javascript">
	$(parent.document).find("#comment_list").attr("src","/lamda/board/comment_select.jsp?seq_board=<%=seq_board%>&count_comment=<%=count_comment%>&pageNum=1");
</script>