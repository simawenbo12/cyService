package com.smwb.po;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Notice {
    private Integer nid;

    private String title;

    @DateTimeFormat(pattern ="yyyy-MM-dd HH:mm:ss") //前端传后端
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8") //后端传前端
    private Date uptime;

    private String content;
    
    private String img;
    
	public Integer getNid() {
		return nid;
	}

	public void setNid(Integer nid) {
		this.nid = nid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	@Override
	public String toString() {
		return "Notice [nid=" + nid + ", title=" + title + ", uptime=" + uptime + ", content=" + content + ", img="
				+ img + "]";
	}
    
}