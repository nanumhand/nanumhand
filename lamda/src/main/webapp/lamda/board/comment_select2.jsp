<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.io.*, java.sql.*, javax.sql.*, java.util.*" %>
<html>
<head>
<link rel="stylesheet" href="/css/buttons.css" type="text/css">
<script src="/js/html5.js"></script>
<script src="/js/jquery-3.1.0.min.js"></script>

<style>
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

<%
	int seq_board= Integer.parseInt(request.getParameter("seq_board"));
	int seq_comment= Integer.parseInt(request.getParameter("seq"));
%>
               

 <form action="comment_record.jsp" method="post" id="frm" onSubmit="return submitContents()">
 <table border="0" cellpadding="1" cellspacing="1" style="width:400px;">
	<tr>
		<td colspan="2"><textarea id="memo" name="memo" rows="4" cols="60" style="width:400px; height:100px"></textarea>
		</tr>
	<tr><td>	
	<input type="image" src="/img/cancel.png" style="height:40px; width:60px" onclick="location.reload(true); return false;"/>
	</td><td align="right">	
	<input type="image" src="/img/insert.png" style="height:40px; width:60px"/>
	</td></tr>
</table>
<input type="hidden" name="seq_board" value="<%=seq_board%>"/>
<input type="hidden" name="parent" value="<%=seq_comment%>"/>
</form>

<script type="text/javascript"> 
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "memo",
    sSkinURI: "/smarteditor/comment_skin3.html",
	htParams : {
            bUseToolbar : true,             
            bUseVerticalResizer : false,     
            bUseModeChanger : false 
        },
    fCreator: "createSEditor2"
});

function submitContents() {
		oEditors.getById["memo"].exec("UPDATE_CONTENTS_FIELD", []);
	
	// 에디터의 내용이 textarea에 적용됩니다.
	var content = document.getElementById("memo").value;
	if(content == "" || content == "&nbsp;" || content == "<p>&nbsp;</p>" || content == "<br>") {
                alert("내용을 입력한 후 등록해주세요.");
                return false;
	} 
}
</script>
</body>
</html>	