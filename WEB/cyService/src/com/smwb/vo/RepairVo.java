package com.smwb.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class RepairVo {
	
	private String rid;

    private String title;

    private String areaItem;
    
    private String categoryItem;
    
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    private Date uptime;

    private Integer state;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAreaItem() {
		return areaItem;
	}

	public void setAreaItem(String areaItem) {
		this.areaItem = areaItem;
	}

	public String getCategoryItem() {
		return categoryItem;
	}

	public void setCategoryItem(String categoryItem) {
		this.categoryItem = categoryItem;
	}

	public Date getUptime() {
		return uptime;
	}

	public void setUptime(Date uptime) {
		this.uptime = uptime;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	@Override
	public String toString() {
		return "RepairVo [rid=" + rid + ", title=" + title + ", areaItem=" + areaItem + ", categoryItem=" + categoryItem
				+ ", uptime=" + uptime + ", state=" + state + "]";
	}
    
 
    
}
