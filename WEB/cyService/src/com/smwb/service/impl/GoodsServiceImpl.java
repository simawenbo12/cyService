package com.smwb.service.impl;


import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smwb.dao.GoodsDao;
import com.smwb.po.Goods;
import com.smwb.po.Lost;
import com.smwb.service.GoodsService;

@Service
public class GoodsServiceImpl implements GoodsService {

	@Autowired
	public GoodsDao goodsDao;

	@Override
	public List<Goods> findAllGoods(Goods goods) {
		return goodsDao.findAllGoods(goods);
	}
	
	@Override
	public List<Goods> findAllGoods2() {
		return goodsDao.findAllGoods2();
	}
	
	@Override
	public Goods findById(Integer gid) {
		return goodsDao.findById(gid);
	}

	@Override
	public void delete(Integer gid) {
		goodsDao.delete(gid);
	}

	@Override
	public void update(Goods goods) {
		goodsDao.update(goods);
	}

	@Override
	public List<Lost> findAll(Goods goods) {
		return goodsDao.findAll(goods);
	}

	@Override
	public void addGoods(Goods goods) {
		goods.setState(0);
		Date date = new Date();
		goods.setUptime(date);
		goodsDao.addGoods(goods);
	}

	@Override
	public void complete(Integer gid, Integer state) {
		goodsDao.complete(gid,state);
	}

	

	
}
