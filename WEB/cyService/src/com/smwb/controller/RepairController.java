package com.smwb.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.smwb.po.Area;
import com.smwb.po.Category;
import com.smwb.po.Progress;
import com.smwb.po.Repair;
import com.smwb.po.User;
import com.smwb.service.AreaService;
import com.smwb.service.CategoryService;
import com.smwb.service.RepairService;
import com.smwb.service.UserService;
import com.smwb.vo.AreaCountVo;
import com.smwb.vo.CategoryCountVo;
import com.smwb.vo.MainCountVo;
import com.smwb.vo.RepairAllVo;
import com.smwb.vo.RepairCountVo;
import com.smwb.vo.RepairQueryVo;
import com.smwb.vo.RepairVo;
import com.zhenzi.sms.ZhenziSmsClient;

@Controller
@RequestMapping("/repair")
public class RepairController {
	
	@Autowired
	public CategoryService categoryService;
	@Autowired
	public AreaService areaService;
	@Autowired
	public RepairService repairService;
	@Autowired
	public UserService userService;
	
	//发送短信必须的变量
	private String apiUrl = "http://sms_developer.zhenzikj.com";
	private String appId = "100424";
	private String appSecret = "0fbe1bb0-658d-4a66-b089-53906a3dcdf8";
	
	//在执行此Controller层中每一个方法之前 执行此方法 
	@ModelAttribute("categorys")
	public List<Category> loadCategorys(){
		List<Category> categorys = categoryService.findAll();
		return categorys;
	}
	@ModelAttribute
	public void loadAreas(Model model){
		List<Area> areas = areaService.findAll();
		model.addAttribute("areas",areas);
	}
	//查询所有维修单
	@RequestMapping("/findAll")
	public String findAll(Integer pageNum,RepairQueryVo repairQueryVo,Model model) {
		if(pageNum==null) {
			pageNum=1;
		}
		PageHelper.startPage(pageNum,15);
		List<RepairVo> repairVos = repairService.findAll(repairQueryVo);
		PageInfo<RepairVo> pageInfo = new PageInfo<RepairVo>(repairVos);
		model.addAttribute("pageInfo",pageInfo);
		model.addAttribute("RepairQueryVo",repairQueryVo);
		return "repair";
	}
	//修改维修单的回显 ,
	@RequestMapping("/findById")
	@ResponseBody
	public Repair findById(String rid) {
		Repair repair = repairService.findById(rid);
		return repair;
	}
	//修改维修单
	@RequestMapping("/update")
	@ResponseBody
	public String update(Repair repair,Model model) {
		repairService.update(repair);
		return "true";
	}
	//删除维修单
	@RequestMapping("/deleteById")
	@ResponseBody
	public String deleteById(String rid) {
		repairService.delete(rid);
		return "true";
	}
	//指派维修员 发送短信在controller层 添加维修进度在service层
	@RequestMapping("/appoint")
	@ResponseBody
	public String appoint(String rid,Integer uid){
		boolean isUpdate = repairService.appoint(rid,uid);
		if(isUpdate) {
			try {
				//rid 维修单号 uid 维修员号    telephone  aid address
				Repair repair = repairService.findById(rid);
				Area area = areaService.findById(repair.getAid());
				//查询该维修员信息
				User user =userService.findById(uid);
				String maintennance=user.getName()+"("+user.getUsername()+")";
				String title=repair.getTitle();
				String address=area.getAreaItem()+" "+repair.getAddress();
				//发送短信通知维修员
				ZhenziSmsClient client = new ZhenziSmsClient(apiUrl,appId,appSecret);
				client.send(user.getTelephone(),maintennance+",后勤管理中心已为您派单。位置："+address+"，问题："+title+"。请登录APP查看详情");
				//发送短信通知用户
				client.send(repair.getTelephone(),"您的报修已被受理，维修员："+user.getName()+",联系电话:"+user.getTelephone()+"。48小时自动确认维修完成");
				
			} catch (Exception e) {
				e.printStackTrace();
			} 
			return "true";
		}else {
			return "false";
		}
	}
	//查询维修进度 &app端
	@RequestMapping("/findProgressById")
	@ResponseBody
	public List<Progress> findProgressById(String rid){
		List<Progress> progresses = repairService.findProgressById(rid);
		return progresses;
	}
	//app查询所有维修单 
	@RequestMapping("/app/findAll")
	@ResponseBody
	public PageInfo<RepairVo> appfindAll(Integer pageNum,RepairQueryVo repairQueryVo){
		if(pageNum==null) {
			pageNum=1;
		}
		PageHelper.startPage(pageNum,20);
		List<RepairVo> lists = repairService.findAll(repairQueryVo);
		PageInfo<RepairVo> pageInfo = new PageInfo<RepairVo>(lists);
		return pageInfo;
	}
	//app查询 我的维修单
	@RequestMapping("/app/findAllByMy")
	@ResponseBody
	public PageInfo<RepairVo> appfindAllByMy(Integer pageNum,RepairQueryVo repairQueryVo,Integer uid){
		if(pageNum==null) {
			pageNum=1;
		}
		PageHelper.startPage(pageNum,20);
		List<RepairVo> lists = repairService.findAllByMy(repairQueryVo,uid);
		PageInfo<RepairVo> pageInfo = new PageInfo<RepairVo>(lists);
		return pageInfo;
	}
	//app查询维修单详情
	@RequestMapping("/app/findById")
	@ResponseBody
	public RepairAllVo appfindById(String rid) {
		RepairAllVo repairAllVo = repairService.appfindById(rid);
		return repairAllVo;
	}
	//app维修员接单
	@RequestMapping("/app/accept")
	@ResponseBody
	public String appaccept(String rid,Integer uid,String telephone) {
		boolean isUpdate = repairService.accept(rid,uid);
		if(isUpdate) {
			try {
				//rid 维修单号 uid 维修员号  telephone 维修员电话  准备三个数据 
				Repair repair = repairService.findById(rid);
				//查询该维修员信息
				User user =userService.findById(uid);
				ZhenziSmsClient client = new ZhenziSmsClient(apiUrl,appId,appSecret);
				//发送短信通知用户
				client.send(repair.getTelephone(),"您的报修已被受理，维修员："+user.getName()+",联系电话:"+user.getTelephone()+"。48小时自动确认维修完成");
			} catch (Exception e) {
				e.printStackTrace();
			} 
			return "true";
		}else {
			return "false";
		}
	}
	//h5+ uplaoder多图上传  在APP端报修 若有图片上传 调用此
	@RequestMapping("/app/webuploader")
	public void upload(HttpServletRequest request, HttpServletResponse response,Repair repair){
		MultipartHttpServletRequest Murequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> files = Murequest.getFileMap();// 得到文件map对象
		// 设置图片上传路径
		String url = request.getSession().getServletContext().getRealPath("/upload");
		for (MultipartFile file : files.values()) {
			// 设置文件名
			String imgName = UUID.randomUUID().toString().replace("-", "");
			// 获取文件后缀 getOriginalFIlename()方法可以得到文件全名
			String imgLastName = FilenameUtils.getExtension(file.getOriginalFilename());
			try {
				file.transferTo(new File(url + "/" + imgName + "." + imgLastName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			repair.setImg("upload/"+imgName+"."+imgLastName);
		}
		repairService.addRepair(repair); 
	}
	
	//分组统计各种维修状态
	@RequestMapping("/app/findCount")
	@ResponseBody
	public List<RepairCountVo> findCount(Integer uid) {
		List<RepairCountVo> list = repairService.findCount(uid);
		return list;
	}
	//分组统计维修区域分布
	@RequestMapping("/findAreaCount")
	@ResponseBody
	public List<AreaCountVo> findAreaCount() {
		List<AreaCountVo> list = repairService.findAreaCount();
		return list;
	}
	//分组统计维修区域分布
	@RequestMapping("/findCategoryCount")
	@ResponseBody
	public List<CategoryCountVo> findCategoryCount() {
		List<CategoryCountVo> list = repairService.findCategoryCount();
		return list;
	}
	//首页 所有项目的 总数   用户，维修， 失物招领， 二手市场
	@RequestMapping("/findAllCount")
	@ResponseBody
	public MainCountVo findAllCount() {
		MainCountVo mainCountVo = repairService.findAllCount();
		return mainCountVo;
	}
	
	//app改变维修状态
	@RequestMapping("/app/updateState")
	@ResponseBody
	public void updateState(String rid,Integer state,Integer uid) {
		repairService.updateState(rid,state,uid);
	}
	
}
