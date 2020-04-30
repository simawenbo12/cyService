<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
    <script>
    	//添加维修分类
    	function addCategory(){
    		var categoryItem = $('#categoryItem').val().trim(); 
    		if(categoryItem==""){
    			layer.msg("分类名不能为空");
    		}else{
    			$.ajax({
        			url:'${pageContext.request.contextPath}/category/add',
            		type:"POST",
            		data:{'categoryItem':categoryItem},
            		success:function(){
            			layer.msg("添加成功",{
        					time:1000,
        				},function(){
        					location.reload()
        				});
            		},
            		error:function(){
            			layer.msg("添加失败");
            		}
        		});
    		}
    	}
    	//维修分类修改回显
    	function showCategory(cid){
    		$.post(
    			'${pageContext.request.contextPath}/category/findById',
    			{'cid':cid},
    			function(res){
    				$("#cid2").val(res.cid);
    				$("#categoryItem2").val(res.categoryItem);
    			}
    		)
    	}
    	//删除分类
   		function deleteCategory(cid){
    		layer.confirm("是否要删除？删除后无法恢复！请谨慎操作！",function(){
    			layer.confirm("请再次确认没有维修单属于这个分类！",function(){
    				$.post(
    	    	   		'${pageContext.request.contextPath}/category/deleteById',
    	    	       	{'cid':cid},
    	    	       	function(){
    	    	       		layer.msg("删除成功",{
    	    	       			time:1000,
    	    	       		},function(){
    	    	       			location.reload();
    	    	       		});
    	    	       	}
    				);
    			});
    		});
    	}
    	
    	$(function(){
    		//修改分类
    		$("#updateCategory").click(function(){
        		var categoryItem = $("#categoryItem2").val().trim();
        		if(categoryItem==""){
        			layer.msg("分类名不能为空");
        		}else{
        			$.ajax({
            			url:'${pageContext.request.contextPath}/category/update',
                		type:"POST",
                		data:{'cid':$("#cid2").val(),'categoryItem':categoryItem},
                		success:function(){
                			layer.msg("修改成功",{
            					time:1000,
            				},function(){
            					location.reload();
            				});
                		},
                		error:function(){
                			layer.msg("修改失败");
                		}
            		});
        		}
        	});
    		
    	});
    	

    </script>
     
</head>

<body>
	
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">维修分类管理</h3>
		</div>
		<div class="panel-body">
			<input type="button" value="添加维修分类" class="btn btn-primary"
				data-toggle="modal" data-target="#addCategoryModal"/>
			<hr />
			<div class="show-list text-center">
				<table class="table table-bordered table-hover table-striped"
					style='text-align: center;' >
					<thead> 
						<tr class="text-danger">
							<th class="text-center">编号</th>
							<th class="text-center">分类名称</th>
							<th class="text-center">操作</th>
						</tr>
					</thead>
					<tbody id="tb">
						<c:forEach items="${categorys}" var="category">
							<tr>
								<td>${category.cid}</td>
								<td>${category.categoryItem}</td>
								<td class="text-center">
									<input type="button" class="btn btn-warning btn-sm" value="修改"
										data-toggle="modal" data-target="#updateCategoryModal" onclick="showCategory(${category.cid})" />
									<input type="button" class="btn btn-warning btn-sm" value="删除"
										onclick="deleteCategory(${category.cid})"/>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<!-- 添加 start -->
	<div class="modal fade" tabindex="-1" id="addCategoryModal">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">添加维修分类</h4>
				</div>
				<div class="modal-body text-center">
					<div class="row text-right">
						<label class="col-sm-4">分类名称：</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="categoryItem" maxlength="10"/>
						</div>
					</div>
					<br />
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" onclick="addCategory()">添加</button>
					<button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 添加 end -->
	<!-- 修改start -->
	<div class="modal fade" tabindex="-1" id="updateCategoryModal">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">修改维修分类</h4>
				</div>
				<div class="modal-body text-center">
					<div class="row text-right">
						<label class="col-sm-4 control-label">编号：</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="cid2" readonly>
						</div>
					</div>
					<br>
					<div class="row text-right">
						<label class="col-sm-4 control-label">类型名称</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" maxlength="10" id="categoryItem2">
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-warning" id="updateCategory">修改</button>
					<button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 修改 end -->
	
</body>

</html>