package com.smwb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.smwb.po.Goods;
import com.smwb.po.Lost;

public interface GoodsDao {

	public List<Goods> findAllGoods(Goods goods);
	
	public List<Goods> findAllGoods2();
	
	public Goods findById(Integer gid);

	public void delete(Integer gid);

	public void update(Goods goods);

	public List<Lost> findAll(Goods goods);

	public void addGoods(Goods goods);

	public void complete(@Param("gid")Integer gid,@Param("state")Integer state);

	
}
