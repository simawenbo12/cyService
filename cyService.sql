/*
Navicat MySQL Data Transfer

Source Server         : sima
Source Server Version : 50549
Source Host           : localhost:3306
Source Database       : cyservice

Target Server Type    : MYSQL
Target Server Version : 50549
File Encoding         : 65001

Date: 2019-03-09 16:39:05
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `area`
-- ----------------------------
DROP TABLE IF EXISTS `area`;
CREATE TABLE `area` (
  `a_id` int(4) NOT NULL AUTO_INCREMENT,
  `area_item` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`a_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of area
-- ----------------------------
INSERT INTO `area` VALUES ('1', '学1');
INSERT INTO `area` VALUES ('2', '学2');
INSERT INTO `area` VALUES ('3', '学3');
INSERT INTO `area` VALUES ('4', '学4');
INSERT INTO `area` VALUES ('5', '学5');
INSERT INTO `area` VALUES ('6', '学6');
INSERT INTO `area` VALUES ('7', '学7');
INSERT INTO `area` VALUES ('8', '学8');
INSERT INTO `area` VALUES ('9', '学9');
INSERT INTO `area` VALUES ('10', '学10');
INSERT INTO `area` VALUES ('11', '学11');
INSERT INTO `area` VALUES ('12', '学12');

-- ----------------------------
-- Table structure for `category`
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `c_id` int(4) NOT NULL AUTO_INCREMENT,
  `category_item` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '水龙头水池');
INSERT INTO `category` VALUES ('2', '电器');
INSERT INTO `category` VALUES ('3', '开关闸门');
INSERT INTO `category` VALUES ('4', '灯具');
INSERT INTO `category` VALUES ('5', '桌椅门窗');
INSERT INTO `category` VALUES ('6', '水箱花洒');
INSERT INTO `category` VALUES ('7', '其他');

-- ----------------------------
-- Table structure for `goods`
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `g_id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `name` varchar(10) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `img` varchar(50) DEFAULT NULL,
  `uptime` datetime DEFAULT NULL,
  `content` varchar(100) DEFAULT NULL,
  `state` int(4) DEFAULT NULL,
  `u_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`g_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('1', '闲置台灯一盏', '50.2', '马哥', '15625522395', null, '2019-03-02 15:25:29', '黑色暖光灯', '0', '69');
INSERT INTO `goods` VALUES ('2', 'iphone6s手机一部', '1600', '李铭', 'QQ 23248482', 'upload/a6cdbeaf233f457f8ffe0e4b15566faa.jpg', '2019-03-02 16:19:48', '垃圾成色', '1', '69');
INSERT INTO `goods` VALUES ('3', '计算机网络', '10', '刘明', '微信 smwb2923', 'upload/7fe359c9a605432b92e928887e84663a.png', '2019-03-02 18:09:00', '要的人请微信联系我', '0', '13');
INSERT INTO `goods` VALUES ('4', 'PS4手柄', '200', '荣未', '15699393932', null, '2019-03-02 18:55:43', '使用时间一年左右，无病无修', '0', '13');
INSERT INTO `goods` VALUES ('5', 'xps15笔记本电脑', '4500', '司马', '15625580661', 'upload/3cda1da39c3e4c56b555599eb8e71be8.jpg', '2019-03-02 19:45:14', ' 使用时间2年 8成新', '0', '25');

-- ----------------------------
-- Table structure for `lost`
-- ----------------------------
DROP TABLE IF EXISTS `lost`;
CREATE TABLE `lost` (
  `l_id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) DEFAULT NULL,
  `content` varchar(100) DEFAULT NULL,
  `name` varchar(10) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `img` varchar(50) DEFAULT NULL,
  `uptime` datetime DEFAULT NULL,
  `state` int(4) DEFAULT NULL,
  `kinds` int(10) DEFAULT NULL,
  `u_id` int(4) DEFAULT NULL,
  PRIMARY KEY (`l_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lost
-- ----------------------------
INSERT INTO `lost` VALUES ('1', '有一个小米的充电宝掉了', '好像掉在操场上', '小龙', '15923829292', 'upload/29b6dd20995a4d36a2feacbeefbd7027.png', '2019-02-17 19:43:38', '1', '0', '25');
INSERT INTO `lost` VALUES ('2', '手机遗失', '华为P9Plus ，在学校操场遗失', '李双', '13299329932', 'upload/57e91bbd02fa425ebe3fe2bcc3e85cf6.jpg', '2019-02-08 19:27:36', '0', '0', '9');
INSERT INTO `lost` VALUES ('3', '捡到一个身份证', '在饭堂捡到的，名字是 XXX ，这位同学速来拿走你的身份证', '王晓晓', '18886668888', 'upload/7fe359c9a605432b92e928887e84663a.png', '2019-02-11 21:30:18', '0', '1', '8');
INSERT INTO `lost` VALUES ('4', '捡到一把黑色的雨伞', '在教学楼7A311捡到的', '肖凯', 'qq 23899382', null, '2019-02-08 17:24:26', '0', '1', '26');
INSERT INTO `lost` VALUES ('5', '掉了一个充电宝', '估计在学校体育馆掉的', '小刘', 'qq 493188516', 'upload/a6cdbeaf233f457f8ffe0e4b15566faa.jpg', '2019-02-12 15:08:32', '0', '0', '25');
INSERT INTO `lost` VALUES ('6', '学3楼下捡到一罐零食', '请有缘人速来', '龙哥', '学5A511', 'upload/83fe0bf22d494e7fac3a2e5ffe2c11f1.png', '2019-02-12 15:19:07', '0', '1', '13');
INSERT INTO `lost` VALUES ('7', '丢失一本学生证', '......', '马小哥', '微信 smwb136165', 'upload/2633611d1db946c4b4c785e615243771.jpg', '2019-03-01 17:18:12', '0', '0', '69');

-- ----------------------------
-- Table structure for `notice`
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `n_id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `content` text,
  `uptime` datetime DEFAULT NULL,
  `img` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`n_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES ('1', '关于调整学生公寓供电时间的通知', '<p style=\"text-align: center; padding: 0px; color: rgb(51, 51, 51); white-space: normal; text-indent: 37px; line-height: 1.5em;\"><strong><span style=\"font-family:宋体\">通知&nbsp;&nbsp;</span></strong></p><p style=\"padding: 0px; color: rgb(51, 51, 51); white-space: normal; text-indent: 37px; line-height: 2em;\"><span style=\"font-family: 宋体; text-align: left; font-size: 14px;\">根据学校工作安排，期末考试临近，毕业生已进入毕业准备答辩阶段，为方便同学们的学习和生活，同时考虑到夏季将临，天气日渐炎热，经研究，决定对学生公寓夏季供电时间作适当调整，具体如下：</span></p><p style=\"padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, arial, sans-serif; font-size: 14px; white-space: normal; text-indent: 37px; text-align: left; line-height: 2em;\"><span style=\"line-height: 32px; font-family: 宋体; font-size: 14px;\">1、从X月XX日起，实行XX小时供电。</span></p><p style=\"padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, arial, sans-serif; font-size: 14px; white-space: normal; text-indent: 37px; text-align: left; line-height: 2em;\"><span style=\"text-align: center; line-height: 32px; font-family: 宋体; font-size: 14px;\">2、请同学们维持正常的作息时间，尽早熄灯就寝，不影响他人学习和休息。</span></p><p><br/></p><p style=\"text-align: center;\"><br/></p>', '2019-01-15 15:34:58', '');
INSERT INTO `notice` VALUES ('2', '停电通知', '<p style=\"padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, arial, sans-serif; font-size: 14px; white-space: normal; margin-top: 0px; margin-bottom: 13px; line-height: normal;\"><span style=\"line-height: 38px; font-family: 宋体; font-size: 14px;\">校属各单位：</span></p><p style=\"padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, arial, sans-serif; font-size: 14px; white-space: normal; text-indent: 37px; margin-top: 0px; margin-bottom: 13px; line-height: normal;\"><span style=\"line-height: 38px; font-family: 宋体; font-size: 14px;\">按照学校暑期工作计划，后勤管理服务中心将对我校一期高压设施进行更换、维护，于201X年X月XX日至X月XX日，对我校一期高压停电维护，届时会造成我校大部分区域停电。</span></p><p style=\"padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, arial, sans-serif; font-size: 14px; white-space: normal; text-indent: 37px; margin-top: 0px; margin-bottom: 13px; line-height: normal;\"><span style=\"line-height: 38px; font-family: 宋体; font-size: 14px;\">预计停电时间：X月XX日8：00——X月XX日20：00。</span></p><p style=\"padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, arial, sans-serif; font-size: 14px; white-space: normal; text-indent: 37px; margin-top: 0px; margin-bottom: 13px; line-height: normal;\"><span style=\"line-height: 38px; font-family: 宋体; font-size: 14px;\">停电范围：1-12号宿舍楼。</span></p><p style=\"padding: 0px; color: rgb(51, 51, 51); font-family: 微软雅黑, arial, sans-serif; font-size: 14px; white-space: normal; text-indent: 37px; margin-top: 0px; margin-bottom: 13px; line-height: normal;\"><span style=\"line-height: 38px; font-family: 宋体; font-size: 14px;\">特此通知！</span></p><p><br/></p>', '2019-01-15 22:48:04', 'upload/83fe0bf22d494e7fac3a2e5ffe2c11f1.png');
INSERT INTO `notice` VALUES ('3', '我校召开校园安全工作会议', '<p style=\"margin-block-start: 0.5em; margin-block-end: 0.5em; font-size: 25px;\">我院召开校园安全工作会议</p><p style=\"margin-block-start: 0.5em; margin-block-end: 0.5em;\">1月3日下午，我院校园安全工作会议暨2019年治安综合治理、消防安全目标管理责任书签订仪式在行政楼112会议室举行。院领导王卫平、刘玉侠、林江龙和各单位负责人出席了会议。副院长刘玉侠主持了会议。</p><p style=\"margin-block-start: 0.5em; margin-block-end: 0.5em;\">后勤保卫处处长王锦锋、实验中心主任葛卫清分别就2018年我院校园安全工作、实验室安全工作等作了年度总结汇报。后勤保卫处副处长刘维仝就近期安全工作的有关文件精神进行了传达，强调各单位要做好禁毒和岁末年初消防安全、安全生产等工作。</p><p style=\"margin-block-start: 0.5em; margin-block-end: 0.5em;\">为明确安全责任主体，我院在安全管理方面实行单位负责人安全责任制，并纳入考核机制，要求各单位将治安综合治理及消防安全工作切实纳入日常工作中。王卫平院长代表学院与各教学单位、行政教辅单位的负责人代表分别签订了2019年度《治安综合治理目标管理责任书》《消防安全工作目标管理责任书》。</p><p style=\"margin-block-start: 0.5em; margin-block-end: 0.5em;\">王卫平院长表示，2019年是至关重要的一年，要求各单位不仅要在日常工作上要将安全工作做好抓牢，更要在意识形态上做到安全工作不放松，牢固树立安全责任意识，认真排查各类安全隐患，杜绝安全事故发生，保障学院的安全平稳发展。</p><p style=\"text-align: center\"><img src=\"/cyService/ueditor/jsp/upload/image/20190228/1551316611925090448.jpg\" title=\"1551316611925090448.jpg\"/></p><p style=\"text-align: center\"><img src=\"/cyService/ueditor/jsp/upload/image/20190228/1551316615560089003.jpg\" title=\"1551316615560089003.jpg\"/></p><p style=\"text-align: center;\"><br/></p>', '2019-01-24 14:48:53', '');
INSERT INTO `notice` VALUES ('4', '紧急停电通知', '<p style=\"white-space: normal;\"><br/><span style=\"font-size: 20px;\">&nbsp; &nbsp; &nbsp; &nbsp; 因明天要进行线路修理，我们决定在3月8日停电一天（早上8点至下午4点）。我们的工作可能给您带来了一些不必要的麻烦，希望大家可以谅解！</span></p><p style=\"white-space: normal;\"><br/><span style=\"font-size: 20px;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;<span style=\"font-size: 16px;\">&nbsp; &nbsp; &nbsp;&nbsp;2019年3月6日<br/>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;后勤管理中心</span></span></p><p><br/></p>', '2019-03-06 15:47:14', 'upload/532356c84baf416b9494fd9072b19c4c.png');

-- ----------------------------
-- Table structure for `progress`
-- ----------------------------
DROP TABLE IF EXISTS `progress`;
CREATE TABLE `progress` (
  `p_id` int(10) NOT NULL AUTO_INCREMENT,
  `uptime` datetime DEFAULT NULL,
  `action` varchar(100) DEFAULT NULL,
  `r_id` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`p_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of progress
-- ----------------------------
INSERT INTO `progress` VALUES ('1', '2019-03-06 15:08:48', '用户报修，等待维修员接单或后期管理中心指派', '20190306001');
INSERT INTO `progress` VALUES ('2', '2019-03-06 15:10:05', '用户报修，等待维修员接单或后期管理中心指派', '20190306002');
INSERT INTO `progress` VALUES ('3', '2019-03-06 15:10:52', '用户报修，等待维修员接单或后期管理中心指派', '20190306003');
INSERT INTO `progress` VALUES ('4', '2019-03-06 15:11:51', '用户报修，等待维修员接单或后期管理中心指派', '20190306004');
INSERT INTO `progress` VALUES ('5', '2019-03-06 15:23:26', '用户报修，等待维修员接单或后期管理中心指派', '20190306005');
INSERT INTO `progress` VALUES ('6', '2019-03-06 15:58:03', '用户报修，等待维修员接单或后期管理中心指派', '20190306006');
INSERT INTO `progress` VALUES ('7', '2019-03-06 15:58:57', '用户报修，等待维修员接单或后期管理中心指派', '20190306007');
INSERT INTO `progress` VALUES ('8', '2019-03-06 15:59:59', '用户报修，等待维修员接单或后期管理中心指派', '20190306008');
INSERT INTO `progress` VALUES ('9', '2019-03-06 16:00:41', '用户报修，等待维修员接单或后期管理中心指派', '20190306009');
INSERT INTO `progress` VALUES ('10', '2019-03-06 16:03:23', '用户报修，等待维修员接单或后期管理中心指派', '20190306010');
INSERT INTO `progress` VALUES ('11', '2019-03-06 16:03:49', '用户报修，等待维修员接单或后期管理中心指派', '20190306011');
INSERT INTO `progress` VALUES ('12', '2019-03-06 16:04:34', '用户报修，等待维修员接单或后期管理中心指派', '20190306012');
INSERT INTO `progress` VALUES ('13', '2019-03-06 16:15:11', '用户报修，等待维修员接单或后期管理中心指派', '20190306013');
INSERT INTO `progress` VALUES ('14', '2019-03-06 16:16:21', '用户报修，等待维修员接单或后期管理中心指派', '20190306014');
INSERT INTO `progress` VALUES ('15', '2019-03-06 16:19:18', '用户报修，等待维修员接单或后期管理中心指派', '20190306015');
INSERT INTO `progress` VALUES ('16', '2019-03-06 16:20:55', '用户报修，等待维修员接单或后期管理中心指派', '20190306016');
INSERT INTO `progress` VALUES ('17', '2019-03-06 16:22:13', '用户报修，等待维修员接单或后期管理中心指派', '20190306017');
INSERT INTO `progress` VALUES ('18', '2019-03-06 16:23:19', '用户报修，等待维修员接单或后期管理中心指派', '20190306018');
INSERT INTO `progress` VALUES ('19', '2019-03-06 16:24:17', '用户报修，等待维修员接单或后期管理中心指派', '20190306019');
INSERT INTO `progress` VALUES ('20', '2019-03-06 16:27:21', '维修员【秦子洋】【18720936757】在APP端接受维修', '20190306001');
INSERT INTO `progress` VALUES ('21', '2019-03-06 16:27:24', '维修员【秦子洋】【18720936757】在APP端接受维修', '20190306003');
INSERT INTO `progress` VALUES ('22', '2019-03-06 16:27:34', '维修员【秦子洋】【18720936757】在APP端接受维修', '20190306005');
INSERT INTO `progress` VALUES ('23', '2019-03-06 16:27:37', '维修员【秦子洋】【18720936757】在APP端接受维修', '20190306006');
INSERT INTO `progress` VALUES ('24', '2019-03-06 16:27:53', '维修员【秦子洋】【18720936757】在APP端确认维修完成', '20190306001');
INSERT INTO `progress` VALUES ('25', '2019-03-06 16:28:02', '维修员【秦子洋】【18720936757】在APP端设置维修单为疑难问题，待解决', '20190306005');
INSERT INTO `progress` VALUES ('26', '2019-03-06 16:28:36', '维修员【袁跃华】【15989308535】在APP端接受维修', '20190306002');
INSERT INTO `progress` VALUES ('27', '2019-03-06 16:28:40', '维修员【袁跃华】【15989308535】在APP端接受维修', '20190306004');
INSERT INTO `progress` VALUES ('28', '2019-03-06 16:28:44', '维修员【袁跃华】【15989308535】在APP端接受维修', '20190306007');
INSERT INTO `progress` VALUES ('29', '2019-03-06 16:28:47', '维修员【袁跃华】【15989308535】在APP端接受维修', '20190306008');
INSERT INTO `progress` VALUES ('30', '2019-03-06 16:29:01', '维修员【袁跃华】【15989308535】在APP端确认维修完成', '20190306002');
INSERT INTO `progress` VALUES ('31', '2019-03-06 16:29:04', '维修员【袁跃华】【15989308535】在APP端确认维修完成', '20190306007');
INSERT INTO `progress` VALUES ('32', '2019-03-06 16:29:06', '维修员【袁跃华】【15989308535】在APP端设置维修单为疑难问题，待解决', '20190306004');
INSERT INTO `progress` VALUES ('33', '2019-03-06 16:30:10', '维修员【司马文铂】【15625527015】在APP端接受维修', '20190306009');
INSERT INTO `progress` VALUES ('34', '2019-03-06 16:30:12', '维修员【司马文铂】【15625527015】在APP端接受维修', '20190306010');
INSERT INTO `progress` VALUES ('35', '2019-03-06 16:30:14', '维修员【司马文铂】【15625527015】在APP端接受维修', '20190306011');
INSERT INTO `progress` VALUES ('36', '2019-03-06 16:30:25', '维修员【司马文铂】【15625527015】在APP端接受维修', '20190306012');
INSERT INTO `progress` VALUES ('37', '2019-03-06 16:30:27', '维修员【司马文铂】【15625527015】在APP端接受维修', '20190306013');
INSERT INTO `progress` VALUES ('38', '2019-03-06 16:30:32', '维修员【司马文铂】【15625527015】在APP端接受维修', '20190306014');
INSERT INTO `progress` VALUES ('39', '2019-03-06 16:30:45', '维修员【司马文铂】【15625527015】在APP端确认维修完成', '20190306010');
INSERT INTO `progress` VALUES ('40', '2019-03-06 16:30:48', '维修员【司马文铂】【15625527015】在APP端确认维修完成', '20190306013');
INSERT INTO `progress` VALUES ('41', '2019-03-06 16:31:23', '后勤管理中心变更维修状态为：【已完工】。', '20190306005');
INSERT INTO `progress` VALUES ('42', '2019-03-06 16:31:39', '维修员【司马文铂】【15625527015】在APP端接受维修', '20190306017');
INSERT INTO `progress` VALUES ('43', '2019-03-06 16:31:42', '维修员【司马文铂】【15625527015】在APP端接受维修', '20190306015');
INSERT INTO `progress` VALUES ('44', '2019-03-06 16:32:01', '维修员【司马文铂】【15625527015】在APP端设置维修单为疑难问题，待解决', '20190306011');
INSERT INTO `progress` VALUES ('45', '2019-03-06 16:32:05', '维修员【司马文铂】【15625527015】在APP端确认维修完成', '20190306009');
INSERT INTO `progress` VALUES ('46', '2019-03-06 16:32:10', '维修员【司马文铂】【15625527015】在APP端确认维修完成', '20190306014');
INSERT INTO `progress` VALUES ('47', '2019-03-06 16:35:17', '用户报修，等待维修员接单或后期管理中心指派', '20190306020');
INSERT INTO `progress` VALUES ('48', '2019-03-06 16:35:50', '后勤管理中心指派【李阳】【15625524233】进行维修', '20190306020');
INSERT INTO `progress` VALUES ('49', '2019-03-06 19:54:42', '后勤管理中心指派【司马文铂】【15625527015】进行维修', '20190306016');
INSERT INTO `progress` VALUES ('50', '2019-03-09 13:30:00', '用户或维修员超时未确认，系统已自动确认维修完成', '20190306003');
INSERT INTO `progress` VALUES ('51', '2019-03-09 13:30:00', '用户或维修员超时未确认，系统已自动确认维修完成', '20190306006');
INSERT INTO `progress` VALUES ('52', '2019-03-09 13:30:01', '用户或维修员超时未确认，系统已自动确认维修完成', '20190306008');
INSERT INTO `progress` VALUES ('53', '2019-03-09 13:30:01', '用户或维修员超时未确认，系统已自动确认维修完成', '20190306012');
INSERT INTO `progress` VALUES ('54', '2019-03-09 13:30:01', '用户或维修员超时未确认，系统已自动确认维修完成', '20190306015');
INSERT INTO `progress` VALUES ('55', '2019-03-09 13:30:01', '用户或维修员超时未确认，系统已自动确认维修完成', '20190306016');
INSERT INTO `progress` VALUES ('56', '2019-03-09 13:30:01', '用户或维修员超时未确认，系统已自动确认维修完成', '20190306017');
INSERT INTO `progress` VALUES ('57', '2019-03-09 13:30:01', '用户或维修员超时未确认，系统已自动确认维修完成', '20190306020');
INSERT INTO `progress` VALUES ('58', '2019-03-09 13:41:17', '用户报修，等待维修员接单或后期管理中心指派', '20190309001');
INSERT INTO `progress` VALUES ('59', '2019-03-09 13:43:06', '用户报修，等待维修员接单或后期管理中心指派', '20190309002');

-- ----------------------------
-- Table structure for `repair`
-- ----------------------------
DROP TABLE IF EXISTS `repair`;
CREATE TABLE `repair` (
  `r_id` varchar(15) NOT NULL,
  `title` varchar(20) DEFAULT NULL,
  `content` varchar(100) DEFAULT NULL,
  `homestart` int(4) DEFAULT NULL,
  `a_id` int(4) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `c_id` int(4) DEFAULT NULL,
  `name` varchar(10) DEFAULT NULL,
  `telephone` varchar(11) DEFAULT NULL,
  `img` varchar(50) DEFAULT NULL,
  `uptime` datetime DEFAULT NULL,
  `state` int(4) DEFAULT NULL,
  `u_id` int(10) DEFAULT NULL,
  `m_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`r_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of repair
-- ----------------------------
INSERT INTO `repair` VALUES ('20190306001', '灯泡炸了', '', '2', '5', 'd402', '5', '司马', '18122933948', null, '2019-03-06 15:08:48', '2', '69', '19');
INSERT INTO `repair` VALUES ('20190306002', '洗手池漏水', '', '1', '9', 'd411', '1', '司马', '18122933948', null, '2019-03-06 15:10:05', '2', '69', '24');
INSERT INTO `repair` VALUES ('20190306003', '空调不制冷', '', '0', '8', 'd115', '2', '刘宁', '18122933958', null, '2019-03-06 15:10:52', '2', '69', '19');
INSERT INTO `repair` VALUES ('20190306004', '椅子断了个腿', '', '2', '2', 'd414', '5', '吴攀越', '18122883955', null, '2019-03-06 15:11:51', '3', '69', '24');
INSERT INTO `repair` VALUES ('20190306005', '水龙头关不上，一直漏水', '', '1', '3', '3d311', '1', 'czb', '15816601368', null, '2019-03-06 15:23:26', '2', '71', '19');
INSERT INTO `repair` VALUES ('20190306006', '门扣锁坏了', '', '1', '1', 'a103', '5', '李双', '17459333435', 'upload/6564ae4cb3b0484a9d02c5f702d9f164.jpg', '2019-03-06 15:58:03', '2', '2', '19');
INSERT INTO `repair` VALUES ('20190306007', '电风扇不转', '急。。。在线等', '0', '4', 'd d311', '2', '李四', '17459333433', null, '2019-03-06 15:58:57', '2', '2', '24');
INSERT INTO `repair` VALUES ('20190306008', '浴室下水道堵塞', '', '2', '6', 'b305', '6', '李四', '17459333433', null, '2019-03-06 15:59:59', '2', '2', '24');
INSERT INTO `repair` VALUES ('20190306009', '淋浴喷头关不住水', '', '1', '7', 'c405', '6', '李四', '17459333433', null, '2019-03-06 16:00:41', '2', '2', '25');
INSERT INTO `repair` VALUES ('20190306010', '厕所门坏了', '', '1', '10', 'a311', '5', '小米', '18682480111', null, '2019-03-06 16:03:23', '2', '10', '25');
INSERT INTO `repair` VALUES ('20190306011', '空调需要加制冷剂', '', '2', '11', 'd402', '2', '小米', '18682480111', null, '2019-03-06 16:03:49', '3', '10', '25');
INSERT INTO `repair` VALUES ('20190306012', '插座烧坏了', '', '2', '11', 'c211', '2', '小米', '18682480111', null, '2019-03-06 16:04:34', '2', '10', '25');
INSERT INTO `repair` VALUES ('20190306013', '灯泡炸了', '', '0', '12', 'd211', '4', '陈光', '15625521111', null, '2019-03-06 16:15:11', '2', '6', '25');
INSERT INTO `repair` VALUES ('20190306014', '水龙头闸门关不上', '急。。。。', '1', '6', 'c305', '3', '陈光', '15625521111', null, '2019-03-06 16:16:21', '2', '6', '25');
INSERT INTO `repair` VALUES ('20190306015', '厕所门槛缺了一块', '如图所示', '2', '4', 'a110', '7', '陈光', '15625521111', 'upload/6113995a1a354b0a9d34c06e5a5e94a8.jpg', '2019-03-06 16:19:18', '2', '6', '25');
INSERT INTO `repair` VALUES ('20190306016', '浴室灯不亮了', '', '1', '3', 'a311', '4', '陈泽', '13892938552', null, '2019-03-06 16:20:55', '2', '9', '25');
INSERT INTO `repair` VALUES ('20190306017', '浴室的水开关掉了', '', '2', '6', 'a315', '3', '陈泽', '13892938552', null, '2019-03-06 16:22:13', '2', '9', '25');
INSERT INTO `repair` VALUES ('20190306018', '电风扇不转了', '急不可耐', '2', '6', 'a512', '2', '陈泽', '13892938552', null, '2019-03-06 16:23:19', '0', '9', null);
INSERT INTO `repair` VALUES ('20190306019', '水池堵塞且漏水', '', '2', '7', 'a501', '1', '陈泽', '13892938552', null, '2019-03-06 16:24:17', '0', '9', null);
INSERT INTO `repair` VALUES ('20190306020', '阳台灯不亮了', '', '2', '10', 'a211', '4', '刘龙', '15625527019', null, '2019-03-06 16:35:16', '2', '25', '36');
INSERT INTO `repair` VALUES ('20190309001', '厕所冲水的坏了', '急。。。', '2', '1', 'a111', '7', '刘技', '18122933922', null, '2019-03-09 13:41:17', '0', '70', null);
INSERT INTO `repair` VALUES ('20190309002', '浴室下水道堵塞', '', '1', '9', 'c208', '7', '刘技', '18122933922', null, '2019-03-09 13:43:06', '0', '70', null);

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `u_id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(15) DEFAULT NULL,
  `password` varchar(15) DEFAULT NULL,
  `name` varchar(15) DEFAULT NULL,
  `telephone` varchar(11) DEFAULT NULL,
  `identity` int(4) DEFAULT NULL,
  `img` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`u_id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', 'admin', '管理员', '', '0', null);
INSERT INTO `user` VALUES ('2', '201692382932', 'sima1234', '李四', '17459333433', '1', null);
INSERT INTO `user` VALUES ('3', '201692328323', '123232332', '张三', '15232323232', '1', null);
INSERT INTO `user` VALUES ('4', '232674', 'asd23456', '王五', '18634838384', '2', null);
INSERT INTO `user` VALUES ('5', '323467', '2321a2337', '赵六', '18634832342', '2', null);
INSERT INTO `user` VALUES ('6', '201523239233', '12232322', '陈光', '15625521111', '1', null);
INSERT INTO `user` VALUES ('7', '201535923653', 'sima1234', '熊小明', '15625521112', '1', null);
INSERT INTO `user` VALUES ('8', '201535020377', 'sima1234', '李四', '15625527016', '1', null);
INSERT INTO `user` VALUES ('9', '201536388294', 'sima23423', '陈泽', '13892938552', '1', null);
INSERT INTO `user` VALUES ('10', '201535010293', 'ak452ka2', '小米', '18682480111', '1', null);
INSERT INTO `user` VALUES ('19', '133215', 'akskkss', '秦子洋', '18720936757', '2', null);
INSERT INTO `user` VALUES ('24', '232461', 'akd23325', '袁跃华', '15989308535', '2', null);
INSERT INTO `user` VALUES ('25', '201503', 'sima1234', '司马文铂', '15625527015', '2', 'upload/4914f7b082734e0a86a1c8fba263b9c5.jpg');
INSERT INTO `user` VALUES ('35', '203993', 'sima1234', '李双江', '13650376317', '2', null);
INSERT INTO `user` VALUES ('36', '135743', '2321a232', '李阳', '15625524233', '2', null);
INSERT INTO `user` VALUES ('37', '282824', 'skd231', '刘㜛', '18692948573', '2', null);
INSERT INTO `user` VALUES ('38', '234513', 'sima1234', '杨流锦', '15672347846', '2', null);
INSERT INTO `user` VALUES ('69', '201535020329', 'sima1234', '司马', '18122933948', '1', 'upload/acfe3a1279a844b59b683b7590ff2277.jpg');
INSERT INTO `user` VALUES ('70', '201535029999', '12345623', '刘技', '18122933922', '1', 'upload/c2db3be3765244f09502a6cc432765b4.jpg');
INSERT INTO `user` VALUES ('71', '201535020304', '123456', '12345', '15816601368', '1', 'upload/ba32e3d8fdf74d588a46010eca02773a.jpg');
