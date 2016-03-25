package com.kfighter.dfm.dao;

import java.util.List;
import java.util.Map;

import com.kfighter.dfm.pojo.FileInfo;

public class FileDAO extends JdbcBaseDao{
	
	public void add(FileInfo file)
	{
		String sql = "INSERT INTO T_FILE "
			+ "(F_FILE_NAME ,F_RELA_PATH, F_EXTEND_NAME,F_FILE_SIZE,F_UPLOAD_USER,F_UPLOAD_TIME)"
			+ "VALUES(?,?,?,?,?,?)";
		Object [] args = new Object[6];
		args[0] = file.getFileName();
		args[1] = file.getRelaPath();
		args[2] = file.getExtendName();
		args[3] = file.getFileSize();
		args[4] = file.getUploadUser();
		args[5] = file.getUploadTime();
		getJdbcTemplate().update(sql, args);
		String idSql = "SELECT LAST_INSERT_ID()";
		int id = getJdbcTemplate().queryForInt(idSql);
		file.setId(id);
	}
	
	public FileInfo getById(int fid)
	{
		FileInfo file = null;
		String sql = "SELECT * FROM T_FILE T WHERE T.F_ID = ?";
		List<Map> list = getJdbcTemplate().queryForList(sql,new Object[] { fid });
		
		if (null == list || list.size() <= 0) {
			return file;
		} else {
			Map map = list.get(0);
			file = new FileInfo();
			file.setId(Integer.parseInt(map.get("F_ID").toString()));
			file.setFileName(map.get("F_FILE_NAME")==null?"":map.get("F_FILE_NAME").toString());
			file.setRelaPath(map.get("F_RELA_PATH")==null?"":map.get("F_RELA_PATH").toString());
			file.setExtendName(map.get("F_EXTEND_NAME")==null?"":map.get("F_EXTEND_NAME").toString());
			file.setFileSize(Long.parseLong(map.get("F_FILE_SIZE").toString()));
			file.setUploadTime(map.get("F_UPLOAD_TIME")==null?"":map.get("F_UPLOAD_TIME").toString());
			file.setUploadUser(Integer.parseInt(map.get("F_UPLOAD_USER").toString()));
		}
		return file;
	}

	public void delete(int fid) {
		String sql = "DELETE T.* FROM T_FILE T WHERE T.F_ID = ?";
		getJdbcTemplate().update(sql, new Object[]{fid});
	}
}
