package com.smwb.po;

public class Area {
    private Integer aid;

    private String areaItem;

	public Integer getAid() {
		return aid;
	}

	public void setAid(Integer aid) {
		this.aid = aid;
	}

	public String getAreaItem() {
		return areaItem;
	}

	public void setAreaItem(String areaItem) {
		this.areaItem = areaItem;
	}

	@Override
	public String toString() {
		return "Area [aid=" + aid + ", areaItem=" + areaItem + "]";
	}

	
}