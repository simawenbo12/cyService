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
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/progress.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrapValidator.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/vue.js"></script>
    <script>
    	$(function(){
            $('#pagination').bootstrapPaginator({
            	bootstrapMajorVersion:3,
                currentPage:${pageInfo.pageNum},  //当前页
                totalPages:${pageInfo.pages},     //总页数
                numberOfPages:10,               //最多显示10个页码
               	onPageClicked:function(event,originalEvent,type,page){
               		$('#pageNum').val(page);
               		$('#searchForm').submit();
               	},
                //shouldShowPage:true, //在第一页和最后一页也显示首页
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
            $("#updateRepairModal").on('hidden.bs.modal',function(e){
            	//移除上次的校验配置
            	$("#updateRepairForm").data('bootstrapValidator').destroy();
            	$('#updateRepairForm').data('bootstrapValidator',null);
            	//重新添加校验
            	formValidator();
            });
            $("#showProgressModal").on('hidden.bs.modal',function(e){
            	location.reload();
            })
            
    	});
    	
       //使用bootstrap validator插件进行客户端数据校验
       function formValidator(){
        $('#updateRepairForm').bootstrapValidator({
        	feedbackIcons: { //根据结果显示图标
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields:{
            	title:{
            		 validators:{
                         notEmpty:{
                             message:'维修问题不能为空'
                         },
                         stringlength:{
                        	 min:3,
                        	 max:15,
                        	 message:'维修问题长度只能为3-12位'
                         }
                     }
            	},
         		homestart:{
         			validators:{
         				notEmpty:{
         					message:'宿舍有人时间不能为空'
         				}
         			}
         		},
                aid:{
                    validators:{
                        notEmpty:{
                            message:'区域不能为空'
                        }
                    }
                },
                address:{
                    validators:{
                        notEmpty:{
                            message:'详细地址不能为空'
                        }
                    }
                },
                cid:{
                    validators:{
                        notEmpty:{
                            message:'维修类别不能为空'
                        }
                    }
                },
                state:{
                    validators:{
                        notEmpty:{
                            message:'维修状态不能为空'
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
                        }
                    }
                },
            }
         });
        }
    	//显示维修信息
        function showRepair(rid){
            $.post(
                 '${pageContext.request.contextPath}/repair/findById',
                 {'rid':rid},
                 function(result){
                	 console.log(result);
                     $('#rid').val(result.rid);
                     $('#title').val(result.title);
                     $('#content').val(result.content);
                     $('#homestart').val(result.homestart);
                     $('#aid').val(result.aid);
                     $('#address').val(result.address);
                     $('#cid').val(result.cid);
                     $('#name').val(result.name);
                     $('#telephone').val(result.telephone);
                     if(result.img!=null){
                     	$('#img').attr('src',"${pageContext.request.contextPath}/" +result.img);
                     }else{
                     	$('#img').attr('src',"${pageContext.request.contextPath}/images/noimg.png");
                     };
                     $('#uptime').val(result.uptime);
                     $('#state').val(result.state);
                 }
            );
        }
    	//删除
    	function deleteRepair(rid){
			layer.confirm("是否要删除？删除后无法恢复！",function(){
				$.post(
    	   			'${pageContext.request.contextPath}/repair/deleteById',
    	      	 	{'rid':rid},
    	      	 	function(){
    	      	 		layer.msg("删除成功",{
    	       				time:1000,
    	       			},function(){
    	       				location.reload();
    	       			});
    	   	    	}	
				);
			});
		}
    	//指派维修员回显所有维修员
    	function showMaintennance(rid){
    		$.ajax({
    			url:"${pageContext.request.contextPath}/user/findAllMaintennance2",
    			type:'POST',
    			success:function(result){
    				var v1 = new Vue({
    					el:'#app1',
    					data:{
    						rows:result
    					},
    					methods:{
    						//使用vue绑定指派维修员函数
    						appoint:function(uid){
    				    		$.ajax({
    				    			url:'${pageContext.request.contextPath}/repair/appoint',
    				    			data:{"uid":uid,"rid":rid},
    				    			type:"POST",
    				    			success:function(data){
    				    				if(data){
    				    					layer.msg("指派成功,已发送短信通知维修员",{
        			    	       				time:1000,
        			    	       			},function(){
        			    	       				location.reload();
        			    	       			});
    				    				}else{
    				    					layer.msg("指派失败,维修单已被接取",{
        			    	       				time:1000,
        			    	       			},function(){
        			    	       				location.reload();
        			    	       			});
    				    				}
    				    				
    				    			}
    				    		}); 
    				    	}
    					}
    				});
    			}
    		});
    	}
    	//维修进度详情
    	function showProgress(rid){
    		$.ajax({
    			url:"${pageContext.request.contextPath}/repair/findProgressById",
    			type:'POST',
    			data:{'rid':rid},
    			success:function(result){
    				console.log(result);
    				var v2 = new Vue({
    					el:'#app2',
    					data:{
    						rows:result
    					}
    				});
    			}
    		});
    	}
    	//修改维修单
    	function updateRepair(){
    		var formdata = new FormData($('#updateRepairForm')[0]);
    		$.ajax({
    			url:"${pageContext.request.contextPath}/repair/update",
    			type:'POST',
    			data:formdata,
                processData: false, //formdata表单提交一定要设定这两个值为false
                contentType: false,
    			success:function(){
    				layer.msg("修改成功",{
	       				time:1000,
	       			},function(){
	       				location.reload();
	       			});
    			}
    		});
    	}
    </script>
   	
</head>

<body>
	<div class="panel panel-default" >
		<div class="panel-heading">
			<h3 class="panel-title">后勤维修管理</h3>
		</div>
		<div class="panel-body center-block" >
			<form class="form-inline" action="${pageContext.request.contextPath }/repair/findAll" method="post" id="searchForm">
				<input type="hidden" name="pageNum" value="${pageInfo.pageNum }" id="pageNum"/>
				<div class="form-group">
  					  <label for="title">维修问题</label>
  					  <input type="text" class="form-control" value="${RepairQueryVo.titleVo }" name="titleVo" maxlength="15" autocomplete="off">
  				</div>
  				<div class="form-group">
  					  <label>状态</label>
  					  <select class="form-control" name="stateVo">
  					      <option value="">--请选择--</option>
  					      <option value="0" <c:if test="${RepairQueryVo.stateVo eq 0}">selected</c:if> >未接受</option>
  					      <option value="1" <c:if test="${RepairQueryVo.stateVo eq 1}">selected</c:if> >待完工</option>
  					      <option value="2" <c:if test="${RepairQueryVo.stateVo eq 2}">selected</c:if> >已完工</option>
  					      <option value="3" <c:if test="${RepairQueryVo.stateVo eq 3}">selected</c:if> >疑难</option>
  					  </select>
  				</div>
  				<div class="form-group">
  					  <label>区域</label>
  					  <select class="form-control" name="aidVo" >
                           <option value="">--请选择--</option>
                           <c:forEach items="${areas}" var="area">
                               <option value="${area.aid}" <c:if test="${RepairQueryVo.aidVo==area.aid }">selected</c:if> >${area.areaItem}</option>
                           </c:forEach>
                      </select>
  				</div>
  				<div class="form-group">
  					  <label>分类</label>
  					  <select class="form-control" name="cidVo">
                           <option value="">--请选择--</option>
                           <c:forEach items="${categorys}" var="category">
                                <option value="${category.cid}" <c:if test="${RepairQueryVo.cidVo==category.cid }">selected</c:if> >${category.categoryItem}</option>
                            </c:forEach>
                      </select>
  				</div>
  				<div class="form-group">
  					  <label>报修时间</label>
  					  <input type="Date" class="form-control" name="uptimeStartVo" 
  					  value='<fmt:formatDate value="${RepairQueryVo.uptimeStartVo }" pattern="yyyy-MM-dd" />'/>~
  					  <input type="Date" class="form-control" name=	"uptimeEndVo" 
  					  value='<fmt:formatDate value="${RepairQueryVo.uptimeEndVo }" pattern="yyyy-MM-dd" />'/>
  				</div>
  				<button class="btn btn-primary" type="submit">查询</button>
			</form>
			<hr />
			<div class="show-list text-center" >
				<table class="table table-bordered table-hover table-striped"
					style='text-align: center;' >
					<thead>
						<tr class="text-danger">
							<th class="text-center">编号</th>
							<th class="text-center">维修问题</th>
							<th class="text-center">区域</th>
							<th class="text-center">类别</th>
							<th class="text-center">报修时间</th>
							<th class="text-center">状态</th>
							<th class="text-center">操作</th>
						</tr>
					</thead>
					<tbody id="tb">
						<c:forEach items="${pageInfo.list}" var="repairVo">
							<tr>
								<td>${repairVo.rid}</td>
								<td>${repairVo.title}</td>
								<td>${repairVo.areaItem}</td>
								<td>${repairVo.categoryItem}</td>	
								<td><fmt:formatDate value="${repairVo.uptime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								<td>
									<c:if test="${repairVo.state==0}"><p class="text-warning">未接受</p></c:if>
									<c:if test="${repairVo.state==1}"><p class="text-primary">待完工</p></c:if>
									<c:if test="${repairVo.state==2}"><p class="text-success">已完工</p></c:if>
									<c:if test="${repairVo.state==3}"><p class="text-danger">疑难</p></c:if>
								</td>
								<td class="text-center">
									<c:if test="${repairVo.state==0}">
										<input type="button" class="btn btn-primary btn-sm" value="指派维修"
										data-toggle="modal" data-target="#showMaintennanceModal" onclick="showMaintennance(${repairVo.rid})" />
									</c:if>
									<c:if test="${repairVo.state!=0}">
										<input type="button" class="btn btn-primary btn-sm" value="指派维修"
											disabled/>
									</c:if>
									<input type="button" class="btn btn-info btn-sm" value="维修进度详情"
										data-toggle="modal" data-target="#showProgressModal" onclick="showProgress(${repairVo.rid})" />
									<input type="button" class="btn btn-warning btn-sm" value="修改"
										data-toggle="modal" data-target="#updateRepairModal" onclick="showRepair(${repairVo.rid})" />
									<input type="button" class="btn btn-danger btn-sm" value="删除"
										onclick="deleteRepair(${repairVo.rid})" />
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
<div class="modal fade" tabindex="-1" id="updateRepairModal">
    <div class="modal-dialog modal-lg">
        <form  class="form-horizontal" method="post" id="updateRepairForm">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">修改维修单</h4>
                </div>
                <!-- modal body start -->
                <div class="modal-body text-center row">
                    <input type="hidden" name="pageNum" value="${pageInfo.pageNum}">
                    <div class="form-group">
	                    <label class="col-sm-3 control-label">编号：</label>
	                    <div class="col-sm-6">
	                        <input type="text" class="form-control"  name="rid" id="rid" readonly>
	                    </div>
	                </div>
	        		<div class="form-group">
	                    <label class="col-sm-3 control-label">维修问题：</label>
	                    <div class="col-sm-6">
	                        <input type="text" class="form-control"  name="title" id="title">
	                    </div>
	                </div>
	                <div class="form-group">
	                    <label class="col-sm-3 control-label">问题详情：</label>
	                    <div class="col-sm-6">
	                        <input type="text"  class="form-control"  name="content" id="content" maxlength="100">
	                    </div>
	                </div>
	                <div class="form-group">
	                    <label  class="col-sm-3 control-label">何时有人：</label>
	                    <div class="col-sm-3">
	                        <select class="form-control" name="homestart" id="homestart">
	  					        <option value="0" >8:00-12:00</option>
	  					      	<option value="1" >12:00-16:00</option>
	  					      	<option value="2" >16:00-20:00</option>
	  						</select>
	                    </div>
	                </div>
	                <div class="form-group">
	                    <label  class="col-sm-3 control-label">维修地址:</label>
	                    <div class="col-sm-3">
	                        <select class="form-control" name="aid" id="aid">
	                            <option value="">--请选择--</option>
	                            <c:forEach items="${areas}" var="area">
	                     	    	<option value="${area.aid}">${area.areaItem}</option>
	                  			</c:forEach>
	                        </select>
	                    </div>
	                    <div class="col-sm-3">
	                        <input type="text" class="form-control" name="address" id="address" placeholder="请输入详细地址" maxlength="30">
	                    </div>
	                </div>
	                <div class="form-group">
	                    <label  class="col-sm-3 control-label">分类：</label>
	                    <div class="col-sm-3">
	                        <select class="form-control" name="cid" id="cid">
	                            <c:forEach items="${categorys}" var="category">
	                     	    	<option value="${category.cid}" >${category.categoryItem}</option>
	                  			</c:forEach>
	                        </select>
	                    </div>
	                </div>
	                <div class="form-group">
	                    <label class="col-sm-3 control-label">联系人：</label>
	                    <div class="col-sm-2">
	                        <input type="text" class="form-control"  name="name" id="name">
	                    </div>
	                    <label class="col-sm-2 control-label">手机号：</label>
	                    <div class="col-sm-2">
	                        <input type="text" class="form-control"  name="telephone" id="telephone">
	                    </div>
	                </div>
	                <div class="form-group">
	                    <label class="col-sm-3 control-label">商品图片：</label>
	                    <div class="col-sm-6">
	                        <img src="" id="img" style="height:100px;width:120px;float:left">
	                    </div>
	                </div>
	                <div class="form-group">
	                    <label class="col-sm-3 control-label">报修时间：</label>
	                    <div class="col-sm-6">
	                        <input type="text" class="form-control"  name="uptime" id="uptime" readonly>
	                    </div>
	                </div>
	                <div class="form-group">
  					    <label class="col-sm-3 control-label">状态</label>
  					 	<div class="col-sm-3">
	  					 	<select class="form-control" name="state" id="state">
	  					        <option value="0" >未接受</option>
	  					      	<option value="1" >待完工</option>
	  					      	<option value="2" >已完工</option>
	  					    	<option value="3" >疑难</option>
	  						</select>
  					 	</div>
  					</div>
                </div>
                <!-- Modal body end -->
                <div class="modal-footer">
                    <button class="btn btn-primary"  type="submit" onclick="updateRepair()">修改</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- 修改 end -->
<!-- 指派维修 start -->
<div class="modal fade" tabindex="-1" id="showMaintennanceModal">
    <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">指派维修</h4>
                </div>
                <!-- modal body start -->
                 <div class="modal-body text-center row" >
                 <font class="text-muted"> 指派后将会发短信通知维修员</font>
                 	<div id="app1">
	               		<table class="table table-bordered table-hover"
							style='text-align: center;' >
							<thead>
								<tr class="text-danger">
									<th class="text-center">编号</th>
									<th class="text-center">用户名</th>
									<th class="text-center">姓名</th>
									<th class="text-center">电话</th>
									<th class="text-center">操作</th>
								</tr>
							</thead>
							<tbody id="tb">
								<tr v-for="u in rows">
									<td>{{u.uid}}</td>
									<td>{{u.username}}</td>
									<td>{{u.name}}</td>
									<td>{{u.telephone}}</td>
									<td><input type="button" class="btn btn-primary btn-sm" value="指派此维修员"
										@click="appoint(u.uid)" /></td>
								</tr>
							</tbody>
						</table>
                 	</div>
                </div>
                <!-- Modal body end -->
                <div class="modal-footer">
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
    </div>
</div>
<!-- 指派维修 end -->
<!-- 维修进度 start -->
<div class="modal fade" tabindex="-1" id="showProgressModal">
    <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">维修进度详情</h4>
                </div>
                <!-- modal body start -->
                	<div class="track-rcol"> 
					<div class="track-list" id="app2">
						<ul>
							<li v-for="(p,index) in rows"  :class="0==index?'first':''">
								<i class="node-icon"><img src="../images/progress-icon.png"/></i>
								<span class="time">{{p.uptime}}</span>
								<span class="txt">{{p.action}}</span>
							</li>
						</ul>
					</div>
				</div>
                <!-- Modal body end -->
                <div class="modal-footer">
                    <button class="btn btn-primary cancel" data-dismiss="modal">关闭</button>
                </div>
            </div>
    </div>
</div>
<!-- 维修进度 end -->

</body>

</html>