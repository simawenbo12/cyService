package com.smwb.utils;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Utils {
	
	//获取维修单主键ID 
	public static String getId() {
		//设置主键 Redis    20190201XXX 前8位日期 后三位自增 001 002 003 004
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String date = sdf.format(new Date());
		long ridLast =RedisUtils.incr(date+"IncrId",24*60*60); //id 为 1 2 3
		DecimalFormat df=new DecimalFormat("000");//三位序列号
		String ridLastThree= df.format(ridLast); //id 格式化为 001 002 003
		System.out.println("======主键为====="+date+ridLastThree);
		String rid =date+ridLastThree;
		return rid;
	}
}
