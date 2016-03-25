package com.kfighter.dfm.service;

import com.kfighter.dfm.dao.UserDAO;
import com.kfighter.dfm.pojo.Page;
import com.kfighter.dfm.pojo.Project;
import com.kfighter.dfm.pojo.UserInfo;
import com.kfighter.dfm.pojo.UserQueryBean;
import java.io.File;
import java.util.List;
import org.apache.log4j.Logger;

public class UserService
{
  private static final Logger logger = Logger.getLogger(UserService.class);
  private UserDAO userDAO;
  private ProjectService projectService;

  public void setProjectService(ProjectService projectService)
  {
    this.projectService = projectService;
  }

  public void setUserDAO(UserDAO userDAO) {
    this.userDAO = userDAO;
  }

  public void addUser(UserInfo user)
  {
    this.userDAO.add(user);
  }

  public List<UserInfo> getAllUser(Page page)
  {
    return this.userDAO.getAll(page);
  }

  public List<UserInfo> getAllUser()
  {
    return this.userDAO.getAll();
  }

  public void deleteUser(int uid, String delProject)
  {
    if ("yes".equals(delProject))
    {
      List list = this.projectService.getProjectByUser(uid);

      if ((list != null) && (!(list.isEmpty())))
      {
        String[] pids = new String[list.size()];
        for (int i = 0; i < list.size(); ++i)
        {
          pids[i] = ((Project)list.get(i)).getId() + "";
        }
        this.projectService.deleteProject(pids);

        UserInfo user = this.userDAO.getById(uid);
        String userDirPath = FileService.rootPath + user.getUsername();
        File userDir = new File(userDirPath);

        if (userDir.exists())
        {
          userDir.delete();
        }

      }

    }

    this.userDAO.delete(uid);
  }

  public UserInfo getUserById(int uid)
  {
    return this.userDAO.getById(uid);
  }

  public void updateUser(UserInfo user)
  {
    UserInfo userInfo = this.userDAO.getById(user.getId());
    userInfo.setDepartment(user.getDepartment());
    userInfo.setEmail(user.getEmail());
    userInfo.setPassword(user.getPassword());
    userInfo.setProjectGroup(user.getProjectGroup());
    userInfo.setGroupId(user.getGroupId());
    this.userDAO.update(userInfo);
  }

  public List<UserInfo> getByQueryBean(UserQueryBean queryBean, Page page) {
    return this.userDAO.getByQueryBean(queryBean, page);
  }

  public void changeUserState(int uid, int state) {
    UserInfo user = getUserById(uid);
    user.setStatus(state);
    this.userDAO.update(user);
  }
}