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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.smwb.po.Lost;
import com.smwb.service.LostService;
@Controller
@RequestMapping("/lost")
public class LostController {
	
	@Autowired
	public LostService lostService;
	
	//查找所有失物招领信息 web端查看所有
	@RequestMapping("/findAllLost")
	public String findAllLost(Integer pageNum,Lost lost,Model model) {
		if(pageNum==null) {
			pageNum=1;
		}
		PageHelper.startPage(pageNum,15);
		List<Lost> lists = lostService.findAll(lost);
		PageInfo<Lost> pageInfo = new PageInfo<Lost>(lists);
		model.addAttribute("pageInfo",pageInfo);
		model.addAttribute("lostVo",lost);
		return "lost";
	}
	//查找所有失物招领信息 web端查看所有
	@RequestMapping("/findAllLost2")
	public String findAllLost2(Integer pageNum,Model model) {
		if(pageNum==null) {
			pageNum=1;
		}
		PageHelper.startPage(pageNum,15);
		List<Lost> lists = lostService.findAll2();
		PageInfo<Lost> pageInfo = new PageInfo<Lost>(lists);
		model.addAttribute("pageInfo",pageInfo);
		return "lost";
	}
	//修改失物招领信息 web端
	@RequestMapping("/update")
	public String update(Lost lost) {
		lostService.update(lost);
		return "forward:findAllLost2"; //如果返回findAllLost 会带有lostVo 所以返回到一个不带模糊查询的视图
	}
	
	//app端显示所有失物招领
	@RequestMapping("/app/findAll")
	@ResponseBody
	public PageInfo<Lost> findAll(Integer pageNum,Lost lost) {
		if(pageNum==null) {
			pageNum=1;
		}
		PageHelper.startPage(pageNum,10);
		List<Lost> lists = lostService.findAll(lost);
		PageInfo<Lost> pageInfo = new PageInfo<Lost>(lists);
		return pageInfo;
	}
	
	//app端 根据id查找某一个失物招领信息
	@RequestMapping("/app/findById")
	@ResponseBody
	public Lost findById(Integer lid) {
		Lost lost = lostService.findById(lid);
		return lost;
	}
	
	//h5+ uplaoder多图上传  在APP端填写失物招领信息 
	@RequestMapping("/app/webuploader")
	public void upload(HttpServletRequest request,Lost lost){
		MultipartHttpServletRequest Murequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> files = Murequest.getFileMap();// 得到文件map对象
		// 设置图片上传路径
		String url = request.getSession().getServletContext().getRealPath("/upload");
		for (MultipartFile file : files.values()) {
			System.out.println("=============="+file.toString());
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
			lost.setImg("upload/"+imgName+"."+imgLastName);
		}
		lostService.addLost(lost);
	}
	
	@RequestMapping("/app/complete")
	public String complete(Integer lid,Integer state) {
		lostService.complete(lid,state);
		return "true";
	}
	
	@RequestMapping("/app/update") 
	public void appupdate(Lost lost,HttpServletRequest request) {
		MultipartHttpServletRequest Murequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> files = Murequest.getFileMap();// 得到文件map对象
		System.out.println("=================="+lost.toString());
		// 设置图片上传路径
		String url = request.getSession().getServletContext().getRealPath("/upload");
		for (MultipartFile file : files.values()) {
			if(!file.isEmpty()) {
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
				lost.setImg("upload/"+imgName+"."+imgLastName);
			}else {
				lost.setImg(lostService.findById(lost.getLid()).getImg());
			}
		}
		lostService.update(lost);
	}
	
	@RequestMapping("/app/delete")
	@ResponseBody
	public String deleteById(Integer lid) {
		lostService.delete(lid);
		return "true";
	}
}	
