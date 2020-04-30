package com.smwb.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smwb.dao.AreaDao;
import com.smwb.po.Area;
import com.smwb.service.AreaService;

@Service
public class AreaServiceImpl implements AreaService {
	
	@Autowired
	public AreaDao areadao;
	
	@Override
	public List<Area> findAll() {
		return areadao.findAll();
	}

	@Override
	public void add(String areaItem) {
		areadao.add(areaItem);
	}

	@Override
	public Area findById(int aid) {
		return areadao.findById(aid);
	}

	@Override
	public void update(int aid, String areaItem) {
		areadao.update(aid,areaItem);
	}

	@Override
	public void deleteById(int aid) {
		areadao.deleteById(aid);
	}
	

	
	
	
}
