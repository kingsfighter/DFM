package com.kfighter.dfm.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.kfighter.dfm.pojo.MenuInfo;

public class MenuDAO extends JdbcBaseDao {

	/**
	 * 根据用户组获取菜单列表
	 * 
	 * @param groupId
	 * @return
	 */
	public List<MenuInfo> getByGroup(int groupId) {
		String sql = "SELECT T1.* FROM t_menu_list T1 , t_menu_group_dz T2 "
				+ "WHERE T1.F_ID = T2.F_MENU_ID AND T2.F_GROUP_ID = ?";
		List<MenuInfo> rs = null;
		List<Map> dbRs = getJdbcTemplate().queryForList(sql, new Object[]{groupId});
		if(null == dbRs || dbRs.isEmpty())
		{
			return rs;
		}
		rs = new ArrayList<MenuInfo>();
		for(int i=0;i<dbRs.size();i++)
		{
			Map map = dbRs.get(i);
			MenuInfo menu = new MenuInfo();
			menu.setId(Integer.parseInt(map.get("F_ID").toString()));
			menu.setUrl(map.get("F_URL")==null?"":map.get("F_URL").toString());
			menu.setMenuName(map.get("F_MENU_NAME")==null?"":map.get("F_MENU_NAME").toString());
			menu.setMenuLevel(Integer.parseInt(map.get("F_NEMU_LEVEL").toString()));
			menu.setParentId(map.get("F_PARENT_ID") == null ?0:Integer.parseInt(map.get("F_PARENT_ID").toString()));
			rs.add(menu);
		}
		return rs;
	}
}
