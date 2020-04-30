package com.smwb.service;

import java.util.List;

import com.smwb.po.Notice;

public interface NoticeService {

	public List<Notice> findAll();

	public void add(Notice notice);

	public void update(Notice notice);

	public Notice findById(Integer nid);

	public void delete(Integer nid);
}
