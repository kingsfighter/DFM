<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.kfighter.dfm.pojo.Page"%>
<%@ page import="com.kfighter.dfm.pojo.UserInfo"%>
<%@ page import="com.kfighter.dfm.util.TimeUtil"%>
<%@ page import="com.kfighter.dfm.pojo.Project"%>
<%@ page import="com.kfighter.dfm.constant.ProjectConstants"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>队列管理</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		
	
	<LINK href="css/Manage.css" type=text/css rel=stylesheet>
	<LINK href="css/Style.css" type=text/css rel=stylesheet>
	<link href="images/skin.css" rel="stylesheet" type="text/css" >
	<script type="text/javascript" src="js/jquery-1.6.min.js"></script>
	<script type="text/javascript"  language="javascript" src="js/My97DatePicker_now/WdatePicker.js"></script>

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

	
	<%
			Page myPage = (Page)request.getAttribute("page");
		 %>	
	
	<script type="text/javascript">
	
		//暂停
		function pause(pid)
		{
			document.location.href='project.do?method=pause&pid=' + pid + '&currentPage=<%=myPage.getCurrentPage()%>';
		}
		
		//恢复
		function restore(pid)
		{
			document.location.href='project.do?method=restore&pid=' + pid + '&currentPage=<%=myPage.getCurrentPage()%>';
		}
		
		//上调优先级
		function changePri( pid,change )
		{
			document.location.href='project.do?method=changePri&pid=' 
								   + pid + 
								   '&change='+change +
								   '&currentPage=<%=myPage.getCurrentPage()%>';
		}
		//删除
		function deleteProject(pid)
		{
			if(confirm("请确认是否删除？"))
			{
				document.location.href='project.do?method=delete&source=queueManage&pid=' + pid + '&currentPage=<%=myPage.getCurrentPage()%>';
			}
		}
		
		//批量删除项目
		function batchDeleteProject()
		{
			var boxes = $("input:checkbox[name='pid']:checked");
			if(boxes.length<1)
			{
				alert('请选择需要操作的项！');
				return ;
			}
			if(confirm("请确认是否批量删除？"))
			{
				var pidStr = "";
				for(var i=0;i<boxes.length;i++)
				{
					pidStr += $(boxes[i]).val() + ",";
				}
				
				document.location.href='project.do?method=delete&source=queueManage&pid=' + pidStr+ '&currentPage=<%=myPage.getCurrentPage()%>';
			}
		}
		
		function batchPauseProject()
		{
			var boxes = $("input:checkbox[name='pid']:checked");
			if(boxes.length<1)
			{
				alert('请选择需要操作的项！');
				return ;
			}
			if(confirm("请确认是否批量暂停？"))
			{
				var pidStr = "";
				for(var i=0;i<boxes.length;i++)
				{
					pidStr += $(boxes[i]).val() + ",";
				}
				document.location.href='project.do?method=pause&pid=' + pidStr+ '&currentPage=<%=myPage.getCurrentPage()%>';
				
			}
		}
		
		
		
		
		
		//下载文件
		function getFile(fid)
		{
			document.location.href='file.do?method=download&fid=' + fid;
		}
		
		//下载参数文件
		function getParamFile(fid,fname)
		{
			document.location.href='project.do?method=downloadParamFile&fid=' + fid + '&fname=' + fname;
		}
	
		//上一页
		function prePage(currPage)
		{
			if(currPage - 1 <= 0)
			{
				return ;
			}
			document.location.href='project.do?method=queueManage&currentPage=' + (currPage - 1);
		}
		
		//下一页
		function nextPage(currPage)
		{
			if(currPage + 1 > ${page.totalPage})
			{
				return ;
			}
		
			document.location.href='project.do?method=queueManage&currentPage=' + (currPage + 1);
		}
		
		//跳转到某页
		function toPage()
		{
			var toPage = $("#toPage").val();
			var reg = /^[0-9]*[1-9][0-9]*$/;
			if(!(reg.test(toPage)) || parseInt(toPage) < 1 || parseInt(toPage) > ${page.totalPage})
			{
				return ;
			}
			document.location.href='project.do?method=queueManage&currentPage=' + toPage;
		}
		
	
		$(document).ready(function(){
			  $("#checkAll").click(function(){
			    	$("input:checkbox[name='pid']").attr("checked",this.checked);
		      });
		});
	
	
	
	
	</script>
	</head>
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
									队列管理
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
											当前位置：队列管理
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
														<span class="left_txt2">本模块用于调整项目检查的优先级，可暂停、恢复、删除待查项目。</span>
													</td>
												</tr>
												
											<tr>
												<td>
													&nbsp;
												</td>
											</tr>	
											</table>			
<!-- 表格插件 -->												
<TABLE borderColor=#cccccc cellSpacing=0 cellPadding=0 width="100%" 
      align=center border=0>
        <TBODY>
        <TR>
          <TD height=25>
          <form action="project.do?method=queryProject&queryType=queueManage" method="post">
            <TABLE cellSpacing=0 cellPadding=2 border=0>
              <TBODY>
              <TR>
                <TD>查询数据：</TD>
                <TD>项目名</TD>
                <TD><INPUT class=textbox id=projectName style="WIDTH: 80px" 
                  maxLength=50 name=projectName></TD>
                <TD>上传人</TD>
                <TD>
                <!-- 
                <INPUT class=textbox id=username style="WIDTH: 80px" 
                  maxLength=50 name=username> -->
                  
                  <select name="username"　style="WIDTH: 80px">
                  	<option value="">--请选择--</option>
                  	<%
                  		List<UserInfo> users = (List<UserInfo>)request.getAttribute("users");
                  		if(null != users)
                  		{
                  			for(int i=0;i<users.size();i++)
	                  		{
	                  			out.println("<option value="+ users.get(i).getUsername() +">"+ users.get(i).getUsername() +"</option>");
	                  		}
                  		}
                  		
                  	 %>
                  </select>
                  
                  </TD>
                  <TD>状态</TD>
                <TD>	<select name="state">
                  		<option value="">--请选择--</option>
                  		<option value="在查">在查</option>
                  		<option value="待查">待查</option>
                  		<option value="暂停">暂停</option>
                  	</select></TD>
                <TD> 上传时间：
                <input style="width:90px;"name="startSubmitTime" id="startSubmitTime" type="text" class="Wdate" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" value=""/>  
                —
                  	<input style="width:90px;" name="endSubmitTime" id="endSubmitTime" type="text" class="Wdate" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" value=""/>
                  </TD>
                <TD><INPUT class=button id=submit type=submit value=" 查询 " name=submit></TD></TR></TBODY></TABLE>
                
                </form>
<BR/>
<TABLE id=grid 
            style="BORDER-TOP-WIDTH: 0px; FONT-WEIGHT: normal; BORDER-LEFT-WIDTH: 0px; BORDER-LEFT-COLOR: #cccccc; 

BORDER-BOTTOM-WIDTH: 0px; BORDER-BOTTOM-COLOR: #cccccc; WIDTH: 100%; BORDER-TOP-COLOR: #cccccc; FONT-STYLE: normal; 

BACKGROUND-COLOR: #cccccc; BORDER-RIGHT-WIDTH: 0px; TEXT-DECORATION: none; BORDER-RIGHT-COLOR: #cccccc" 
            cellSpacing=1 cellPadding=2 rules=all border=0>
              <TBODY>
              <TR 
              style="FONT-WEIGHT: bold; FONT-STYLE: normal;text-align:center; BACKGROUND-COLOR: #eeeeee; TEXT-DECORATION: none">
                <TD>任务编号</TD>
                <TD>项目名</TD>
                <TD>版本</TD>
                <TD>上传人</TD>
                <TD>文件名</TD>
                <TD>上传时间</TD>
                <TD>状态</TD>
                <TD>优先级调整</TD>
                <TD>操作</TD>
                </TR>
                
                
                
                <%
              	Object rs = request.getAttribute("projects");
              	if(null == rs)
              	{
              		%>
              			<TR 
		              style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
		               <TD colspan="10" align=center>--没有数据--</TD>
		            </TR>
              		<%
              	}
              	else{
              	List<Project> list = (List<Project>)rs;
              	
              	if(list.isEmpty())
              	{
              		%>
              			<TR 
		              style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
		               <TD colspan="10" align=center>--没有数据--</TD>
		            </TR>
              		<%
              	}else{
              	Project pre = (null == request.getAttribute("pre") ? null : (Project)request.getAttribute("pre"));
              	Project next = (null == request.getAttribute("next") ? null : (Project)request.getAttribute("next"));
              	for(int i=0;i<list.size();i++)
              	{
              		Project project = list.get(i);
               %>
                
              <TR 
              style="FONT-WEIGHT: normal;text-align:center; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
                <TD>
                
                <%=(myPage.getPageSize() * (myPage.getCurrentPage() - 1) ) + (i + 1)%>
                </TD>
                <TD><%=project.getProjectName() %></TD>
                <TD><%=project.getVersion() %></TD>
                <TD><%=project.getSubmitUserName() %></TD>
                <TD align=left>
				<span style="width:60px;margin-right:5px;">PCB文件:</span><A href="javascript:getFile(<%=project.getPcbFile() %>);"><%=project.getPcbFileName() %></A>
				</br>
				<span style="width:60px;margin-right:5px;">BOM文件:</span><A href="javascript:getFile(<%=project.getBomFile() %>);"><%=project.getBomFileName() %></A>
				</br>
				<%
					int fid = 0;
					if(0 != project.getPcbFile() )
	                {
	                	fid = project.getPcbFile();
	                }
	                else if(0 != project.getBomFile() )
	                {
	                	fid = project.getBomFile();
	                }
				 %>
				<span style="width:60px;margin-right:5px;">参数文件:</span><A href="javascript:getParamFile(<%=fid%>,'<%=project.getProjectName() + "_" + project.getVersion() + ".param" %>');"><%=project.getProjectName() + "_" + project.getVersion() + ".param"%></A>
				</TD>
                <TD><%= TimeUtil.getDateStrByFormat(project.getSubmitTime(),"yyyy-MM-dd HH:mm:ss")%></TD>
                <TD><%=project.getState() %></TD>
                <TD> 
                
                <%
                	
                	if(ProjectConstants.PROJECT_STATE_DAICHA.equals(project.getState()))
                	{
	                	if(i == 0)
	                	{
		                 	if(null != pre )
		                 	{
		                 		%>
		                 		<a  href="javascript:changePri(<%=project.getId() %>,'up');"><img style="border:0px;"src="images/pic15.gif" /></a>
		                 		<%
		                 	}
		                 
						}
		                 else
		                 {
		                  if(ProjectConstants.PROJECT_STATE_DAICHA.equals(list.get(i-1).getState())  )
		                  {
		                 %>
		                	<a  href="javascript:changePri(<%=project.getId() %>,'up');"><img style="border:0px;"src="images/pic15.gif" /></a>
		                 <%
		                 }
		                }
		                 %>
		                 
		                 <%
		                 
		                	if(i == list.size() - 1)
		                	 {
		                	 	if(null != next )
			                 	{
			                 		%>
			                 		<a  href="javascript:changePri(<%=project.getId() %>,'down');"><img style="border:0px;"src="images/pic8.gif" /></a>
			                 		<%
			                 	}
					               	
					         }
					         else
					          {
					          	 if(ProjectConstants.PROJECT_STATE_DAICHA.equals(list.get(i+1).getState())  )
					          	 {
					                 %>
					                <a  href="javascript:changePri(<%=project.getId() %>,'down');"><img style="border:0px;"src="images/pic8.gif" /></a>
					               	<%
				                }
				              }
				          }
                 %>
                </TD>
                <TD> 
                <%
                	if(!ProjectConstants.PROJECT_STATE_ZAICHA.equals(project.getState()))
                	{
                 %>
	                <input type="checkbox" value='<%=project.getId() %>' name="pid"/>
	              	<%
	              		if(ProjectConstants.PROJECT_STATE_ZANTING.equals(project.getState()))
	              		{
	              			out.write("<A href='javascript:restore(" +project.getId() +")'>继续</A>");
	              		}
	              		else
	              		{
	              			out.write("<A href='javascript:pause(" +project.getId() +")'>暂停</A>");
	              		}
	              	
	              	 %>&nbsp;&nbsp;&nbsp;&nbsp;
	                <A href="javascript:deleteProject(<%=project.getId() %>)">删除</A>
	                <%} %>
                </TD>
                </TR>
               
                 <%
               }}}
                %>
                  
                   
                  
              </TBODY></TABLE>




		<TABLE WIDTH="100%"><TBODY>
		<TR>
          <TD align=right height=25><INPUT id=boxListValue type=hidden 
            name=boxListValue>&nbsp; 

            <INPUT  type=checkbox name=checkAll id="checkAll"></INPUT> 
            全选&nbsp;&nbsp;&nbsp; <INPUT class=button id=button2 type=button value=暂停 onclick="batchPauseProject()"  name=button2 /><INPUT class=button id=button2 onclick="batchDeleteProject()" type=button value=删除 name=button2 /> </TD></TR>
        <TR>
          <TD><SPAN id=pagelink>
            <DIV style="LINE-HEIGHT: 20px; HEIGHT: 20px; TEXT-ALIGN: right">共[<B><%=myPage.getTotalCount() %></B>]条记录 
            共[<B><%=myPage.getTotalPage() %></B>]页 
            当前第[<B><%=myPage.getCurrentPage() %></B>]页 
             [<A 
            href="javascript:prePage(<%=myPage.getCurrentPage() %>);">前一页</A>] 
            
            [<A class="" 
            href="javascript:nextPage(<%=myPage.getCurrentPage() %>);">后一页</A>] 
            
			<input type="text" size="2" id="toPage"/><INPUT class=button id=button2 type=button value=跳转 onclick="toPage();" name=button2 />

		</DIV></SPAN></TD></TR></TBODY></TABLE>
												
												
												</TD></TR></TBODY>
											</TABLE>
										</td>
									</tr>
									
									</table>

								


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
