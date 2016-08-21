<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.io.*, java.sql.*, javax.sql.*, java.util.*" %>
<%@ page import="org.json.simple.JSONArray, org.json.simple.JSONObject, org.json.simple.parser.JSONParser" %>
<!DOCTYPE html>
<meta charset="utf-8">
<style>
.background {
    background: rgba(0, 0, 0, 0.1);
}
.node {
  cursor: pointer;
}

.node:hover {
  stroke: #000;
  stroke-width: 1.5px;
}

.node--leaf {
  fill: white;
}

.label {
  font: 11px "Helvetica Neue", Helvetica, Arial, sans-serif;
  text-anchor: middle;
  text-shadow: 0 1px 0 #fff, 1px 0 0 #fff, -1px 0 0 #fff, 0 -1px 0 #fff;
}

.label,
.node--root,
.node--leaf {
  pointer-events: none;
}

</style>
<body>
<script src="/js/d3.v3.min.js"></script>
<%

	Class.forName("oracle.jdbc.driver.OracleDriver"); 
	Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.48.128:1521:oraedu", "red_my11", "hardhard");
	Statement stmt = conn.createStatement(); 
	
	ResultSet rset =stmt.executeQuery("select count(seq) from tbl_board");
	rset.next();
	int end=rset.getInt(1);
	String Qtxt1="select * from(	select rownum as R, C.* from( select A.user_id, B.* from tbl_user A, tbl_board B where A.seq = B.seq_user start with	 B.parent=0 connect by prior B.seq = B.parent order siblings by B.create_date desc) C where rownum <="+end+") where R >= 1";
	
	rset =stmt.executeQuery(Qtxt1);

	
	JSONArray jsonArray = new JSONArray();
	
	while(rset.next()) {
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("user_id",rset.getString(2));
		jsonObj.put("seq",rset.getInt(3));
		jsonObj.put("parentkey",rset.getInt(4));
		jsonObj.put("title",rset.getString(6));
		jsonArray.add(jsonObj);
	}
	
rset.close(); stmt.close(); conn.close(); 

%>
<script>

var margin = 20,
    diameter = 700;

var color = d3.scale.linear()
    .domain([-1, 5])
    .range(["hsl(152,80%,80%)", "hsl(228,30%,40%)"])
    .interpolate(d3.interpolateHcl);

var pack = d3.layout.pack()
    .padding(2)
    .size([diameter - margin, diameter - margin])
    .value(function(d) { return d.seq*30; })

var svg = d3.select("body").append("svg")
    .attr("width", diameter)
    .attr("height", diameter)
  .append("g")
    .attr("transform", "translate(" + diameter / 2 + "," + diameter / 2 + ")");
	
var treeModel = function (arrayList, rootkey) {
	var rootNodes = [];
	var traverse = function (nodes, item, index) {
		if (nodes instanceof Array) {
			return nodes.some(function (node) {
				if (node.seq === item.parentkey) {
					node.children = node.children || [];
					return node.children.push(arrayList.splice(index, 1)[0]);
				}
				return traverse(node.children, item, index);
			});
		}
	};

	while (arrayList.length > 0) {
		arrayList.some(function (item, index) {
			if (item.parentkey === rootkey) {
				return rootNodes.push(arrayList.splice(index, 1)[0]);
			}
			return traverse(rootNodes, item, index);
		});
	}
	return rootNodes;
};

var t = treeModel(<%=jsonArray%>, 0);
var s = "{\"title\": \"Board\", \"children\": "+JSON.stringify(t, null, '   ')+" }";
var ss = JSON.parse(s);	

//d3.json("test1.json", function(error, ss) {
//  if (error) throw error;

  var focus = ss,
      nodes = pack.nodes(ss),
      view;

  var circle = svg.selectAll("circle")
      .data(nodes)
    .enter().append("circle")
      .attr("class", function(d) { return d.parent ? d.children ? "node" : "node node--leaf" : "node node--root"; })
      .style("fill", function(d) { return d.children ? color(d.depth) : null; })
      .on("click", function(d) { if (focus !== d) zoom(d), d3.event.stopPropagation(); });

  var text = svg.selectAll("text")
      .data(nodes)
    .enter().append("text")
      .attr("class", "label")
      .style("fill-opacity", function(d) { return d.parent === ss ? 1 : 0; })
      .style("display", function(d) { return d.parent === ss ? "inline" : "none"; })
      .text(function(d) { return d.title; });

  var node = svg.selectAll("circle,text");

  d3.select("body")
      //.attr("class", "background")
      .on("click", function() { zoom(ss); });

  zoomTo([ss.x, ss.y, ss.r * 2 + margin]);

  function zoom(d) {
    var focus0 = focus; focus = d;

    var transition = d3.transition()
        .duration(d3.event.altKey ? 7500 : 750)
        .tween("zoom", function(d) {
          var i = d3.interpolateZoom(view, [focus.x, focus.y, focus.r * 2 + margin]);
          return function(t) { zoomTo(i(t)); };
        });

    transition.selectAll("text")
      .filter(function(d) { return d.parent === focus || this.style.display === "inline"; })
        .style("fill-opacity", function(d) { return d.parent === focus ? 1 : 0; })
        .each("start", function(d) { if (d.parent === focus) this.style.display = "inline"; })
        .each("end", function(d) { if (d.parent !== focus) this.style.display = "none"; });
  }

  function zoomTo(v) {
    var k = diameter / v[2]; view = v;
    node.attr("transform", function(d) { return "translate(" + (d.x - v[0]) * k + "," + (d.y - v[1]) * k + ")"; });
    circle.attr("r", function(d) { return d.r * k; });
  }

//});
d3.select(self.frameElement).style("height", diameter + "px");

</script>
