package com.smwb.controller;

import java.util.List;

import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;

import org.apache.commons.io.FilenameUtils;
import org.aspectj.weaver.ast.Var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.smwb.po.Repair;
import com.smwb.po.User;
import com.smwb.service.UserService;
import com.smwb.utils.RedisUtils;
import com.zhenzi.sms.ZhenziSmsClient;

@Controller
@RequestMapping("/user")
public class UserController {
	
	//发短信用的
	private String apiUrl = "http://sms_developer.zhenzikj.com";
	private String appId = "100424";
	private String appSecret = "0fbe1bb0-658d-4a66-b089-53906a3dcdf8";
	
	@Autowired
	public UserService userService;
	
	
	//后台登录验证
	@RequestMapping("/loginMain")
	@ResponseBody
	public String loginMain(HttpServletRequest request,String username,String password) {
		List<User> user = userService.loginMain(username,password);
		if(user.isEmpty()) {
			return "false";
		}else {
			HttpSession session = request.getSession();
			session.setAttribute("LOGIN_USER", true);
			session.setMaxInactiveInterval(60*60*6); // 设置生存时间为6小时
			return "true";
		}
	}
	
	//查找所有用户 web端查看所有用户
	@RequestMapping("/findAllUser")
	public String findAllUser(Integer pageNum,User user,Model model) {
		if(pageNum==null) {
			pageNum=1;
		}
		PageHelper.startPage(pageNum,15);
		List<User> users = userService.findAllUser(user);
		PageInfo<User> pageInfo = new PageInfo<User>(users);
		model.addAttribute("pageInfo",pageInfo);
		model.addAttribute("userVo",user);
		return "user";
	}
	//查找所有用户 修改回显所返回的视图层 （没有多条件查找的userVo返回） web端
	@RequestMapping("/findAllUser2")
	public String findAllUser2(Integer pageNum,Model model) {
		if(pageNum==null) {
			pageNum=1;
		}
		PageHelper.startPage(pageNum,15);
		List<User> users = userService.findAllUser2();
		PageInfo<User> pageInfo = new PageInfo<User>(users);
		model.addAttribute("pageInfo",pageInfo);
		return "user";
	}
	//注册用户 web端
	@RequestMapping("/addUser")
	public String addUser(User user) {
		userService.addUser(user);
		return "forward:findAllUser2";
	}
	//bootstrapvalidate ajax验证 &app端
	@RequestMapping("/checkUsername")
	@ResponseBody
	public Map<String,Boolean> checkUsername(String username,Integer uid) {
		Map<String, Boolean> map = new HashMap<>();
		if (userService.checkUsername(username,uid)) {  //用户名可用
            map.put("valid", true);
        } else {
            map.put("valid", false);
        }
        return map;
	}
	//bootstrapvalidate ajax验证 &app端
	@RequestMapping("/checkTelephone")
	@ResponseBody
	public Map<String,Boolean> checkTelephone(String telephone,Integer uid){
		Map<String, Boolean> map = new HashMap<>();
		if (userService.checkTelephone(telephone,uid)) { //用户名可用
            map.put("valid", true);
        } else {
            map.put("valid", false);
        }
        return map;
	}
	//用户和维修员的修改回显 &app端
	@RequestMapping("/findById")
	@ResponseBody
	public User findById(Integer uid){
	    User user =	userService.findById(uid);
		return user;
	}
	@RequestMapping("/update")
	public String update(User user,Integer uid) {
		userService.update(user);
		return "forward:findAllUser2";  //如果返回findAllUser 会带有userVo 所以返回到一个不带模糊查询的视图
	}
	//用户和维修员的删除
	@RequestMapping("/delete")
	@ResponseBody
	public String delete(Integer uid) {
		userService.delete(uid);
		return "true";
	}
	//维修员 web端查看所有维修员
	@RequestMapping("/findAllMaintennance")
	public String findAllMaintennance(User user,Model model) {
		List<User> users = userService.findAllMaintennance();
		model.addAttribute("maintennances",users);
		return "maintennance";
	}
	//ajax返回所有维修员 web端指派维修员
	@RequestMapping("/findAllMaintennance2")
	@ResponseBody
	public List<User> findAllMaintennance2(User user) {
		List<User> users = userService.findAllMaintennance();
		return users;
	}
	//添加维修员
	@RequestMapping("/addMaintennance")
	public String addMaintennance(User user,Model model) {
		userService.addMaintennance(user);
		return "forward:findAllMaintennance";
	}
	//修改维系员
	@RequestMapping("/updateMaintennance")
	public String updateMaintennance(User user) {
		userService.updateMaintennance(user);
		return "forward:findAllMaintennance";
	}
	//app端 登录
	@RequestMapping("app/login")
	@ResponseBody
	public User login(String username,String password) {
		User user = userService.login(username,password);
		return user;
	}
	//app端 获取验证码  注册 忘记密码
	@RequestMapping("/app/sendCode")
	@ResponseBody
	public String sendCode(String telephone) {
		try {
			//生成验证码
			String verifyCode = String.valueOf(new Random().nextInt(899999)+100000);
			//验证码发送至手机号
			ZhenziSmsClient client = new ZhenziSmsClient(apiUrl,appId,appSecret);
			client.send(telephone,"您的验证码为 "+verifyCode+" ,5分钟内输入有效");
			//将验证码放入redis中
			RedisUtils.set(telephone+"checkCode",verifyCode,5*60);
			//session.setAttribute("verifyLoginTime",System.currentTimeMillis());
			return "true";
		} catch (Exception e) {
			return "false";
		}
	}
	//app端 注册 忘记密码
	@RequestMapping("/app/regUser")
	@ResponseBody
	public Map<String, String> regUser(String loginCode,User user){
		String verifyCode = RedisUtils.get(user.getTelephone()+"checkCode");
		Map<String,String> map = new HashMap<>();
		if(ObjectUtils.isEmpty(verifyCode)){
			map.put("valid","验证码不存在或已过期，请重新输入");
		}else if(!verifyCode.equals(loginCode)){
			map.put("valid","验证码错误");
		}else {
			if(!ObjectUtils.isEmpty(user.getUsername())) { 
				//如果有用户名就是注册 没有就是忘记密码  找回密码不执行此步骤
				userService.addUser(user);
			}
			map.put("valid", "true");
		}
		return map;
	}
	//app端  修改密码
	@RequestMapping("/app/updatePwd")
	@ResponseBody
	public void updatePwd(String telephone,String password){
		userService.update(telephone,password);
	}
	//app端 修改手机号
	@RequestMapping("/app/updateTelephone")
	@ResponseBody
	public Map<String, String> updateTelephone(String telephone,String uid,String loginCode){
		String verifyCode = RedisUtils.get(telephone+"checkCode");
		Map<String,String> map = new HashMap<>();
		if(ObjectUtils.isEmpty(verifyCode)){
			map.put("valid","验证码不存在或已过期，请重新输入");
		}else if(!verifyCode.equals(loginCode)){
			map.put("valid","验证码错误");
		}else {
			userService.updateTel(telephone,uid);
			map.put("valid", "true");
		}
		return map;
	}
	//app端 用户上传头像
	@RequestMapping("/app/userimg")
	public void userimg(HttpServletRequest request, HttpServletResponse response,Integer uid) {
		MultipartHttpServletRequest Murequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> files = Murequest.getFileMap();// 得到文件map对象
		System.out.println("======uid=="+files.toString());
		// 设置图片上传路径
		String url = request.getSession().getServletContext().getRealPath("/upload");
		// 设置用户img属性
		String imgurl;
		for (MultipartFile file : files.values()) {
			System.out.println("======uid=="+file.toString());
			// 设置文件名
			String imgName = UUID.randomUUID().toString().replace("-", "");
			// 获取文件后缀 getOriginalFIlename()方法可以得到文件全名
			String imgLastName = FilenameUtils.getExtension(file.getOriginalFilename());
			try {
				file.transferTo(new File(url + "/" + imgName + "." + imgLastName));
				imgurl="upload/"+imgName+"."+imgLastName;
				userService.updateImg(imgurl,uid);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
	}
}
