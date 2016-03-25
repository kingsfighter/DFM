<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.kfighter.dfm.pojo.ProjectStage"%>
<%@ page import="com.kfighter.dfm.util.TimeUtil"%>
<%@page import="com.kfighter.dfm.pojo.Project"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>服务器监控</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
<LINK 
href="css/Style.css" type=text/css rel=stylesheet><LINK 
href="css/Manage.css" type=text/css rel=stylesheet>
	<script type="text/javascript" src="js/jquery-1.6.min.js"></script></head>

	<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #F8F9FA;
}
-->
</style>
	
	<link href="images/skin.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript">
	function getProject(v)
	{
		//$($("form")[0]).submit();
		document.location.href = 'project.do?method=serverMonitor&server=' + v;
	}
	
	function stopProject(pid,server)
	{
		document.location.href = 'project.do?method=stopProject&pid=' + pid + '&server=' + server;
		
	}
	</script>
	<body>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="17" height="29" valign="top"
					background="images/mail_leftbg.gif">
					<img src="images/left-top-right.gif" width="17" height="29" />
				</td>
				<td width="100%" height="29" valign="top"
					background="images/content-bg.gif">
					<table width="100%" height="31" border="0" cellpadding="0"
						cellspacing="0" class="left_topbg" id="table2">
						<tr>
							<td height="31">
								<div class="titlebt">
									服务器监控
								</div>
							</td>
						</tr>
					</table>
				</td>
				<td width="16" valign="top" background="images/mail_rightbg.gif">
					<img src="images/nav-right-bg.gif" width="16" height="29" />
				</td>
			</tr>
			<tr>
				<td height="71" valign="middle" background="images/mail_leftbg.gif">
					&nbsp;
				</td>
				<td valign="top" bgcolor="#F7F8F9">
					<table width="100%" height="138" border="0" cellpadding="0"
						cellspacing="0">
						<tr>
							<td height="13" valign="top">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td valign="top">
								<table width="98%" border="0" align="center" cellpadding="0"
									cellspacing="0">
									<tr>
										<td class="left_txt">
											当前位置：服务器监控
										</td>
									</tr>
									<tr>
										<td height="20">
											<table width="100%" height="1" border="0" cellpadding="0"
												cellspacing="0" bgcolor="#CCCCCC">
												<tr>
													<td></td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td>
											<table width="100%" height="55" border="0" cellpadding="0"
												cellspacing="0">
												<tr>
													<td width="10%" height="55" valign="middle">
														<img src="images/title.gif" width="54" height="55">
													</td>
													<td width="90%" valign="top">
														<span class="left_txt2">本模块用于监控各服务器上在查项目的阶段状态信息。</span>
													</td>
												</tr>
												
											<tr>
										<td>
											&nbsp;
										</td>
									</tr>	
										
<!-- 表格插件 -->												
<TABLE borderColor=#cccccc cellSpacing=0 cellPadding=0 width="100%" 
      align=center border=0>
        <TBODY>
        <form action='project.do?method=serverMonitor' method='post'>		
        <TR>
          <TD height=25>
             <%
             Object obj = request.getAttribute("project");
             Object obj1 = request.getAttribute("servers");
             Project project = null;
             List<String> servers = null;
             if(null != obj)
             {
             	project = (Project)obj;
             }
             if(null != obj1)
             {
             	servers = (List<String>)obj1;
             }
             
              %>
            <TABLE cellSpacing=0 cellPadding=2 border=0>
              <TBODY>
              	<TR>
	                <TD >服务器：
	                <select name="server" onchange='getProject(this.value)'>
	                <%
	                	if(null != servers)
	                	{
	                		for(String server : servers)
	                		{
	                			if(server.equals(request.getAttribute("server")))
	                			{
	                		%>
	                		<option value='<%=server %>' selected><%=server %></option>
	                		<%
	                			}else
	                			{
	                			%>
	                			
	                			<option value='<%=server %>'><%=server %></option>
	                			<%
	                			}
	                		}
	                	}
	                 %>
	                </select>
	               <span style='margin-left:100px;'> 
	                状态：
	                <%=project == null ? "<span style='color:green;'>空闲</span>" : "<span style='color:red;'>忙</span>" %>
	                </span>
	                </td>
                </TR>
                
                <TR>
                	<!-- 
	                <TD >当前任务：</TD>
	                <TD width="12%" style='text-align:left'><%=project == null ? "--" : project.getProjectName() %></TD>
	                <TD width="12%">提交人：</TD>
	                <td width="12%"><%=project == null ? "--" : project.getSubmitUserName() %></td>
	                <TD width="12%">提交时间：</TD>
	                <td width="12%"><%=project == null ? "--" : (null == project.getSubmitTime() || "".equals(project.getSubmitTime().trim()) ? "--" :TimeUtil.getDateStrByFormat(project.getSubmitTime(),"yyyy-MM-dd HH:mm:ss")) %></td>
	                <TD width="12%">任务类型：</TD>
	                <td width="12%"><%=project == null ? "--" : project.getCheckType() %></td>
	                 -->
	                 
	                 <TD >
	                 <span style='font-weight:bold;'>当前任务：</span>
	                <%=project == null ? "--" : project.getProjectName() %>
	                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:bold;'>版本：</span>
	               <%=project == null ? "--" : project.getVersion() %>
	                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:bold;'>提交人：</span>
	               <%=project == null ? "--" : project.getSubmitUserName() %>
	                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:bold;'>提交时间：</span>
	               <%=project == null ? "--" : (null == project.getSubmitTime() || "".equals(project.getSubmitTime().trim()) ? "--" :TimeUtil.getDateStrByFormat(project.getSubmitTime(),"yyyy-MM-dd HH:mm:ss")) %>
	                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:bold;'>任务类型：</span>
	                <%=project == null ? "--" : project.getCheckTypeStr() %>
	                <%
	                	if(null != project)
	                	{
	                	%>
	                	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' value='中止' onclick="stopProject(<%=project.getId() %>,'<%=project.getServer() %>');"/>
	                	<%
	                	}
	                 %>
	                
	                </td>
                </TR>
                
                </TBODY></TABLE>
                
                </form>
<BR/>
<TABLE id=grid 
            style="BORDER-TOP-WIDTH: 0px; FONT-WEIGHT: normal; BORDER-LEFT-WIDTH: 0px; BORDER-LEFT-COLOR: #cccccc; 

BORDER-BOTTOM-WIDTH: 0px; BORDER-BOTTOM-COLOR: #cccccc; WIDTH: 100%; BORDER-TOP-COLOR: #cccccc; FONT-STYLE: normal; 

BACKGROUND-COLOR: #cccccc; BORDER-RIGHT-WIDTH: 0px; TEXT-DECORATION: none; BORDER-RIGHT-COLOR: #cccccc" 
            cellSpacing=1 cellPadding=2 rules=all border=0>
              <TBODY>
              <TR 
              style="FONT-WEIGHT: bold;text-align:center; FONT-STYLE: normal; BACKGROUND-COLOR: #eeeeee; TEXT-DECORATION: none">
                <TD>序号</TD>
                <TD>运行阶段</TD>
                <TD>开始时间</TD>
                <TD>完成时间</TD>
                <TD>耗时（分钟）</TD>
                </TR>
                
              <%
              	Object rs = request.getAttribute("stages");
              	if(null == project || null == rs)
              	{
              		%>
              			<TR 
		              style="FONT-WEIGHT: normal; text-align:center;FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
		                <TD colspan="5" align=center>--没有数据--</TD>
		            </TR>
              		<%
              		
              	}
              	else
              	{
              	List<ProjectStage> list = (List<ProjectStage>)rs;
              	
              	if(list.isEmpty())
              	{
              		%>
              			<TR 
		              style="FONT-WEIGHT: normal; text-align:center;FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
		                <TD colspan="5" align=center>--没有数据--</TD>
		            </TR>
              		<%
              		
              	}
              	
              	
              	for(int i=0;i<list.size();i++)
              	{
              		ProjectStage stage = list.get(i);
               %>
               	
               		
                <TR style="FONT-WEIGHT: normal; text-align:center;FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
		                <TD><%=stage.getStageOrder() %></TD>
		                <TD><%=stage.getStageName() %></TD>
		                <TD><%=null == stage.getStatrTime() || "".equals(stage.getStatrTime().trim()) ? "--" :TimeUtil.getDateStrByFormat(stage.getStatrTime(),"yyyy-MM-dd HH:mm:ss") %></TD>
		                <TD><%=null == stage.getEndTime() || "".equals(stage.getEndTime().trim()) ? "--" :TimeUtil.getDateStrByFormat(stage.getEndTime(),"yyyy-MM-dd HH:mm:ss") %></TD>
		                <TD><%
		                	if(null == stage.getStatrTime() || "".equals(stage.getStatrTime().trim()) || null == stage.getEndTime() || "".equals(stage.getEndTime().trim()))
		                	{
		                		out.print("--");
		                	}
		                	else
		                	{
		                		Date start = TimeUtil.toUtilDateFromStrDateByFormat(stage.getStatrTime(),"yyyyMMddHHmmss");
		                		Date end = TimeUtil.toUtilDateFromStrDateByFormat(stage.getEndTime(),"yyyyMMddHHmmss");
		                		Long start1 = TimeUtil.getMillisOfDate(start);
		                		Long end1 = TimeUtil.getMillisOfDate(end);
		                		Long m = (end1 - start1)/60000;
		                		Long s = (end1 - start1)%60000/1000;
		                		out.print(m+"分钟"+s+"秒");
		                	}
		                
		                %></TD>
		                
		            </TR>
               <%
               }}
                %>
                 
                 
                  
              </TBODY></TABLE>


		

		<TABLE WIDTH="100%"><TBODY>
        <TR>
          <TD><SPAN id=pagelink>
            </SPAN></TD></TR></TBODY></TABLE>
												
												
											</table>
										</td>
									</tr>
									


								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td colspan="3"></td>
									</tr>
									

									<tr>
										<td height="30" colspan="3">
											&nbsp;
										</td>
									</tr>
									
								</table>
							</td>
						</tr>
					</table>
				</td>
				<td background="images/mail_rightbg.gif">
					&nbsp;
				</td>
			</tr>
			<tr>
				<td valign="middle" background="images/mail_leftbg.gif">
					<img src="images/buttom_left2.gif" width="17" height="17" />
				</td>
				<td height="17" valign="top" background="images/buttom_bgs.gif">
					<img src="images/buttom_bgs.gif" width="17" height="17" />
				</td>
				<td background="images/mail_rightbg.gif">
					<img src="images/buttom_right2.gif" width="16" height="17" />
				</td>
			</tr>
		</table>

	</body>
</html>
