package com.smwb.po;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Goods {
    private Integer gid;

    private String title;

    private String content;
    
    private Double price;

    private String name;

    private String telephone;

    private String img;
    
    @DateTimeFormat(pattern ="yyyy-MM-dd HH:mm:ss") //前端传后端
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8") //后端传前端
    private Date uptime;

    private Integer state;

    private Integer uid;

	public Integer getGid() {
		return gid;
	}

	public void setGid(Integer gid) {
		this.gid = gid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
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

	

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	@Override
	public String toString() {
		return "Goods [gid=" + gid + ", title=" + title + ", content=" + content + ", price=" + price + ", name=" + name
				+ ", telephone=" + telephone + ", img=" + img + ", uptime=" + uptime + ", state=" + state + ", uid="
				+ uid + ", getGid()=" + getGid() + ", getTitle()=" + getTitle() + ", getPrice()=" + getPrice()
				+ ", getName()=" + getName() + ", getTelephone()=" + getTelephone() + ", getImg()=" + getImg()
				+ ", getUptime()=" + getUptime() + ", getContent()=" + getContent() + ", getState()=" + getState()
				+ ", getUid()=" + getUid() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}
    
}