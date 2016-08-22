<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.io.*, java.sql.*, javax.sql.*, java.util.*" %>
<html>
<head>
<link rel="stylesheet" href="/css/buttons.css" type="text/css">
<script src="/js/html5.js"></script>
</head>
<body bgcolor="ffffff" text="000000" link="0089FF" alink="0000ff">
<script src="/js/jquery-3.1.0.min.js"></script>
<script src="/js/printPreview.js"></script>
<script src="/js/jquery-print.js"></script>
<%
	 int seq_user = 0;
	int seq_board= Integer.parseInt(request.getParameter("seq_board"));
	int hit_view= Integer.parseInt(request.getParameter("hit_view"));
	if(session != null && session.getAttribute("user_id") != null && !session.getAttribute("user_id").equals("")){
	seq_user = (Integer) session.getAttribute("seq_user");	}
	
	Class.forName("oracle.jdbc.driver.OracleDriver"); 
	Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.48.128:1521:oraedu", "red_my11", "hardhard");
	Statement stmt = conn.createStatement();
	stmt.executeUpdate("update tbl_board set hit_view=hit_view+"+hit_view+" where seq="+seq_board);
	
	String sql="select count(seq) from tbl_comment where seq_board="+seq_board; 
	ResultSet rset =stmt.executeQuery(sql);
	rset.next();
	int count_comment=rset.getInt(1);
	
	sql="select A.user_id, B.seq, B.parent, B.seq_user, B.title, B.category, B.content, B.hit_view, B.hit_like, B.create_date, B.modify_date from tbl_user A, tbl_board B where A.seq = B.seq_user and B.seq ="+seq_board; //게시글 고유번호 받아서 조회
	
	rset =stmt.executeQuery(sql);	
	rset.next();
%>
<table border="0" cellspacing="1" style="width:700px">
	<tbody>
		<tr>
			<td colspan="2" style="font-weight: 600; text-align: left;">&nbsp;&nbsp;<%=rset.getString(6)%>&nbsp;:&nbsp;<%=rset.getString(5)%></td>
		</tr>
		<tr>
			<td colspan="2" width="407px"><button class="button button--aylen button--round-s button--border-thin button--size-m" onclick="select_byUser()"><%=rset.getString(1)%>&nbsp;님의 게시글 보러가기</button><a href class="button button--aylen button--round-s button--border-thin button--size-m">As My Mento</a><span style="float:right;"><button id="comment_show" class="button button--isi button--border-zero button--size-m button--round-m" style="background: #FC7155;" onclick="comment_show(<%=seq_board%>,<%=count_comment%>);">댓글보기</button></span><span style="float:right;" class="button button--isi button--border-zero button--size-m button--round-s">댓글수<%=count_comment%></span><a href="/lamda/board/updateDB_like.jsp?seq_board=<%=seq_board%>" style="float:right;" class="button button--isi button--border-zero button--size-m button--round-s">좋아요<%=rset.getString(9)%></a><span style="float:right;" class="button button--isi button--border-zero button--size-m button--round-s">조회수<%=rset.getString(8)%></span></td>
		</tr>
		<tr bgcolor="#F1F8E0">
			<td colspan="2" style="border-top:2px solid; border-bottom:2px solid; height: 500px;"><div style="height: 500px; margin-left: 10px; overflow:auto;"><div  id="print"><%=rset.getString(7)%></div></div></td>
		</tr>
		
		<tr>
			<td colspan="2" style="text-align: center;"><button class="button button--isi button--border-zero button--size-m button--round-m" onclick="logincheck('reply')">답글쓰기</button><button class="button button--isi button--border-zero button--size-m button--round-m" onclick="logincheck('new')">새글쓰기</button><button id="printbutton" class="button button--isi button--border-zero button--size-m button--round-m" onclick="$('#print').print()">인쇄</button><%
		if(seq_user==rset.getInt(4)) out.println("<div><button class='button button--isi button--border-zero button--size-m button--round-s' style='background: #FC7155;' onclick='delete_board()'>삭제</button>"); 
		else{}
		
		if(seq_user==rset.getInt(4)) out.println("<a href='correct_board.jsp?seq_board="+seq_board+"' class='button button--isi button--border-zero button--size-m button--round-m' style='background: ##FFFF00;'>수정</a></div>"); else{}
		%>
			<span style="font-size:12px; float:right;" class="button button--aylen button--round-s button--border-thin button--size-m">*작성일&nbsp;<%=rset.getString(10)%><br>*수정일&nbsp;<%=rset.getString(11)%></span></td>
		</tr>
	</tbody>
</table>
<script>
function comment_show(s, c){
	$(parent.document).find("#comment_list").attr("src","/lamda/board/comment_select.jsp?seq_board="+s+"&count_comment="+c+"&pageNum=1");		
}
function delete_board(){
	   if(confirm("정말로 삭제하시겠습니까?")==true){ 
			location.replace("delete_board.jsp?seq_board=<%=seq_board%>"); 
		}
	} 
function select_byUser(){
	$(parent.document).find("#board_list").attr("src","/lamda/board/boardlist.jsp?seq_user=<%=rset.getInt(4)%>&pageNum=1");
}

function logincheck(c){
	var link=(c=="reply")? "write.jsp?parent=<%=seq_board%>": "write.jsp?parent=0";
	alert("먼저 로그인을 해주세요.");
	if(<%=seq_user%>==0) alert("먼저 로그인을 해주세요.");
	else location.replace=link;
}

</script>



<%
rset.close(); stmt.close(); conn.close();
%>
</body>
</html>