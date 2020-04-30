package com.smwb.utils;

import org.springframework.beans.factory.annotation.Autowired;

import com.smwb.service.RepairService;

/**
 * @author 司马文铂
 * Quartz定时任务 
 * 2019/1/17
 */
public class QuartzJob {
	
	@Autowired
	public RepairService repairService;
	
	//执行任务的方法
	public void execute() {
		System.out.println("quartz任务调度:超时自动确认维修完成（每5分钟执行一次）");
		//设置未完成的维修单在48小时后自动完成
		repairService.autoComplete();
	}
}
