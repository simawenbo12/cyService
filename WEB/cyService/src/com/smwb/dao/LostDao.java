package com.smwb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.smwb.po.Lost;

public interface LostDao {

	public List<Lost> findAll(Lost lost);
	
	public Lost findById(Integer lid);

	public void addLost(Lost lost);

	public void update(Lost lost);

	public void delete(Integer lid);

	public void complete(@Param("lid")Integer lid,@Param("state")Integer state);

	public List<Lost> findAll2();
	
}
