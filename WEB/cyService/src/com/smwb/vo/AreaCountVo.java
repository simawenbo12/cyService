package com.smwb.vo;

public class AreaCountVo {
	private String areaItem;
	private Integer count;
	public String getAreaItem() {
		return areaItem;
	}
	public void setAreaItem(String areaItem) {
		this.areaItem = areaItem;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	@Override
	public String toString() {
		return "AreaCountVo [areaItem=" + areaItem + ", count=" + count + "]";
	}
}
