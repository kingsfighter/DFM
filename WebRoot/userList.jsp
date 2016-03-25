<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.kfighter.dfm.pojo.UserInfo"%>
<%@ page import="com.kfighter.dfm.constant.UserConstants"%>
<%@ page import="com.kfighter.dfm.pojo.Page"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'admintitle.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
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
	<%
			Page myPage = (Page)request.getAttribute("page");
		 %>	
	<script type="text/javascript">
		//修改账户信息
		function modifyUser(){
			document.location.href='modifyUser.jsp';
		}
		//上一页
		function prePage(currPage)
		{
			if(currPage - 1 <= 0)
			{
				return ;
			}
			document.location.href='user.do?method=getUserList&currentPage=' + (currPage - 1);
		}
		
		//下一页
		function nextPage(currPage)
		{
			if(currPage + 1 > ${page.totalPage})
			{
				return ;
			}
		
			document.location.href='user.do?method=getUserList&currentPage=' + (currPage + 1);
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
		
			document.location.href='user.do?method=getUserList&currentPage=' + toPage;
		}
		
		//修改用户信息
		function modifyUser(uid)
		{
			document.location.href='user.do?method=getModifyUser&uid=' + uid;
		}
		
		//删除用户信息
		function deleteUser(uid)
		{
			if(confirm("请确认是否删除？"))
			{
				if(confirm("是否删除该账户下的所有项目？"))
				{
					document.location.href='user.do?method=deleteUser&delProject=yes&uid=' + uid　+'&currentPage=<%=myPage.getCurrentPage()%>';
				}
				else
				{
					document.location.href='user.do?method=deleteUser&delProject=no&uid=' + uid　+'&currentPage=<%=myPage.getCurrentPage()%>';
				}
			}
		}
		
		//暂停用户信息
		function pauseUser(uid)
		{
			if(confirm("请确认是否暂停？"))
			{
				document.location.href='user.do?method=changeUserState&state=1&uid=' + uid +'&currentPage=<%=myPage.getCurrentPage()%>';
			}
		}
		//启用用户信息
		function restoreUser(uid)
		{
			if(confirm("请确认是否暂停？"))
			{
				document.location.href='user.do?method=changeUserState&state=0&uid=' + uid　+'&currentPage=<%=myPage.getCurrentPage()%>';
			}
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
									帐户列表
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
											当前位置：帐户列表
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
														<span class="left_txt2">本模块用于账户管理，可查询、删除、暂停、启用账户及修改账户信息等。</span>
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
        <TR>
          <TD height=25>
             <form action="user.do?method=queryUser" method="post">
            <TABLE cellSpacing=0 cellPadding=2 border=0>
              <TBODY>
              <TR>
                <TD>查询数据：</TD>
                <TD>员工姓名</TD>
                <TD><INPUT class=textbox id=name style="WIDTH: 80px" 
                  maxLength=50 name=name></TD>
                <TD>用户名</TD>
                <TD><INPUT class=textbox id=username style="WIDTH: 80px" 
                  maxLength=50 name=username></TD>
                  <TD>所在部门</TD>
                <TD><INPUT class=textbox id=department style="WIDTH: 80px" 
                  maxLength=50 name=department></TD>
                <TD>项目组</TD>
                <TD>
                <INPUT class=textbox id=name=projectGroup style="WIDTH: 80px" 
                  maxLength=50 name=projectGroup>
                  </TD>
                <TD>状态</TD>
                <TD>
                  	<select name="state">
                  		<option value="-1">--请选择--</option>
                  		<option value="0">启用</option>
                  		<option value="1">禁用</option>
                  	</select>
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
              style="FONT-WEIGHT: bold;text-align:center; FONT-STYLE: normal; BACKGROUND-COLOR: #eeeeee; TEXT-DECORATION: none">
                <TD>员工姓名</TD>
                <TD>用户名</TD>
                <TD>所在部门</TD>
                <TD>项目组</TD>
                <TD>Email</TD>
                <TD>是否管理员</TD>
                <TD>状态</TD>
                <TD>操作</TD>
                </TR>
                
              <%
              	Object rs = request.getAttribute("userList");
              	if(null == rs)
              	{
              		%>
              			<TR 
		              style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
		                <TD colspan="7">--没有数据--</TD>
		            </TR>
              		<%
              		return ;
              	}
              	List<UserInfo> list = (List<UserInfo>)rs;
              	
              	if(list.isEmpty())
              	{
              		%>
              			<TR 
		              style="FONT-WEIGHT: normal; FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
		                <TD colspan="7">--没有数据--</TD>
		            </TR>
              		<%
              		return ;
              	}
              	
              	for(int i=0;i<list.size();i++)
              	{
              		UserInfo user = list.get(i);
               %>
               	
               		<TR 
		              style="FONT-WEIGHT: normal; text-align:center;FONT-STYLE: normal; BACKGROUND-COLOR: white; TEXT-DECORATION: none">
		                <TD><%=user.getName() %></TD>
		                <TD><%=user.getUsername() %></TD>
		                <TD><%=user.getDepartment() %></TD>
		                <TD><%=user.getProjectGroup() %></TD>
		                <TD><%=user.getEmail() %></TD>
		                <TD><%=UserConstants.USER_LEVEL_ADMIN == user.getGroupId()?"是":"否" %></TD>
		                <TD>
		                	<%=user.getStatus() == 0 ? "启用" : "暂停" %>
		                </TD>
		                <TD>
		                <A href="javascript:modifyUser(<%=user.getId() %>);">修改</A> 
		                <A href="javascript:deleteUser(<%=user.getId() %>);">删除</A> 
		                
		                <%
		                if(user.getStatus() == 0)
		                	{
		                 %>
		                <A href="javascript:pauseUser(<%=user.getId() %>);">暂停</A> 
		                <%
		                	
		                	}else{
		                 %>
		                 <A href="javascript:restoreUser(<%=user.getId() %>);">启用</A> 
		                 <%
		                 	}
		                  %>
		                 </TD>
		            </TR>
               <%
               }
                %>
                 
                   
                  
              </TBODY></TABLE>
		

		<TABLE WIDTH="100%"><TBODY>
		<!-- 
			<TR>
          <TD align=right height=25><INPUT id=boxListValue type=hidden 
            name=boxListValue> <INPUT class=button id=button1 type=submit value=批量重置密码 name=button1> 
            <INPUT onclick=selectallbox(); type=checkbox name=checkAll> 
            全选&nbsp;&nbsp;&nbsp; </TD></TR>
        -->
        <TR>
          <TD><SPAN id=pagelink>
            <DIV 
            style="LINE-HEIGHT: 20px; HEIGHT: 20px; TEXT-ALIGN: right">共[<B><%=myPage.getTotalCount() %></B>]条记录 
            共[<B><%=myPage.getTotalPage() %></B>]页 
            当前第[<B><%=myPage.getCurrentPage() %></B>]页 
             [<A 
            href="javascript:prePage(<%=myPage.getCurrentPage() %>);">前一页</A>] 
            
            [<A class="" 
            href="javascript:nextPage(<%=myPage.getCurrentPage() %>);">后一页</A>] 
            
			<input type="text" size="2" id="toPage"/><button onclick="toPage();">跳转</button>

		</DIV></SPAN></TD></TR></TBODY></TABLE>
												
												
												
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
