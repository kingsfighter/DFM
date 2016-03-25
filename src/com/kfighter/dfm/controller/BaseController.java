package com.kfighter.dfm.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.kfighter.dfm.pojo.UserInfo;

public class BaseController extends MultiActionController{
	
	protected void outputMsg(HttpServletResponse res , String msg) throws Exception
	{
		PrintWriter out = res.getWriter();
		res.setContentType("text/html");
		res.setCharacterEncoding("utf-8");
		out.write(msg);
		out.flush();
		out.close();
	}
	
	protected void outputJson(HttpServletResponse res , String msg) throws Exception
	{
		PrintWriter out = res.getWriter();
		res.setContentType("text/json");
		res.setCharacterEncoding("utf-8");
		out.write(msg);
		out.flush();
		out.close();
	}
	
	
	protected UserInfo getUserInfo(HttpServletRequest req) 
	{
		UserInfo user = null;
		user = (UserInfo)req.getSession().getAttribute("user");
		return user;
	}
}
