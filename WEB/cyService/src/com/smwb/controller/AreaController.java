package com.smwb.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.smwb.po.Area;
import com.smwb.service.AreaService;

@Controller
@RequestMapping("/area")
public class AreaController {
	
	@Autowired
	public AreaService areaService;
	
	@RequestMapping("/findAll")
	public String findAll(Model model) {
		List<Area> areas=areaService.findAll();
		model.addAttribute("areas",areas);
		return "area";
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public String add(String areaItem) {
		areaService.add(areaItem);
		return "true";
	}
	
	@RequestMapping("/findById")
	@ResponseBody
	public Area findById(int aid) {
		Area area = areaService.findById(aid);
		return area;
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public String update(int aid,String areaItem) {
		areaService.update(aid,areaItem);
		return "true";
	}
	
	@RequestMapping("/deleteById")
	@ResponseBody
	public String deleteById(int aid) {
		areaService.deleteById(aid);
		return "true";
	}
	
	//app查找所有区域
	@RequestMapping("/app/findAll")
	@ResponseBody
	public List<Area> appfindAll(Model model) {
		List<Area> areas=areaService.findAll();
		return areas;
	}
}
