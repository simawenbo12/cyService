package com.smwb.service;

import java.util.List;

import com.smwb.po.Goods;
import com.smwb.po.Lost;

public interface GoodsService {

	public List<Goods> findAllGoods(Goods goods);

	public Goods findById(Integer gid);

	public void delete(Integer gid);

	public List<Goods> findAllGoods2();

	public void update(Goods goods);

	public List<Lost> findAll(Goods goods);

	public void addGoods(Goods goods);

	public void complete(Integer gid, Integer state);
	
}
