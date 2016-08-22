<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.io.*, java.sql.*, javax.sql.*, java.util.*" %>
<%@ page import="org.json.simple.JSONArray, org.json.simple.JSONObject, org.json.simple.parser.JSONParser" %>

<!DOCTYPE html>
<meta charset="utf-8">
<head>
<link rel="stylesheet" href="/css/buttons.css" type="text/css">
<script src="/js/html5.js"></script>
<script src="/js/jquery-3.1.0.min.js"></script>
<style>
html, body { height:100%;}
.center {
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  width: 48%;
  height: 59%;
  margin: 5px;
  text-align: center;
  padding: 5px;
 }
 
 .hcenter {
  position: absolute;
  left: 50%;
  transform: translate(0%);
  width: 50%; 
  padding-left: 10px;
}

.zindex{ z-index: 1}
 </style>
</head>
<body>
<script src="/js/d3.old.js"></script>
<%

	int seq_user= Integer.parseInt(request.getParameter("seq_user"));	
	int pageNum=Integer.parseInt(request.getParameter("pageNum"));	
	
	Class.forName("oracle.jdbc.driver.OracleDriver"); 
	Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.48.128:1521:oraedu", "red_my11", "hardhard");
	Statement stmt = conn.createStatement(); 
	
	ResultSet rset =stmt.executeQuery("select count(seq) from tbl_board");
	rset.next();
	int cntNum=rset.getInt(1);
	int blockNum =5;
	int listNum=10;
	int fromNum=1;	
	
	int totalPage=(cntNum%listNum>0)? cntNum/listNum+1: cntNum/listNum;
	int totalBlock=(totalPage%blockNum>0)? totalPage/blockNum+1: totalPage/blockNum;
	int rowS=listNum*(pageNum-1)+fromNum;
	int rowE=rowS+listNum-1;		
	
	String Qtxt1="select * from(select rownum as R, C.* from(select level as indent, A.user_id, B.* from tbl_user A, tbl_board B where A.seq = B.seq_user start with B.parent=0 connect by prior B.seq = B.parent order siblings by B.create_date desc) C where rownum <="+rowE+") where R >="+rowS;
	
	String Qtxt2="select * from(select rownum as R, C.* from(select 0, A.user_id, B.* from tbl_user A, tbl_board B where A.seq = B.seq_user and B.seq_user="+seq_user+"order by B.create_date desc) C where rownum <="+rowE+") where R >="+rowS;
	
	if (seq_user==0) rset =stmt.executeQuery(Qtxt1);
	else rset=stmt.executeQuery(Qtxt2);
	
	JSONArray jsonArray = new JSONArray();
	while(rset.next()) {	
		JSONObject jsonObj = new JSONObject();	
		jsonObj.put("R",rset.getInt(1));
		jsonObj.put("indent",rset.getInt(2));
		jsonObj.put("seq",rset.getInt(4));
		jsonObj.put("title",rset.getString(7));
		jsonArray.add(jsonObj);		
	}
		
rset.close(); stmt.close(); conn.close(); 

%>

<script>
 var dataset = <%=jsonArray%>;
var colors = d3.scale.category20();
 
    d3.select("body").selectAll("div")
			.data(dataset)
			.enter()            			
            .append("div")			
           	.attr("id",function(d){return d.seq;})			
			.attr("class", "hcenter button button--aylen button--round-s button--border-thin button--size-m")
			.style("position","absolute")
			.style("width", "300px")
			.style("height", "50px")
			.style("line-height", "40px")
            .style("background-color", function (d,i) { return colors(i); })
            .style("color", "white")					
            .text(function (d) { return d.title.slice(0,15); })
			.on("click", function(d){
				$(parent.document).find("#board_contents").attr("src","/lamda/board/board_selectOne.jsp?hit_view=1&seq_board="+d.seq);
			});
			
	d3.selectAll("div").each(function(d, i){
        d3.select(this)
			.transition().ease("cubic")
			.duration(500)
			.style("left", function(d){ return d.indent*20+"px";})
			.style("top", i*42+20+"px");			
		}); 
</script>


<div style="margin-top:490px; text-align:center">
<%
int bs=((pageNum-1)/blockNum)*blockNum;
int be=(pageNum-1>=(totalPage/blockNum)*blockNum)? (totalPage%blockNum)+bs : blockNum+bs;
if (bs !=0) 
	out.print(String.format("<a href=\"boardlist.jsp?seq_user=%d&pageNum=%d\" style=\"text-decoration:none\"><<</a>&nbsp;&nbsp;&nbsp;", seq_user, bs));
else out.print("<<&nbsp;&nbsp;&nbsp;");
for(int i=bs; i<be; i++) {
	out.print(String.format("<a href=\"boardlist.jsp?seq_user=%d&pageNum=%d\" style=\"text-decoration:none\">%d</a>&nbsp;&nbsp;&nbsp;", seq_user, i+1, i+1));
}
if (be !=totalPage) 
	out.print(String.format("<a href=\"boardlist.jsp?seq_user=%d&pageNum=%d\" style=\"text-decoration:none\">>></a>", seq_user, be+1));
else out.print(">>");
%>
</div>

</body>
</html>