package com.kfighter.dfm.controller;

import com.kfighter.dfm.pojo.FileInfo;
import com.kfighter.dfm.pojo.Page;
import com.kfighter.dfm.pojo.Project;
import com.kfighter.dfm.pojo.ProjectQueryBean;
import com.kfighter.dfm.pojo.UserInfo;
import com.kfighter.dfm.service.FileService;
import com.kfighter.dfm.service.ProjectService;
import com.kfighter.dfm.service.UserService;
import com.kfighter.dfm.util.PropertiesUtils;
import com.kfighter.dfm.util.TimeUtil;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.cos.CosMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

public class ProjectController extends BaseController
{
  private static final Logger logger = Logger.getLogger(ProjectController.class);
  private ProjectService projectService;
  private FileService fileService;
  private UserService userService;

  public void setProjectService(ProjectService projectService)
  {
    this.projectService = projectService;
  }

  public void setFileService(FileService fileService)
  {
    this.fileService = fileService;
  }

  public void setUserService(UserService userService)
  {
    this.userService = userService;
  }

  public ModelAndView defaultHandle(HttpServletRequest req, HttpServletResponse res)
    throws Exception
  {
    return new ModelAndView("addProject");
  }

  public ModelAndView getAddPage(HttpServletRequest req, HttpServletResponse res)
    throws Exception
  {
    return new ModelAndView("addProject");
  }

  public ModelAndView add(HttpServletRequest request, HttpServletResponse res)
    throws Exception
  {
    try
    {
      MultipartResolver cmr = new CosMultipartResolver(request.getSession().getServletContext());

      MultipartHttpServletRequest req = cmr.resolveMultipart(request);

      String projectName = req.getParameter("projectName");
      String[] dfmCheckArr = req.getParameterValues("dfmCheck");
      String dfmCheck = "";
      if (dfmCheckArr != null)
      {
        for (String check : dfmCheckArr)
        {
          dfmCheck = dfmCheck + check + ",";
        }
      }
      int version = (req.getParameter("version").trim() == "") ? 0 : Integer.parseInt(req.getParameter("version").trim());
      int pri = (req.getParameter("pri").trim() == "") ? 0 : Integer.parseInt(req.getParameter("pri").trim());
      int checkType = (req.getParameter("checkType").trim() == "") ? 0 : Integer.parseInt(req.getParameter("checkType").trim());
      int pcbType = (req.getParameter("pcbType").trim() == "") ? 0 : Integer.parseInt(req.getParameter("pcbType").trim());
      int hdiModel = (req.getParameter("hdiModel").trim() == "") ? 0 : Integer.parseInt(req.getParameter("hdiModel").trim());
      int panelModel = (req.getParameter("panelModel").trim() == "") ? 0 : Integer.parseInt(req.getParameter("panelModel").trim());
      float boardThickness = (req.getParameter("boardThickness").trim() == "") ? 0.0F : Float.parseFloat(req.getParameter("boardThickness").trim());
      float maxHeightTop = (req.getParameter("maxHeightTop").trim() == "") ? 0.0F : Float.parseFloat(req.getParameter("maxHeightTop").trim());
      int railwayPosition = (req.getParameter("railwayPosition").trim() == "") ? 0 : Integer.parseInt(req.getParameter("railwayPosition").trim());
      float maxHeightBot = (req.getParameter("maxHeightBot").trim() == "") ? 0.0F : Float.parseFloat(req.getParameter("maxHeightBot").trim());

      int assemblyProcessTop = (req.getParameter("assemblyProcessTop").trim() == "") ? 0 : Integer.parseInt(req.getParameter("assemblyProcessTop").trim());
      int subPcbNum = (req.getParameter("subPcbNum").trim() == "") ? 0 : Integer.parseInt(req.getParameter("subPcbNum").trim());
      int havePb = (req.getParameter("havePb").trim() == "") ? 0 : Integer.parseInt(req.getParameter("havePb").trim());
      int assemblyProcessBot = (req.getParameter("assemblyProcessBot").trim() == "") ? 0 : Integer.parseInt(req.getParameter("assemblyProcessBot").trim());
      int surfaceProcess = (req.getParameter("surfaceProcess").trim() == "") ? 0 : Integer.parseInt(req.getParameter("surfaceProcess").trim());
      int directionTop = (req.getParameter("directionTop").trim() == "") ? 0 : Integer.parseInt(req.getParameter("directionTop").trim());
      int primarySide = (req.getParameter("primarySide").trim() == "") ? 0 : Integer.parseInt(req.getParameter("primarySide").trim());
      int directionBot = (req.getParameter("directionBot").trim() == "") ? 0 : Integer.parseInt(req.getParameter("directionBot").trim());
      int directionBotFs = (req.getParameter("directionBotFs").trim() == "") ? 0 : Integer.parseInt(req.getParameter("directionBotFs").trim());
      String density = req.getParameter("density");

      Project project = new Project();
      project.setPri(pri);
      project.setAssemblyProcessBot(assemblyProcessBot);
      project.setAssemblyProcessTop(assemblyProcessTop);
      project.setBoardThickness(boardThickness);
      project.setCheckType(checkType);
      project.setDfmCheck(dfmCheck);
      project.setDirectionBot(directionBot);
      project.setDirectionTop(directionTop);
      project.setHavePb(havePb);
      project.setHdiModel(hdiModel);
      project.setMaxHeightBot(maxHeightBot);
      project.setMaxHeightTop(maxHeightTop);
      project.setPcbType(pcbType);
      project.setPrimarySide(primarySide);
      project.setProjectName(projectName);
      project.setRailwayPosition(railwayPosition);
      project.setSubPcbNum(subPcbNum);
      project.setSurfaceProcess(surfaceProcess);
      project.setVersion(version);

      project.setPanelModel(panelModel);
      project.setDirectionBotFs(directionBotFs);
      project.setDensity(density);

      UserInfo user = getUserInfo(req);
      project.setSubmitUser(user.getId());
      project.setSubmitUserName(user.getUsername());
      project.setSubmitTime(TimeUtil.getNowChar14());

      this.projectService.addProject(req, project);
      outputMsg(res, "<script>alert('添加项目成功，点击确定继续添加！');document.location.href='project.do?method=getAddPage';</script>");
      return null;
    } catch (Exception e) {
      logger.error("添加项目失败", e);
      outputMsg(res, "<script>alert('添加项目失败，请检查数据正确性，重新添加！');document.location.href='project.do?method=getAddPage';</script>"); }
    return null;
  }

  public void getLastVersion(HttpServletRequest req, HttpServletResponse res)
    throws Exception
  {
    int uid = getUserInfo(req).getId();
    String projectName = req.getParameter("projectName");
    Project project = this.projectService.getLastVersion(uid, projectName);

    String msg = "";
    if (project != null)
    {
      msg = JSONObject.fromObject(project).toString();
    }

    outputJson(res, msg);
  }

  public void getAttrValue(HttpServletRequest req, HttpServletResponse res) throws Exception
  {
    String attrName = req.getParameter("attrName");
    List list = this.projectService.getAttrValue(attrName);
    String msg = "";
    if ((list != null) || (!(list.isEmpty())))
    {
      JSONArray arr = new JSONArray();
      for (int i = 0; i < list.size(); ++i)
      {
        JSONObject obj = new JSONObject();
        obj.put("text", ((Map)list.get(i)).get("F_ATTR_VALUE"));
        obj.put("value", ((Map)list.get(i)).get("F_ID"));
        obj.put("isDefault", ((Map)list.get(i)).get("F_IS_DEFAULT"));
        arr.add(obj);
      }
      msg = arr.toString();
    }

    outputJson(res, msg);
  }

  public ModelAndView queueManage(HttpServletRequest req, HttpServletResponse res)
    throws Exception
  {
    String[] states = new String[3];
    states[0] = "待查";
    states[1] = "在查";
    states[2] = "暂停";

    String currentPage = req.getParameter("currentPage");
    Page page = new Page();
    if ((currentPage == null) || ("".equals(currentPage.trim())))
    {
      page.setCurrentPage(1);
    }
    else
    {
      page.setCurrentPage(Integer.parseInt(currentPage));
    }
    UserInfo user = getUserInfo(req);
    List projects = null;
    Project pre = null;
    Project next = null;
    if (1 == user.getGroupId())
    {
      projects = this.projectService.getProjectByStates(states, page, null);
      if ((projects != null) && (!(projects.isEmpty())))
      {
        pre = this.projectService.getByPriState("up", ((Project)projects.get(0)).getId(), -1, "待查");
        next = this.projectService.getByPriState("down", ((Project)projects.get(projects.size() - 1)).getId(), -1, "待查");
      }
    }
    else if (2 == user.getGroupId())
    {
      projects = this.projectService.getProjectByStates(states, user.getId(), page, null);
      if ((projects != null) && (!(projects.isEmpty())))
      {
        pre = this.projectService.getByPriState("up", ((Project)projects.get(0)).getId(), user.getId(), "待查");
        next = this.projectService.getByPriState("down", ((Project)projects.get(projects.size() - 1)).getId(), user.getId(), "待查");
      }

    }

    List users = this.userService.getAllUser();
    req.setAttribute("pre", pre);
    req.setAttribute("next", next);
    req.setAttribute("projects", projects);
    req.setAttribute("page", page);
    req.setAttribute("users", users);
    return new ModelAndView("queueManage");
  }

  public void pause(HttpServletRequest req, HttpServletResponse res)
    throws Exception
  {
    try
    {
      String pid = req.getParameter("pid");
      String[] pids = pid.split(",");

      String currentPage = req.getParameter("currentPage");
      this.projectService.pauseProject(pids);
      outputMsg(res, "<script>document.location.href='project.do?method=queueManage&currentPage=" + currentPage + "';</script>");
    } catch (Exception e) {
      logger.error("暂停项目失败！", e);
      outputMsg(res, "<script>alert('暂停项目失败，请联系管理员！');window.history.go(-1);</script>");
    }
  }

  public void restore(HttpServletRequest req, HttpServletResponse res) throws Exception
  {
    try
    {
      String pid = req.getParameter("pid");

      String currentPage = req.getParameter("currentPage");
      this.projectService.restoreProject(pid);
      outputMsg(res, "<script>document.location.href='project.do?method=queueManage&currentPage=" + currentPage + "';</script>");
    } catch (Exception e) {
      logger.error("恢复项目失败！", e);
      outputMsg(res, "<script>alert('恢复项目失败，请联系管理员！');window.history.go(-1);</script>");
    }
  }

  public void delete(HttpServletRequest req, HttpServletResponse res) throws Exception
  {
    try
    {
      String source = req.getParameter("source");
      String pid = req.getParameter("pid");

      String[] pids = pid.split(",");
      this.projectService.deleteProject(pids);

      String currentPage = req.getParameter("currentPage");
      outputMsg(res, "<script>alert('删除成功，确定跳转到队列管理！');document.location.href='project.do?method=" + source + "&currentPage=" + currentPage + "';</script>");
    } catch (Exception e) {
      logger.error("删除项目失败！", e);
      outputMsg(res, "<script>alert('删除失败，确定跳转到队列管理！');window.history.go(-1);</script>");
    }
  }

  public ModelAndView resultDownload(HttpServletRequest req, HttpServletResponse res)
    throws Exception
  {
    String[] states = new String[3];
    states[0] = "完成";
    states[1] = "出错";
    states[2] = "中断";

    String currentPage = req.getParameter("currentPage");
    Page page = new Page();
    if ((currentPage == null) || ("".equals(currentPage.trim())))
    {
      page.setCurrentPage(1);
    }
    else
    {
      page.setCurrentPage(Integer.parseInt(currentPage));
    }

    UserInfo user = getUserInfo(req);
    List projects = null;

    String taskResultInquire = (String)PropertiesUtils.getProperties().get("task.result.inquire");
    if ("user".equals(taskResultInquire))
    {
      projects = this.projectService.getProjectByStates(states, user.getId(), page, null);
    }
    else if (1 == user.getGroupId())
    {
      projects = this.projectService.getProjectByStates(states, page, null);
    }
    else if (2 == user.getGroupId())
    {
      projects = this.projectService.getProjectByStates(states, user.getId(), page, null);
    }

    List users = this.userService.getAllUser();
    req.setAttribute("users", users);
    req.setAttribute("projects", projects);
    req.setAttribute("page", page);
    req.setAttribute("oper", user);
    req.setAttribute("queryParam", "{}");
    req.setAttribute("loadType", "init");
    return new ModelAndView("resultDownload");
  }

  public void downloadResultFile(HttpServletRequest req, HttpServletResponse response)
    throws Exception
  {
    try
    {
      String fid = req.getParameter("fid");
      String fname = req.getParameter("fname");
      FileInfo pcbFileInfo = this.fileService.getById(Integer.parseInt(fid));
      fname = new String(fname.getBytes("utf-8"), "iso8859-1");

      String path = this.fileService.getRootPath() + "/" + pcbFileInfo.getRelaPath() + "/" + fname;
      File file = new File(path);
      if (!(file.exists()))
      {
        outputMsg(response, "<script>alert('结果文件不存在，请联系管理员！');window.history.go(-1);</script>");
        logger.error("结果文件不存在");
        return;
      }
      response.setHeader("Location", fname);
      response.setHeader("Cache-Control", "max-age=");
      response.setHeader("Content-Disposition", "attachment; filename=" + fname);
      response.setContentLength((int)file.length());
      OutputStream outputStream = response.getOutputStream();
      InputStream inputStream = new FileInputStream(file);
      byte[] buffer = new byte[1024];
      int i = -1;
      while ((i = inputStream.read(buffer)) != -1) {
        outputStream.write(buffer, 0, i);
      }
      outputStream.flush();
      outputStream.close();
      inputStream.close();
      outputStream = null;
    }
    catch (Exception e) {
      logger.error("下载结果文件失败！", e);
      outputMsg(response, "<script>alert('下载结果文件失败，请联系管理员！');window.history.go(-1);</script>");
    }
  }

  public void downloadParamFile(HttpServletRequest req, HttpServletResponse response)
    throws Exception
  {
    try
    {
      String fid = req.getParameter("fid");
      String fname = req.getParameter("fname");
      FileInfo pcbFileInfo = this.fileService.getById(Integer.parseInt(fid));
      fname = new String(fname.getBytes("utf-8"), "iso8859-1");

      String path = this.fileService.getRootPath() + "/" + pcbFileInfo.getRelaPath() + "/" + fname;
      File file = new File(path);
      if (!(file.exists()))
      {
        outputMsg(response, "<script>alert('参数文件不存在，请联系管理员！');window.history.go(-1);</script>");
        logger.error("参数文件不存在");
        return;
      }
      response.setHeader("Location", fname);
      response.setHeader("Cache-Control", "max-age=");
      response.setHeader("Content-Disposition", "attachment; filename=" + fname);
      response.setContentLength((int)file.length());
      OutputStream outputStream = response.getOutputStream();
      InputStream inputStream = new FileInputStream(file);
      byte[] buffer = new byte[1024];
      int i = -1;
      while ((i = inputStream.read(buffer)) != -1) {
        outputStream.write(buffer, 0, i);
      }
      outputStream.flush();
      outputStream.close();
      inputStream.close();
      outputStream = null;
    }
    catch (Exception e) {
      logger.error("下载参数文件失败！", e);
      outputMsg(response, "<script>alert('下载参数文件失败，请联系管理员！');window.history.go(-1);</script>");
    }
  }

  public ModelAndView queryProject(HttpServletRequest req, HttpServletResponse res)
    throws Exception
  {
    String queryType = req.getParameter("queryType");
    String projectName = req.getParameter("projectName");
    String username = req.getParameter("username");
    String state = req.getParameter("state");
    String startSubmitTime = req.getParameter("startSubmitTime");
    String endSubmitTime = req.getParameter("endSubmitTime");

    ProjectQueryBean queryBean = new ProjectQueryBean();
    queryBean.setEndSubmitTime(endSubmitTime);
    queryBean.setProjectName(projectName);
    queryBean.setStartSubmitTime(startSubmitTime);
    queryBean.setState(state);
    queryBean.setUsername(username);

    String currentPage = req.getParameter("currentPage");
    Page page = new Page();
    if ((currentPage == null) || ("".equals(currentPage.trim())))
    {
      page.setCurrentPage(1);
    }
    else
    {
      page.setCurrentPage(Integer.parseInt(currentPage));
    }

    String[] states = new String[3];
    List projects = null;
    UserInfo user = getUserInfo(req);
    if ("resultDownload".equals(queryType))
    {
      states[0] = "完成";
      states[1] = "出错";
      states[2] = "中断";

      String taskResultInquire = (String)PropertiesUtils.getProperties().get("task.result.inquire");
      if ("user".equals(taskResultInquire))
      {
        projects = this.projectService.getProjectByStates(states, page, queryBean);
      }
      else if (1 == user.getGroupId())
      {
        projects = this.projectService.getProjectByStates(states, page, queryBean);
      }
      else if (2 == user.getGroupId())
      {
        projects = this.projectService.getProjectByStates(states, user.getId(), page, queryBean);
      }

      List users = this.userService.getAllUser();
      req.setAttribute("projects", projects);
      req.setAttribute("page", page);
      req.setAttribute("users", users);
      req.setAttribute("queryParam", JSONObject.fromObject(queryBean));
      req.setAttribute("loadType", "query");
      return new ModelAndView("resultDownload");
    }
    if ("queueManage".equals(queryType))
    {
      states[0] = "待查";
      states[1] = "在查";
      states[2] = "暂停";
      if (1 == user.getGroupId())
      {
        projects = this.projectService.getProjectByStates(states, page, queryBean);
      }
      else if (2 == user.getGroupId())
      {
        projects = this.projectService.getProjectByStates(states, user.getId(), page, queryBean);
      }

      List users = this.userService.getAllUser();
      req.setAttribute("projects", projects);
      req.setAttribute("page", page);
      req.setAttribute("users", users);
      return new ModelAndView("queueManage");
    }

    return null;
  }

  public void changePri(HttpServletRequest req, HttpServletResponse res)
    throws Exception
  {
    try
    {
      String pid = req.getParameter("pid");
      String change = req.getParameter("change");

      String currentPage = req.getParameter("currentPage");
      int uid = -1;
      if (2 == getUserInfo(req).getGroupId())
      {
        uid = getUserInfo(req).getId();
      }
      this.projectService.changePri(pid, uid, change);
      outputMsg(res, "<script>document.location.href='project.do?method=queueManage&currentPage=" + currentPage + "';</script>");
    }
    catch (Exception e) {
      logger.error("调整优先级失败！", e);
      outputMsg(res, "<script>alert('调整优先级失败，请联系管理员！');window.history.go(-1);</script>");
    }
  }

  public void recheck(HttpServletRequest req, HttpServletResponse res)
    throws Exception
  {
    try
    {
      String pid = req.getParameter("pid");
      String[] pids = pid.split(",");

      String currentPage = req.getParameter("currentPage");
      this.projectService.recheck(pids);
      outputMsg(res, "<script>document.location.href='project.do?method=resultDownload&currentPage=" + currentPage + "';</script>");
    }
    catch (Exception e) {
      logger.error("再查项目失败！", e);
      outputMsg(res, "<script>alert('再查项目失败，请联系管理员！');window.history.go(-1);</script>");
    }
  }

  public ModelAndView serverMonitor(HttpServletRequest req, HttpServletResponse res)
    throws Exception
  {
    List servers = this.projectService.getAllServers();
    String server = req.getParameter("server");
    if ((server == null) && (servers != null))
    {
      server = (String)servers.get(0);
    }
    if ((server != null) || ("".equals(server)))
    {
      server = new String(server.getBytes("iso-8859-1"), "utf-8");
      Project project = this.projectService.getProjectByServerState(server, "在查");
      if (project != null)
      {
        int pid = project.getId();
        List stages = this.projectService.getStagesByProject(pid);
        req.setAttribute("project", project);
        req.setAttribute("stages", stages);
      }
    }
    req.setAttribute("servers", servers);
    req.setAttribute("server", server);
    return new ModelAndView("serverMonitor");
  }

  public void stopProject(HttpServletRequest req, HttpServletResponse res)
    throws Exception
  {
    try
    {
      String pid = req.getParameter("pid");
      this.projectService.stopProject(pid);
      String server = new String(req.getParameter("server").getBytes("iso-8859-1"), "utf-8");
      outputMsg(res, "<script>document.location.href='project.do?method=serverMonitor&server=" + server + "';</script>");
    }
    catch (Exception e) {
      logger.error("中止项目失败！", e);
      outputMsg(res, "<script>alert('中止项目失败，请联系管理员！');window.history.go(-1);</script>");
    }
  }
}