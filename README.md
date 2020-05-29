# cyService

#### 介绍
大学时期给学校后勤管理中心开发的项目，最后没有上线。

城市学院移动后勤   有APP端(webapp)和WEB端（PC）  

后端使用技术    spring springmvc mybatis redis mysql quartz

前端使用技术    mui  vue ueditor echart


quartz 用于定时检测超时维修单。

redis 用于记录短信验证码 生成日期+流水号id 配合quartz自动完成超时维修单。 


前端要用hbuilder 想要运行APP（IOS或安卓），请把web打包成app 才能运行。
短信验证码用的是榛子云短信  要运行请换成自己的。