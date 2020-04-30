package com.smwb.controller;

import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {
	
	//主页
	@RequestMapping("/")
	public String Index() {
		return "index";
	}
	
	//后台登录页
	@RequestMapping("/admin")
	public String toLogin() {
		return "login";
	}
	
	//总后台页面
	@RequestMapping("/main")
	public String toMain(){
		return "main";
	}
	
	//后台主页
	@RequestMapping("/home")
	public String home(){
		return "home";
	}
	
	//退出登录
	@RequestMapping("exitLogin")
	public String exitLogin(HttpServletRequest request) {
		request.getSession().removeAttribute("LOGIN_USER");
		return "login";
	}
	

}
