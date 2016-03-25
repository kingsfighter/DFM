package com.kfighter.dfm.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.ModelAndView;

import com.kfighter.dfm.constant.RequestConstants;
import com.kfighter.dfm.constant.UserConstants;
import com.kfighter.dfm.pojo.Page;
import com.kfighter.dfm.pojo.UserInfo;
import com.kfighter.dfm.pojo.UserQueryBean;
import com.kfighter.dfm.service.FileService;
import com.kfighter.dfm.service.UserService;

public class UserController extends BaseController{
	private static final Logger logger = Logger.getLogger(UserController.class);
	
	private UserService userService;
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	private FileService fileService;
	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}

	/**
	 * 用户管理控制器，默认打开个人资料方法
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	public ModelAndView defaultHandle(HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		return new ModelAndView("modifyUser");
	}
	
	/**
	 * 添加用户
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	public ModelAndView add(HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		String name = req.getParameter("name");
		String username = req.getParameter("username");
		String pwd = req.getParameter("password");
		String pwd1 = req.getParameter("password1");
		String department = req.getParameter("department");
		String projectGroup = req.getParameter("projectGroup");
		String email = req.getParameter("email");
		String isGroup = req.getParameter("isGroup");
		try {
			UserInfo user = new UserInfo();
			user.setDepartment(department);
			user.setEmail(email);
			user.setPassword(pwd);
			int groupId = UserConstants.USER_LEVEL_NORMAL;
			if(null != isGroup && !"".equals(isGroup.trim()))
			{
				groupId = Integer.parseInt(isGroup);
			}
			user.setGroupId(groupId);
			user.setName(name);
			user.setProjectGroup(projectGroup);
			user.setUsername(username);
			userService.addUser(user);
			//创建用户目录
			String dir = fileService.getRootPath() + user.getUsername();
			fileService.createDir(dir);
			outputMsg(res, "<script>alert('添加成功，点击确定跳转到用户列表！');document.location.href='user.do?method=getUserList';</script>");
			return null;
		} catch (Exception e) {
			logger.error("添加用户失败", e);
			outputMsg(res, "<script>alert('添加用户失败，请检查数据正确性，重新添加！');window.history.go(-1)';</script>");
			return null;
		}
		
	}
	
	/**
	 * 获取用户列表
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	public ModelAndView getUserList(HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		String currentPage = req.getParameter("currentPage");
		Page page = new Page();
		if(currentPage == null || "".equals(currentPage.trim()))
		{
			page.setCurrentPage(1);
		}
		else
		{
			page.setCurrentPage(Integer.parseInt(currentPage));
		}
		List<UserInfo> rs = userService.getAllUser(page);
		req.setAttribute("userList", rs);
		req.setAttribute("page", page);
		return new ModelAndView("userList");
	}
	
	
	
	/**
	 * 删除用户
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	public ModelAndView deleteUser(HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		try {
			String delProject = req.getParameter("delProject");
			int uid = Integer.parseInt(req.getParameter("uid"));
			userService.deleteUser(uid,delProject);
			outputMsg(res, "<script>alert('删除用户成功！');document.location.href='user.do?method=getUserList';</script>");
		} catch (Exception e) {
			logger.error("删除用户失败", e);
			outputMsg(res, "<script>alert('删除用户失败，请重试！');window.history.go(-1);</script>");
		}
		return null;
	}
	
	
	/**
	 * 暂停用户
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	public ModelAndView changeUserState(HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		try {
			int uid = Integer.parseInt(req.getParameter("uid"));
			int state = Integer.parseInt(req.getParameter("state"));
			//构造分页参数
			String currentPage = req.getParameter("currentPage");
			userService.changeUserState(uid , state);
			outputMsg(res, "<script>alert('操作用户成功！');document.location.href='user.do?method=getUserList&currentPage="+currentPage+"';</script>");
		} catch (Exception e) {
			logger.error("暂停用户失败", e);
			outputMsg(res, "<script>alert('操作用户失败，请重试！');window.history.go(-1);</script>");
		}
		return null;
	}
	
	/**
	 * 获取修改用户界面
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	public ModelAndView getModifyUser(HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		int uid = 0 ;
		String ustr = req.getParameter("uid");
		if(ustr == null || "".equals(ustr))
		{
			uid = getUserInfo(req).getId();
		}else
		{
			uid = Integer.parseInt(ustr);
		}
		 
		UserInfo user = userService.getUserById(uid);
		req.setAttribute("user", user);
		return new ModelAndView("modifyUser");
	}
	
	
	public ModelAndView modifyUser(HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		String id = req.getParameter("id");
		String name = req.getParameter("name");
		String username = req.getParameter("username");
		String pwd = req.getParameter("password");
		String pwd1 = req.getParameter("password1");
		String department = req.getParameter("department");
		String projectGroup = req.getParameter("projectGroup");
		String email = req.getParameter("email");
		UserInfo user1 = getUserInfo(req);
		try {
			UserInfo user = new UserInfo();
			user.setId(Integer.parseInt(id));
			user.setDepartment(department);
			user.setEmail(email);
			user.setPassword(pwd);
			user.setGroupId(UserConstants.USER_LEVEL_NORMAL);
			user.setName(name);
			user.setProjectGroup(projectGroup);
			user.setUsername(username);
			userService.updateUser(user);
			if(UserConstants.USER_LEVEL_ADMIN == user1.getGroupId())
			{
				outputMsg(res, "<script>alert('修改成功，点击确定跳转到用户列表！');document.location.href='user.do?method=getUserList';</script>");
			}
			else
			{
				outputMsg(res, "<script>alert('修改成功，点击确定跳转项目提交页面！');document.location.href='project.do?method=getAddPage';</script>");
			}
			
			return null;
		} catch (Exception e) {
			logger.error("修改用户失败", e);
			outputMsg(res, "<script>alert('修改用户失败，请检查数据正确性，重新添加！');window.history.go(-1)';</script>");
			return null;
		}
	}
	
	public ModelAndView queryUser(HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		
		String name = req.getParameter("name");
		String username = req.getParameter("username");
		String department = req.getParameter("department");
		String projectGroup = req.getParameter("projectGroup");
		String state = req.getParameter("state");
		
		UserQueryBean queryBean = new UserQueryBean();
		queryBean.setDepartment(department);
		queryBean.setName(name);
		queryBean.setProjectGroup(projectGroup);
		queryBean.setState(state);
		queryBean.setUsername(username);
		
		//构造分页参数
		String currentPage = req.getParameter("currentPage");
		Page page = new Page();
		if(currentPage == null || "".equals(currentPage.trim()))
		{
			page.setCurrentPage(1);
		}
		else
		{
			page.setCurrentPage(Integer.parseInt(currentPage));
		}
		List<UserInfo> list = userService.getByQueryBean(queryBean , page);
		req.setAttribute("page", page);
		req.setAttribute("userList", list);
		return new ModelAndView("userList");
		
		
	}
	
	
}
