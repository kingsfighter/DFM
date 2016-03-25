package com.kfighter.dfm.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;

import com.kfighter.dfm.constant.UserConstants;
import com.kfighter.dfm.pojo.MenuInfo;
import com.kfighter.dfm.pojo.UserInfo;
import com.kfighter.dfm.service.LoginService;
import com.kfighter.dfm.service.MenuService;

/**
 * 登录控制器
 * @author Kfighter
 *
 */
public class LoginController extends BaseController {

	private static final Logger logger = Logger.getLogger(LoginController.class);
	
	private LoginService loginService;
	public void setLoginService(LoginService loginService) {
		this.loginService = loginService;
	}
	private MenuService menuService;
	public void setMenuService(MenuService menuService) {
		this.menuService = menuService;
	}


	/**
	 * 获取登录界面
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	public ModelAndView defaultHandle(HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		logger.debug("请求登录");
		return new ModelAndView("login");
	}
	
	
	public ModelAndView login(HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		logger.debug("有用户登录……");
		String username = req.getParameter("username");
		String pwd = req.getParameter("password");
		if(username == null || pwd == null || "".equals(username.trim()) || "".equals(pwd.trim()))
		{
			outputMsg(res, "<script>alert('对不起，用户名或密码不能为空，请重新登录！');document.location.href='login.do';</script>");
			return null;
		}
		UserInfo user = loginService.checkUser(username, pwd);
		if(null != user)
		{
			if(UserConstants.USER_STATUS_ZANTING == user.getStatus())
			{
				outputMsg(res, "<script>alert('对不起，您的帐户已被暂停，请联系管理员！');document.location.href='login.do';</script>");
				return null;
			}
			
			logger.debug("用户：" + user.getUsername() + " 登录成功！");
			req.getSession().setAttribute("user", user);
			List<MenuInfo> menus = menuService.getMenuByUser(user);
			req.getSession().setAttribute("menus", menus);
			return new ModelAndView("index");
		}
		else
		{
			outputMsg(res, "<script>alert('对不起，您的用户名或密码有误，请重新登录！');document.location.href='login.do';</script>");
			return null;
		}
		
	}
	
}
