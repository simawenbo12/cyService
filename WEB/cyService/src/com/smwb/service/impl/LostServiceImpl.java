package com.smwb.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smwb.dao.LostDao;
import com.smwb.po.Lost;
import com.smwb.service.LostService;
@Service
public class LostServiceImpl implements LostService {

	@Autowired
	public LostDao lostDao;

	@Override
	public List<Lost> findAll(Lost lost) {
		return lostDao.findAll(lost);
	}

	@Override
	public Lost findById(Integer lid) {
		return lostDao.findById(lid);
	}

	@Override
	public void addLost(Lost lost) {
		lost.setState(0);
		Date date = new Date();
		lost.setUptime(date);
		lostDao.addLost(lost);
	}

	@Override
	public void update(Lost lost) {
		lostDao.update(lost);
	}

	@Override
	public void delete(Integer lid) {
		lostDao.delete(lid);
	}

	@Override
	public void complete(Integer lid, Integer state) {
		lostDao.complete(lid,state);
	}

	@Override
	public List<Lost> findAll2() {
		return lostDao.findAll2();
	}

	
}
