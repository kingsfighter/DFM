<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>添加项目</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

	<script type="text/javascript" src="js/jquery-1.6.min.js"></script>
	<script type="text/javascript" src="js/jquery.processing.plugin.js"></script>
	
	<script type="text/javascript"><!--
		
		var hasOldVersion = false;
		var oldProjectData = null;
		/**
		* 获取当前用户及项目名单最大版本号
		*/
		function getVersion(v)
		{
			if(null == v || ""==v)
			{
				return false;
			}
			$.ajax({
			  url: "project.do?method=getLastVersion",
			  data: "projectName="+v,
			  cache:false,
			  success: function(json){
			      if(null == json)
			      {
			      	$("#version").val(1);
			      	hasOldVersion = false;
			      	resetForm();
			      }
			      else //有相同项目，开始赋值
			      {
			      	hasOldVersion = true;
			      	oldProjectData = json;
			      	fillParams();
			      }
			  }
			});
		}
		
		jQuery(function($) {
		  initAllElement();
		});
		var dfmCheckValue = '2';
		//如有修改DFM分析自定义的名称,修改这个变量即可
		var dfmCheckName = 'DFM自定义';
		
		/**
		* 初始化页面SELECT数据
		*/
		function initAllElement()
		{
			var selects = $("select");
			for(var i=0;i<selects.length;i++)
			{
				if($(selects[i]).attr("name") == 'pri')
				{
					continue;
				}
				initElement($(selects[i]));
			}
			$("input[name='boardThickness']").val(2);
			$("input[name='maxHeightTop']").val(5);
			$("input[name='subPcbNum']").val(2);
			$("input[name='maxHeightBot']").val(5);
			$("input[name='dfmCheck']").each(function(){
				$(this).attr("checked",true);
			});
			//var dfmCheck = $("input[name='checkType']").children(":selected").html();
			//var dfmCheck = $("input[name='checkType']");
			//showDfmCheck(dfmCheck);
		}
		
		
		
		/**
		* Ajax获取元素值，并赋值到相应元素
		*/
		function initElement(element)
		{
			$.ajax({
			  url: "project.do?method=getAttrValue",
			  data: "attrName="+element.attr("name"),
			  success: function(json){
			      var html = "<option value=''>--请选择--</option>";
			      for(var i=0;i<json.length;i++)
			      {
			      		if(json[i].isDefault == '1')
			      		{
			      			html += "<option value='"+ json[i].value +"' selected='true'>" + json[i].text + "</option>";
			      			//新增checkType面板初始化
			      			if('checkType' == element.attr('name'))
					      	{
						      	if(dfmCheckName == json[i].text)
								{
									$("#taskType").show();
								}
								else
								{
									$("#taskType").hide();
								}
					      	}
			      		}
			      		else
			      		{
			      			html += "<option value='"+ json[i].value +"'>" + json[i].text + "</option>";
			      		}
			      		
			      		
			      		
			      }
			      element.html(html);
			      
			  }
			});
		}
		
		
		function showDfmCheck(select)
		{
			var dfmCheck = $(select).children(":selected").text();
			//var dfmCheck = $(select).val();
			if(dfmCheckName == dfmCheck)
			{
				$("#taskType").show();
			}
			else
			{
				$("#taskType").hide();
			}
		}
		//有相同版本时填充其他参数
		function fillParams()
		{
			data = oldProjectData;
			$("#version").val(data.version + 1);
			var checkType = $("select[name='checkType']");
			checkType.val(data.checkType);
			var dfmCheck = checkType.children(":selected").text();
			//var dfmCheck = $(checkType).val();
			if(dfmCheck == dfmCheckName)
			{
				$("#taskType").show();
			}
			else
			{
				$("#taskType").hide();
			}
			var dfmCheckArr = data.dfmCheck.split(',');
			//$("#wbfx").attr("checked",false);
			//$("#lbfx").attr("checked",false);
			//$("#zpfx").attr("checked",false);
			$("input[name='dfmCheck']").each(function(i,item){
				$(item).attr("checked",false);
			});
			
			for(var i=0;i< dfmCheckArr.length;i++)
			{
				if(dfmCheckArr[i] == $("#netlistcheck").val())
				{
					$("#netlistcheck").attr("checked",true);
				}
				else if(dfmCheckArr[i] == $("#fiducial").val())
				{
					$("#fiducial").attr("checked",true);
				}
				else if(dfmCheckArr[i] == $("#component").val())
				{
					$("#component").attr("checked",true);
				}
				else if(dfmCheckArr[i] == $("#padstack").val())
				{
					$("#padstack").attr("checked",true);
				}
				else if(dfmCheckArr[i] == $("#solderpaste").val())
				{
					$("#solderpaste").attr("checked",true);
				}
				else if(dfmCheckArr[i] == $("#pin2pad").val())
				{
					$("#pin2pad").attr("checked",true);
				}
				else if(dfmCheckArr[i] == $("#testpoint").val())
				{
					$("#testpoint").attr("checked",true);
				}
				else if(dfmCheckArr[i] == $("#drill").val())
				{
					$("#drill").attr("checked",true);
				}
				else if(dfmCheckArr[i] == $("#signallayer").val())
				{
					$("#signallayer").attr("checked",true);
				}
				else if(dfmCheckArr[i] == $("#pglayer").val())
				{
					$("#pglayer").attr("checked",true);
				}
				else if(dfmCheckArr[i] == $("#silkscreen").val())
				{
					$("#silkscreen").attr("checked",true);
				}
				else if(dfmCheckArr[i] == $("#soldermask").val())
				{
					$("#soldermask").attr("checked",true);
				}
				else if(dfmCheckArr[i] == $("#extchk1").val())
				{
					$("#extchk1").attr("checked",true);
				}
				else if(dfmCheckArr[i] == $("#extchk2").val())
				{
					$("#extchk2").attr("checked",true);
				}
				else if(dfmCheckArr[i] == $("#extchk3").val())
				{
					$("#extchk3").attr("checked",true);
				}
				else if(dfmCheckArr[i] == $("#extchk4").val())
				{
					$("#extchk4").attr("checked",true);
				}
				else if(dfmCheckArr[i] == $("#extchk5").val())
				{
					$("#extchk5").attr("checked",true);
				}
				else if(dfmCheckArr[i] == $("#extchk6").val())
				{
					$("#extchk6").attr("checked",true);
				}
			}
			/*
			for(var i=0;i< dfmCheckArr.length;i++)
			{
				var str = dfmCheckArr[i].toLowerCase().replace(' ','');
				if(dfmCheckArr[i] == $("#"+str).val())
				{
					$("#"+str).attr("checked",true);
				}
			}
			*/
			$("select[name='pcbType']").val(data.pcbType);
			$("select[name='hdiModel']").val(data.hdiModel);
			$("input[name='boardThickness']").val(data.boardThickness);
			$("select[name='panelModel']").val(data.panelModel);
			$("input[name='maxHeightTop']").val(data.maxHeightTop);
			$("input[name='subPcbNum']").val(data.subPcbNum);
			$("input[name='maxHeightBot']").val(data.maxHeightBot);
			$("select[name='railwayPosition']").val(data.railwayPosition);
			//$("select[name='viacapLayer']").val(data.viacapLayer);
			$("select[name='assemblyProcessTop']").val(data.assemblyProcessTop);
			$("select[name='havePb']").val(data.havePb);
			$("select[name='assemblyProcessBot']").val(data.assemblyProcessBot);
			$("select[name='surfaceProcess']").val(data.surfaceProcess);
			$("select[name='directionTop']").val(data.directionTop);
			$("select[name='primarySide']").val(data.primarySide);
			$("select[name='directionBot']").val(data.directionBot);
			$("select[name='directionBotFs']").val(data.directionBotFs);
			$("select[name='density']").val(data.density);
		}
		//重置表单数据
		function resetForm()
		{
			if(hasOldVersion)
			{
				fillParams();
				return false;
			}
			else
			{
				initAllElement();
				return false;
			}
		}
		//验证form
		function submitForm()
		{
			if($.trim($("input[name='projectName']").val()) == "")
			{
				alert("项目名不能为空！");
				return false;
			}
			if($.trim($("input[name='version']").val()) == "")
			{
				alert("版本不能为空！");
				return false;
			}
			if($("select[name='checkType']").val() == "")
			{
				alert("请选择任务类型！");
				return false;
			}
			
			
			var checkType = $("select[name='checkType']");
			var dfmCheck = checkType.children(":selected").text();
			//var dfmCheck = $(checkType).val();
			if(dfmCheckName == dfmCheck)
			{	//必须提供PCB文件包与BOM文件，需提供所有的单板参数、工艺参数。
				if(!doValidate('addProjectForm'))
				{
					return false;
				}
			}
			else if ("BOM预审" == dfmCheck){
				//只需提供BOM文件，无需提供PCB文件包。无需提供单板参数、工艺参数。
				if($("input[name='bomFile']").val() == "")
				{
					alert("必需提供BOM文件！");
					return false;
				}
				
			}
			else if ("CAM验证" == dfmCheck){
				//只需提供PCB文件包，无需提供BOM文件。无需提供单板参数、工艺参数。
				if($("input[name='pcbFile']").val() == "")
				{
					alert("必需提供PCB文件！");
					return false;
				}
			}
			
			//显示进度条
			setTimeout(showProcess,200);
		}
		//自动获取项目名称
		function fillProjectName(o)
		{
			var fileName = getFileName($(o).val());
			var index = fileName.lastIndexOf(".");
			fileName = fileName.substring(0,index);
			$("input[name='projectName']").val(fileName);
			$("input[name='projectName']").blur();
		}
		
		function getFileName(path)
		{
			var pos1 = path.lastIndexOf('/');
			var pos2 = path.lastIndexOf('\\');
			var pos = Math.max(pos1, pos2)
			return path.substring(pos+1);
		}
		
		function showProcess()
		{  
			$(document).progressDialog.showDialog("正在上传文件，请耐心等待...");
		} 
	--></script>
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
	<script type="text/javascript" src="/DFM/js/validation-framework.js"></script>
	<body style="position: relative;">
	<div id="processDiv" style="position: absolute;left:0px;top:0px;">
		
	</div>
	<form  onsubmit="return submitForm();"action='project.do?method=add' method="post" id="addProjectForm" enctype="multipart/form-data">
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
									项目提交
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
											当前位置：项目提交
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
														<span class="left_txt2">
														本模块用于提交项目。任务类型里，BOM预审用于预审BOM中的器件是否全有VPL库对应；
														<br>DFM分析的内容可以具体选择；CAM验证是指验证Gerber数据与IPC-D-356的一致性。
														</span>
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
														&nbsp;&nbsp;&nbsp;&nbsp;任务描述
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
														项目描述：
													</td>
													<td width="3%" bgcolor="#f2f2f2">
														&nbsp;
													</td>
													<td width="32%" height="30" bgcolor="#f2f2f2">
														<input name="projectName" type="text" id="projectName" size="30" onBlur="getVersion(this.value);"/>
													</td>
													<td width="45%" height="30" bgcolor="#f2f2f2"
														class="left_txt">
														版本（<input type="text" value="" style="border-width:0px;"  name="version" id="version" size="1" readOnly/>）
													</td>
												</tr>
												<tr>
													<td height="30" align="right" class="left_txt2">
														PCB文件包：
													</td>
													<td>
														&nbsp;
													</td>
													<td height="30">
														<input type="file" name="pcbFile" size="50" onblur="fillProjectName(this);"/>
													</td>
													<td height="30" class="left_txt">
														 布局密度：<select style="width:120px" name='density'>
																		
														</select>
													</td>
												</tr>
												<tr>
													<td height="30" align="right" bgcolor="#f2f2f2"
														class="left_txt2">
														BOM文件：
													</td>
													<td bgcolor="#f2f2f2">
														&nbsp;
													</td>
													<td height="30" bgcolor="#f2f2f2">
														<input type="file" name="bomFile" size="50" />	
													</td>
													<td height="30" bgcolor="#f2f2f2" class="left_txt">
														
													</td>
												</tr>
												
												<tr>
													<td height="30" align="right" bgcolor="#f2f2f2"
														class="left_txt2">
														任务优先级：
													</td>
													<td bgcolor="#f2f2f2">
														&nbsp;
													</td>
													<td height="30" bgcolor="#f2f2f2">
														<select name="pri">
															<option value="99999" selected>低</option>
															<option value="1000">高</option>
														</select>	
													</td>
													<td height="30" bgcolor="#f2f2f2" class="left_txt">
														
													</td>
												</tr>
												
												<tr>
													<td height="80" align="right" class="left_txt2">
														任务类型：
													</td>
													<td>
														&nbsp;
													</td>
													<td height="80" colspan="2" style="font-size: 12px;">
														<table>
														<tr>
														<td>
														<span >
														<!-- 任务类型添加=================================================== -->
														<select style="width:120px" name="checkType" onchange="showDfmCheck(this);">
															
														</select>
														
														</span>
														
														</td>
														<td>
														
														
														<!-- DFM Check可变项 -->
														
														<span id="taskType" style="padding-left:30px;display:;">
															<table style="font-size: 12px">
																			<tr>
																				<td>
																					<input id='netlistcheck' type="checkbox"
																						name='dfmCheck' value="NetlistCheck" />
																					<label for='netlistcheck'>
																						NetlistCheck
																					</label>
																				</td>
																				<td>
																					<input id='fiducial' type="checkbox"
																						name='dfmCheck' value="Fiducial" />
																					<label for='fiducial'>
																						Fiducial
																					</label>
																				</td>
																				<td>
																					<input id='component' type="checkbox"
																						name='dfmCheck' value="Component" />
																					<label for='component'>
																						Component
																					</label>
																				</td>
																				<td>
																					<input id='padstack' type="checkbox"
																						name='dfmCheck' value="Padstack" />
																					<label for='padstack'>
																						Padstack
																					</label>
																				</td>
																				<td>
																					<input id='solderpaste' type="checkbox"
																						name='dfmCheck' value="Solderpaste" />
																					<label for='solderpaste'>
																						Solderpaste
																					</label>
																				</td>
																				<td>
																					<input id='pin2pad' type="checkbox"
																						name='dfmCheck' value="Pin2Pad" />
																					<label for='pin2pad'>
																						Pin2Pad
																					</label>
																				</td>
																			</tr>
																			<tr>
																				<td>
																					<input id='testpoint' type="checkbox"
																						name='dfmCheck' value="Testpoint" />
																					<label for='testpoint'>
																						Testpoint
																					</label>
																				</td>
																				<td>
																					<input id='drill' type="checkbox" name='dfmCheck'
																						value="Drill" />
																					<label for='drill'>
																						Drill
																					</label>
																				</td>
																				<td>
																					<input id='signallayer' type="checkbox"
																						name='dfmCheck' value="Signal Layer" />
																					<label for='signallayer'>
																						Signal Layer
																					</label>
																				</td>
																				<td>
																					<input id='pglayer' type="checkbox"
																						name='dfmCheck' value="P/G Layer" />
																					<label for='pglayer'>
																						P/G Layer
																					</label>
																				</td>
																				<td>
																					<input id='silkscreen' type="checkbox"
																						name='dfmCheck' value="Silk Screen" />
																					<label for='silkscreen'>
																						Silk Screen
																					</label>
																				</td>
																				<td>
																					<input id='soldermask' type="checkbox"
																						name='dfmCheck' value="Solder Mask" />
																					<label for='soldermask'>
																						Solder Mask
																					</label>
																				</td>
																			</tr>
																			<tr>
																				<td>
																					<input id='extchk1' type="checkbox"
																						name='dfmCheck' value="extchk1" />
																					<label for='extchk1'>
																						extchk1
																					</label>
																				</td>
																				<td>
																					<input id='extchk2' type="checkbox"
																						name='dfmCheck' value="extchk2" />
																					<label for='extchk2'>
																						extchk2
																					</label>
																				</td>
																				<td>
																					<input id='extchk3' type="checkbox"
																						name='dfmCheck' value="extchk3" />
																					<label for='extchk3'>
																						extchk3
																					</label>
																				</td>
																				<td>
																					<input id='extchk4' type="checkbox"
																						name='dfmCheck' value="extchk4" />
																					<label for='extchk4'>
																						extchk4
																					</label>
																				</td>
																				<td>
																					<input id='extchk5' type="checkbox"
																						name='dfmCheck' value="extchk5" />
																					<label for='extchk5'>
																						extchk5
																					</label>
																				</td>
																				<td>
																					<input id='extchk6' type="checkbox"
																						name='dfmCheck' value="extchk6" />
																					<label for='extchk6'>
																						extchk6
																					</label>
																				</td>
																			</tr>
																			
																	</table> 
																</span>
														</td>
														</tr>
														</table>
													</td>
												</tr>


												<!-- 第二大标题 -->

												<tr>
													<td height="30" colspan="3">
														&nbsp;
													</td>
												</tr>

												<tr>
													<td height="30" colspan="4" class="left_txt2">
														<table width="100%" height="31" border="0" cellpadding="0"
															cellspacing="0" class="nowtable">
															<tr>
																<td class="left_bt2">
																	&nbsp;&nbsp;&nbsp;&nbsp;单板参数
																</td>
															</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td height="30" colspan="4" class="left_txt">

														<table width="100%" height="90" border="0" cellpadding="0"
															cellspacing="0">
															<tr>
																<td width="27%"  bgcolor="#f2f2f2" style="text-align:right;"
																	class="left_txt">
																	单板类型：
																</td>
																<td width="27%" bgcolor="#f2f2f2" class="left_txt">
																	<select style="width:120px" name="pcbType">
																		
																	</select>
																</td>
																<td width="24%" bgcolor="#f2f2f2" class="left_txt" style="text-align:right;">
																	HDI层叠方式：
																</td>
																<td width="22%" bgcolor="#f2f2f2" class="left_txt">
																	<select style="width:120px" name='hdiModel'>
																		
																	</select>
																</td>
															</tr>
															<tr>
																<td class="left_txt" style="text-align:right;">
																	板厚：
																</td>
																<td class="left_txt">
																	<input type="text" style="" name="boardThickness"
																		 style="width:120px" class="button01" /> mm 
																</td>
																<td class="left_txt" style="text-align:right;">
																	拼板方式：
																</td>
																<td class="left_txt">
																	<select style="width:120px" name='panelModel'>
																		
																	</select>
																	
																</td>
															</tr>
															<tr>
																<td  bgcolor="#f2f2f2" class="left_txt" style="text-align:right;">
																	Top面限高：
																</td>
																<td bgcolor="#f2f2f2" class="left_txt">
																	<input type="text" style="" 
																		name='maxHeightTop' style="width:120px" class="button01" /> mm 
																</td>
																<td bgcolor="#f2f2f2" class="left_txt" style="text-align:right;">
																	几拼板：
																</td>
																<td bgcolor="#f2f2f2" class="left_txt">
																	<input type="text" style="" name='subPcbNum' style="width:120px" class="button01" />
																</td>
															</tr>
															<tr>
																<td  class="left_txt" style="text-align:right;">
																	Bottom限高：
																</td>
																<td  class="left_txt">
																	<input type="text" style="" name="maxHeightBot"
																		 style="width:120px" class="button01" />
																	mm
																</td>
																<td  class="left_txt" style="text-align:right;">
																	辅助边位置：
																</td>
																<td  class="left_txt">
																	<select style="width:120px" name='railwayPosition'>
																		
																	</select>
																</td>
															</tr>
															
														</table>
													</td>
												</tr>
												
												<!-- 工艺参数 -->

												<tr>
													<td height="30" colspan="3">
														&nbsp;
													</td>
												</tr>

												<tr>
													<td height="30" colspan="4" class="left_txt2">
														<table width="100%" height="31" border="0" cellpadding="0"
															cellspacing="0" class="nowtable">
															<tr>
																<td class="left_bt2">
																	&nbsp;&nbsp;&nbsp;&nbsp;工艺参数
																</td>
															</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td height="30" colspan="4" class="left_txt">

														<table width="100%" height="90" border="0" cellpadding="0"
															cellspacing="0">
															<tr>
																<td width="27%"  bgcolor="#f2f2f2"
																	class="left_txt" style="text-align:right;"> 
																	是否无铅： 
																</td>
																<td width="27%" bgcolor="#f2f2f2" class="left_txt">
																	<select style="width:120px" name='havePb'>
																		
																	</select>
																	<!-- 
																	<select style="width:120px" name='viacapLayer'>
																		
																	</select>
																	 -->
																</td>
																<td width="24%" bgcolor="#f2f2f2" class="left_txt" style="text-align:right;">
																	Top工艺路线：
																</td>
																<td width="22%" bgcolor="#f2f2f2" class="left_txt">
																	<select style="width:120px" name='assemblyProcessTop'>
																		
																	</select>
																</td>
															</tr>
															<tr>
																<td class="left_txt" style="text-align:right;">表面处理方式： 
																</td>
																<td class="left_txt">
																	<select style="width:120px" name='surfaceProcess'>
																		
																	</select>
																</td>
																<td class="left_txt" style="text-align:right;">
																	Bottom工艺路线：
																</td>
																<td class="left_txt">
																	<select style="width:120px" name='assemblyProcessBot'>
																		
																	</select>
																	
																</td>
															</tr>
															<tr>
																<td bgcolor="#f2f2f2" class="left_txt" style="text-align:right;"> 
																	主要面： 
																</td>
																<td bgcolor="#f2f2f2" class="left_txt">
																	<select style="width:120px" name='primarySide'>
																		
																	</select>
																	
																</td>
																<td bgcolor="#f2f2f2" class="left_txt" style="text-align:right;"> 
																	Top回流过板方向： 
																</td>
																<td bgcolor="#f2f2f2" class="left_txt">
																	<select style="width:120px" name='directionTop'>
																		
																	</select>
																</td>
															</tr>
															<tr>
																<td   class="left_txt" style="text-align:right;"> 
																	Bottom回流过板方向： 
																</td>
																<td  class="left_txt">
																	<select style="width:120px" name='directionBot'>
																		
																	</select>
																	
																</td>
																<td  class="left_txt" style="text-align:right;"> 
																	Bottom波峰过板方向： 
																</td>
																<td  class="left_txt">
																	<select style="width:120px" name='directionBotFs'>
																		
																	</select>
																</td>
															</tr>
															
														</table>
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
										<td colspan="3">&nbsp;</td>
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
											<input type="reset" onclick="return resetForm();" value="取  消" name="reset" />
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
