<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.io.*, java.sql.*, javax.sql.*" %>
<html ng-app>
<head>
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

.center {
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  width: 48%;
  height: 59%;
}
</style>
</head>
<body>
<script src="/js/angular.js"></script>
<script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="/smarteditor/sample/js/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>
<script src="/js/jquery-3.1.0.min.js"></script>
               
<%

	String parent=request.getParameter("parent");
	Class.forName("oracle.jdbc.driver.OracleDriver"); 
	Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.48.128:1521:oraedu", "red_my11", "hardhard");
	Statement stmt = conn.createStatement(); 
	
	String Qtxt1="select board_cat from tbl_category";	
	ResultSet rset =stmt.executeQuery(Qtxt1);
%>
<div id="absolute2"><img src="/img/logo_small.png" style="height:75px; width:120px"></div>
 <div id="absolute1">
 <form action="recordDB.jsp" method="post" id="frm" onSubmit="return submitContents(this)">
 <table border="0" cellpadding="1" cellspacing="1" style="width:682px">
	<tbody>
		<tr>
			<td colspan=2 style="text-align:right">
			<%	
	out.println("<select name='category'>");    
	int i=0;
	while(rset.next()){
		String append=(i==0)? "selected": "";
		out.println(String.format("<option value='%s' %s>%s</option>", rset.getString(1), append, rset.getString(1))); 
		i++;
	}
	rset.close(); stmt.close(); conn.close();	
	%>
</select>			
			<input maxlength="80" id="title" name="title" size="70" type="text"  value="제목을 입력하세요." onFocus="if(this.value=='제목을 입력하세요.'){this.value=''; this.className='myColor2';}" 
	onBlur="if(this.value==''){this.value='제목을 입력하세요.'; this.className='myColor1';}" 
	class="myColor1" /></td>
		</tr>
		<tr>
			<td colspan=2><textarea name="textAreaContent" id="textAreaContent" rows="7" cols="10" style="width:675px; height:490px; overflow:auto;">
    </textarea></td>
		</tr>
		<tr>
			<td style="text-align:left">
			<input type="image" src="/img/reset.png" style="height:40px; width:80px" onclick="location.reload(true); return false;"/></td>
			<td style="text-align:right">
			<input type="image" src="/img/save.png" style="height:40px; width:80px"/></td>
		</tr>
	</tbody>
</table>
<input type="hidden" name="parent" value="<%=parent%>"/>
 </form>
 </div>
<script type="text/javascript"> 
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "textAreaContent",
    sSkinURI: "/smarteditor/board_skin.html",
	htParams : {
            bUseToolbar : true,             
            bUseVerticalResizer : false,     
            bUseModeChanger : false, 
        },
    fCreator: "createSEditor2"
});

function submitContents(c) {
	oEditors.getById["textAreaContent"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	var content = document.getElementById("textAreaContent").value;
	if(c.title.value==""||c.title.value=="제목을 입력하세요."||content == "" || content == "&nbsp;" || content == "<p>&nbsp;</p>" || content == "<br>") {
                alert("제목이나 내용이 빠져있습니다.");
                return false;
	} 
}
 
function clearContent(){
	if(confirm("정말로 내용을 지우시겠습니까?")==true)
	history.go(0);
}
</script>



</body>
</html>