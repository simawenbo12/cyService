package com.smwb.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class RepairQueryVo {
private String titleVo;
    
    private Integer stateVo;
    
    private Integer aidVo;
    
    private Integer cidVo;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd" ) 
    private Date uptimeStartVo;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd" ) 
    private Date uptimeEndVo;

	public String getTitleVo() {
		return titleVo;
	}

	public void setTitleVo(String titleVo) {
		this.titleVo = titleVo;
	}

	public Integer getStateVo() {
		return stateVo;
	}

	public void setStateVo(Integer stateVo) {
		this.stateVo = stateVo;
	}

	public Integer getAidVo() {
		return aidVo;
	}

	public void setAidVo(Integer aidVo) {
		this.aidVo = aidVo;
	}

	public Integer getCidVo() {
		return cidVo;
	}

	public void setCidVo(Integer cidVo) {
		this.cidVo = cidVo;
	}

	public Date getUptimeStartVo() {
		return uptimeStartVo;
	}

	public void setUptimeStartVo(Date uptimeStartVo) {
		this.uptimeStartVo = uptimeStartVo;
	}

	public Date getUptimeEndVo() {
		return uptimeEndVo;
	}

	public void setUptimeEndVo(Date uptimeEndVo) {
		this.uptimeEndVo = uptimeEndVo;
	}

	@Override
	public String toString() {
		return "RepairQueryVo [titleVo=" + titleVo + ", stateVo=" + stateVo + ", aidVo=" + aidVo + ", cidVo=" + cidVo
				+ ", uptimeStartVo=" + uptimeStartVo + ", uptimeEndVo=" + uptimeEndVo + "]";
	}
    
    
}
