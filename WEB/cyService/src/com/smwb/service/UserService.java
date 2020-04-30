package com.smwb.service;

import java.util.List;

import com.smwb.po.User;

public interface UserService {

	public List<User> findAllUser(User user);

	public List<User> findAllMaintennance();

	public void addUser(User user);

	public boolean checkUsername(String username, Integer uid);

	public boolean checkTelephone(String telephone, Integer uid);

	public User findById(Integer uid);

	public void update(User user);

	public void delete(Integer uid);

	public List<User> findAllUser2();

	public void addMaintennance(User user);

	public void updateMaintennance(User user);

	public User login(String username, String password);

	public void update(String telephone, String password);

	public void updateTel(String telephone, String uid);

	public void updateImg(String imgurl,Integer uid);

	public List<User> loginMain(String username, String password);

}
