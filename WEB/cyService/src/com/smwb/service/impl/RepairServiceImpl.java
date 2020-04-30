package com.smwb.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smwb.dao.RepairDao;
import com.smwb.dao.UserDao;
import com.smwb.po.Progress;
import com.smwb.po.Repair;
import com.smwb.po.User;
import com.smwb.service.RepairService;
import com.smwb.utils.RedisUtils;
import com.smwb.utils.Utils;
import com.smwb.vo.AreaCountVo;
import com.smwb.vo.CategoryCountVo;
import com.smwb.vo.MainCountVo;
import com.smwb.vo.RepairAllVo;
import com.smwb.vo.RepairCountVo;
import com.smwb.vo.RepairQueryVo;
import com.smwb.vo.RepairVo;

@Service
public class RepairServiceImpl implements RepairService {

	@Autowired
	public RepairDao repairDao;
	@Autowired
	public UserDao UserDao;
	
	//条件查找所有维修单
	@Override
	public List<RepairVo> findAll(RepairQueryVo repairQueryVo) {
		return repairDao.findAll(repairQueryVo);
	}
	//修改维修单
	@Override
	public void update(Repair repair) {
		//如果修改为未接单，把维修人取消
		if(repair.getState()==0) {
			repairDao.setStateNull(repair.getRid());
		}
		//判断是否修改了维修状态
		Repair repair2 =repairDao.findById(repair.getRid());
		if(repair.getState()!=repair2.getState()) {
			//设置维修进度
			Progress progress = new Progress();
			progress.setRid(repair.getRid());
			Date date = new Date();
			progress.setUptime(date);
			String state="";
			if(repair.getState()==0) {
				state="未接受";
			}
			if(repair.getState()==1) {
				state="待完工";
				//设置变为已接单的时间
				RedisUtils.set(repair.getRid()+"autoComplete","48hours",48*60*60);
			}
			if(repair.getState()==2) {
				state="已完工";
			}
			if(repair.getState()==3) {
				state="疑难";
			}
			String action ="后勤管理中心变更维修状态为：【"+state+"】。";
			progress.setAction(action);
			repairDao.addProgress(progress);
		}
		
		repairDao.update(repair);
	}
	//维修单修改回显
	@Override
	public Repair findById(String rid) {
		return repairDao.findById(rid);
	}
	//删除维修单
	@Override
	public void delete(String rid) {
		repairDao.delete(rid);
	}
	//指派维修员
	@Override
	public boolean appoint(String rid, Integer uid) {
		int isUpdate=repairDao.appoint(rid,uid);
		if(isUpdate==1) {
			//设置维修进度
			Progress progress = new Progress();
			progress.setRid(rid);
			Date date = new Date();
			progress.setUptime(date);
			User user = UserDao.findById(uid);
			String maintennance="【"+user.getName()+"】【"+user.getTelephone()+"】";
			String action="后勤管理中心指派"+maintennance+"进行维修";
			progress.setAction(action);
			repairDao.addProgress(progress);
			//设置变为已接单的时间
			RedisUtils.set(rid+"autoComplete","48hours",48*60*60);
			return true;
		}else {
			return false;
		}
		
		
	}
	//查找维修单的维修进度
	@Override
	public List<Progress> findProgressById(String rid) {
		List<Progress> progresses = repairDao.findProgressById(rid);
		return progresses;
	}
	//Quartz定时任务 设置超时维修单自动完成
	@Override
	public void autoComplete() {
		//找到所有超过48小时且维修状态为未完成的订单 
		List<Repair> repairs=repairDao.findAutoComplete();
		//设置维修进度
		if(!repairs.isEmpty()) {
			Progress progress = new Progress();
			for(Repair repair:repairs) {
				if(RedisUtils.get(repair.getRid()+"autoComplete")==null) {
					progress.setRid(repair.getRid());
					Date date = new Date();
					progress.setUptime(date);
					String action="用户或维修员超时未确认，系统已自动确认维修完成";
					progress.setAction(action);
					repairDao.addProgress(progress);
					//设置这种订单为已完成
					repairDao.autoComplete(repair.getRid());
				}
			}
		}
	}
	//app端 查找维修单详情
	@Override 
	public RepairAllVo appfindById(String rid) {
		return repairDao.appfindById(rid);
	}
	//app端 维修员接单
	@Override
	public boolean accept(String rid, Integer uid) {
		int isUpdate=repairDao.appoint(rid,uid);
		if(isUpdate==1) {
			//设置维修进度
			Progress progress = new Progress();
			progress.setRid(rid);
			Date date = new Date();
			progress.setUptime(date);
			User user = UserDao.findById(uid);
			String maintennance="【"+user.getName()+"】【"+user.getTelephone()+"】";
			String action="维修员"+maintennance+"在APP端接受维修";
			progress.setAction(action);
			repairDao.addProgress(progress);
			//设置变为已接单的时间
			RedisUtils.set(rid+"autoComplete","48hours",48*60*60);
			return true;
		}else {
			return false;
		}
	}
	//app报修
	@Override
	public void addRepair(Repair repair) {
		//调用工具类的获得主键ID方法
		repair.setRid(Utils.getId());
		//设置报修时间和维修状态
		Date uptime = new Date();
		repair.setUptime(uptime);
		repair.setState(0);
		repairDao.addRepair(repair);
		//设置维修进度
		Progress progress = new Progress();
		progress.setRid(repair.getRid());
		Date date2 = new Date();
		progress.setUptime(date2);
		String action="用户报修，等待维修员接单或后期管理中心指派";
		progress.setAction(action);
		repairDao.addProgress(progress);
		//设置变为已接单的时间
		RedisUtils.set(repair.getRid()+"autoComplete","48hours",48*60*60);
	}
	@Override
	public List<RepairVo> findAllByMy(RepairQueryVo repairQueryVo,Integer uid) {
		return repairDao.findAllByMy(repairQueryVo,uid);
	}
	@Override
	public List<RepairCountVo> findCount(Integer uid) {
		return repairDao.findCount(uid);
	}
	@Override
	public void updateState(String rid, Integer state,Integer uid) {
		//设置维修进度
		Progress progress = new Progress();
		progress.setRid(rid);
		Date date2 = new Date();
		progress.setUptime(date2);
		User user = UserDao.findById(uid);
		String maintennance="【"+user.getName()+"】【"+user.getTelephone()+"】";
		String identity ="";
		if(user.getIdentity()==1) {
			identity="用户";
		}else {
			identity="维修员";
		}
		String actionbefore="";
		if(state==2) {
			actionbefore="确认维修完成";
		}else if(state==3){
			actionbefore="设置维修单为疑难问题，待解决";
		}
		String action=identity+maintennance+"在APP端"+actionbefore;
		progress.setAction(action);
		repairDao.addProgress(progress);
		repairDao.updateState(rid,state);
	}
	@Override
	public List<AreaCountVo> findAreaCount() {
		return repairDao.findAreaCount();
	}
	@Override
	public List<CategoryCountVo> findCategoryCount() {
		return repairDao.findCategoryCount();
	}
	@Override
	public MainCountVo findAllCount() {
		MainCountVo mainCountVo = new MainCountVo();
		mainCountVo.setUserCount(repairDao.findAllUserCount());
		mainCountVo.setRepairCount(repairDao.findAllRepairCount());
		mainCountVo.setLostCount(repairDao.findAllLostCount());
		mainCountVo.setGoodsCount(repairDao.findAllGoodsCount());
		System.out.println("============"+mainCountVo);
		return mainCountVo;
	}
	
} 
