package com.smwb.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.smwb.po.Category;
import com.smwb.service.CategoryService;

@Controller
@RequestMapping("/category")
public class CategoryController {
	
	@Autowired
	public CategoryService categoryService;
	
	@RequestMapping("/findAll")
	public String findAll(Model model) {
		List<Category> categorys= categoryService.findAll();
		model.addAttribute("categorys",categorys);
		return "category";
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public String add(String categoryItem) {
		categoryService.add(categoryItem);
		return "true";
	}
	
	@RequestMapping("/findById")
	@ResponseBody
	public Category findById(int cid) {
		Category category = categoryService.findById(cid);
		return category;
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public String add(int cid,String categoryItem) {
		categoryService.update(cid,categoryItem);
		return "true";
	}
	
	@RequestMapping("/deleteById")
	@ResponseBody
	public String deleteById(int cid) {
		categoryService.deleteById(cid);
		return "true";
	}
	// app 查找所有分类
	@RequestMapping("/app/findAll")
	@ResponseBody
	public List<Category> appfindAll() {
		List<Category> categorys= categoryService.findAll();
		return categorys;
	}
}
