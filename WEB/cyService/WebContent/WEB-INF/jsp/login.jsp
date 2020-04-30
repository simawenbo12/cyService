<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>CyService-后台管理系统</title>
    <link rel="icon" href="${pageContext.request.contextPath }/images/icon_title.png">
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/login.css" />
    
	<style>
		
    </style>  
</head>
<body>  
    <div class="lowin"> 
		<div class="lowin-brand">
			<img src="${pageContext.request.contextPath }/images/kodinger.jpg" alt="logo">
		</div> 
		<div class="lowin-wrapper"> 
			<div class="lowin-box lowin-login">
				<div class="lowin-box-inner">
					<form>
						<p>CyService-城市学院移动后勤</p>
						<div class="lowin-group">
							<label>账号</label>
							<input type="text" autocomplete="off" placeholder="请输入账号" name="username" id="username" class="lowin-input">
						</div>
						<div class="lowin-group password-group">
							<label>密码</label>
							<input type="password" autocomplete="off" name="password" placeholder="请输入密码" id="password" class="lowin-input">
						</div>
					</form> 
						<button class="lowin-btn login-btn" id="loginBtn" >
							登录
						</button>  
				</div> 
			</div>  
		</div> 
	</div>
	<script src="${pageContext.request.contextPath}/js/jquery.js"></script> 
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
	<script>
	$("#loginBtn").click(function(){
		if($("#username").val()==""||$("#password").val()==""){
			layer.alert("账号及密码不得为空",{skin:'layui-layer-molv',icon:5,title:'提示'});
			return;	
		} 
		$.ajax({
			url:"${pageContext.request.contextPath}/user/loginMain",
			type:"POST",
			data:{
				"username":$("#username").val(),
				"password":$("#password").val() 
			}, 
			success:function(result){
				if(result=="true"){
					location.href = "${pageContext.request.contextPath}/main"; 
				}else{ 
					layer.alert("账号或密码错误,请重新输入",{skin:'layui-layer-molv',icon:2,title:'提示'});
				}
			}
		})
	});
	</script>
</body>
</html>  