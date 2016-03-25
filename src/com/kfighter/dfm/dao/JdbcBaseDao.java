package com.kfighter.dfm.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.PreparedStatementCallback;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.jdbc.support.lob.LobHandler;

/**
 * 
 * @author
 *
 */
public class JdbcBaseDao extends JdbcDaoSupport {
	
	protected static final Logger log = Logger.getLogger(JdbcBaseDao.class);
	
	
	/**
	 * 设置 LOB 处理器
	 */
	private LobHandler lobHandler ;

	public LobHandler getLobHandler() {
		return lobHandler;
	}
	public void setLobHandler(LobHandler lobHandler) {
		this.lobHandler = lobHandler;
	}

	/**
	 * 构造方法
	 */
	public JdbcBaseDao(){}
	
	/**
	 * 执行查询，返回Map结果集的List
	 * 
	 * @param sql sql文本
	 * @param args 参数数组，注意与sql语句里面的排序对应, 无参数传null
	 * @return Map结果集的List，List存放的是多个数据库列和值的Map
	 */
	public List queryForList(String sql, Object[] args) throws DataAccessException	{
		return getJdbcTemplate().queryForList(sql, args);
	}
	
	/**
	 * 提供一个参数执行查询
	 * @param sql
	 * @return
	 * @throws DataAccessException
	 * <ul>
	 *  <li>邹美亮,2008/01/08 PM,查询话单业务分类信息列表</li>
	 * </ul> 
	 */
	public List queryForList(String sql) throws DataAccessException	{
		return getJdbcTemplate().queryForList(sql);
	}
	
	/**
	 * 执行查询象，返回Map结果集
	 * 
	 * @param sql sql文本
	 * @param args  参数数组，注意与sql语句里面的排序对应, 无参数传null
	 * @return 数据库列和值的Map
	 * @throws SQLException
	 */
	public Map queryForMap(String sql, Object[] args) throws DataAccessException {
		
		return (args == null) ? getJdbcTemplate().queryForMap(sql) : 
				getJdbcTemplate().queryForMap(sql, args);
	}
	
	/**
	 * 执行单一值查询
	 * 
	 * @param sql sql文本
	 * @param args 参数数组，注意与sql语句里面的排序对应, 无参数传null
	 * @param requiredType 该值的类型
	 * @return 单一值
	 */
	public Object queryForObject(String sql, Object[] args, Class requiredType) throws DataAccessException	{
		return (args == null) ? getJdbcTemplate().queryForObject(sql, requiredType) : 
				getJdbcTemplate().queryForObject(sql, args, requiredType);
	}
	
	/**
	 * 执行单一值查询
	 * 
	 * @param sql sql文本
	 * @param args 参数数组，注意与sql语句里面的排序对应, 无参数传null
	 * @return long
	 * @throws SQLException
	 */
	public long queryForLong(String sql, Object[] args) throws DataAccessException	{
		return (args == null) ? getJdbcTemplate().queryForLong(sql) : 
			getJdbcTemplate().queryForLong(sql, args);
	}
	
	/**
	 * 执行单一值查询
	 * 
	 * @param sql sql文本
	 * @param args 参数数组，注意与sql语句里面的排序对应, 无参数传null
	 * @return int
	 * @throws SQLException
	 */
	public int queryForInt(String sql, Object[] args) throws SQLException	{
		return (args == null) ? getJdbcTemplate().queryForInt(sql) : 
			getJdbcTemplate().queryForInt(sql, args);
	}
	
	public int update(String sql, Object[] args) {
		return (args == null) ? getJdbcTemplate().update(sql) : 
			getJdbcTemplate().update(sql, args);
	}
	
	/**
	 * 执行无返回结果集的SQL，返回影响行数
	 * 
	 * @param sql  sql文本
	 * @param args 参数数组，注意与sql语句里面的排序对应, 无参数传null
	 * @return 影响行数
	 */
	public Object execute(String sql, final Object[] args) throws DataAccessException, SQLException	{
		return this.getJdbcTemplate().execute(sql, new PreparedStatementCallback() {
				public Object doInPreparedStatement(PreparedStatement ps) 
					throws SQLException, DataAccessException {				
					
					if(args != null) {
						for(int i = 0; i < args.length; i++) {
							ps.setObject(i+1, args[i]);
						}
					}
					return ps.executeUpdate();
				}	
			}	
		);
	}
	
	

	public int updateForClob(String sql, Object[] args) throws DataAccessException {
		
		int  intResult = 0;
		try {
			String className = "";
			int[] argTypes = new int[args.length];
			for(int i=0; i<args.length; i++){
				className = args[i].getClass().getName();
				if(className.indexOf("String")>0){
					argTypes[i] = Types.VARCHAR;
				}else if (className.indexOf("Long")>0  
						|| className.indexOf("Integer")>0
						|| className.indexOf("Double")>0 
						|| className.indexOf("Float")>0) {
					argTypes[i] = Types.NUMERIC;					
				}else if(className.indexOf("SqlLobValue")>0 ){
					argTypes[i] = Types.CLOB;
				}else{
					argTypes[i] = Types.VARCHAR;
				}
			}
			intResult = this.getJdbcTemplate().update(sql, args, argTypes);
		} catch (Exception e) {
			e.printStackTrace();
			intResult = -1;
		}
		return intResult;
	}
	
	/**
	 * 获取含有CLOB、BLOB字段内容表数据 String
	 * @param sql
	 * @param args
	 * @return
	 * @throws DataAccessException
	 */
	public Map queryClobToStringForMap(String sql, Object[] args) throws DataAccessException {
		Map mapResult = null;
		try {
			mapResult = (Map)this.getJdbcTemplate().queryForObject(sql, args, new RowMapper(){
				public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
					Map<String, String> mapRs = new HashMap<String, String>();
					ResultSetMetaData metaData =rs.getMetaData();	
					for(int num=1 ; num<=metaData.getColumnCount(); num++){
						if(metaData.getColumnType(num)==Types.CLOB){
							mapRs.put(metaData.getColumnName(num).toLowerCase(), lobHandler.getClobAsString(rs, num));
						}else{
							mapRs.put(metaData.getColumnName(num).toLowerCase(), rs.getString(num));
						}
					}
					return mapRs;
				}
			});
		} catch (DataAccessException da) {
			mapResult = null;
		} catch (Exception e) {
			mapResult = null;
		}
		return mapResult;
	}
	
	/**
     * 带Clob字段的查询
     * @param sql
     * @param args
     * @return
     */
    protected List queryForClob(String sql,Object[] args)
    {
    	return this.getJdbcTemplate().query(sql,args,new RowMapper(){
			public Object mapRow(ResultSet resultset, int i) throws SQLException
			{
				Map<String,String> retMap = new HashMap<String,String>();
				
				ResultSetMetaData metaData = resultset.getMetaData();
				for(int num = 1; num <= metaData.getColumnCount(); num++)
				{
					if(metaData.getColumnType(num) == Types.CLOB)
					{
						retMap.put(metaData.getColumnName(num).toLowerCase(), getLobHandler().getClobAsString(resultset, num));
					}
					else
					{
						retMap.put(metaData.getColumnName(num).toLowerCase(), resultset.getString(num));
					}
				}
				return retMap;
			}});
    }
    
    /**
     * 带Clob字段的查询
     * @param sql
     * @return
     */
    protected List queryForClob(String sql)
    {
    	return this.queryForClob(sql, null);
    }


	
	
	
	
}
