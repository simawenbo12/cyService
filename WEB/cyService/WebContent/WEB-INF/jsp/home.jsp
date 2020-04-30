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
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/custom-styles.css" />
    <link rel="stylesheet"  href="${pageContext.request.contextPath}/css/font-awesome.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script> 
    <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
    <script src="${pageContext.request.contextPath}/js/echarts.js"></script>
    <style>
    	#page-inner{  
    		width:98%;  
    		margin:0 auto;
    	} 
    </style>
</head> 
<body>  
	<div id="page-inner">
                <div class="row"> 
                    <div class="col-md-12">
                        <h2 class="page-header">
                          	  <small>cyService</small>
                        </h2>
                    </div> 
                </div>
                <div class="row">  
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="panel panel-primary text-center no-boder bg-color-green">
                            <div class="panel-body">
                                <i class="fa fa-users fa-5x"></i>
                                <h3 id="userCount"></h3>
                            </div> 
                            <div class="panel-footer back-footer-green">
                                	注册用户 
                            </div> 
                        </div>
                    </div> 
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="panel panel-primary text-center no-boder bg-color-blue">
                            <div class="panel-body">
                                <i class="fa fa-wrench fa-5x"></i>
                                <h3 id="repairCount"> </h3>
                            </div>
                            <div class="panel-footer back-footer-blue">
                               		 后勤维修
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="panel panel-primary text-center no-boder bg-color-red">
                            <div class="panel-body">
                                <i class="fa fa fa-comments fa-5x"></i>
                                <h3 id="lostCount"></h3>
                            </div>
                            <div class="panel-footer back-footer-red">
                               		 失物招领
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="panel panel-primary text-center no-boder bg-color-brown">
                            <div class="panel-body">
                                <i class="fa fa-users fa-5x"></i>
                                <h3 id="goodsCount"></h3>
                            </div>
                            <div class="panel-footer back-footer-brown">
                                 	二手交易
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-7 col-sm-12 col-xs-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                	维修区域分布 
                            </div>
                            <div class="panel-body"> 
                                <div id="echart1" style="width:100%;height:400px;"></div>
                            </div> 
                        </div> 
                    </div>
                    <div class="col-md-5 col-sm-12  col-xs-12">
                        <div class="panel panel-default">
                            <div class="panel-heading"> 
                                  	维修类别分布 
                            </div> 
                            <div class="panel-body">
                                <div id="echart2" style="width:100%;height:400px;"></div>
                            </div> 
                        </div>
                    </div>
                </div> 
                <!-- /. ROW  -->
				<footer><p><center>Copyright &copy; 2019 Simawenbo All rights reserved.</center></p></footer>
            </div> 
            <!-- /. PAGE INNER  -->
   	    <script type="text/javascript">
		    $.ajax({
				url:"${pageContext.request.contextPath}/repair/findAllCount",
				type:'POST',
				dataType : "json",
				success:function(result){
					$("#userCount").html(result.userCount);
					$("#repairCount").html(result.repairCount);
					$("#lostCount").html(result.lostCount);
					$("#goodsCount").html(result.goodsCount); 
				}
			});	
    
        // 基于准备好的dom，初始化echarts实例 
        var myChart = echarts.init(document.getElementById('echart1'));
        // 指定图表的配置项和数据 
        var option = {
       		color: ['#3398DB'],
       	    tooltip : {
       	        trigger: 'axis',
       	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
       	            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
       	        }
       	    },
       	    grid: {
       	        left: '3%',
       	        right: '4%',
       	        bottom: '3%',
       	        containLabel: true
       	    },
       	    xAxis : [{
       	        data : [],
       	    }],
       	    yAxis : [{ 
   	            type : 'value'
   	        }],
       	    series : [{
   	            type:'bar',
   	            data:[]
       	    }]
        }; 
        $.ajax({
			url:"${pageContext.request.contextPath}/repair/findAreaCount",
			type:'POST',
			dataType : "json",
			success:function(result){
				var names = [];
				var nums = [];
				for(var i=0;i<result.length;i++){
					names.push(result[i].areaItem);
					nums.push(result[i].count);
				}
				myChart.setOption({        //加载数据图表
                    xAxis: {
                        data: names 
                    },
                    series: [{
                        // 根据名字对应到相应的系列
                        name: '维修单数',
                        data: nums
                    }]
                });
			}
		});
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
        
       // 基于准备好的dom，初始化echarts实例
       var myChart2	 = echarts.init(document.getElementById('echart2'));
       var option2 = {
        	    tooltip : {
        	        trigger: 'item',
        	        formatter: "{a} <br/>{b} : {c} ({d}%)"
        	    },
        	    legend: {
        	        orient: 'vertical',
        	        left: 'left',
        	        data: []
        	    },
        	    series: [
        	        {
        	            type: 'pie',
        	            radius : '55%',
        	            center: ['50%', '60%'],
        	            data:[],
        	            itemStyle: {
        	                emphasis: {
        	                    shadowBlur: 10,
        	                    shadowOffsetX: 0,
        	                    shadowColor: 'rgba(0, 0, 0, 0.5)'
        	                }
        	            }
        	        }
        	    ]
        	};
	       $.ajax({
				url:"${pageContext.request.contextPath}/repair/findCategoryCount",
				type:'POST',
				dataType : "json",
				success:function(result){
					var names = [];
					var nums = [];
					for(var i=0;i<result.length;i++){
						names.push(result[i].categoryItem);
						var obj = new Object();
						obj.name = result[i].categoryItem;
						obj.value = result[i].count;
						nums.push(obj);
					}
					myChart2.setOption({        //加载数据图表
					   legend:{
	                       data: names 
	                   },
	                   series: [{
	                       // 根据名字对应到相应的系列
	                       name: '维修单数',
	                       data: nums
	                   }]
	               });
				}
			});
         // 使用刚指定的配置项和数据显示图表。
         myChart2.setOption(option2);
         
	     window.addEventListener("resize", function () {
			myChart.resize();
			myChart2.resize();
		 });
    </script>  
</body> 

</html>