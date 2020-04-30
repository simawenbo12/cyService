package com.smwb.po;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Lost {
    private Integer lid;

    private String title;

    private String content;

    private String name;

    private String telephone;

    private String img;

    @DateTimeFormat(pattern ="yyyy-MM-dd HH:mm:ss") //前端传后端
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8") //后端传前端
    private Date uptime; 

    private Integer state;
    
    private Integer kinds;
    
    private Integer uid;

	public Integer getLid() {
		return lid;
	}

	public void setLid(Integer lid) {
		this.lid = lid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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

	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	
	public Integer getKinds() {
		return kinds;
	}

	public void setKinds(Integer kinds) {
		this.kinds = kinds;
	}

	@Override
	public String toString() {
		return "Lost [lid=" + lid + ", title=" + title + ", content=" + content + ", name=" + name + ", telephone="
				+ telephone + ", img=" + img + ", uptime=" + uptime + ", state=" + state + ", kinds=" + kinds + ", uid="
				+ uid + "]";
	}


}