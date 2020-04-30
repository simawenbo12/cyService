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
import com.smwb.po.Goods;
import com.smwb.po.Lost;
import com.smwb.service.GoodsService;

@Controller
@RequestMapping("/goods")
public class GoodsController {
	
	@Autowired
	public GoodsService goodsService;

	@RequestMapping("/findAllGoods")
	public String findAllGoods(Integer pageNum,Goods goods,Model model) {
		if(pageNum==null) {
			pageNum=1;
		}
		PageHelper.startPage(pageNum,15);
		List<Goods> lists = goodsService.findAllGoods(goods);
		PageInfo<Goods> pageInfo = new PageInfo<Goods>(lists);
		model.addAttribute("pageInfo",pageInfo);
		model.addAttribute("goodsVo",goods);
		return "goods";
	}
	@RequestMapping("/findAllGoods2")
	public String findAllGoods2(Integer pageNum,Model model) {
		System.out.println("=========2===");
		if(pageNum==null) {
			pageNum=1;
		}
		PageHelper.startPage(pageNum,15);
		List<Goods> lists = goodsService.findAllGoods2();
		PageInfo<Goods> pageInfo = new PageInfo<Goods>(lists);
		model.addAttribute("pageInfo",pageInfo);
		return "goods";
	}
	@RequestMapping("/findById")
	@ResponseBody
	public Goods findById(Integer gid){
		Goods goods =goodsService.findById(gid);
		return goods;
	}
	
	//app端 web端 删除二手信息
	@RequestMapping("/delete")
	@ResponseBody
	public String delete(Integer gid) {
		goodsService.delete(gid);
		return "true";
	}
	
	@RequestMapping("/update")
	public String update(Goods goods) {
		goodsService.update(goods);
		return "forward:findAllGoods2";
	}
	
	//app端显示所有二手交易
	@RequestMapping("/app/findAll")
	@ResponseBody
	public PageInfo<Lost> findAll(Integer pageNum,Goods goods) {
		if(pageNum==null) {
			pageNum=1;
		}
		PageHelper.startPage(pageNum,10);
		List<Lost> lists = goodsService.findAll(goods);
		PageInfo<Lost> pageInfo = new PageInfo<Lost>(lists);
		return pageInfo;
	}
	
	//app端 修改二手商品已完成
	@RequestMapping("/app/complete")
	public String complete(Integer gid,Integer state) {
		goodsService.complete(gid,state);
		return "true";
	}
	
	//h5+ uplaoder多图上传  在APP端填写二手信息
	@RequestMapping("/app/webuploader")
	public void upload(HttpServletRequest request, HttpServletResponse response,Goods goods){
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
			goods.setImg("upload/"+imgName+"."+imgLastName);
		}
		goodsService.addGoods(goods);
	}
	@RequestMapping("/app/update") 
	public void appupdate(Goods goods,HttpServletRequest request) {
		MultipartHttpServletRequest Murequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> files = Murequest.getFileMap();// 得到文件map对象
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
				goods.setImg("upload/"+imgName+"."+imgLastName);
			}else {
				goods.setImg(goodsService.findById(goods.getGid()).getImg());
			}
		}
		goodsService.update(goods);
	}
}	
