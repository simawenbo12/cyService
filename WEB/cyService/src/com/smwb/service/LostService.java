package com.smwb.service;

import java.util.List;

import com.smwb.po.Lost;

public interface LostService {

	public List<Lost> findAll(Lost lost);

	public Lost findById(Integer lid);

	public void addLost(Lost lost);

	public void update(Lost lost);

	public void delete(Integer lid);

	public void complete(Integer lid,Integer state);

	public List<Lost> findAll2();

	
}
