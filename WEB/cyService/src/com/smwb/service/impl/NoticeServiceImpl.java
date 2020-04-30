package com.smwb.service.impl;


import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smwb.dao.NoticeDao;
import com.smwb.po.Notice;
import com.smwb.service.NoticeService;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	public NoticeDao noticeDao;

	@Override
	public List<Notice> findAll() {
		List<Notice> notices = noticeDao.findAll();
		return notices;
	}

	@Override
	public void add(Notice notice) {
		Date date = new Date();
		notice.setUptime(date);
		noticeDao.add(notice);
	}

	@Override
	public void update(Notice notice) {
		noticeDao.update(notice);
	}

	@Override
	public Notice findById(Integer nid) {
		return noticeDao.findById(nid);
	}

	@Override
	public void delete(Integer nid) {
		noticeDao.delete(nid);
	}
}
