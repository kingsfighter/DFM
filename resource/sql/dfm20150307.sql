/*
Navicat MySQL Data Transfer

Source Server         : DFM
Source Server Version : 50515
Source Host           : localhost:3306
Source Database       : dfm

Target Server Type    : MYSQL
Target Server Version : 50515
File Encoding         : 65001

Date: 2015-03-07 09:19:31
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_file`
-- ----------------------------
DROP TABLE IF EXISTS `t_file`;
CREATE TABLE `t_file` (
  `F_ID` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `F_FILE_NAME` varchar(256) DEFAULT NULL COMMENT '文件名',
  `F_RELA_PATH` varchar(256) DEFAULT NULL COMMENT '相对路径',
  `F_EXTEND_NAME` varchar(20) DEFAULT NULL COMMENT '文件扩展名',
  `F_FILE_SIZE` int(10) DEFAULT NULL COMMENT '文件大小',
  `F_UPLOAD_USER` int(10) DEFAULT NULL COMMENT '上传人',
  `F_UPLOAD_TIME` varchar(20) DEFAULT NULL COMMENT '上传时间',
  PRIMARY KEY (`F_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COMMENT='文件表';

-- ----------------------------
-- Records of t_file
-- ----------------------------
INSERT INTO `t_file` VALUES ('1', 'demo.tgz', 'Admin/test11111/Ver1', 'tgz', '980749', '2', '20141023211240');
INSERT INTO `t_file` VALUES ('2', 'demo.tgz', 'jiwei01/test11111/Ver1', 'tgz', '980749', '4', '20141024052216');
INSERT INTO `t_file` VALUES ('3', 'demo.tgz', 'jiwei01/hjhjhjlklkl/Ver1', 'tgz', '980749', '4', '20141024094950');
INSERT INTO `t_file` VALUES ('4', 'demo.tgz', 'Admin/test2222/Ver1', 'tgz', '980749', '2', '20141024101402');
INSERT INTO `t_file` VALUES ('5', 'demo.tgz', 'Admin/test33333/Ver1', 'tgz', '980749', '2', '20141024101451');
INSERT INTO `t_file` VALUES ('6', 'demo.tgz', 'Admin/test44444/Ver1', 'tgz', '980749', '2', '20141025133604');
INSERT INTO `t_file` VALUES ('7', 'demo.tgz', 'Admin/test55555/Ver1', 'tgz', '980749', '2', '20141025133822');
INSERT INTO `t_file` VALUES ('13', 'bom.xls', 'Admin/demo001/Ver1', 'xls', '28672', '2', '20141207171539');
INSERT INTO `t_file` VALUES ('14', 'demo.tgz', 'Admin/demo001/Ver1', 'tgz', '980749', '2', '20141207171539');
INSERT INTO `t_file` VALUES ('15', 'bom.xls', 'Admin/test002/Ver1', 'xls', '28672', '2', '20141207180432');
INSERT INTO `t_file` VALUES ('16', 'demo.tgz', 'Admin/test002/Ver1', 'tgz', '980749', '2', '20141207180432');
INSERT INTO `t_file` VALUES ('17', 'demo.tgz', 'Admin/demo001/Ver2', 'tgz', '980749', '2', '20141207220951');
INSERT INTO `t_file` VALUES ('18', 'demo.tgz', 'Admin/test002/Ver1', 'tgz', '980749', '2', '20141208073858');
INSERT INTO `t_file` VALUES ('19', 'demo.tgz', 'Admin/test1208001/Ver1', 'tgz', '980749', '2', '20141208074042');
INSERT INTO `t_file` VALUES ('20', '数字化集成软件二次开发内容及验收标准.xlsx', 'Admin/test2015011201/Ver1', 'xlsx', '13477', '2', '20150112092251');
INSERT INTO `t_file` VALUES ('21', '新建文本文档.txt', 'Admin/test20150112002/Ver1', 'txt', '7569', '2', '20150112092314');
INSERT INTO `t_file` VALUES ('22', 'scripts-Keda20141029.rar', 'Admin/scriptsKeda20141029/Ver1', 'rar', '4825437', '2', '20150112213353');
INSERT INTO `t_file` VALUES ('23', 'users.sql', 'Admin/users4444/Ver1', 'sql', '888', '2', '20150112213929');
INSERT INTO `t_file` VALUES ('24', '1.pdf', 'Admin/1erererererere/Ver1', 'pdf', '3008256', '2', '20150112214318');
INSERT INTO `t_file` VALUES ('25', '数字化集成软件二次开发内容及验收标准.xlsx', 'Admin/users33333333/Ver1', 'xlsx', '13477', '2', '20150112214906');
INSERT INTO `t_file` VALUES ('26', 'users.sql', 'Admin/users33333333/Ver1', 'sql', '888', '2', '20150112214906');
INSERT INTO `t_file` VALUES ('27', 'users.sql', 'Admin/users777777/Ver1', 'sql', '888', '2', '20150112223620');
INSERT INTO `t_file` VALUES ('28', 'PCBA Assy.pdf', 'Admin/qqq888888/Ver1', 'pdf', '3931742', '2', '20150112223652');
INSERT INTO `t_file` VALUES ('29', 'esop.sql', 'Admin/esop999999/Ver1', 'sql', '8471', '2', '20150112224314');
INSERT INTO `t_file` VALUES ('30', 'users.sql', 'Admin/users111111111/Ver1', 'sql', '888', '2', '20150112224400');
INSERT INTO `t_file` VALUES ('31', 'scripts-Keda20141029.rar', 'Admin/scriptsKeda20141029/Ver2', 'rar', '4825437', '2', '20150120144220');
INSERT INTO `t_file` VALUES ('32', 'scripts-Keda20141029.rar', 'Admin/scripts1111111/Ver1', 'rar', '4825437', '2', '20150120153644');
INSERT INTO `t_file` VALUES ('34', 'demo.tgz', 'Admin/demo/Ver1', 'tgz', '980749', '2', '20150120221933');
INSERT INTO `t_file` VALUES ('35', 'demo.tgz', 'Admin/demo0307/Ver1', 'tgz', '980749', '2', '20150307091233');
INSERT INTO `t_file` VALUES ('36', 'demo.tgz', 'jiwei1/demojiwei1/Ver1', 'tgz', '980749', '5', '20150307091543');

-- ----------------------------
-- Table structure for `t_group`
-- ----------------------------
DROP TABLE IF EXISTS `t_group`;
CREATE TABLE `t_group` (
  `F_ID` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `F_NAME` varchar(32) DEFAULT NULL COMMENT '用户组名称',
  `F_DESC` varchar(512) DEFAULT NULL COMMENT '用户组描述',
  PRIMARY KEY (`F_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户组表';

-- ----------------------------
-- Records of t_group
-- ----------------------------
INSERT INTO `t_group` VALUES ('1', '管理员', '系统管理员，负责维护系统');
INSERT INTO `t_group` VALUES ('2', '普通用户', '普通使用者');

-- ----------------------------
-- Table structure for `t_menu_group_dz`
-- ----------------------------
DROP TABLE IF EXISTS `t_menu_group_dz`;
CREATE TABLE `t_menu_group_dz` (
  `F_MENU_ID` int(10) DEFAULT NULL COMMENT '菜单ID',
  `F_GROUP_ID` int(10) DEFAULT NULL COMMENT '用户组ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜单-用户组对照表';

-- ----------------------------
-- Records of t_menu_group_dz
-- ----------------------------
INSERT INTO `t_menu_group_dz` VALUES ('1', '1');
INSERT INTO `t_menu_group_dz` VALUES ('2', '1');
INSERT INTO `t_menu_group_dz` VALUES ('3', '1');
INSERT INTO `t_menu_group_dz` VALUES ('4', '1');
INSERT INTO `t_menu_group_dz` VALUES ('5', '1');
INSERT INTO `t_menu_group_dz` VALUES ('6', '1');
INSERT INTO `t_menu_group_dz` VALUES ('7', '1');
INSERT INTO `t_menu_group_dz` VALUES ('8', '1');
INSERT INTO `t_menu_group_dz` VALUES ('1', '2');
INSERT INTO `t_menu_group_dz` VALUES ('2', '2');
INSERT INTO `t_menu_group_dz` VALUES ('3', '2');
INSERT INTO `t_menu_group_dz` VALUES ('4', '2');
INSERT INTO `t_menu_group_dz` VALUES ('5', '2');
INSERT INTO `t_menu_group_dz` VALUES ('8', '2');
INSERT INTO `t_menu_group_dz` VALUES ('9', '1');

-- ----------------------------
-- Table structure for `t_menu_list`
-- ----------------------------
DROP TABLE IF EXISTS `t_menu_list`;
CREATE TABLE `t_menu_list` (
  `F_ID` int(10) NOT NULL AUTO_INCREMENT,
  `F_MENU_NAME` varchar(32) DEFAULT NULL COMMENT '菜单名称',
  `F_URL` varchar(512) DEFAULT NULL COMMENT 'URL',
  `F_NEMU_LEVEL` int(2) DEFAULT NULL COMMENT '菜单层级',
  `F_PARENT_ID` int(10) DEFAULT NULL,
  PRIMARY KEY (`F_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='菜单表';

-- ----------------------------
-- Records of t_menu_list
-- ----------------------------
INSERT INTO `t_menu_list` VALUES ('1', '任务管理', null, '0', '0');
INSERT INTO `t_menu_list` VALUES ('2', '账户管理', null, '0', '0');
INSERT INTO `t_menu_list` VALUES ('3', '项目提交', 'project.do?method=getAddPage', '1', '1');
INSERT INTO `t_menu_list` VALUES ('4', '队列管理', 'project.do?method=queueManage', '1', '1');
INSERT INTO `t_menu_list` VALUES ('5', '结果下载', 'project.do?method=resultDownload', '1', '1');
INSERT INTO `t_menu_list` VALUES ('6', '新增账户', 'addUser.jsp', '1', '2');
INSERT INTO `t_menu_list` VALUES ('7', '帐户列表', 'user.do?method=getUserList', '1', '2');
INSERT INTO `t_menu_list` VALUES ('8', '个人资料', 'user.do?method=getModifyUser', '1', '2');
INSERT INTO `t_menu_list` VALUES ('9', '服务器监控', 'project.do?method=serverMonitor', '1', '1');

-- ----------------------------
-- Table structure for `t_project`
-- ----------------------------
DROP TABLE IF EXISTS `t_project`;
CREATE TABLE `t_project` (
  `F_ID` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `F_PROJECT_NAME` varchar(50) DEFAULT NULL COMMENT '项目名',
  `F_VERSION` int(3) DEFAULT '1' COMMENT '版本',
  `F_PCB_FILE` int(10) DEFAULT NULL COMMENT 'PCB文件包',
  `F_BOM_FILE` int(10) DEFAULT NULL COMMENT 'BOM文件',
  `F_PCB_FILE_NAME` varchar(128) DEFAULT NULL COMMENT 'PCB文件名',
  `F_BOM_FILE_NAME` varchar(128) DEFAULT NULL COMMENT 'BOM文件名',
  `F_CHECK_TYPE` int(10) DEFAULT NULL COMMENT '任务类型',
  `F_DFM_CHECK` varchar(4000) DEFAULT NULL COMMENT 'DFM检查,多选，用逗号隔开',
  `F_PCB_TYPE` int(10) DEFAULT NULL COMMENT '单板类型',
  `F_HDI_Model` int(10) DEFAULT NULL COMMENT 'HDI层叠方式',
  `F_Board_Thickness` double DEFAULT NULL COMMENT '板厚',
  `F_Panel_Model` int(10) DEFAULT NULL COMMENT '拼板方式',
  `F_Max_Heigh_Top` double DEFAULT NULL COMMENT 'Top面限高',
  `F_SubPCB_Num` int(5) DEFAULT NULL COMMENT '几拼板',
  `F_Max_Heigh_Bot` double DEFAULT NULL COMMENT 'Bottom面限高',
  `F_Railway_Position` int(10) DEFAULT NULL COMMENT '辅助边位置',
  `F_Viacap_layer` int(10) DEFAULT NULL COMMENT '过孔涂绿油',
  `F_Assembly_Process_Top` int(10) DEFAULT NULL COMMENT 'Top工艺路线',
  `F_Have_Pb` int(10) DEFAULT NULL COMMENT '是否有铅',
  `F_Assembly_Process_Bot` int(10) DEFAULT NULL COMMENT 'Bottom工艺路线',
  `F_Surface_Process` int(10) DEFAULT NULL COMMENT '表面处理方式',
  `F_Direction_Top` int(10) DEFAULT NULL COMMENT 'Top过板方向',
  `F_Primary_Side` int(10) DEFAULT NULL COMMENT '主要面',
  `F_Direction_Bot` int(10) DEFAULT NULL COMMENT 'Bottom过板方向',
  `F_SUBMIT_USERNAME` varchar(32) DEFAULT NULL COMMENT '提交人用户名',
  `F_SUBMIT_USER` int(10) DEFAULT NULL COMMENT '提交人',
  `F_SUBMIT_TIME` varchar(20) DEFAULT NULL COMMENT '提交时间',
  `F_END_TIME` varchar(20) DEFAULT NULL COMMENT '完成时间',
  `F_CHECK_TIME` int(10) DEFAULT NULL,
  `F_STATE` varchar(20) DEFAULT '待查' COMMENT '状态',
  `F_RUN_TIME` varchar(20) DEFAULT '-' COMMENT '运行时长',
  `F_PRI` int(5) DEFAULT NULL COMMENT '优先级',
  `F_FILE_RESULT` varchar(256) DEFAULT NULL COMMENT '结果文件',
  `F_SERVER` varchar(50) DEFAULT NULL COMMENT '服务器名',
  `F_CANCEL` int(1) DEFAULT '0' COMMENT '是否终止，0:否，1:是',
  `F_TASK_SERVER` varchar(50) DEFAULT '' COMMENT '抢得任务的服务器名',
  `F_SENT_MAIL` int(1) unsigned zerofill DEFAULT '0' COMMENT '是否请求发送邮件',
  `F_Direction_Bot_Fs` int(10) DEFAULT NULL COMMENT 'Bottom波峰过板方向',
  `F_Density` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`F_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='项目表，项目详细信息';

-- ----------------------------
-- Records of t_project
-- ----------------------------
INSERT INTO `t_project` VALUES ('1', 'demo0307', '1', '35', '0', 'demo.tgz', null, '77', 'NetlistCheck,Fiducial,Component,Padstack,Solderpaste,Pin2Pad,Testpoint,Drill,Signal Layer,P/G Layer,Silk Screen,Solder Mask,extchk1,extchk2,extchk3,extchk4,extchk5,extchk6,', '39', '4', '2', '60', '5', '2', '5', '8', '0', '59', '19', '53', '33', '21', '25', '29', 'Admin', '2', '20150307091233', '20150307091251', null, '完成', '0', '0', 'Result_For_demo0307_v1.zip', 'cns-wji-lt', '0', '', '1', '66', '61');
INSERT INTO `t_project` VALUES ('2', 'demojiwei1', '1', '36', '0', 'demo.tgz', null, '77', 'NetlistCheck,Fiducial,Component,Padstack,Solderpaste,Pin2Pad,Testpoint,Drill,Signal Layer,P/G Layer,Silk Screen,Solder Mask,extchk1,extchk2,extchk3,extchk4,extchk5,extchk6,', '39', '4', '2', '60', '5', '2', '5', '8', '0', '59', '19', '53', '33', '21', '25', '29', 'jiwei1', '5', '20150307091543', '20150307091600', null, '完成', '0', '0', 'Result_For_demojiwei1_v1.zip', 'cns-wji-lt', '0', '', '1', '66', '61');

-- ----------------------------
-- Table structure for `t_project_attr`
-- ----------------------------
DROP TABLE IF EXISTS `t_project_attr`;
CREATE TABLE `t_project_attr` (
  `F_ID` int(5) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `F_ATTR_EN_NAME` varchar(50) DEFAULT NULL COMMENT '项目属性英文名称',
  `F_ATTR_CN_NAME` varchar(50) DEFAULT NULL COMMENT '项目属性中文名称',
  `F_ATTR_DESC` varchar(512) DEFAULT NULL COMMENT '项目属性描述',
  PRIMARY KEY (`F_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='项目属性表';

-- ----------------------------
-- Records of t_project_attr
-- ----------------------------
INSERT INTO `t_project_attr` VALUES ('1', 'checkType', '任务类型', null);
INSERT INTO `t_project_attr` VALUES ('2', 'pcbType', '单板类型', null);
INSERT INTO `t_project_attr` VALUES ('3', 'hdiModel', 'HDI层叠方式', null);
INSERT INTO `t_project_attr` VALUES ('4', 'panelModel', '拼板方式', null);
INSERT INTO `t_project_attr` VALUES ('5', 'railwayPosition', '是否通过拼板增加辅助边', null);
INSERT INTO `t_project_attr` VALUES ('6', 'viacapLayer', '过孔涂绿油', null);
INSERT INTO `t_project_attr` VALUES ('7', 'assemblyProcessTop', 'Top工艺路线', null);
INSERT INTO `t_project_attr` VALUES ('8', 'havePb', '是否无铅', null);
INSERT INTO `t_project_attr` VALUES ('9', 'assemblyProcessBot', 'Bottom工艺路线', null);
INSERT INTO `t_project_attr` VALUES ('10', 'surfaceProcess', '表面处理方式', null);
INSERT INTO `t_project_attr` VALUES ('11', 'directionTop', 'Top过板方向', null);
INSERT INTO `t_project_attr` VALUES ('12', 'primarySide', '主要面', null);
INSERT INTO `t_project_attr` VALUES ('13', 'directionBot', 'Bottom过板方向', null);
INSERT INTO `t_project_attr` VALUES ('14', 'directionBotFs', 'Bottom波峰过板方向', null);
INSERT INTO `t_project_attr` VALUES ('16', 'density', '布局密度', null);

-- ----------------------------
-- Table structure for `t_project_attr_value`
-- ----------------------------
DROP TABLE IF EXISTS `t_project_attr_value`;
CREATE TABLE `t_project_attr_value` (
  `F_ID` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `F_ATTR_NAME` int(5) DEFAULT NULL COMMENT '属性类型，包括以下内容：\r\n            任务类型、单板类型、HDI层叠方式……',
  `F_ATTR_VALUE` varchar(50) DEFAULT NULL COMMENT '属性值',
  `F_IS_DEFAULT` int(1) DEFAULT '0',
  PRIMARY KEY (`F_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8 COMMENT='项目属性值表';

-- ----------------------------
-- Records of t_project_attr_value
-- ----------------------------
INSERT INTO `t_project_attr_value` VALUES ('2', '1', 'DFM自定义', '0');
INSERT INTO `t_project_attr_value` VALUES ('4', '3', 'N+N', '1');
INSERT INTO `t_project_attr_value` VALUES ('8', '5', '无', '1');
INSERT INTO `t_project_attr_value` VALUES ('9', '5', '上', '0');
INSERT INTO `t_project_attr_value` VALUES ('15', '6', 'Top', '0');
INSERT INTO `t_project_attr_value` VALUES ('16', '6', 'Bottom', '0');
INSERT INTO `t_project_attr_value` VALUES ('17', '6', 'Both', '1');
INSERT INTO `t_project_attr_value` VALUES ('18', '6', '不支持', '0');
INSERT INTO `t_project_attr_value` VALUES ('19', '8', '不支持', '1');
INSERT INTO `t_project_attr_value` VALUES ('21', '11', '从左到右', '1');
INSERT INTO `t_project_attr_value` VALUES ('22', '11', '从上到下', '0');
INSERT INTO `t_project_attr_value` VALUES ('23', '11', '从右到左', '0');
INSERT INTO `t_project_attr_value` VALUES ('24', '11', '从下到上', '0');
INSERT INTO `t_project_attr_value` VALUES ('25', '12', 'Top', '1');
INSERT INTO `t_project_attr_value` VALUES ('26', '12', 'Bottom', '0');
INSERT INTO `t_project_attr_value` VALUES ('27', '13', '从左到右', '0');
INSERT INTO `t_project_attr_value` VALUES ('28', '13', '从上到下', '0');
INSERT INTO `t_project_attr_value` VALUES ('29', '13', '从右到左', '1');
INSERT INTO `t_project_attr_value` VALUES ('30', '13', '从下到上', '0');
INSERT INTO `t_project_attr_value` VALUES ('33', '10', '不支持', '1');
INSERT INTO `t_project_attr_value` VALUES ('39', '2', '普通单板', '1');
INSERT INTO `t_project_attr_value` VALUES ('52', '9', 'FS: Full wave Solder', '0');
INSERT INTO `t_project_attr_value` VALUES ('53', '9', 'PS: Partial wave Solder', '1');
INSERT INTO `t_project_attr_value` VALUES ('54', '9', 'FR: Full Reflow', '0');
INSERT INTO `t_project_attr_value` VALUES ('57', '7', 'FS: Full wave Solder', '0');
INSERT INTO `t_project_attr_value` VALUES ('58', '7', 'PS: Partial wave Solder', '0');
INSERT INTO `t_project_attr_value` VALUES ('59', '7', 'FR: Full Reflow', '1');
INSERT INTO `t_project_attr_value` VALUES ('60', '4', '不支持', '1');
INSERT INTO `t_project_attr_value` VALUES ('61', '16', '高', '1');
INSERT INTO `t_project_attr_value` VALUES ('62', '16', '中', '0');
INSERT INTO `t_project_attr_value` VALUES ('63', '16', '低', '0');
INSERT INTO `t_project_attr_value` VALUES ('64', '14', '从左到右', '0');
INSERT INTO `t_project_attr_value` VALUES ('65', '14', '从上到下', '0');
INSERT INTO `t_project_attr_value` VALUES ('66', '14', '从右到左', '1');
INSERT INTO `t_project_attr_value` VALUES ('67', '14', '从下到上', '0');
INSERT INTO `t_project_attr_value` VALUES ('68', '5', '下', '0');
INSERT INTO `t_project_attr_value` VALUES ('69', '5', '左', '0');
INSERT INTO `t_project_attr_value` VALUES ('70', '5', '右', '0');
INSERT INTO `t_project_attr_value` VALUES ('71', '5', '上下', '0');
INSERT INTO `t_project_attr_value` VALUES ('72', '5', '左右', '0');
INSERT INTO `t_project_attr_value` VALUES ('73', '1', '预布局', '0');
INSERT INTO `t_project_attr_value` VALUES ('74', '1', '布局后', '0');
INSERT INTO `t_project_attr_value` VALUES ('75', '1', '预布线', '0');
INSERT INTO `t_project_attr_value` VALUES ('76', '1', '布线后', '0');
INSERT INTO `t_project_attr_value` VALUES ('77', '1', '投板', '1');
INSERT INTO `t_project_attr_value` VALUES ('78', '1', '网表比较', '0');
INSERT INTO `t_project_attr_value` VALUES ('79', '2', '背钻单板', '0');
INSERT INTO `t_project_attr_value` VALUES ('80', '2', '超大单板', '0');
INSERT INTO `t_project_attr_value` VALUES ('81', '3', '1+N+1', '0');
INSERT INTO `t_project_attr_value` VALUES ('82', '3', '2+N+2', '0');

-- ----------------------------
-- Table structure for `t_project_stage`
-- ----------------------------
DROP TABLE IF EXISTS `t_project_stage`;
CREATE TABLE `t_project_stage` (
  `F_ID` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `F_STAGE_NAME` varchar(100) DEFAULT NULL COMMENT '阶段名称',
  `F_STAGE_ORDER` int(3) DEFAULT NULL COMMENT '阶段顺序',
  `F_START_TIME` varchar(20) DEFAULT NULL COMMENT '阶段开始时间',
  `F_END_TIME` varchar(20) DEFAULT NULL COMMENT '阶段结束时间',
  `F_PROJECT_ID` int(10) DEFAULT NULL COMMENT '项目ID',
  PRIMARY KEY (`F_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=utf8 COMMENT='项目运行阶段状态表';

-- ----------------------------
-- Records of t_project_stage
-- ----------------------------
INSERT INTO `t_project_stage` VALUES ('160', 'Start Valor', '1', '20150307091551', null, '2');
INSERT INTO `t_project_stage` VALUES ('161', 'Import parameters', '2', '20150307091557', null, '2');
INSERT INTO `t_project_stage` VALUES ('162', 'Import PCB Data', '3', '20150307091557', null, '2');

-- ----------------------------
-- Table structure for `t_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `F_ID` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `F_NAME` varchar(32) DEFAULT NULL COMMENT '员工真实姓名',
  `F_USERNAME` varchar(32) DEFAULT NULL COMMENT '用户名，帐号',
  `F_PASSWORD` varchar(32) DEFAULT NULL COMMENT '密码',
  `F_DEPARTMENT` varchar(32) DEFAULT NULL COMMENT '所在部门',
  `F_PROJECT_GROUP` varchar(32) DEFAULT NULL COMMENT '项目组',
  `F_EMAIL` varchar(50) DEFAULT NULL COMMENT '电子邮件',
  `F_GROUP_ID` int(10) DEFAULT NULL COMMENT '用户组别',
  `F_STATUS` int(1) DEFAULT '0' COMMENT '0:可用，1：不可用',
  PRIMARY KEY (`F_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('2', '管理员', 'Admin', 'admin', '技术部', 'PCB设计', 'jiwei_sh@163.com', '1', '0');
INSERT INTO `t_user` VALUES ('5', 'jiwei1', 'jiwei1', 'jiwei1', 'www', 'www', 'jiweish@163.com', '2', '0');
INSERT INTO `t_user` VALUES ('6', 'jiwei2', 'jiwei2', 'jiwei2', 'jiwei2', 'jiwei2', 'jiwei2@163.com', '2', '0');
