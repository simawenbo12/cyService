<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>CyService-城市学院移动后勤</title>
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script> 
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
	<style>
		.container{
			text-align:center;
		}
		.img_2view{
			width:150px;
			height:150px;
		} 
    </style> 
</head>  
<body>  
	<div class="container">  
		<div class="row">
			<img src="${pageContext.request.contextPath }/images/download_main.png" style="width:80%;max-width:1000px">
			<br /><br />
		</div> 
		 
		<div class="row"> 
		   <div class="col-md-6 col-sm-6"> 
		   		<img class="img_2view" src="${pageContext.request.contextPath }/download/apk.png">
	            <p>Android下载</p>
	       </div> 
	        
	       <div class="col-md-6 col-sm-6">
	      		<img class="img_2view" src="${pageContext.request.contextPath }/download/ipa.png">
	            <p>ios下载(限越狱)</p>
	       </div> 
		</div>
	</div>

	
</body>
</html> 