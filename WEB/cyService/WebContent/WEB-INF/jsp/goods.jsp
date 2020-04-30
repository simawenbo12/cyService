<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/bootstrapValidator.min.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrapValidator.min.js"></script>
    <script>
    	$(function(){
            $('#pagination').bootstrapPaginator({
            	bootstrapMajorVersion:3,
                currentPage:${pageInfo.pageNum},  //当前页
                totalPages:${pageInfo.pages},     //总页数
                numberOfPages:10,               //最多显示10个页码
                pageUrl:function(type,page,current){
               		return '${pageContext.request.contextPath}/goods/findAllGoods?pageNum='+page;
                },
               	itemTexts: function (type, page, current) {
                    switch (type) {
                        case "first":
                            return "首页";
                        case "prev":
                            return "上一页";
    						case "next":
                            return "下一页";
                        case "last":
                            return "末页";
                        case "page":
                            return page;
                    }
                },
    		});
            formValidator();
            $("#updateGoodsModal").on('hidden.bs.modal',function(e){
            	//移除上次的校验配置
            	$("#updateGoodsForm").data('bootstrapValidator').destroy();
            	$('#updateGoodsForm').data('bootstrapValidator',null);
            	//重新添加校验
            	formValidator();
            });
            
    	});
        function formValidator(){
        	$('#updateGoodsForm').bootstrapValidator({
             	feedbackIcons: { //根据结果显示图标
                     valid: 'glyphicon glyphicon-ok',
                     invalid: 'glyphicon glyphicon-remove',
                     validating: 'glyphicon glyphicon-refresh'
                 },
                 fields:{
                 	 title:{
                 		 validators:{
                              notEmpty:{
                                  message:'标题不能为空'
                              },
                              stringLength: {
                                  max: 15,
                                  message:'标题长度必须小于15个字符'
                              }
                          }
                 	 },
                 	 price:{
                		 validators:{
                             notEmpty:{
                                 message:'价格不能为空'
                             },
                             regexp: {
                                 regexp: /^(([1-9]{1}\d*)|(0{1}))(\.\d{0,1})?$/,
                                 message: '价格不符合格式'
                             }
                             
                         }
                	 },
                 	 state:{
                		 validators:{ 
                             notEmpty:{
                                 message:'状态不能为空'
                             }
                         }
                	 },
                     name:{
                         validators:{
                             notEmpty:{
                                 message:'联系人不能为空'
                             },
                             stringLength: {
                                 max: 5,
                                 message:'联系人长度必须小于5个字符'
                             },
                         }
                     },
                     telephone:{
                         validators:{
                             notEmpty:{
                                 message:'联系方式不能为空'
                             },
                             stringLength: {
                                 max: 20,
                                 message:'联系方式长度必须小于20个字符'
                             },
                         }
                     },
                 }
              });
        }
        function showGoods(gid){
        	$.post(
        		'${pageContext.request.contextPath}/goods/findById',
        		{'gid':gid},
        		function(result){
        			console.log(result.title);
        			$("#gid").val(result.gid); 
        			$("#title").val(result.title);
        			$("#price").val(result.price);
        			$("#content").val(result.content);
        			$("#state").val(result.state);
        			$("#uptime").val(result.uptime);
        			$("#name").val(result.name);
        			$("#telephone").val(result.telephone);
        			if(result.img!=null){
                    	$('#img').attr('src',"${pageContext.request.contextPath}/" +result.img);
                    }else{
                    	$('#img').attr('src',"${pageContext.request.contextPath}/images/noimg.png");
                    };
        		} 
        	)
        }
        function deleteGoods(gid){
        	layer.confirm("是否要删除？删除后无法恢复！",function(){
        		$.post(
        			'${pageContext.request.contextPath}/goods/delete',
        			{'gid':gid},
        			function(){
        				layer.msg("删除成功",{
        					time:1000,
        				},function(){
        					location.href='${pageContext.request.contextPath}/goods/findAllGoods?pageNum='+${pageInfo.pageNum};
        				}); 
        			}
        		) 
        	});
        }
    </script>
   	
</head>

<body>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">二手市场管理</h3>
		</div>
		<div class="panel-body center-block" >
			<form class="form-inline" action="${pageContext.request.contextPath }/goods/findAllGoods" method="post" id="searchForm">
				  <input type="hidden" name="pageNum" value="${pageInfo.pageNum }" id="pageNum"/>
 					  <label for="title">标题:</label>
 					  <input type="text" class="form-control" value="${goodsVo.title}" name="title" maxlength="15" autocomplete="off">
 					  <label for="state">状态:</label>
 					  <select class="form-control" name="state">
  					      <option value="">--请选择--</option>
  					      <option value="0" <c:if test="${lostVo.state eq 0}">selected</c:if> >进行中</option>
  					      <option value="1" <c:if test="${lostVo.state eq 1}">selected</c:if> >已完成</option>
  					  </select>
 					  <button class="btn btn-primary" type="submit">查询</button>
			</form>
			<hr />
			<div class="show-list text-center" >
				<table class="table table-bordered table-hover table-striped"
					style='text-align: center;' >
					<thead>
						<tr class="text-danger">
							<th class="text-center">编号</th>
							<th class="text-center">标题</th>
							<th class="text-center">价格</th>
							<th class="text-center">状态</th>
							<th class="text-center">发布时间</th>
							<th class="text-center">操作</th>
						</tr>
					</thead>
					<tbody id="tb">
						<c:forEach items="${pageInfo.list}" var="goods">
							<tr>
								<td>${goods.gid}</td>
								<td>${goods.title}</td>
								<td>${goods.price}</td>
								<td>
									<c:if test="${goods.state==0}"><p class="text-danger">进行中</p></c:if>
									<c:if test="${goods.state==1}"><p class="text-success">已完成</p></c:if>
								</td>
								<td><fmt:formatDate value="${goods.uptime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								<td class="text-center">
									<input type="button" class="btn btn-warning btn-sm" value="修改"
										data-toggle="modal" data-target="#updateGoodsModal" onclick="showGoods(${goods.gid})" />
									<input type="button" class="btn btn-danger btn-sm" value="删除"
										onclick="deleteGoods(${goods.gid})" />
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<ul id="pagination"></ul>
			</div>
		</div>
	</div>
	
<!-- 修改start -->
<div class="modal fade" tabindex="-1" id="updateGoodsModal">
    <div class="modal-dialog modal-lg">
        <form action="${pageContext.request.contextPath}/goods/update" class="form-horizontal" method="post" id="updateGoodsForm">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">修改二手信息</h4>
                </div>
                <!-- modal body start -->
                <div class="modal-body text-center row">
                    <input type="hidden" name="pageNum" value="${pageInfo.pageNum}">
                    <div class="form-group">
	                    <label class="col-sm-3 control-label">编号：</label>
	                    <div class="col-sm-6">
	                        <input type="text" class="form-control"  name="gid" id="gid" readonly>
	                    </div>
	                </div>
	        		<div class="form-group">
	                    <label class="col-sm-3 control-label">标题：</label>
	                    <div class="col-sm-6">
	                        <input type="text" class="form-control"  name="title" id="title">
	                    </div>
	                </div>
	                <div class="form-group">
	                    <label class="col-sm-3 control-label">详情：</label>
	                    <div class="col-sm-6">
	                        <input type="text"  class="form-control"  name="content" id="content" maxlength="100">
	                    </div>
	                </div>
	                 <div class="form-group">
	                    <label class="col-sm-3 control-label">图片：</label>
	                    <div class="col-sm-6">
	                         <img src="" id="img" style="height:100px;width:120px;float:left">
	                    </div>
	                </div>
	                <div class="form-group">
	                    <label class="col-sm-3 control-label">联系人：</label>
	                    <div class="col-sm-2">
	                        <input type="text" class="form-control"  name="name" id="name">
	                    </div>
	                    <label class="col-sm-2 control-label">联系方式：</label>
	                    <div class="col-sm-2">
	                        <input type="text" class="form-control"  name="telephone" id="telephone">
	                    </div>
	                </div>
	                <div class="form-group">
	                    <label class="col-sm-3 control-label">状态：</label>
	                    <div class="col-sm-2">
	                        <select class="form-control" id="state" name="state">
				            	<option value="">--请选择状态--</option>
				        	 	<option value="0">进行中</option>
				        	 	<option value="1">已完成</option>
				            </select>
	                    </div>
	                    <label class="col-sm-2 control-label">价格：</label>
	                    <div class="col-sm-2">
	                         <input type="text" class="form-control"  name="price" id="price">
	                    </div>
	                </div>
	                <div class="form-group">
	                    <label class="col-sm-3 control-label">发布时间：</label>
	                    <div class="col-sm-6">
	                        <input type="text"  class="form-control"  name="uptime" id="uptime" readonly>
	                    </div>
	                </div>
	                
                </div>
                <!-- Modal body end -->
                <div class="modal-footer">
                    <button class="btn btn-primary" type="submit" >修改</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </form>
    </div> 
</div>
<!-- 修改 end -->

</body>

</html>