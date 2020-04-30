package com.smwb.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.smwb.po.User;

public interface UserDao {

	public List<User> findAllUser(User user);

	public List<User> findAllMaintennance();

	public void addUser(User user);

	public List<User> checkUsername(String username);

	public List<User> checkTelephone(String telephone);

	public User findById(Integer uid);

	public void update(User user);

	public void delete(Integer uid);

	public List<User> findAllUser2();

	public void addMaintennance(User user);

	public void updateMaintennance(User user);

	public User login(@Param("username")String username,@Param("password")String password);

	public void updatePwd(@Param("telephone")String telephone,@Param("password")String password);

	public void updateTel(@Param("telephone")String telephone,@Param("uid")String uid);

	public void updateImg(@Param("imgurl")String imgurl,@Param("uid")Integer uid);

	public List<User> loginMain(@Param("username")String username,@Param("password")String password);
}
