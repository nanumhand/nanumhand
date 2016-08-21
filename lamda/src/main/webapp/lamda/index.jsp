<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.io.*, java.sql.*, javax.sql.*, javax.servlet.*" %>
<!DOCTYPE html>
<head>
<meta charset="utf-8">
<title>Transition Filtering</title>
<link rel="stylesheet" type="text/css" href="/css/styles.css"/>
<link rel="stylesheet" href="/css/buttons.css" type="text/css">
<script src="/js/html5.js"></script>
<script src="/js/angular.js"></script>
<script src="/js/d3.old.js"></script>
<script src="/js/jquery-3.1.0.min.js"></script>
<style type="text/css">
 html, body { height:100%; width:100%}
 
 .overflowhidden {
	overflow-x: hidden;
	overflow-y: hidden;
}

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
 .logocenter {
  position: absolute;
  left: 47%;
  top: 50%;
  transform: translate(-50%, -50%);
  width: 48%;
  height: 59%;
  margin: 5px;
  text-align: center;
  padding: 5px;
 }
 
 .greetingscenter {
  position: absolute;
  left: 48%;
  top: 30%;
  transform: translate(-50%, -50%);
  width: 48%;
  height: 59%;
  margin: 5px;
  text-align: center;
  padding: 5px;
 } 
 
  .logincenter {
  position: absolute;
  left: 43%;
  top: 30%;
  transform: translate(-50%, -50%);
  width: 48%;
  height: 59%;
  margin: 5px;
  text-align: center;
  padding: 5px;
 }
 
 .listcenter {
  position: absolute;
  left: 43%;
  top: 40%;
  transform: translate(-45%, -35%);
  width: 48%;
  height: 80%;
  margin: 5px;
  padding: 5px;
 } 
.background {
    background: rgba(0, 0, 0, 0.1);
}

#absolute1, #absolute2, #absolute3, #absolute4
{ position: absolute; }
#absolute1{ z-index: 1;}
#absolute2 { z-index: 2;}
#absolute3 { z-index: 3;}
#absolute4 { z-index: 4;}
</style>
</head>
<body style="overflow-y:auto; overflow-x:hidden">
<%
if(session != null && session.getAttribute("user_id") != null && !session.getAttribute("user_id").equals("")){
	String user_id=(String) session.getAttribute("user_id");
	out.println("<a href='/lamda/login/logout.jsp' id='welcomelogin' style='background: #F2F2F2; text-align:center; position:absolute; left:780px; top:8px; width:270px;' class='button button--aylen button--round-m button--border-medium button--size-m' z-index='12'>welcome! <b>"+user_id+"</b> logout click</a><script src='/js/auto-logout.js'></script>");
} else {
out.println("<a href='/lamda/login/logout.jsp' id='welcomelogin' style='display:none; background: #F2F2F2; text-align:center; position:absolute; left:780px; top:8px; width:270px;' class='button button--aylen button--round-m button--border-medium button--size-m' z-index='12'></a>");
}
%>
<script type="text/javascript">
	
    var w = "100%", h = "100%",
        force = d3.layout.force()
            .size([w ,h])
            .gravity(0)
            .charge(-60)
            .friction(0.7);			
	var colors = d3.scale.category20();
    var svg = d3.select("body")
        .append("svg")
            .attr("width", w)
            .attr("height", h);
    force.on("tick", function () {
        svg.selectAll("circle")
            .attr("cx", function (d) {return d.x;})
            .attr("cy", function (d) {return d.y;})
			 .attr("fill", function (d, i) { return colors(i);}) 
			;
    });
    svg.on("mousemove", function () {
        var point = d3.mouse(this),
            node = {x: point[0], y: point[1]};
        svg.append("circle")
                .data([node])
            .attr("class", "node")
            .attr("cx", function (d) {return d.x;})
            .attr("cy", function (d) {return d.y;})
			.attr("fill", function (d, i) { return colors(i);})
            .attr("r", 1e-6)
        .transition()
            .attr("r", 4.5)
        .transition()
            .delay(7000)
            .attr("r", 1e-6)
            .each("end", function () {
                force.nodes().shift(); 
            })
            .remove();
        force.nodes().push(node); 
        force.start(); 
    }); 
	
	
	
</script>

<script type="text/javascript">
    var data = [ "cubic", "cubic-in-out", "circle", "bounce", "sin-out", "sin"],
        colors = d3.scale.category10();
    d3.select("body").selectAll("div")
            .data(data) // <-C
        .enter()
        .append("div")
           
			.attr("class", "center") //처음위치
			.attr("id",function(d){return d;})
            .style("width", "80px")
			.style("height", "40px")
			.style("line-height", "40px")
            .style("background-color", function (d, i) {
                return colors(i);
            })
            .style("color", "white")
            .text(function (d) {
                switch(d){
				case "sin": return "Login";break;
				case "cubic": return "Jquery";break;
				case "cubic-in-out": return "D3";break;
				case "circle": return "Ur_info";break;			
				case "bounce": return "B.K. view";break;
				default : return "Commuity";break;           
            }});
    d3.selectAll("div").each(function(d, i){
        d3.select(this)
			.transition().ease(d) // <-D
			.duration(1500)
			.style("left", function(){ return (i+1)*95+125+"px";})
			.style("top", "20px");
    });

</script>
<a href="/lamda/login/logout.jsp" id="welcomelogin" style="display:none; background: #F2F2F2; text-align:center; position:absolute; left:780px; top:8px; width:270px;" class="button button--aylen button--round-m button--border-medium button--size-m" z-index="12"></a>

<img id="logo_small" src="/img/logo_small.png" style="position:absolute; left:-13px; top:-27px;">
<img id="logo_big" class="logocenter" src="/img/logo_big.png" style="width:805px; height:317px">

<div z-index="20">
<iframe id="motherframe" class="center" scrolling="no" width="100%" height="100%" style="text-align:center; display:none; border:0px; overflow-y: auto; overflow-x: hidden;" src="">
</iframe></div>

<div z-index="9">
<iframe id="boardframe" class="listcenter" scrolling="no" style="display:none;  border:0px; overflow-y: auto; overflow-x: hidden; width:1650px; height:633px;" src="">
</iframe></div>

<iframe id="d3frame" class="center" scrolling="no" style="display:none; text-align:center; border:0px; overflow-y: auto; overflow-x: hidden; width:900px; height:800px;" src="">
</iframe>




<script>
    $("#logo_small").click(function(){
		 $("iframe").hide();
		$("#motherframe").show();
		$("#motherframe").attr("src","greetings.html");	
	});
	
    $("#sin").click(function(){ $("iframe").hide(); $("#motherframe").show(); $("#motherframe").attr("src","/lamda/login/login.jsp"); $("#logo_big").fadeTo("slow",0.5); });	
	$("#cubic").click(function(){ $("#logo_big").fadeTo("slow",0.1); $("iframe").hide();
		$("#d3frame").show(); $("#d3frame").attr("src","/lamda/d3/tough2.jsp"); });
	$("#cubic-in-out").click(function(){ $("#logo_big").fadeTo("slow",0.1); $("iframe").hide();
		$("#d3frame").show(); $("#d3frame").attr("src","/lamda/d3/tough.jsp"); });
	$("#circle").click(function(){  $("iframe").hide(); $("#motherframe").show(); $("#motherframe").attr("src","/lamda/urinfo/urinfo.jsp"); $("#logo_big").fadeTo("slow",0.5); });	
	$("#bounce").click(function(){ $("#logo_big").fadeTo("slow",0.1); $("iframe").hide();
		$("#d3frame").show(); $("#d3frame").attr("src","/lamda/stview/stview.html"); });
	$("#sin-out").click(function(){ 
		$("iframe").hide();
		$("#boardframe").show();
		$("#boardframe").attr("src","/lamda/board/boardlist_frame.html"); $("#logo_big").fadeTo("slow",0.5); });
	
	
</script>
</body>
</html>