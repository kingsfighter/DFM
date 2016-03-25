package com.kfighter.dfm.service;

import org.apache.log4j.Logger;

import com.kfighter.dfm.controller.LoginController;
import com.kfighter.dfm.dao.UserDAO;
import com.kfighter.dfm.pojo.UserInfo;

public class LoginService {

	private static final Logger logger = Logger.getLogger(LoginService.class);
	private UserDAO userDAO;

	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}

	public UserInfo checkUser(String username, String pwd) {
		return userDAO.checkUser(username, pwd);
	}

}
