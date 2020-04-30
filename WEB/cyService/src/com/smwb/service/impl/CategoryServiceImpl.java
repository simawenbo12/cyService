package com.smwb.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smwb.dao.CategoryDao;
import com.smwb.po.Category;
import com.smwb.service.CategoryService;

@Service
public class CategoryServiceImpl implements CategoryService {
	
	@Autowired
	public CategoryDao categoryDao;
	
	@Override
	public List<Category> findAll(){
		return categoryDao.findAll();
	}

	@Override
	public void add(String categoryItem) {
		categoryDao.add(categoryItem);
	}

	@Override
	public void update(int cid, String categoryItem) {
		categoryDao.update(cid,categoryItem);
	}

	@Override
	public Category findById(int cid) {
		return categoryDao.findById(cid);
	}

	@Override
	public void deleteById(int cid) {
		categoryDao.deleteById(cid);
	}
	
	
	
}
