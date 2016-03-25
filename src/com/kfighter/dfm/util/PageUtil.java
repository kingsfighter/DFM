package com.kfighter.dfm.util;

import com.kfighter.dfm.pojo.Page;

public class PageUtil {
	public  static void constructPage(Page page , int totalCount){
		page.setTotalCount(totalCount);
		page.setTotalPage(totalCount % page.getPageSize() == 0 ? totalCount / page.getPageSize() : totalCount / page.getPageSize() + 1);
	}
}
