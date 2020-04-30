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
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
    <!-- 引入ueditor资源文件 -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/ueditor/ueditor.config.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/ueditor/ueditor.all.js"></script>
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
        //上传图像预览
        $('#file').on('change',function() {
            $('#img').attr('src', window.URL.createObjectURL(this.files[0]));
        });
        $('#file2').on('change',function() {
            $('#img2').attr('src', window.URL.createObjectURL(this.files[0]));
        });
	});
	function check(){
		var title = $("#title").val();
		if(title==null||title==''){
			layer.msg("标题不能为空");
			return false;
		}
		return true;
	}
	function check2(){
		var title = $("#title2").val();
		if(title==null||title==''){
			layer.msg("标题不能为空");
			return false;
		}
		return true;
	}
	//修改时的回显
	function showNotice(nid){
		$.ajax({
			url:'${pageContext.request.contextPath}/notice/findById',
			type:'POST',
			data:{'nid':nid},
			success:function(result){
				$('#nid2').val(result.nid); 
				$('#title2').val(result.title);
				if(result.img!=''){
                	$('#img2').attr('src',"${pageContext.request.contextPath}/" +result.img);
                }else{
                	$('#img2').attr('src',"${pageContext.request.contextPath}/images/noimg.png"); 
                }
				ue2.ready(function() {
				    ue2.setContent(result.content);
				});
			}
		});
	}
	//删除通知
	function deleteNotice(nid){
		$.ajax({
			url:'${pageContext.request.contextPath}/notice/delete',
			type:'POST',
			data:{'nid':nid},
			success:function(){
				layer.confirm("确定要删除么",function(){
					layer.msg("删除成功",{
						time:1000,
					},function(){
						location.href='${pageContext.request.contextPath}/notice/findAll?pageNum='+${pageInfo.pageNum};
					});
				});
			}
		});
	}
	//验证文件大小 
	function verficationFile() {
        if (document.getElementById("file").value != "") {
            //计算上传图片大小
            var fileSize = document.getElementById("file").files[0].size/1024/1024;
            //如果上传文件大于2M
            if (fileSize > 2) {
                layer.msg("图片不能超过2M");
                document.getElementById("file").value='';
            	return false; 
            }
      	}
    };
	</script>
	<style>
		//修改上传图片的样式
        .fileinput-button {
            position: relative;
            display: inline-block;
            overflow: hidden;
        }
        .fileinput-button input{
            position:absolute;
            right: 0px;
            top: 0px;
            opacity: 0;
            -ms-filter: 'alpha(opacity=0)';
            height:40px;
            font-size:10px;
        }
    </style>
</head>
<body>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">通知管理</h3>
		</div>
		<div class="panel-body center-block" >
			<input type="button" value="发布通知" class="btn btn-primary"
				  data-toggle="modal" data-target="#addNoticeModal"/>
			<hr />
			<div class="show-list text-center" >
				<table class="table table-bordered table-hover table-striped"
					style='text-align: center;' >
					<thead>
						<tr class="text-danger">
							<th class="text-center">编号</th>
							<th class="text-center">标题</th>
							<th class="text-center">发布时间</th>
							<th class="text-center">操作</th>
						</tr>
					</thead>
					<tbody id="tb">
						<c:forEach items="${pageInfo.list}" var="notice">
							<tr>
								<td>${notice.nid}</td>
								<td>${notice.title}</td>
								<td><fmt:formatDate value="${notice.uptime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								<td class="text-center">
									<input type="button" class="btn btn-warning btn-sm" value="修改"
										data-toggle="modal" data-target="#updateNoticeModal" onclick="showNotice(${notice.nid})" />
									<input type="button" class="btn btn-danger btn-sm" value="删除"
										onclick="deleteNotice(${notice.nid})" />
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
<div class="modal fade" tabindex="-1" id="addNoticeModal">
    <div class="modal-dialog modal-lg">
        <form action="${pageContext.request.contextPath}/notice/add" class="form-horizontal" enctype="multipart/form-data" method="post" id="addNoticeForm" onsubmit="return check()">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">发布通知</h4>
                </div>
                <!-- modal body start -->
                <div class="modal-body text-center row">
                    <input type="hidden" name="pageNum" value="${pageInfo.pageNum}">
	                <div class="form-group">
	                    <label class="col-sm-3 control-label">标题：</label>
	                    <div class="col-sm-5" style="z-index:1000">
	                        <input type="text"  class="form-control"  name="title" id="title" maxlength="30" autocomplete="off">
	                    </div>
	                </div>
	                <div class="form-group">
	                    <label class="col-sm-3 control-label">封面：</label>
	                    <div class="col-sm-3" style="z-index:1000">
	                        <img style="height:150px;width:150px;" id="img">
	                    </div>
	                    <div class="col-sm-2" style="z-index:1000">
	                         <span class="btn btn-primary fileinput-button">
						         <span>上传封面</span>
						         <input type="file" name="file" id="file" accept="image/jpg,image/png,image/jpeg" onchange="verficationFile()">
						     </span>
	                    </div>
	                </div>
	                <div class="form-group">
	                    <label class="col-sm-3 control-label">内容：</label>
	                    <div class="col-sm-6">
	                        <script id="container" name="content" type="text/plain"></script>
	                    </div>
	                </div>
	                
                </div> 
                <!-- Modal body end -->
                <div class="modal-footer">
                    <button class="btn btn-primary" type="submit">发布</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- 添加 end -->
<!-- 修改start -->
<div class="modal fade" tabindex="-1" id="updateNoticeModal">
    <div class="modal-dialog modal-lg">
        <form action="${pageContext.request.contextPath}/notice/update" class="form-horizontal" enctype="multipart/form-data" method="post" id="updateNoticeForm" onsubmit="return check2()">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">发布通知</h4>
                </div>
                <!-- modal body start -->
                <div class="modal-body text-center row">
                    <input type="hidden" name="pageNum" value="${pageInfo.pageNum}">
                    <input type="hidden" name="nid" id="nid2" >
	                <div class="form-group">
	                    <label class="col-sm-3 control-label">标题：</label>
	                    <div class="col-sm-5" style="z-index:1000">
	                        <input type="text"  class="form-control"  name="title" id="title2" maxlength="30" autocomplete="off">
	                    </div>
	                </div>
	                <div class="form-group">
	                    <label class="col-sm-3 control-label">封面：</label>
	                    <div class="col-sm-3" style="z-index:1000">
	                        <img style="height:150px;width:150px;" id="img2">
	                    </div>
	                    <div class="col-sm-2" style="z-index:1000">
	                         <span class="btn btn-primary fileinput-button">
						         <span>上传封面</span>
						         <input type="file" name="file" id="file2"  accept="image/jpeg,image/jpg,image/png" onchange="verficationFile()">
						     </span>
	                    </div>
	                </div>
	                <div class="form-group">
	                    <label class="col-sm-3 control-label">内容：</label>
	                    <div class="col-sm-6">
	                        <script id="container2" name="content" type="text/plain"></script>
	                    </div>
	                </div>
                </div>
                <!-- Modal body end -->
                <div class="modal-footer">
                    <button class="btn btn-primary" type="submit">修改</button>
                    <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- 修改 end -->
	<script>
		var ue = UE.getEditor('container', {
			//设置宽度 高度
			initialFrameWidth : 380,
			initialFrameHeight : 500,
			elementPathEnabled : false,
			autoFloatEnabled : false,
			zIndex : 1100
		});
		var ue2 = UE.getEditor('container2', {
			//设置宽度 高度
			initialFrameWidth : 380,
			initialFrameHeight : 500,
			elementPathEnabled : false,
			autoFloatEnabled : false,
			zIndex : 1100
		});
	</script>
</body>
</html>