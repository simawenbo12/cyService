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
               		return '${pageContext.request.contextPath}/user/findAllUser?pageNum='+page;
                },
                /* 	onPageClicked:function(event,originalEvent,type,page){
               		$('#pageNum').val(page);
               		$('#searchForm').submit();
               	}, */
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
    		
            $('#addUserForm').bootstrapValidator({
             	feedbackIcons: { //根据结果显示图标
                     valid: 'glyphicon glyphicon-ok',
                     invalid: 'glyphicon glyphicon-remove',
                     validating: 'glyphicon glyphicon-refresh'
                 },
                 fields:{
                 	 username:{
                 		 validators:{
                              notEmpty:{
                                  message:'用户名不能为空'
                              },
                              stringLength: {
                            	  min: 6,
                                  max: 15,
                                  message:'用户名长度必须在6-15之间'
                              },
                 			  regexp: {
                                  regexp: /^[a-zA-Z0-9_@]+$/,
                                  message: '用户名只能包含大写、小写、数字、下划@'
                              },
                              remote:{
                                  type:'post',
                                  url:'${pageContext.request.contextPath}/user/checkUsername',
                                  delay:2000,
                                  message:'用户名已存在'
                              }
                          }
                 	 },
                 	 password:{
                		 validators:{
                             notEmpty:{
                                 message:'密码不能为空'
                             },
                             stringLength: {
                           	 	 min: 6,
                                 max: 15,
                				  message: '密码只能为6到15位'
                			  },
                			  regexp: {
                                 regexp: /^[a-zA-Z0-9_@]+$/,
                                 message: '密码只能包含大写、小写、数字、下划线、@'
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
                                 message:'联系人长度必须小于5'
                             },
                         }
                     },
                     telephone:{
                         validators:{
                             notEmpty:{
                                 message:'手机号不能为空'
                             },
                             regexp: {
                                 regexp: /^[1][3,4,5,7,8][0-9]{9}$/,
                                 message: '手机号码不符合格式'
                             },
                          	 remote:{
                          		 type:'post',
                          		 url:'${pageContext.request.contextPath}/user/checkTelephone',
                                 delay:1000,
                                 message:'手机号已被使用'
                          	 }
                         }
                     },
                 }
              });
            formValidator();
            $("#updateUserModal").on('hidden.bs.modal',function(e){
            	//移除上次的校验配置
            	$("#updateUserForm").data('bootstrapValidator').destroy();
            	$('#updateUserForm').data('bootstrapValidator',null);
            	//重新添加校验
            	formValidator();
            });
            
    	});
        function formValidator(){
        	$('#updateUserForm').bootstrapValidator({
             	feedbackIcons: { //根据结果显示图标
                     valid: 'glyphicon glyphicon-ok',
                     invalid: 'glyphicon glyphicon-remove',
                     validating: 'glyphicon glyphicon-refresh'
                 },
                 fields:{
                 	 username:{
                 		 validators:{
                              notEmpty:{
                                  message:'用户名不能为空'
                              },
                              stringLength: {
                            	  min: 6,
                                  max: 15,
                                  message:'用户名长度必须在6-15之间'
                              },
                 			  regexp: {
                                  regexp: /^[a-zA-Z0-9_@]+$/,
                                  message: '用户名只能包含大写、小写、数字、下划@'
                              },
                              remote:{
                                  type:'post',
                                  data: function(validator,$field, value) {
                                      return {
                                          uid:$('#uid2').val(),
                                      }
                                  },
                                  url:'${pageContext.request.contextPath}/user/checkUsername',
                                  delay:2000,
                                  message:'用户名已存在'
                              }
                          }
                 	 },
                 	 password:{
                		 validators:{
                             notEmpty:{
                                 message:'密码不能为空'
                             },
                             stringLength: {
                           	 	 min: 6,
                                 max: 15,
                				 message: '密码只能为6到15位'
                			  },
                			  regexp: {
                                 regexp: /^[a-zA-Z0-9_@]+$/,
                                 message: '密码只能包含大写、小写、数字、下划线、@'
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
                                 message:'联系人长度必须小于5'
                             },
                         }
                     },
                     telephone:{
                         validators:{
                             notEmpty:{
                                 message:'手机号不能为空'
                             },
                             regexp: {
                                 regexp: /^[1][3,4,5,7,8][0-9]{9}$/,
                                 message: '手机号码不符合格式'
                             },
                          	 remote:{
                          		 type:'post',
                          		data: function(validator,$field, value) {
                                    return {
                                        uid:$('#uid2').val(),
                                    }
                                },
                          		 url:'${pageContext.request.contextPath}/user/checkTelephone',
                                 delay:1000,
                                 message:'手机号已被使用'
                          	 }
                         }
                     },
                 }
              });
        }
        function showUser(uid){
        	$.post(
        		'${pageContext.request.contextPath}/user/findById',
        		{'uid':uid},
        		function(result){
        			$("#uid2").val(result.uid);
        			$("#username2").val(result.username);
        			$("#password2").val(result.password);
        			$("#name2").val(result.name);
        			$("#telephone2").val(result.telephone);
        		}
        	)
        }
        function deleteUser(uid){
        	layer.confirm("是否要删除用户？删除后无法恢复",function(){
        		$.post(
        			'${pageContext.request.contextPath}/user/delete',
        			{'uid':uid},
        			function(){
        				layer.msg("删除成功",{
        					time:1000,
        				},function(){
        					location.href='${pageContext.request.contextPath}/user/findAllUser?pageNum='+${pageInfo.pageNum};
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
			<h3 class="panel-title">用户管理</h3>
		</div>
		<div class="panel-body center-block" >
				<form class="form-inline" action="${pageContext.request.contextPath }/user/findAllUser" method="post" id="searchForm">
				  <input type="button" value="添加用户" class="btn btn-primary"
				  data-toggle="modal" data-target="#addUserModal"/>
					  <input type="hidden" name="pageNum" value="${pageInfo.pageNum }" id="pageNum"/>
  					  <label for="title" style="padding-left:100px">用户名:</label>
  					  <input type="text" class="form-control" value="${userVo.username }" name="username" maxlength="15" autocomplete="off">
  					  <label for="title">手机号:</label>
  					  <input type="text" class="form-control" value="${userVo.telephone }" name="telephone" maxlength="11" autocomplete="off">
  					  <button class="btn btn-primary" type="submit">查询</button>
			</form>
			<hr />
			<div class="show-list text-center" >
				<table class="table table-bordered table-hover table-striped"
					style='text-align: center;' >
					<thead>
						<tr class="text-danger">
							<th class="text-center">编号</th>
							<th class="text-center">用户名</th>
							<th class="text-center">密码</th>
							<th class="text-center">姓名</th>	
							<th class="text-center">电话</th>
							<th class="text-center">操作</th>
						</tr>
					</thead>
					<tbody id="tb">
						<c:forEach items="${pageInfo.list}" var="user">
							<tr>
								<td>${user.uid}</td>
								<td>${user.username}</td>
								<td>${user.password}</td>
								<td>${user.name}</td>	
								<td>${user.telephone}</td>
								<td class="text-center">
									<input type="button" class="btn btn-warning btn-sm" value="修改"
										data-toggle="modal" data-target="#updateUserModal" onclick="showUser(${user.uid})" />
									<input type="button" class="btn btn-danger btn-sm" value="删除"
										onclick="deleteUser(${user.uid})" />
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<ul id="pagination"></ul>
			</div>
		</div>
	</div>

<!-- 添加start -->
<div class="modal fade" tabindex="-1" id="addUserModal">
    <div class="modal-dialog modal-lg">
        <form action="${pageContext.request.contextPath}/user/addUser" class="form-horizontal" method="post" id="addUserForm">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">添加用户信息</h4>
                </div>
                <!-- modal body start -->
                <div class="modal-body text-center row">
                    <input type="hidden" name="pageNum" value="${pageInfo.pageNum}">
	        		<div class="form-group">
	                    <label class="col-sm-3 control-label">用户名：</label>
	                    <div class="col-sm-6">
	                        <input type="text" class="form-control"  name="username" id="username" placeholder="建议使用学号">
	                    </div>
	                </div>
	                <div class="form-group">
	                    <label class="col-sm-3 control-label">密码：</label>
	                    <div class="col-sm-6">
	                        <input type="text"  class="form-control"  name="password" id="password">
	                    </div>
	                </div>
	                <div class="form-group">
	                    <label class="col-sm-3 control-label">姓名：</label>
	                    <div class="col-sm-2">
	                        <input type="text" class="form-control"  name="name" id="name">
	                    </div>
	                    <label class="col-sm-2 control-label">手机号：</label>
	                    <div class="col-sm-2">
	                        <input type="text" class="form-control"  name="telephone" id="telephone">
	                    </div>
	                </div>
                </div>
                <!-- Modal body end -->
                <div class="modal-footer">
                    <button class="btn btn-primary" type="submit">添加</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- 添加 end -->
<!-- 修改start -->
<div class="modal fade" tabindex="-1" id="updateUserModal">
    <div class="modal-dialog modal-lg">
        <form action="${pageContext.request.contextPath}/user/update" class="form-horizontal" method="post" id="updateUserForm">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">修改用户信息</h4>
                </div>
                <!-- modal body start -->
                <div class="modal-body text-center row">
                    <input type="hidden" name="pageNum" value="${pageInfo.pageNum}">
                    <div class="form-group">
	                    <label class="col-sm-3 control-label">编号：</label>
	                    <div class="col-sm-6">
	                        <input type="text" class="form-control"  name="uid" id="uid2" readonly>
	                    </div>
	                </div>
	        		<div class="form-group">
	                    <label class="col-sm-3 control-label">用户名：</label>
	                    <div class="col-sm-6">
	                        <input type="text" class="form-control"  name="username" id="username2">
	                    </div>
	                </div>
	                <div class="form-group">
	                    <label class="col-sm-3 control-label">密码：</label>
	                    <div class="col-sm-6">
	                        <input type="text"  class="form-control"  name="password" id="password2">
	                    </div>
	                </div>
	                <div class="form-group">
	                    <label class="col-sm-3 control-label">姓名：</label>
	                    <div class="col-sm-2">
	                        <input type="text" class="form-control"  name="name" id="name2">
	                    </div>
	                    <label class="col-sm-2 control-label">手机号：</label>
	                    <div class="col-sm-2">
	                        <input type="text" class="form-control"  name="telephone" id="telephone2">
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