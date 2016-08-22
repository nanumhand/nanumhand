<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp"%>

<div>
<!-- Main content -->
<section class="content">
	<div class="row">
		<!-- left column -->
		<div class="col-md-12">
			<!-- general form elements -->
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">REGISTER BOARD</h3>
				</div>
				<!-- /.box-header -->

<form role="form" method="post">
	<div class="box-body">
		<div class="form-group">
			<label for="exampleInputEmail1">Title</label> 
			<input type="text"
				name='title' class="form-control" placeholder="Enter Title">
		</div>
		<div class="form-group">
			<label for="exampleInputPassword1">Content</label>
			<textarea class="form-control" name="content" rows="3"
				placeholder="Enter ..."></textarea>
		</div>
		<div class="form-group">
			<label for="exampleInputEmail1">Writer</label> 
			<input type="text"
				name="writer" class="form-control" placeholder="Enter Writer">
		</div>
	</div>
	<!-- /.box-body -->

	<div class="box-footer">
		<button type="submit" class="btn btn-primary">Submit</button>
	</div>
</form>

<button id="ajax_test" class="btn btn-primary">ajax_test</button>
<button id="ajax_json" class="btn btn-primary">ajax_json</button>

			</div>
			<!-- /.box -->
		</div>
		<!--/.col (left) -->

	</div>
	<!-- /.row -->
</section>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->

<script>
	$("#ajax_test").on("click", function(){
		console.log('ajax_test');
		
		$.ajax({
			url: "register",
			type: "POST",
// 			async: false,
			data: {
				title: 'ajax_title_1',
				content: 'ajax_content_1',
				writer: 'ajax_writer_1'
			},
			success: function(result){
				console.log('success');
				console.log(result);
			},
			fail: function(result){
				console.log('fail');
			},
	    });		
	});
	
	$("#ajax_json").on("click", function(){
		console.log('ajax_json');
		
		$.ajax({
			url: "json",
			type: "GET",
			success: function(result){
				console.log('success');
				console.log(result);
				console.log(result.content)
			},
			fail: function(result){
				console.log('fail');
			},
	    });		
	});
</script>

<%@include file="../include/footer.jsp"%>
