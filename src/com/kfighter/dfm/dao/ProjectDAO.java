package com.kfighter.dfm.dao;

import com.kfighter.dfm.pojo.Page;
import com.kfighter.dfm.pojo.Project;
import com.kfighter.dfm.pojo.ProjectQueryBean;
import com.kfighter.dfm.pojo.ProjectStage;
import com.kfighter.dfm.util.PageUtil;
import com.kfighter.dfm.util.TimeUtil;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.JdbcTemplate;

public class ProjectDAO extends JdbcBaseDao
{
  private static final Logger logger = Logger.getLogger(ProjectDAO.class);

  public void add(Project project)
  {
    String sql = "INSERT INTO T_PROJECT (F_PROJECT_NAME ,F_VERSION, F_PCB_FILE,F_BOM_FILE,F_CHECK_TYPE,F_DFM_CHECK,F_PCB_TYPE,F_HDI_Model ,F_Board_Thickness, F_Panel_Model,F_Max_Heigh_Top,F_SubPCB_Num,F_Max_Heigh_Bot ,F_Railway_Position, F_Viacap_layer,F_Assembly_Process_Top,F_Have_Pb ,F_Assembly_Process_Bot, F_Surface_Process,F_Direction_Top,F_Primary_Side,F_Direction_Bot, F_Direction_Bot_Fs ,F_Density,F_SUBMIT_USER, F_SUBMIT_TIME,F_STATE,F_PRI ,F_FILE_RESULT, F_SERVER,F_PCB_FILE_NAME,F_BOM_FILE_NAME,F_SUBMIT_USERNAME)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

    Object[] args = new Object[33];
    args[0] = project.getProjectName();
    args[1] = Integer.valueOf(project.getVersion());
    args[2] = Integer.valueOf(project.getPcbFile());
    args[3] = Integer.valueOf(project.getBomFile());
    args[4] = Integer.valueOf(project.getCheckType());
    args[5] = project.getDfmCheck();
    args[6] = Integer.valueOf(project.getPcbType());
    args[7] = Integer.valueOf(project.getHdiModel());
    args[8] = Float.valueOf(project.getBoardThickness());
    args[9] = Integer.valueOf(project.getPanelModel());
    args[10] = Float.valueOf(project.getMaxHeightTop());
    args[11] = Integer.valueOf(project.getSubPcbNum());
    args[12] = Float.valueOf(project.getMaxHeightBot());
    args[13] = Integer.valueOf(project.getRailwayPosition());
    args[14] = Integer.valueOf(project.getViacapLayer());
    args[15] = Integer.valueOf(project.getAssemblyProcessTop());
    args[16] = Integer.valueOf(project.getHavePb());
    args[17] = Integer.valueOf(project.getAssemblyProcessBot());
    args[18] = Integer.valueOf(project.getSurfaceProcess());
    args[19] = Integer.valueOf(project.getDirectionTop());
    args[20] = Integer.valueOf(project.getPrimarySide());
    args[21] = Integer.valueOf(project.getDirectionBot());
    args[22] = Integer.valueOf(project.getDirectionBotFs());
    args[23] = project.getDensity();
    args[24] = Integer.valueOf(project.getSubmitUser());
    args[25] = project.getSubmitTime();
    args[26] = project.getState();

    args[27] = Integer.valueOf(project.getPri());
    args[28] = project.getResultFile();
    args[29] = project.getServer();

    args[30] = project.getPcbFileName();
    args[31] = project.getBomFileName();
    args[32] = project.getSubmitUserName();
    getJdbcTemplate().update(sql, args);
  }

  public Project getById(int id)
  {
    String sql = "SELECT * FROM T_PROJECT T WHERE T.F_ID = ?";
    List list = getJdbcTemplate().queryForList(sql, new Object[] { Integer.valueOf(id) });
    Project rs = null;
    if ((list == null) || (list.size() <= 0))
    {
      return null;
    }

    Map map = (Map)list.get(0);
    rs = map2Bean(map);

    return rs;
  }

  public List<Project> getByStates(String[] states, Page page, ProjectQueryBean queryBean)
  {
    int totalCount = getCountByStates(states, queryBean);
    int start = (page.getCurrentPage() - 1) * page.getPageSize();
    String sql = "SELECT * FROM T_PROJECT T WHERE T.F_STATE IN ('-1'";
    for (int i = 0; i < states.length; ++i)
    {
      sql = sql + ",'" + states[i] + "'";
    }
    sql = sql + ") ";

    List params = new ArrayList();
    if (queryBean != null)
    {
      sql = constructConditionSql(queryBean, sql, params);
    }

    for (String state : states)
    {
      if ("完成".equals(state))
      {
        sql = sql + " ORDER BY T.F_END_TIME DESC limit ?,?";
        break;
      }
      if (!("在查".equals(state)))
        continue;
      sql = sql + " ORDER BY T.F_PRI ASC limit ?,?";
      break;
    }

    params.add(Integer.valueOf(start));
    params.add(Integer.valueOf(page.getPageSize()));
    List<Project> list = getJdbcTemplate().queryForList(sql, params.toArray());
    List<Project> rs = null;
    if ((list == null) || (list.size() <= 0)) {
      return rs;
    }
    rs = new ArrayList();
    for (int k = 0; k < list.size(); ++k)
    {
      Map map = (Map)list.get(k);
      ((List)rs).add(map2Bean(map));
    }

    PageUtil.constructPage(page, totalCount);
    return ((List<Project>)rs);
  }

  private int getCountByStates(String[] states, ProjectQueryBean queryBean)
  {
    String sql = "SELECT COUNT(*) FROM T_PROJECT T WHERE T.F_STATE IN ('-1'";
    for (int i = 0; i < states.length; ++i)
    {
      sql = sql + ",'" + states[i] + "'";
    }
    sql = sql + ")";
    List params = new ArrayList();
    if (queryBean != null)
    {
      sql = constructConditionSql(queryBean, sql, params);
    }
    return getJdbcTemplate().queryForInt(sql, params.toArray());
  }

  public Project getLastVersion(int uid, String projectName)
  {
    String sql = "select t1.* from T_PROJECT t1 where t1.f_version = (SELECT max(t.f_version) FROM T_PROJECT T WHERE T.F_SUBMIT_USER = ? AND T.F_PROJECT_NAME = ?) and T1.F_SUBMIT_USER = ? AND T1.F_PROJECT_NAME = ?";
    List list = getJdbcTemplate().queryForList(sql, new Object[] { Integer.valueOf(uid), projectName, Integer.valueOf(uid), projectName });
    if ((list != null) && (!(list.isEmpty())))
    {
      return map2Bean((Map)list.get(0));
    }
    return null;
  }

  private Project map2Bean(Map map)
  {
    Project project = new Project();
    project.setId(Integer.parseInt(map.get("F_ID").toString()));
    project.setProjectName((map.get("F_PROJECT_NAME") == null) ? "" : map.get("F_PROJECT_NAME").toString());
    project.setVersion((map.get("F_VERSION") == null) ? 0 : Integer.parseInt(map.get("F_VERSION").toString()));
    project.setPcbFile((map.get("F_PCB_FILE") == null) ? 0 : Integer.parseInt(map.get("F_PCB_FILE").toString()));
    project.setBomFile((map.get("F_BOM_FILE") == null) ? 0 : Integer.parseInt(map.get("F_BOM_FILE").toString()));
    project.setCheckType((map.get("F_CHECK_TYPE") == null) ? 0 : Integer.parseInt(map.get("F_CHECK_TYPE").toString()));
    project.setDfmCheck((map.get("F_DFM_CHECK") == null) ? "" : map.get("F_DFM_CHECK").toString());
    project.setPcbType((map.get("F_PCB_TYPE") == null) ? 0 : Integer.parseInt(map.get("F_PCB_TYPE").toString()));
    project.setHdiModel((map.get("F_HDI_Model") == null) ? 0 : Integer.parseInt(map.get("F_HDI_Model").toString()));
    project.setBoardThickness((map.get("F_Board_Thickness") == null) ? 0.0F : Float.parseFloat(map.get("F_Board_Thickness").toString()));
    project.setPanelModel((map.get("F_Panel_Model") == null) ? 0 : Integer.parseInt(map.get("F_Panel_Model").toString()));
    project.setMaxHeightTop((map.get("F_Max_Heigh_Top") == null) ? 0.0F : Float.parseFloat(map.get("F_Max_Heigh_Top").toString()));
    project.setSubPcbNum((map.get("F_SubPCB_Num") == null) ? 0 : Integer.parseInt(map.get("F_SubPCB_Num").toString()));
    project.setMaxHeightBot((map.get("F_Max_Heigh_Bot") == null) ? 0.0F : Float.parseFloat(map.get("F_Max_Heigh_Bot").toString()));
    project.setRailwayPosition((map.get("F_Railway_Position") == null) ? 0 : Integer.parseInt(map.get("F_Railway_Position").toString()));
    project.setViacapLayer((map.get("F_Viacap_layer") == null) ? 0 : Integer.parseInt(map.get("F_Viacap_layer").toString()));
    project.setAssemblyProcessTop((map.get("F_Assembly_Process_Top") == null) ? 0 : Integer.parseInt(map.get("F_Assembly_Process_Top").toString()));
    project.setHavePb((map.get("F_Have_Pb") == null) ? -1 : Integer.parseInt(map.get("F_Have_Pb").toString()));
    project.setAssemblyProcessBot((map.get("F_Assembly_Process_Bot") == null) ? 0 : Integer.parseInt(map.get("F_Assembly_Process_Bot").toString()));
    project.setSurfaceProcess((map.get("F_Surface_Process") == null) ? 0 : Integer.parseInt(map.get("F_Surface_Process").toString()));
    project.setDirectionTop((map.get("F_Direction_Top") == null) ? 0 : Integer.parseInt(map.get("F_Direction_Top").toString()));
    project.setPrimarySide((map.get("F_Primary_Side") == null) ? 0 : Integer.parseInt(map.get("F_Primary_Side").toString()));
    project.setDirectionBot((map.get("F_Direction_Bot") == null) ? 0 : Integer.parseInt(map.get("F_Direction_Bot").toString()));
    project.setDirectionBotFs((map.get("F_Direction_Bot_Fs") == null) ? 0 : Integer.parseInt(map.get("F_Direction_Bot_Fs").toString()));
    project.setDensity((map.get("F_Density") == null) ? "" : map.get("F_Density").toString());
    project.setSubmitUser((map.get("F_SUBMIT_USER") == null) ? 0 : Integer.parseInt(map.get("F_SUBMIT_USER").toString()));
    project.setSubmitTime((map.get("F_SUBMIT_TIME") == null) ? "" : map.get("F_SUBMIT_TIME").toString());
    project.setEndTime((map.get("F_END_TIME") == null) ? "" : map.get("F_END_TIME").toString());
    project.setState((map.get("F_STATE") == null) ? "" : map.get("F_STATE").toString());
    project.setTaskNum((map.get("T_TASK_NUM") == null) ? 0 : Integer.parseInt(map.get("T_TASK_NUM").toString()));
    project.setPri((map.get("F_PRI") == null) ? 0 : Integer.parseInt(map.get("F_PRI").toString()));
    project.setResultFile((map.get("F_FILE_RESULT") == null) ? "" : map.get("F_FILE_RESULT").toString());
    project.setServer((map.get("F_SERVER") == null) ? "" : map.get("F_SERVER").toString());
    project.setServerState((map.get("F_SERVER_STATE") == null) ? "" : map.get("F_SERVER_STATE").toString());
    project.setPcbFileName((map.get("F_PCB_FILE_NAME") == null) ? "" : map.get("F_PCB_FILE_NAME").toString());
    project.setBomFileName((map.get("F_BOM_FILE_NAME") == null) ? "" : map.get("F_BOM_FILE_NAME").toString());
    project.setSubmitUserName((map.get("F_SUBMIT_USERNAME") == null) ? "" : map.get("F_SUBMIT_USERNAME").toString());
    project.setRunTime((String)map.get("F_RUN_TIME"));
    return project;
  }

  public List<Map> getAttrValue(String attrName)
  {
    String sql = "select t2.F_ID , t2.F_ATTR_VALUE ,t2.F_IS_DEFAULT from t_project_attr  t1 , t_project_attr_value t2 where t1.F_ATTR_EN_NAME=? and t1.F_ID = t2.F_ATTR_NAME";

    return getJdbcTemplate().queryForList(sql, new Object[] { attrName });
  }

  public void delete(String pid) {
    String sql = "DELETE T.* FROM T_PROJECT T WHERE T.F_ID = " + pid;
    getJdbcTemplate().update(sql);
  }

  public List<Project> getByStates(String[] states, int uid, Page page, ProjectQueryBean queryBean)
  {
    int totalCount = getCountByStates(states, uid, queryBean);
    int start = (page.getCurrentPage() - 1) * page.getPageSize();

    String sql = "SELECT * FROM T_PROJECT T WHERE T.F_STATE IN ('-1'";
    for (int i = 0; i < states.length; ++i)
    {
      sql = sql + ",'" + states[i] + "'";
    }

    sql = sql + ") ";

    List params = new ArrayList();
    if (queryBean != null)
    {
      sql = constructConditionSql(queryBean, sql, params);
    }

    sql = sql + " AND T.F_SUBMIT_USER = ? ORDER BY T.F_PRI ASC limit ?,?";
    params.add(Integer.valueOf(uid));
    params.add(Integer.valueOf(start));
    params.add(Integer.valueOf(page.getPageSize()));
    logger.info("getProjectsSQL====" + sql);
    List list = getJdbcTemplate().queryForList(sql, params.toArray());

    List rs = null;
    if ((list == null) || (list.size() <= 0)) {
      return rs;
    }
    rs = new ArrayList();
    for (int i = 0; i < list.size(); ++i)
    {
      Map map = (Map)list.get(i);
      rs.add(map2Bean(map));
    }

    PageUtil.constructPage(page, totalCount);
    return rs;
  }

  public List<Project> getByStatesOrderUser(String[] states, int uid, Page page, ProjectQueryBean queryBean)
  {
    int totalCount = getCountByStates(states, queryBean);
    int start = (page.getCurrentPage() - 1) * page.getPageSize();

    String subTabSql = 
      "  ( \tSELECT 1 f_order,t1.*  FROM t_project t1 WHERE t1.F_SUBMIT_USER = ? \tunion  \tSELECT 2 f_order,t2.*  FROM t_project t2 WHERE t2.F_SUBMIT_USER <> ? )  ";

    String sql = "SELECT * FROM " + subTabSql + " T WHERE T.F_STATE IN ('-1'";
    for (int i = 0; i < states.length; ++i)
    {
      sql = sql + ",'" + states[i] + "'";
    }

    sql = sql + ") ";

    List params = new ArrayList();
    if (queryBean != null)
    {
      sql = constructConditionSql(queryBean, sql, params);
    }

    sql = sql + " ORDER BY T.f_order,T.F_PRI ASC limit ?,?";
    params.add(Integer.valueOf(uid));
    params.add(Integer.valueOf(uid));
    params.add(Integer.valueOf(start));
    params.add(Integer.valueOf(page.getPageSize()));
    logger.info("getProjectsSQL====" + sql);
    List list = getJdbcTemplate().queryForList(sql, params.toArray());

    List rs = null;
    if ((list == null) || (list.size() <= 0)) {
      return rs;
    }
    rs = new ArrayList();
    for (int i = 0; i < list.size(); ++i)
    {
      Map map = (Map)list.get(i);
      rs.add(map2Bean(map));
    }

    PageUtil.constructPage(page, totalCount);
    return rs;
  }

  private int getCountByStates(String[] states, int uid, ProjectQueryBean queryBean)
  {
    String sql = "SELECT COUNT(*) FROM T_PROJECT T WHERE T.F_STATE IN ('-1'";
    for (int i = 0; i < states.length; ++i)
    {
      sql = sql + ",'" + states[i] + "'";
    }
    sql = sql + ") AND T.F_SUBMIT_USER = ? ";
    List params = new ArrayList();
    params.add(Integer.valueOf(uid));
    if (queryBean != null)
    {
      sql = constructConditionSql(queryBean, sql, params);
    }
    return getJdbcTemplate().queryForInt(sql, params.toArray());
  }

  private String constructConditionSql(ProjectQueryBean queryBean, String sql, List<Object> params)
  {
    if ((queryBean.getUsername() != null) && (!("".equals(queryBean.getUsername().trim()))))
    {
      sql = sql + " AND T.F_SUBMIT_USERNAME like '%" + queryBean.getUsername() + "%'";
    }

    if ((queryBean.getState() != null) && (!("".equals(queryBean.getState().trim()))))
    {
      sql = sql + " AND T.F_STATE=?";
      params.add(queryBean.getState());
    }
    String time;
    if ((queryBean.getStartSubmitTime() != null) && (!("".equals(queryBean.getStartSubmitTime().trim()))))
    {
      sql = sql + " AND T.F_SUBMIT_TIME >= ?";
      time = TimeUtil.getDateStrByFormat(queryBean.getStartSubmitTime(), "yyyy-MM-dd", "yyyyMMddHHMMSS");
      time = time.substring(0, 8) + "000000";
      params.add(time);
    }
    if ((queryBean.getEndSubmitTime() != null) && (!("".equals(queryBean.getEndSubmitTime().trim()))))
    {
      sql = sql + " AND T.F_SUBMIT_TIME <= ?";
      time = TimeUtil.getDateStrByFormat(queryBean.getEndSubmitTime(), "yyyy-MM-dd", "yyyyMMddHHMMSS");
      time = time.substring(0, 8) + "245999";
      params.add(time);
    }
    if ((queryBean.getProjectName() != null) && (!("".equals(queryBean.getProjectName().trim()))))
    {
      sql = sql + " AND T.F_PROJECT_NAME like '%" + queryBean.getProjectName() + "%'";
    }

    return sql;
  }

  public void changePri(String pid, int pri, String state)
  {
    String sql = "UPDATE T_PROJECT T SET T.F_PRI = ? , T.F_STATE = ? WHERE T.F_ID = " + pid;
    getJdbcTemplate().update(sql, new Object[] { Integer.valueOf(pri), state });
  }

  public void changePri(int pid, int pri)
  {
    String sql = "UPDATE T_PROJECT T SET T.F_PRI = ?  WHERE T.F_ID = " + pid;
    getJdbcTemplate().update(sql, new Object[] { Integer.valueOf(pri) });
  }

  public int getMaxPri()
  {
    String sql = "SELECT max(t.F_PRI) FROM T_PROJECT T WHERE T.F_STATE = ?";
    return getJdbcTemplate().queryForInt(sql, new Object[] { "待查" });
  }

  public List<Map> getAttrValueByIds(int[] ids)
  {
    String sql = "SELECT T.F_ID, T.F_ATTR_VALUE FROM t_project_attr_value T WHERE T.F_ID IN ( -1";
    for (int i = 0; i < ids.length; ++i)
    {
      sql = sql + "," + ids[i];
    }
    sql = sql + ")";
    return getJdbcTemplate().queryForList(sql);
  }

  public Project getByPriState(int pid, int uid, String change, String state) {
    List list = null;
    String sql;
    if (-1 == uid)
    {
      sql = "";

      if ("up".equals(change))
      {
        sql = "select * from t_project where f_pri = ( select max(t1.f_pri) from t_project t1 where  t1.f_pri <(select t.f_pri from t_project t where t.f_id = ?) and t1.f_state = ?)";
      }
      else if ("down".equals(change))
      {
        sql = "select * from t_project where f_pri = ( select min(t1.f_pri) from t_project t1 where  t1.f_pri >(select t.f_pri from t_project t where t.f_id = ?) and t1.f_state = ?)";
      }

      list = getJdbcTemplate().queryForList(sql, new Object[] { Integer.valueOf(pid), state });
    }
    else
    {
      sql = "";

      if ("up".equals(change))
      {
        sql = "select * from t_project where f_pri = ( select max(t1.f_pri) from t_project t1 where  t1.f_pri <(select t.f_pri from t_project t where t.f_id = ? ) and t1.f_state = ?  and t1.f_submit_user = ? ) and f_submit_user = ?";
      }
      else if ("down".equals(change))
      {
        sql = "select * from t_project where f_pri = ( select min(t1.f_pri) from t_project t1 where  t1.f_pri >(select t.f_pri from t_project t where t.f_id = ?) and t1.f_state = ?  and t1.f_submit_user = ? ) and f_submit_user = ?";
      }

      list = getJdbcTemplate().queryForList(sql, new Object[] { Integer.valueOf(pid), state, Integer.valueOf(uid), Integer.valueOf(uid) });
    }
    Project rs = null;
    if ((list == null) || (list.size() <= 0))
    {
      return null;
    }

    Map map = (Map)list.get(0);
    rs = map2Bean(map);

    return rs;
  }

  public void reOrderPriByState(String state, int pri)
  {
    int i;
    if (pri <= 1000)
    {
      String selectSql = "select t.* from t_project t where t.f_state = ? and t.f_pri <= 1000 order by t.f_pri asc";
      List list = getJdbcTemplate().queryForList(selectSql, new Object[] { state });

      String updateSql = "update t_project t set t.f_pri = ? where t.f_id = ? and t.f_pri <= 1000";
      for (i = 0; i < list.size(); ++i)
      {
        getJdbcTemplate().update(updateSql, new Object[] { Integer.valueOf(i + 1), ((Map)list.get(i)).get("f_id") });
      }
    }
    else
    {
      String selectSql1 = "select t.* from t_project t where t.f_state = ? and t.f_pri > 1000 order by t.f_pri asc";
      List list1 = getJdbcTemplate().queryForList(selectSql1, new Object[] { state });

      String updateSql1 = "update t_project t set t.f_pri = ? where t.f_id = ? and t.f_pri > 1000";
      for (i = 0; i < list1.size(); ++i)
      {
        getJdbcTemplate().update(updateSql1, new Object[] { Integer.valueOf(i + 1001), ((Map)list1.get(i)).get("f_id") });
      }
    }
  }

  public List<Project> getByUser(int uid)
  {
    String sql = "SELECT * FROM T_PROJECT T WHERE T.F_SUBMIT_USER = ?";
    List list = getJdbcTemplate().queryForList(sql, new Object[] { Integer.valueOf(uid) });

    List rs = null;
    if ((list == null) || (list.size() <= 0)) {
      return rs;
    }
    rs = new ArrayList();
    for (int i = 0; i < list.size(); ++i)
    {
      Map map = (Map)list.get(i);
      rs.add(map2Bean(map));
    }

    return rs;
  }

  public void deleteStageByProject(int pid)
  {
    String sql = "DELETE T.* FROM T_PROJECT_STAGE T WHERE T.F_PROJECT_ID = ?";
    getJdbcTemplate().update(sql, new Object[] { Integer.valueOf(pid) });
  }

  public void recheck(int pid, String submitTime, String state)
  {
    int pri = getMaxPri() + 1;
    String sql = "update t_project set F_SUBMIT_TIME = ?,F_STATE=?,f_pri = ? where f_id = ?";

    getJdbcTemplate().update(sql, new Object[] { submitTime, state, Integer.valueOf(pri), Integer.valueOf(pid) });
  }

  public List<String> getAllServers() {
    String sql = "SELECT t.f_server FROM T_PROJECT T where t.F_SERVER is not null and t.F_SERVER != '' group by t.f_server ";

    List list = getJdbcTemplate().queryForList(sql);
    List rs = null;
    if ((list == null) || (list.size() <= 0)) {
      return rs;
    }
    rs = new ArrayList();
    for (int i = 0; i < list.size(); ++i)
    {
      Map map = (Map)list.get(i);
      if (map.get("F_SERVER") == null)
        continue;
      rs.add(map.get("F_SERVER").toString());
    }

    return rs;
  }

  public Project getByServerState(String server, String state) {
    String sql = "SELECT T.* , T1.F_ATTR_VALUE FROM T_PROJECT T , T_PROJECT_ATTR_VALUE T1 WHERE T.F_SERVER = ? AND T.F_STATE = ? AND T.F_CHECK_TYPE = T1.F_ID";
    List list = getJdbcTemplate().queryForList(sql, new Object[] { server, state });
    Project rs = null;
    if ((list == null) || (list.size() <= 0))
    {
      return null;
    }

    Map map = (Map)list.get(0);
    rs = map2Bean(map);
    rs.setCheckTypeStr((map.get("F_ATTR_VALUE") == null) ? "" : map.get("F_ATTR_VALUE").toString());

    return rs;
  }

  public List<ProjectStage> getStagesByProject(int pid) {
    String sql = "SELECT T.* FROM T_PROJECT_STAGE T WHERE T.F_PROJECT_ID = ? ORDER BY T.F_STAGE_ORDER ASC";

    List list = getJdbcTemplate().queryForList(sql, new Object[] { Integer.valueOf(pid) });
    List rs = null;
    if ((list == null) || (list.size() <= 0)) {
      return rs;
    }
    rs = new ArrayList();
    for (int i = 0; i < list.size(); ++i)
    {
      Map map = (Map)list.get(i);
      ProjectStage stage = new ProjectStage();
      stage.setStageName((map.get("F_STAGE_NAME") == null) ? "" : map.get("F_STAGE_NAME").toString());
      stage.setId((map.get("F_ID") == null) ? 0 : Integer.parseInt(map.get("F_ID").toString()));
      stage.setEndTime((map.get("F_END_TIME") == null) ? "" : map.get("F_END_TIME").toString());
      stage.setId((map.get("F_PROJECT_ID") == null) ? 0 : Integer.parseInt(map.get("F_PROJECT_ID").toString()));
      stage.setStatrTime((map.get("F_START_TIME") == null) ? "" : map.get("F_START_TIME").toString());
      stage.setStageOrder((map.get("F_STAGE_ORDER") == null) ? 0 : Integer.parseInt(map.get("F_STAGE_ORDER").toString()));
      rs.add(stage);
    }

    return rs;
  }

  public void stop(String pid) {
    String sql = "update t_project set F_CANCEL= 1 where f_id = " + 
      pid;
    getJdbcTemplate().update(sql);
  }
}