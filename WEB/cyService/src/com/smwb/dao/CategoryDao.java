package com.smwb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.smwb.po.Category;

public interface CategoryDao {
	
	public List<Category> findAll();

	public void add(String categoryItem);

	public void update(@Param("cid") int cid,@Param("categoryItem") String categoryItem);

	public Category findById(int cid);

	public void deleteById(int cid);
}
