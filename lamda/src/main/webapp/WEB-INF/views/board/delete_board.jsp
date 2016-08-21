<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.io.*, java.sql.*, javax.sql.*" %>
<%
	
	int seq_board= Integer.parseInt(request.getParameter("seq_board"));
	
	Class.forName("oracle.jdbc.driver.OracleDriver"); 
	Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.48.128:1521:oraedu", "red_my11", "hardhard");
	Statement stmt = conn.createStatement(); 
	
	try{
		stmt.executeUpdate("delete from tbl_board where seq="+seq_board);
	} catch(Exception e){	
		stmt.executeUpdate("update tbl_board set title='삭제된 글', content='이 글은 당사자의 요청에 의해 삭제되었습니다.', modify_date=to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') where seq="+seq_board);
	}
		
	stmt.close();
	conn.close();
		
%>
<script src="/js/html5.js"></script>
<script src="/js/jquery-3.1.0.min.js"></script>
<script type="text/javascript">
	$(parent.document).find("#board_list").attr("src","/lamda/board/boardlist.jsp?seq_user=0&pageNum=1");
    $(parent.document).find("#board_contents").attr("src","");
	$(parent.document).find("#comment_list").attr("src","");
	 
</script>