package com.smwb.service;

import java.util.List;

import com.smwb.po.Category;

public interface CategoryService {
	
	public List<Category> findAll();

	public void add(String categoryItem);

	public void update(int cid, String categoryItem);

	public Category findById(int cid);

	public void deleteById(int cid);
}
