package com.smwb.vo;

public class MainCountVo {
	private Integer userCount;
	private Integer repairCount;
	private Integer lostCount;
	private Integer goodsCount;
	
	public Integer getUserCount() {
		return userCount;
	}
	public void setUserCount(Integer userCount) {
		this.userCount = userCount;
	}
	public Integer getRepairCount() {
		return repairCount;
	}
	public void setRepairCount(Integer repairCount) {
		this.repairCount = repairCount;
	}
	public Integer getLostCount() {
		return lostCount;
	}
	public void setLostCount(Integer lostCount) {
		this.lostCount = lostCount;
	}
	public Integer getGoodsCount() {
		return goodsCount;
	}
	public void setGoodsCount(Integer goodsCount) {
		this.goodsCount = goodsCount;
	}
	@Override
	public String toString() {
		return "MainCountVo [userCount=" + userCount + ", repairCount=" + repairCount + ", lostCount=" + lostCount
				+ ", goodsCount=" + goodsCount + "]";
	}
	
	
}
