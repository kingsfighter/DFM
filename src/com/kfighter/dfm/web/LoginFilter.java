package com.kfighter.dfm.web;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.kfighter.dfm.pojo.UserInfo;

public class LoginFilter implements Filter {

	FilterConfig filterConfig;

	public void destroy() {
		
	}

	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpSession session = request.getSession(false);
		RequestDispatcher dispatcher = request
				.getRequestDispatcher("/login.jsp");

		if (filterConfig.getInitParameter("loginURL").equals(request.getRequestURI().trim())) {
			chain.doFilter(req, resp);// 初始页面没有user，要让他通过
										// ？？？或者要用静态属性
			return;

		}
		if (session == null)
			dispatcher.forward(req, resp); // user 为 null，转发到login.jsp
		else {
			UserInfo user = (UserInfo) session.getAttribute("user");
			if (user == null)
				dispatcher.forward(req, resp); // user 为 null,转发到login.jsp
			else
				chain.doFilter(req, resp); // user 不为 null，继续

		}

	}

	public void init(FilterConfig arg0) throws ServletException {
		filterConfig = arg0;
	}

}
