package com.smwb.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.smwb.po.Progress;
import com.smwb.po.Repair;
import com.smwb.vo.AreaCountVo;
import com.smwb.vo.CategoryCountVo;
import com.smwb.vo.MainCountVo;
import com.smwb.vo.RepairAllVo;
import com.smwb.vo.RepairCountVo;
import com.smwb.vo.RepairQueryVo;
import com.smwb.vo.RepairVo;



public interface RepairDao {

	public List<RepairVo> findAll(RepairQueryVo repairQueryVo);

	public void update(Repair repair);

	public Repair findById(String rid);

	public void delete(String rid);

	public int appoint(@Param("rid")String rid,@Param("uid")Integer uid);

	public void setStateNull(String rid);

	public List<Progress> findProgressById(String rid);

	public void addProgress(Progress progress);

	public void autoComplete(String rid);

	public List<Repair> findAutoComplete();

	public RepairAllVo appfindById(String rid);

	public void addRepair(Repair repair);

	public List<RepairVo> findAllByMy(@Param("repairQueryVo")RepairQueryVo repairQueryVo,@Param("uid")Integer uid);

	public List<RepairCountVo> findCount(Integer uid);

	public void updateState(@Param("rid")String rid,@Param("state")Integer state);

	public List<AreaCountVo> findAreaCount();

	public List<CategoryCountVo> findCategoryCount();
	
	public Integer findAllUserCount();

	public Integer findAllRepairCount();

	public Integer findAllLostCount();

	public Integer findAllGoodsCount();
	
	
}
