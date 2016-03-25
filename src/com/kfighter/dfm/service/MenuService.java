package com.kfighter.dfm.service;

import java.util.List;

import org.apache.log4j.Logger;

import com.kfighter.dfm.dao.MenuDAO;
import com.kfighter.dfm.pojo.MenuInfo;
import com.kfighter.dfm.pojo.UserInfo;

public class MenuService {
	private static final Logger logger = Logger.getLogger(MenuService.class);
	
	private MenuDAO menuDAO;
	public void setMenuDAO(MenuDAO menuDAO) {
		this.menuDAO = menuDAO;
	}
	

	/**
	 * 根据用户ID获取该用户拥有的菜单列表
	 * @return
	 */
	public List<MenuInfo> getMenuByUser(UserInfo user)
	{
		return menuDAO.getByGroup(user.getGroupId());
	}
}
