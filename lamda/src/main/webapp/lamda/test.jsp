
<script src="/js/d3.old.js"></script>
<script>
 var dataset = [{"title":"lamda1","indent":1,"R":1,"seq":29},{"title":"lamda2","indent":1,"R":2,"seq":29}];
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
				$(parent.document).find("#board_contents").attr("src","/lamda/board/board_selectOne.jsp?seq_board="+d.seq);
			});
			
	d3.selectAll("div").each(function(d, i){
        d3.select(this)
			.transition().ease("cubic")
			.duration(500)
			.style("left", function(d){ return d.indent*20+"px";})
			.style("top", i*42+"px");			
		}); 
</script>