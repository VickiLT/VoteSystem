/*
Navicat MySQL Data Transfer

Source Server         : Root
Source Server Version : 50719
Source Host           : localhost:3306
Source Database       : votesystem

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2018-05-21 20:17:53
*/
SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for details
-- ----------------------------
DROP TABLE IF EXISTS `details`;
CREATE TABLE `details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '投票统计表2',
  `vote_project_id` bigint(20) DEFAULT NULL,
  `voter` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of details
-- ----------------------------

-- ----------------------------
-- Table structure for file
-- ----------------------------
DROP TABLE IF EXISTS `file`;
CREATE TABLE `file` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `vote_project_id` bigint(20) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `filepath` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of file
-- ----------------------------

-- ----------------------------
-- Table structure for manager
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理员id',
  `name` varchar(25) NOT NULL COMMENT '管理员用户名',
  `password` varchar(255) NOT NULL,
  `tel` varchar(25) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(25) DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of manager
-- ----------------------------
INSERT INTO `manager` VALUES ('1', '孙文伟', '74b44e49860986583274eb37454382f4555ef0de49b0ad0b', null, null);

-- ----------------------------
-- Table structure for operate_log
-- ----------------------------
DROP TABLE IF EXISTS `operate_log`;
CREATE TABLE `operate_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `operate_id` bigint(20) DEFAULT NULL COMMENT '操作人id',
  `operate_name` varchar(255) DEFAULT NULL COMMENT '操作人姓名',
  `operate_content` varchar(255) DEFAULT NULL COMMENT '操作内容',
  `operate_time` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of operate_log
-- ----------------------------

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '资源权限表',
  `resource` varchar(255) DEFAULT NULL COMMENT 'url路径',
  `description` varchar(255) DEFAULT NULL COMMENT '路径描述',
  `permission` varchar(255) DEFAULT NULL COMMENT '允许权限集合，1为管理员，2为委员，3为秘书',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '/manage/managerManage', '管理员信息管理', '1');
INSERT INTO `role` VALUES ('2', '/manage/userManage', '委员信息管理', '1');
INSERT INTO `role` VALUES ('3', '/manage/secretaryManage', '秘书信息管理', '1');
INSERT INTO `role` VALUES ('4', '/frame', '共用url 无需拦截', '123');
INSERT INTO `role` VALUES ('5', '/vote/createVote/firstStep', '创建投票', '13');
INSERT INTO `role` VALUES ('6', '/vote/createVote/show', '创建投票', '13');
INSERT INTO `role` VALUES ('7', '/vote/manageVote', '管理投票', '13');
INSERT INTO `role` VALUES ('8', '/vote/voteProject/load', '加载数据', '123');
INSERT INTO `role` VALUES ('9', '/vote/voteProject/tab1Load', '加载数据', '123');
INSERT INTO `role` VALUES ('10', '/vote/voteProject/tab2Load', '加载数据', '123');
INSERT INTO `role` VALUES ('11', '/vote/manageVote/search', '查询数据', '123');
INSERT INTO `role` VALUES ('12', '/vote/search', '查询数据', '123');
INSERT INTO `role` VALUES ('13', '/vote/search1', '查询数据', '123');
INSERT INTO `role` VALUES ('14', '/vote/delete', '删除数据', '13');
INSERT INTO `role` VALUES ('15', '/vote/toUpdate', '更新投票项目', '13');
INSERT INTO `role` VALUES ('16', '/vote/update', '更新投票项目', '13');
INSERT INTO `role` VALUES ('17', '/vote/updateConsoleDlg', '弹框', '13');
INSERT INTO `role` VALUES ('18', '/vote/consoleDlg', '弹框', '13');
INSERT INTO `role` VALUES ('19', '/vote/showVoteDetails', '投票页面', '12');
INSERT INTO `role` VALUES ('20', '/vote/vote', '投票', '12');
INSERT INTO `role` VALUES ('21', '/vote/showVoteResults', '查看投票结果', '12');
INSERT INTO `role` VALUES ('22', '/vote/showVoteProjectDetails', '投票项目详细介绍', '123');
INSERT INTO `role` VALUES ('23', '/user/loginOut', '注销', '123');
INSERT INTO `role` VALUES ('24', '/file/uploadFile', '文件上传', '123');
INSERT INTO `role` VALUES ('25', '/file/downFile', '文件下载', '123');

-- ----------------------------
-- Table structure for secretary
-- ----------------------------
DROP TABLE IF EXISTS `secretary`;
CREATE TABLE `secretary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `tel` varchar(25) DEFAULT NULL,
  `email` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of secretary
-- ----------------------------

-- ----------------------------
-- Table structure for secretkey
-- ----------------------------
DROP TABLE IF EXISTS `secretkey`;
CREATE TABLE `secretkey` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '密钥表',
  `vote_details_id` bigint(20) DEFAULT NULL,
  `R1` varchar(255) DEFAULT NULL,
  `R2` varchar(255) DEFAULT NULL,
  `ET1` varchar(255) DEFAULT NULL,
  `num1` int(11) DEFAULT NULL,
  `ET2` varchar(255) DEFAULT NULL,
  `num2` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of secretkey
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `name` varchar(25) NOT NULL COMMENT '用户名',
  `password` varchar(255) NOT NULL,
  `tel` varchar(25) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(25) DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user
-- ----------------------------

-- ----------------------------
-- Table structure for vote_details
-- ----------------------------
DROP TABLE IF EXISTS `vote_details`;
CREATE TABLE `vote_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '投票信息统计表id',
  `vote_project_id` bigint(20) DEFAULT NULL COMMENT '投票项目id',
  `voter_name` varchar(255) DEFAULT NULL COMMENT '投票人用户名',
  `vote_selects` varchar(255) DEFAULT NULL COMMENT '所投选项集合',
  `vote_time` datetime DEFAULT NULL COMMENT '投票时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of vote_details
-- ----------------------------

-- ----------------------------
-- Table structure for vote_item
-- ----------------------------
DROP TABLE IF EXISTS `vote_item`;
CREATE TABLE `vote_item` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `vote_project_id` bigint(20) NOT NULL COMMENT '投票项目id',
  `vote_item_number` varchar(10) DEFAULT NULL COMMENT '投票选项编号(A-Z)',
  `vote_item_content` varchar(255) DEFAULT NULL COMMENT '投票选项内容',
  `vote_item_poll` int(11) DEFAULT NULL COMMENT '选项票数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of vote_item
-- ----------------------------

-- ----------------------------
-- Table structure for vote_project
-- ----------------------------
DROP TABLE IF EXISTS `vote_project`;
CREATE TABLE `vote_project` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `vote_title` varchar(255) NOT NULL COMMENT '投票标题',
  `vote_sum` int(11) DEFAULT NULL COMMENT '选项个数',
  `image` varchar(255) DEFAULT NULL COMMENT '图片',
  `create_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL COMMENT '截至时间',
  `vote_mode` bit(1) DEFAULT NULL COMMENT '投票模式；1表示多选模式，0表示单选模式',
  `select_num` int(11) DEFAULT NULL COMMENT '多选模式下需要选择的个数',
  `is_check_results` bit(1) DEFAULT NULL COMMENT '用户是否可以查看投票结果;1表示可查看;0便是不可查看',
  `is_modify_vote` bit(1) DEFAULT NULL COMMENT '用户在截止时间前是否可以修改选择结果;1表示可修改,0表示不可修改',
  `is_close` bit(1) DEFAULT NULL COMMENT '投票是否关闭；1未关闭，0已关闭',
  `vote_explain` varchar(1000) DEFAULT NULL COMMENT '投票描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of vote_project
-- ----------------------------
