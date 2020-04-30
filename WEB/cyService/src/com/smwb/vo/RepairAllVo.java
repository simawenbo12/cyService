package com.smwb.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class RepairAllVo {
    private String rid;

    private String title;

    private String content;
    
    private Integer homestart;

    private String areaItem;

    private String address;

    private String categoryItem;

    private String name;

    private String telephone;

    private String img;

    
    @DateTimeFormat(pattern ="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date uptime;
    
    private Integer state;
    
    private Integer uid;

    private Integer mid;
    
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getHomestart() {
		return homestart;
	}

	public void setHomestart(Integer homestart) {
		this.homestart = homestart;
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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
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

	public Integer getUid() {
		return uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}

	public Integer getMid() {
		return mid;
	}

	public void setMid(Integer mid) {
		this.mid = mid;
	}

	@Override
	public String toString() {
		return "RepairAllVo [rid=" + rid + ", title=" + title + ", content=" + content + ", homestart=" + homestart
				+ ", areaItem=" + areaItem + ", address=" + address + ", categoryItem=" + categoryItem + ", name="
				+ name + ", telephone=" + telephone + ", img=" + img + ", uptime=" + uptime + ", state=" + state
				+ ", uid=" + uid + ", mid=" + mid + ", getRid()=" + getRid() + ", getTitle()=" + getTitle()
				+ ", getContent()=" + getContent() + ", getHomestart()=" + getHomestart() + ", getAreaItem()="
				+ getAreaItem() + ", getCategoryItem()=" + getCategoryItem() + ", getAddress()=" + getAddress()
				+ ", getName()=" + getName() + ", getTelephone()=" + getTelephone() + ", getImg()=" + getImg()
				+ ", getUptime()=" + getUptime() + ", getState()=" + getState() + ", getUid()=" + getUid()
				+ ", getMid()=" + getMid() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}

	
}
