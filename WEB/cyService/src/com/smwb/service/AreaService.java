package com.smwb.service;

import java.util.List;

import com.smwb.po.Area;

public interface AreaService {

	public List<Area> findAll();

	public void add(String areaItem);

	public Area findById(int aid);

	public void update(int aid, String areaItem);

	public void deleteById(int aid);

	
}
