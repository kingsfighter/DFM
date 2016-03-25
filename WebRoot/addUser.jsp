<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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

	<script type="text/javascript" src="js/validation-framework.js"></script>
	<script type="text/javascript">
		function checkAdmin(c)
		{
			if(c.checked)
			{
				c.value = '1';
			}
			else
			{
				c.value = '2';
			}
		}
	</script>
	
	</head>

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
	
	<body>
		<form onsubmit="return doValidate('addUserForm')" action="user.do?method=add" id="addUserForm" method="post">
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
									新增员工
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
											当前位置：新增员工
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
														<span class="left_txt2">本模块用于新增账户，用户名长度不能小于6个字符，各项信息不得为空，必须准确填写。</span>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td>
											&nbsp;
										</td>
									</tr>

									<!-- 第一个标题栏 -->
									<tr>
										<td>
											<table width="100%" height="31" border="0" cellpadding="0"
												cellspacing="0" class="nowtable">
												<tr>
													<td class="left_bt2">
														&nbsp;&nbsp;&nbsp;&nbsp;新增员工
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td>
											<table width="100%" border="0" cellspacing="0"
												cellpadding="0">

												<tr>
													<td width="20%" height="30" align="right" bgcolor="#f2f2f2"
														class="left_txt2">
														员工姓名：
													</td>
													<td width="1%" bgcolor="#f2f2f2">
														&nbsp;
													</td>
													<td width="32%" height="30" bgcolor="#f2f2f2">
														<input name="name" type="text" id="name" size="30" />
													</td>
													
												</tr>
												<tr>
													<td height="30" align="right" class="left_txt2">
														用户名：
													</td>
													<td>
														&nbsp;
													</td>
													<td height="30">
														<input type="text" name="username" size="30" />
													</td>
													
												</tr>
												<tr>
													<td height="30" align="right" bgcolor="#f2f2f2"
														class="left_txt2">
														密码：
													</td>
													<td bgcolor="#f2f2f2">
														&nbsp;
													</td>
													<td height="30" bgcolor="#f2f2f2">
														<input type="password" name="password" size="30" />
													</td>
													
												</tr>
												<tr>
													<td height="30" align="right" 
														class="left_txt2">
														确认密码：
													</td>
													<td >
														&nbsp;
													</td>
													<td height="30" >
														<input type="password" name="password1" size="30" />
													</td>
													
												</tr>
												<tr>
													<td height="30" align="right" bgcolor="#f2f2f2"class="left_txt2">
														所在部门：
													</td>
													<td bgcolor="#f2f2f2">
														&nbsp;
													</td>
													<td height="30" colspan="2" style="font-size: 12px;"bgcolor="#f2f2f2">
														<input type="text" name="department" size="30" />
													</td>
												</tr>

												<tr>
													<td height="30" align="right" class="left_txt2">
														项目组：
													</td>
													<td>
														&nbsp;
													</td>
													<td height="30">
														<input type="text" name="projectGroup" size="30" />
													</td>
													
												</tr>
												
												<tr>
													<td height="30" align="right" class="left_txt2"bgcolor="#f2f2f2">
														Email：
													</td>
													<td bgcolor="#f2f2f2">
														&nbsp;
													</td>
													<td height="30"bgcolor="#f2f2f2">
														<input type="text" name="email" size="30" />
													</td>
													
												</tr>
												
												
												<tr>
													<td height="30" align="right" class="left_txt2"bgcolor="#f2f2f2">
														是否管理员：
													</td>
													<td bgcolor="#f2f2f2">
														&nbsp;
													</td>
													<td height="30"bgcolor="#f2f2f2" style="padding-left:0px;font-size:12px;">
														<input type="checkbox" name="isGroup" onclick="checkAdmin(this);" size="30" />(选中代表该用户是管理员)
													</td>
													
												</tr>
												
												
													</td>
												</tr>
											</table>
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
									<tr>
										<td width="50%" height="30" align="right">
											<input type="submit" value="提  交" name="submit" />
										</td>
										<td width="6%" height="30" align="right">
											&nbsp;
										</td>
										<td width="44%" height="30">
											<input type="reset" value="取  消" name="reset" />
										</td>
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
		</form>
	</body>
</html>
