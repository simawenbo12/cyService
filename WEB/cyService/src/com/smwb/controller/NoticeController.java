package com.smwb.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.smwb.po.Notice;
import com.smwb.service.NoticeService;

// 公告通知
@Controller
@RequestMapping("/notice")
public class NoticeController{
	
	@Autowired
	public NoticeService noticeService;
	
	//查询所有通知
	@RequestMapping("/findAll")
	public String findAll(Integer pageNum,Model model) {
		if(pageNum==null) {
			pageNum=1;
		}
		PageHelper.startPage(pageNum,15);
		List<Notice> notices = noticeService.findAll();
		PageInfo<Notice> pageInfo = new PageInfo<Notice>(notices);
		model.addAttribute("pageInfo",pageInfo);
		return "notice";
	}
	//添加通知
	@RequestMapping("/add")
	public String add(Notice notice,MultipartFile file,HttpServletRequest request) {
		if(!file.isEmpty()){
			//设置图片上传路径
			String url = request.getSession().getServletContext().getRealPath("/upload");
			//设置文件名
			String imgName = UUID.randomUUID().toString().replace("-","");
			//获取文件后缀   getOriginalFIlename()方法可以得到文件全名  
			String imgLastName = FilenameUtils.getExtension(file.getOriginalFilename());
			//以绝对路径保存重名命后的图片
			try {
				file.transferTo(new File(url+"/"+imgName + "." + imgLastName));
			} catch (IOException e) {
				e.printStackTrace();
			}
			notice.setImg("upload/"+imgName+"."+imgLastName);
		}
		noticeService.add(notice);
		return "forward:findAll";
	}
	//修改通知
	@RequestMapping("/update")
	public String update(Notice notice,MultipartFile file,HttpServletRequest request) {
		System.out.println("============"+notice.toString());
		if(!file.isEmpty()){
			//设置图片上传路径
			System.out.println("======0======"+notice.toString());
			String url = request.getSession().getServletContext().getRealPath("/upload");
			//设置文件名
			String imgName = UUID.randomUUID().toString().replace("-","");
			//获取文件后缀   getOriginalFIlename()方法可以得到文件全名  
			String imgLastName = FilenameUtils.getExtension(file.getOriginalFilename());
			//以绝对路径保存重名命后的图片
			try {
				file.transferTo(new File(url+"/"+imgName + "." + imgLastName));
			} catch (IOException e) {
				e.printStackTrace();
			}
			System.out.println("=====1======="+notice.toString());
			notice.setImg("upload/"+imgName+"."+imgLastName);
		}else {
			notice.setImg(noticeService.findById(notice.getNid()).getImg());
		}
		System.out.println("=====2======="+notice.toString());
		noticeService.update(notice);
		return "forward:findAll";
	}
	//修改通知的回显
	@RequestMapping("/findById")
	@ResponseBody
	public Notice findById(Integer nid) {
		Notice notice =noticeService.findById(nid);
		return notice;
	}
	//删除通知
	@RequestMapping("/delete")
	@ResponseBody
	public String delete(Integer nid) {
		noticeService.delete(nid);
		return "true";
	}
	//app显示所有通知
	@RequestMapping("/app/findAll")
	@ResponseBody
	public List<Notice> appfindAll() {
		List<Notice> notices = noticeService.findAll();
		return notices;
	}
	//最新更新
	@RequestMapping("/app/update")
	@ResponseBody
	public Map<String,String> appupdate(){
		Map<String,String> map = new HashMap<>();
		map.put("valid","已是最新版本");
		return map;
	}
	
}
