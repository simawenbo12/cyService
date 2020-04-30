package com.smwb.vo;

public class RepairCountVo {
	private Integer state;
	private Integer count;
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	@Override
	public String toString() {
		return "repairCountVo [state=" + state + ", count=" + count + "]";
	}
	
}
