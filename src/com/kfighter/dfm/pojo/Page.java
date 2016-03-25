package com.kfighter.dfm.pojo;

import java.io.File;

import com.kfighter.dfm.util.PropertiesUtils;

public class Page {
	private int currentPage;
	private int pageSize;
	private int totalCount;
	private int totalPage;
	private static int PAGE_SIZE;
	// 获取系统文件根路径
	static {
		PAGE_SIZE = Integer.parseInt(PropertiesUtils.getProperties().getProperty("PAGE_SIZE"));
	}
	public Page() {
		this.currentPage = 1;
		this.pageSize = PAGE_SIZE;
		this.totalCount = 0;
		this.totalPage = 1;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	
	
}
