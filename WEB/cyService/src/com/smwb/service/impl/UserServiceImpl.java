package com.smwb.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smwb.dao.UserDao;
import com.smwb.po.User;
import com.smwb.service.UserService;



@Service
public class UserServiceImpl implements UserService {

	@Autowired
	public UserDao userDao;
	
	@Override
	public List<User> findAllUser(User user) {
		List<User> users = userDao.findAllUser(user);
		return users;
	} 
	
	@Override
	public List<User> findAllMaintennance() {
		List<User> users = userDao.findAllMaintennance();
		return users;
	}

	@Override
	public void addUser(User user) {
		user.setIdentity(1);                   //设置身份为用户
		userDao.addUser(user);
	}

	@Override
	public boolean checkUsername(String username,Integer uid) {
		List<User> users =userDao.checkUsername(username);
		if(users.isEmpty()||users.get(0).getUid().equals(uid)) { //用户名可用 修改时要把自身忽略
			return true;
		}
		return false;
	}

	@Override
	public boolean checkTelephone(String telephone,Integer uid) {
		List<User> users =userDao.checkTelephone(telephone);
		if(users.isEmpty()||users.get(0).getUid().equals(uid)) { //修改时要把自身忽略
			return true;
		}
		return false;
	}

	@Override
	public User findById(Integer uid) {
		return userDao.findById(uid);
	}

	@Override
	public void update(User user) {
		userDao.update(user);
	}

	@Override
	public void delete(Integer uid) {
		userDao.delete(uid);
	}

	@Override
	public List<User> findAllUser2() {
		return userDao.findAllUser2();
	}

	@Override
	public void addMaintennance(User user) {
		user.setIdentity(2);                    //设置身份为维修员
		userDao.addMaintennance(user);
	}

	@Override
	public void updateMaintennance(User user) {
		userDao.updateMaintennance(user);
	}

	@Override
	public User login(String username, String password) {
		return userDao.login(username,password);
	}

	@Override
	public void update(String telephone, String password) {
		userDao.updatePwd(telephone,password);
	}

	@Override
	public void updateTel(String telephone, String uid) {
		userDao.updateTel(telephone,uid);
	}

	@Override
	public void updateImg(String imgurl,Integer uid) {
		userDao.updateImg(imgurl,uid);
	}

	@Override
	public List<User> loginMain(String username, String password) {
		return userDao.loginMain(username,password);
	}

	
}
