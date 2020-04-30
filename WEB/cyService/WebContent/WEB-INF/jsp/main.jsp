<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>CyService-后台管理系统</title>
    <link rel="icon" href="${pageContext.request.contextPath }/images/icon_title.png">
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/bootstrap.css" />
	<link rel="stylesheet"  href="${pageContext.request.contextPath}/css/index.css" /><!-- 头尾样式 -->
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/js/userSetting.js"></script>
    <script type="text/javascript">
    $(function(){ 
    	// 点击切换页面 
	    $("#main-set").click(function() {
            $("#frame-id").attr("src", "${pageContext.request.contextPath }/home");
        });
        $("#notice-set").click(function() {
            $("#frame-id").attr("src", "${pageContext.request.contextPath }/notice/findAll");
        });
        $("#repair-set").click(function() { 
            $("#frame-id").attr("src", "${pageContext.request.contextPath }/repair/findAll");
        });
        $("#area-set").click(function() {
            $("#frame-id").attr("src", "${pageContext.request.contextPath }/area/findAll");
        });
        $("#category-set").click(function() {
            $("#frame-id").attr("src", "${pageContext.request.contextPath }/category/findAll");
        });
        $("#goods-set").click(function() {
            $("#frame-id").attr("src", "${pageContext.request.contextPath}/goods/findAllGoods");
        });
        $("#lost-set").click(function() {
            $("#frame-id").attr("src", "${pageContext.request.contextPath}/lost/findAllLost");
        });
        $("#user-set").click(function() {
            $("#frame-id").attr("src", "${pageContext.request.contextPath}/user/findAllUser");
        });
        $("#maintennance-set").click(function() {
            $("#frame-id").attr("src", "${pageContext.request.contextPath }/user/findAllMaintennance");
        });
        $("#exitlogin").click(function(){
        	location.href="${pageContext.request.contextPath }/exitLogin";
        });
    });
   
    </script>
     
    <style>
		body{    
		    overflow-y: hidden;
		    overflow-x: hidden; 
		}  
    	.exit a{color:white; }
		li span{color:#337AB7; }  
    </style>
</head>

<body>
    <div class="wrapper-cc clearfix">  
        <div class="content-cc">
            <!-- header start -->
            <div class="clear-bottom head">
                <div class="container head-cc">
                    <p>城市学院移动后勤<span>CyService</span></p>
                    <div class="welcome" style="float:right;right:20px;width:40px;"> 
                        <div class="exit"><a id="exitlogin" href="javascript:;">退出</a></div> 
                    </div>
                </div>
            </div>
            <!-- header end -->
            <!-- content start --> 
            <div class="container-flude flude-cc" id="a">
                <div class="row user-setting">
                    <div class="col-xs-2 user-wrap">
                        <ul class="list-group">
                            <li class="list-group-item active" name="mainSet" id="main-set">
                                <span class="glyphicon glyphicon-home"></span> &nbsp;首页
                            </li>
                            <li class="list-group-item" name="noticeSet" id="notice-set">
                                <span class="glyphicon glyphicon-bullhorn"></span> &nbsp;通知管理
                            </li>
                            <li class="list-group-item" name="repairSet" id="repair-set">
                                <span class="glyphicon glyphicon-wrench"></span> &nbsp;后勤维修管理
                            </li>
                            <li class="list-group-item" name="repairSet" id="area-set">
                                <span class="glyphicon glyphicon-map-marker"></span> &nbsp;维修分区管理
                            </li>
                            <li class="list-group-item" name="repairSet" id="category-set">
                                <span class="glyphicon glyphicon-cog"></span> &nbsp;维修分类管理
                            </li>
                            <li class="list-group-item" name="goodsSet" id="goods-set">
                                <span class="glyphicon glyphicon-shopping-cart"></span> &nbsp;二手市场管理
                            </li>
                            <li class="list-group-item" name="lostSet" id="lost-set">
                                <span class="glyphicon glyphicon-calendar"></span> &nbsp;失物招领管理
                            </li>
                            <li class="list-group-item" name="userSet" id="user-set">
                                <span class="glyphicon glyphicon-user"></span> &nbsp;用户管理
                            </li>
                            <li class="list-group-item" name="maintennanceSet" id="maintennance-set">
                                <span class="glyphicon glyphicon-star"></span> &nbsp;维修员管理
                            </li>
                        </ul>
                    </div>
                    <div class="col-xs-10" id="userPanel">
                        <iframe id="frame-id" src="${pageContext.request.contextPath }/home"
                        	width="100%" height="100%" frameborder="0"> 
                        	  
                        </iframe> 
                    </div>

                </div>
            </div>
            <!-- content end-->
        </div>
    </div>
    
    <!-- footers start -->
    <div class="footer">
      	东莞理工学院城市学院移动后勤-后台管理系统
    </div>
    <!-- footers end -->
</body>

</html>