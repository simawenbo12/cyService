package com.smwb.service;

import java.util.List;
import java.util.Map;

import com.smwb.po.Progress;
import com.smwb.po.Repair;
import com.smwb.vo.AreaCountVo;
import com.smwb.vo.CategoryCountVo;
import com.smwb.vo.MainCountVo;
import com.smwb.vo.RepairAllVo;
import com.smwb.vo.RepairCountVo;
import com.smwb.vo.RepairQueryVo;
import com.smwb.vo.RepairVo;

public interface RepairService {

	public List<RepairVo> findAll(RepairQueryVo repairQueryVo);

	public void update(Repair repair);

	public Repair findById(String rid);

	public void delete(String rid);

	public boolean appoint(String rid, Integer uid);

	public List<Progress> findProgressById(String rid);

	public void autoComplete();

	public RepairAllVo appfindById(String rid);

	public boolean accept(String rid, Integer uid);

	public void addRepair(Repair repair);

	public List<RepairVo> findAllByMy(RepairQueryVo repairQueryVo, Integer uid);

	public List<RepairCountVo> findCount(Integer uid);

	public void updateState(String rid, Integer state,Integer uid);

	public List<AreaCountVo> findAreaCount();

	public List<CategoryCountVo> findCategoryCount();

	public MainCountVo findAllCount();
	
}
