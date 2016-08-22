<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.io.*, java.sql.*, javax.sql.*, java.util.*" %>
<html>
<head>
<link rel="stylesheet" href="/css/buttons.css" type="text/css">
<script src="/js/html5.js"></script>
<script src="/js/jquery-3.1.0.min.js"></script>
<head>
<style>
.background {
    background: rgba(246, 248, 214, 0.3);
}

#absolute1, #absolute2
{ position:absolute; }

#absolute2 {
	top:2px;
	left:17px;
	z-index: 2;
}
#absolute1{
	top:19px;
	left:19px;
	z-index: 1;
}
.myColor1 {color:#F7A363;}
.myColor2 {color:#000000;}
.reply_div{ display:none;}
}
</style>
</head>
<body bgcolor="ffffff" text="000000" link="0089FF" alink="0000ff">
<script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="/smarteditor/sample/js/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>
<div class='background' style="border:1px dotted steelblue; padding:10px;">
<%
	int seq_user = 0;
	int seq_board= Integer.parseInt(request.getParameter("seq_board"));
	if(session != null && session.getAttribute("user_id") != null && !session.getAttribute("user_id").equals("")){
	seq_user = (Integer) session.getAttribute("seq_user");	}
	
	int blockNum =5;
	int listNum=5;
	int fromNum=1;
	int cntNum=Integer.parseInt(request.getParameter("count_comment"));
	int pageNum=Integer.parseInt(request.getParameter("pageNum"));
	int totalPage=(cntNum%listNum>0)? cntNum/listNum+1: cntNum/listNum;
	int totalBlock=(totalPage%blockNum>0)? totalPage/blockNum+1: totalPage/blockNum;
	int s=listNum*(pageNum-1)+fromNum;
	int e=s+listNum-1;	
	
	Class.forName("oracle.jdbc.driver.OracleDriver"); 
	Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.48.128:1521:oraedu", "red_my11", "hardhard");
	Statement stmt = conn.createStatement(); 
	String sql="select indent, user_id, seq, memo, create_date, modify_date, seq_user from(select rownum as R, C.* from(select level as indent, A.user_id, B.* from tbl_user A, tbl_comment B where A.seq = B.seq_user and B.seq_board ="+seq_board+" start with	B.parent = 0 connect by prior B.seq = B.parent order siblings by B.create_date desc) C where rownum <="+e+") where R >="+s;
	ResultSet rset =stmt.executeQuery(sql);
	%>	
	
	<%
	int indent=0;
	while(rset.next()){
		indent = (rset.getInt(1)-1);
		out.print(String.format("<table border='0' cellpadding='1' cellspacing='1' style='width:470px'><tr><td><strong>%s</strong><span style='font-size:11px;'>&nbsp;작성 : %s&nbsp;수정 : %s</span></td><td  width='30px'>",rset.getString(2),rset.getString(5),rset.getString(6)));
		
		if(seq_user==rset.getInt(7)) out.print(String.format("<button class='button button--isi button--border-zero button--size-m button--round-s' style='background: #FC7155;' onclick='delete_comment(%d,%d)'>삭제</button>", rset.getInt(3), seq_board)); 
		else{}
		
		out.print(String.format("<button id='reply_button' class='button button--aylen button--round-m button--border-thin button--size-s' onclick='logincheck(%d)'>답글</button></td></tr></table>",rset.getInt(3)));
		
		out.print(String.format("<div style='margin-left:%dpx;'><table border='0' cellpadding='1' cellspacing='1' style='width:460px'><tr><td style='border-bottom:1px dotted orange'>%s<div style='margin-left:%dpx;'>%s</div></td></tr></table></div>",(indent)*10, (indent==0)?"":"ㄴ ",(indent)*10,(rset.getString(4))));
		out.print(String.format("<div id='reply_div' style='margin-left:%dpx;' ></div>",(indent+1)*20));
	}
	%>               

 <form action="comment_record.jsp" method="post" id="frm" onSubmit="return submitContents(1)">
 <table border="0" cellpadding="1" cellspacing="1" style="width:400px; height:300px">
	<tr>
		<td colspan="2"><textarea id="memo" name="memo" rows="4" cols="60" style="width:400px; height:200px"></textarea>
		<input type="hidden" name="seq_board" value="<%=seq_board%>"/>
		<input type="hidden" name="parent" value="0"/>
	</tr><tr><td>	
	<input type="image" src="/img/reset.png" style="height:40px; width:80px" onclick="location.reload(true); return false;"/></td><td align="right">	
	<input type="image" src="/img/save.png" style="height:40px; width:80px"/></td>
	</tr><tr><td colspan="2">	

<div style="text-align:center">
<%
int bs=((pageNum-1)/blockNum)*blockNum;
int be=(pageNum-1>=(totalPage/blockNum)*blockNum)? (totalPage%blockNum)+bs : blockNum+bs;
if (bs !=0) 
	out.print(String.format("<a href=\"comment_select.jsp?seq_board=%d&count_comment=%d&pageNum=%d\" style=\"text-decoration:none\"><<</a>&nbsp;&nbsp;&nbsp;", seq_board, cntNum, bs));
else out.print("<<&nbsp;&nbsp;&nbsp;");
for(int i=bs; i<be; i++) {
	out.print(String.format("<a href=\"comment_select.jsp?seq_board=%d&count_comment=%d&pageNum=%d\" style=\"text-decoration:none\">%d</a>&nbsp;&nbsp;&nbsp;", seq_board, cntNum, i+1, i+1));
}
if (be !=totalPage) 
	out.print(String.format("<a href=\"comment_select.jsp?seq_board=%d&count_comment=%d&pageNum=%d\" style=\"text-decoration:none\">>></a>", seq_board, cntNum, be+1));
else out.print(">>");


%>
</div>
</td></tr>
</table>
</form>
</div>
<script type="text/javascript"> 
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "memo",
    sSkinURI: "/smarteditor/comment_skin3.html",
	htParams : {
            bUseToolbar : true,             
            bUseVerticalResizer : false,     
            bUseModeChanger : false, 
        },
    fCreator: "createSEditor2"
});


function submitContents(c) {
	if(<%=seq_user%>==0) {
		alert("먼저 로그인을 해주세요."); return false;
	}else{
		oEditors.getById["memo"].exec("UPDATE_CONTENTS_FIELD", []);	
	// 에디터의 내용이 textarea에 적용됩니다.
		var content = document.getElementById("memo").value;
		if(content == "" || content == "&nbsp;" || content == "<p>&nbsp;</p>" || content == "<br>") {
					alert("내용을 입력한 후 등록해주세요.");
					return false;
		}
	} 
}

function delete_comment(d, e){
	   if(confirm("정말로 삭제하시겠습니까?")==true){ 
			location.replace("delete_comment.jsp?seq_comment="+d+"&seq_board="+e); 
		}
	} 

function logincheck(c){
	if(<%=seq_user%>==0) alert("먼저 로그인을 해주세요.");
	else $("#reply_div").load("comment_select2.jsp?seq_board=<%=seq_board%>&seq="+c);
}	

</script>
<%rset.close(); stmt.close(); conn.close();%>
</body>
</html>	