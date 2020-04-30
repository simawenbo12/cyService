package com.smwb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.smwb.po.Area;

public interface AreaDao {

	public List<Area> findAll();

	public void add(String areaItem);

	public Area findById(int aid);

	public void update(@Param("aid") int aid,@Param("areaItem") String areaItem);

	public void deleteById(int aid);
	
}
