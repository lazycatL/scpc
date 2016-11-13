/*
Navicat MySQL Data Transfer

Source Server         : sss
Source Server Version : 50624
Source Host           : 127.0.0.1:3306
Source Database       : scpc

Target Server Type    : MYSQL
Target Server Version : 50624
File Encoding         : 65001

Date: 2016-09-10 13:14:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for scglxt_gx_bom_cl
-- ----------------------------
DROP TABLE IF EXISTS `scglxt_gx_bom_cl`;
CREATE TABLE `scglxt_gx_bom_cl` (
  `dj` int(10) DEFAULT '0' COMMENT '单价',
  `jlsj` date DEFAULT NULL COMMENT '记录时间',
  `sl` int(10) DEFAULT '0' COMMENT '数量（件数）',
  `clxzid` varchar(10) DEFAULT NULL COMMENT '材料（材质）形状ID',
  `gd` int(10) DEFAULT '0' COMMENT '高度',
  `kd` int(10) DEFAULT '0' COMMENT '宽度',
  `cd` int(10) DEFAULT '0' COMMENT '长度',
  `bomid` varchar(40) DEFAULT NULL COMMENT 'BOMID',
  `clid` varchar(40) DEFAULT NULL COMMENT '材料ID',
  `id` varchar(40) DEFAULT NULL COMMENT 'ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of scglxt_gx_bom_cl
-- ----------------------------

-- ----------------------------
-- Table structure for scglxt_mk_scpc
-- ----------------------------
DROP TABLE IF EXISTS `scglxt_mk_scpc`;
CREATE TABLE `scglxt_mk_scpc` (
  `id` varchar(50) NOT NULL COMMENT 'ID',
  `zddbh` varchar(50) DEFAULT NULL COMMENT '所属子订单',
  `gxbh` varchar(10) DEFAULT NULL COMMENT '工序编号',
  `sbbh` varchar(50) DEFAULT NULL COMMENT '工序使用设备编号',
  `jgjs` varchar(10) DEFAULT NULL COMMENT '加工件数',
  `bzbh` varchar(10) DEFAULT NULL COMMENT '班组ID',
  `rybh` varchar(10) DEFAULT NULL COMMENT '人员ID',
  `jhkssj` date DEFAULT NULL COMMENT '计划加工时间(开始时间)',
  `jhwcsj` date DEFAULT NULL COMMENT '计划加工时间(结束时间)',
  `sfyjwc` varchar(10) DEFAULT NULL COMMENT '是否已经完成',
  `ywcjs` int(11) DEFAULT NULL COMMENT '已完成件数',
  `wcbfb` float DEFAULT NULL COMMENT '完成百分比',
  `sjwcsj` datetime DEFAULT NULL COMMENT '完成时间',
  `sjkssj` datetime DEFAULT NULL,
  `jgmx` varchar(50) DEFAULT NULL COMMENT '生产加工时间明细',
  `pjjggs` float DEFAULT NULL COMMENT '平均加工工时/件',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='排产任务表';

-- ----------------------------
-- Records of scglxt_mk_scpc
-- ----------------------------

-- ----------------------------
-- Table structure for scglxt_tyzd
-- ----------------------------
DROP TABLE IF EXISTS `scglxt_tyzd`;
CREATE TABLE `scglxt_tyzd` (
  `XH` varchar(40) DEFAULT NULL COMMENT '序号',
  `ID` varchar(40) NOT NULL DEFAULT '' COMMENT 'ID字段',
  `MC` varchar(60) DEFAULT NULL COMMENT '名称',
  `BZ` varchar(100) DEFAULT NULL COMMENT '备注',
  `JLSJ` datetime DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of scglxt_tyzd
-- ----------------------------
INSERT INTO `scglxt_tyzd` VALUES ('01', '01', '设备字典', '设备型号', '2014-10-20 19:01:49');
INSERT INTO `scglxt_tyzd` VALUES ('0101', '0101', '设备型号', '设备型号', '2014-10-20 19:05:23');
INSERT INTO `scglxt_tyzd` VALUES ('010101', '010101', '车床', '设备型号01', '2014-10-20 19:02:17');
INSERT INTO `scglxt_tyzd` VALUES ('010102', '010102', '铣床', '设备型号02', '2014-10-20 19:02:49');
INSERT INTO `scglxt_tyzd` VALUES ('010103', '010103', '光室', '设备型号03', '2014-10-20 19:03:17');
INSERT INTO `scglxt_tyzd` VALUES ('010104', '010104', 'CNC', '用来抛光类型的机器', null);
INSERT INTO `scglxt_tyzd` VALUES ('010105', '010105', '磨床', null, null);
INSERT INTO `scglxt_tyzd` VALUES ('010106', '010106', '注塑', null, null);
INSERT INTO `scglxt_tyzd` VALUES ('010107', '010107', '线切割', null, null);
INSERT INTO `scglxt_tyzd` VALUES ('010108', '010109', '电火花', null, null);
INSERT INTO `scglxt_tyzd` VALUES ('0102', '0102', '设备状态', '设备状态', '2014-10-20 19:06:52');
INSERT INTO `scglxt_tyzd` VALUES ('010201', '010201', '良好', '良好', '2014-10-20 19:06:47');
INSERT INTO `scglxt_tyzd` VALUES ('010202', '010202', '报废', '报废', '2014-10-20 19:06:44');
INSERT INTO `scglxt_tyzd` VALUES ('02', '02', '人员', '人员', null);
INSERT INTO `scglxt_tyzd` VALUES ('0201', '0201', '人员技术级别', '人员技术级别', null);
INSERT INTO `scglxt_tyzd` VALUES ('020101', '020101', '技术三级', '技术三级', null);
INSERT INTO `scglxt_tyzd` VALUES ('020102', '020102', '技术二级', '技术二级', null);
INSERT INTO `scglxt_tyzd` VALUES ('020103', '020103', '技术一级', '技术一级', null);
INSERT INTO `scglxt_tyzd` VALUES ('03', '03', '材料形状', '圆柱', null);
INSERT INTO `scglxt_tyzd` VALUES ('0301', '0301', '圆柱', '圆柱', null);
INSERT INTO `scglxt_tyzd` VALUES ('0302', '0302', '长方体', '长方体', null);
INSERT INTO `scglxt_tyzd` VALUES ('0303', '0303', '其它', '其它', null);
INSERT INTO `scglxt_tyzd` VALUES ('30', '30', '客户类型', '客户类型', null);
INSERT INTO `scglxt_tyzd` VALUES ('3001', '3001', '大客户', '大客户', null);
INSERT INTO `scglxt_tyzd` VALUES ('3002', '3002', '中等客户', '中等客户', null);
INSERT INTO `scglxt_tyzd` VALUES ('3003', '3003', '政府客户', '政府客户', null);
INSERT INTO `scglxt_tyzd` VALUES ('3004', '3004', '小企业客户', null, null);
INSERT INTO `scglxt_tyzd` VALUES ('31', '31', '业务类型', '业务类型', null);
INSERT INTO `scglxt_tyzd` VALUES ('3101', '3101', '业务类型A', '业务类型A', null);
INSERT INTO `scglxt_tyzd` VALUES ('3102', '3102', '业务类型B', '业务类型B', null);
INSERT INTO `scglxt_tyzd` VALUES ('3103', '3103', '业务类型C', '业务类型C', null);
INSERT INTO `scglxt_tyzd` VALUES ('32', '32', '付款状态', '付款状态', null);
INSERT INTO `scglxt_tyzd` VALUES ('3201', '3201', '部分', null, null);
INSERT INTO `scglxt_tyzd` VALUES ('3202', '3202', '结清', null, null);
INSERT INTO `scglxt_tyzd` VALUES ('3203', '3203', '其它', null, null);

-- ----------------------------
-- Table structure for scglxt_t_bom
-- ----------------------------
DROP TABLE IF EXISTS `scglxt_t_bom`;
CREATE TABLE `scglxt_t_bom` (
  `id` varchar(50) NOT NULL COMMENT 'ID',
  `zddmc` varchar(50) DEFAULT NULL COMMENT '子订单名称',
  `zddcz` varchar(60) DEFAULT NULL COMMENT '子订单材质',
  `clxz` varchar(10) DEFAULT NULL COMMENT '料的形状',
  `cldx` varchar(10) DEFAULT NULL COMMENT '料的大小',
  `cltj` float DEFAULT NULL COMMENT '料的体积',
  `clje` float DEFAULT NULL COMMENT '料的金额',
  `jgsl` int(11) DEFAULT NULL COMMENT '加工数量',
  `bmcl` varchar(20) DEFAULT NULL COMMENT '表面处理',
  `starttime` datetime DEFAULT NULL COMMENT '子订单开始时间',
  `endtime` datetime DEFAULT NULL COMMENT '子订单结束时间',
  `gs` varchar(32) DEFAULT NULL COMMENT '子订单工时',
  `blqk` varchar(10) DEFAULT NULL COMMENT '当前备料情况',
  `blkssj` datetime DEFAULT NULL COMMENT '备料开始时间',
  `bljssj` datetime DEFAULT NULL COMMENT '备料结束时间',
  `clzt` varchar(10) DEFAULT NULL COMMENT '料的状态',
  `cgry` varchar(50) DEFAULT NULL COMMENT '采购人员',
  `cgsj` varchar(50) DEFAULT NULL COMMENT '采购商家',
  `ddtz` varchar(50) DEFAULT NULL COMMENT '子订单图纸',
  `rksj` date DEFAULT NULL COMMENT '入库时间',
  `bfjs` int(11) DEFAULT NULL COMMENT '报废件数',
  `bhgjs` int(11) DEFAULT NULL COMMENT '不合格件数',
  `gxnr` varchar(180) DEFAULT NULL COMMENT '工序内容',
  `SSDD` varchar(50) DEFAULT NULL COMMENT '所属订单',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='子订单管理';

-- ----------------------------
-- Records of scglxt_t_bom
-- ----------------------------

-- ----------------------------
-- Table structure for scglxt_t_bz
-- ----------------------------
DROP TABLE IF EXISTS `scglxt_t_bz`;
CREATE TABLE `scglxt_t_bz` (
  `id` varchar(50) NOT NULL COMMENT 'ID',
  `bzmc` varchar(50) DEFAULT NULL COMMENT '班组名称',
  `bzfzr` varchar(10) DEFAULT NULL COMMENT '班组负责人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工作班组表';

-- ----------------------------
-- Records of scglxt_t_bz
-- ----------------------------
INSERT INTO `scglxt_t_bz` VALUES ('759007553955134000000', '管理组', '');
INSERT INTO `scglxt_t_bz` VALUES ('759007553955134000001', '线切割', '');
INSERT INTO `scglxt_t_bz` VALUES ('759007553955134000002', '铣工班', '李红斌');
INSERT INTO `scglxt_t_bz` VALUES ('759007553955134000004', '注塑班', '徐豪杰');
INSERT INTO `scglxt_t_bz` VALUES ('759007553955134000005', '车工班', '');
INSERT INTO `scglxt_t_bz` VALUES ('759007553955134000006', '钳工班', '郑斌');
INSERT INTO `scglxt_t_bz` VALUES ('759007553955134000007', 'CNC班', '姜雨浩');
INSERT INTO `scglxt_t_bz` VALUES ('759007553955134000008', '电火花', '');
INSERT INTO `scglxt_t_bz` VALUES ('759007553955134000009', '检验组', '');
INSERT INTO `scglxt_t_bz` VALUES ('759007553955134000010', '库房组', '');
INSERT INTO `scglxt_t_bz` VALUES ('759007553955134000011', '模具设计', '');
INSERT INTO `scglxt_t_bz` VALUES ('759007553955134000012', '磨工组', '');

-- ----------------------------
-- Table structure for scglxt_t_cd
-- ----------------------------
DROP TABLE IF EXISTS `scglxt_t_cd`;
CREATE TABLE `scglxt_t_cd` (
  `id` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT 'ID',
  `cdmc` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '菜单名称',
  `cdtb` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '菜单图标',
  `cddz` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '菜单编号',
  `cdfjd` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '菜单父节点如果根节点默认为空',
  `isyz` int(10) DEFAULT NULL COMMENT '是否叶子节点',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of scglxt_t_cd
-- ----------------------------
INSERT INTO `scglxt_t_cd` VALUES ('', null, null, null, null, null);
INSERT INTO `scglxt_t_cd` VALUES ('1001', '销售管理', 'icon-edit', 'xsgl', '0', '0');
INSERT INTO `scglxt_t_cd` VALUES ('100101', '客户信息管理', 'glyphicon glyphicon-user', 'khxxgl', '1001', '1');
INSERT INTO `scglxt_t_cd` VALUES ('100102', '合同管理', 'icon-caret-right', 'htgl', '1001', '1');
INSERT INTO `scglxt_t_cd` VALUES ('1002', '技术管理', 'glyphicon glyphicon-wrench', 'jsgl', '0', '0');
INSERT INTO `scglxt_t_cd` VALUES ('100201', '订单管理', 'glyphicon glyphicon-align-justify', 'ddgl', '1002', '1');
INSERT INTO `scglxt_t_cd` VALUES ('100202', 'BOM表管理', 'glyphicon glyphicon-th-list', 'bomgl', '1002', '1');
INSERT INTO `scglxt_t_cd` VALUES ('100203', '工序管理', 'glyphicon glyphicon-tower', 'gxgl', '1002', '1');
INSERT INTO `scglxt_t_cd` VALUES ('1003', '生产管理', 'glyphicon glyphicon-calendar', 'scgl', '0', '0');
INSERT INTO `scglxt_t_cd` VALUES ('100301', '设备管理', 'glyphicon glyphicon-inbox', 'sbgl', '1003', '1');
INSERT INTO `scglxt_t_cd` VALUES ('100302', '班组管理', 'glyphicon glyphicon-bookmark', 'bzgl', '1003', '1');
INSERT INTO `scglxt_t_cd` VALUES ('100303', '人员管理', 'glyphicon glyphicon-user', 'rygl', '1003', '1');
INSERT INTO `scglxt_t_cd` VALUES ('100304', '加工人员加工', 'glyphicon glyphicon-indent-left', 'jgryjg', '1003', '1');
INSERT INTO `scglxt_t_cd` VALUES ('100305', '生产情况跟踪', 'glyphicon glyphicon-facetime-video', 'jgqkhz', '1003', '1');
INSERT INTO `scglxt_t_cd` VALUES ('100306', '排产任务管理', 'glyphicon glyphicon-tasks', 'pcrwgl', '1003', '1');
INSERT INTO `scglxt_t_cd` VALUES ('1004', '采购管理', 'glyphicon glyphicon-shopping-cart', 'cggl', '0', '0');
INSERT INTO `scglxt_t_cd` VALUES ('100401', '订单采购管理', 'glyphicon glyphicon-tags', 'ddcggl', '1004', '1');
INSERT INTO `scglxt_t_cd` VALUES ('100402', '供货商管理', 'icon-caret-right', 'ghsgl', '1004', '1');
INSERT INTO `scglxt_t_cd` VALUES ('1005', '质量管理', 'glyphicon glyphicon-plane', 'zlgl', '0', '0');
INSERT INTO `scglxt_t_cd` VALUES ('100501', '检验人员检验', 'glyphicon glyphicon-barcode', 'jyryjy', '1005', '1');
INSERT INTO `scglxt_t_cd` VALUES ('1006', '库存管理', 'glyphicon glyphicon-briefcase', 'kcgl', '0', '0');
INSERT INTO `scglxt_t_cd` VALUES ('100601', '基本零件管理', 'glyphicon glyphicon-pushpin', 'jbljgl', '1006', '1');
INSERT INTO `scglxt_t_cd` VALUES ('100602', '生产材料管理', 'icon-caret-right', 'scclgl', '1006', '1');
INSERT INTO `scglxt_t_cd` VALUES ('100603', '库存管理', 'icon-caret-right', 'kcgl', '1006', '1');
INSERT INTO `scglxt_t_cd` VALUES ('1007', '基本信息管理', 'glyphicon glyphicon-cog', 'jbxxgl', '0', '0');

-- ----------------------------
-- Table structure for scglxt_t_cl
-- ----------------------------
DROP TABLE IF EXISTS `scglxt_t_cl`;
CREATE TABLE `scglxt_t_cl` (
  `id` varchar(50) NOT NULL COMMENT 'ID',
  `clmc` varchar(50) DEFAULT NULL COMMENT '材料名称',
  `clcz` varchar(10) DEFAULT NULL COMMENT '材料材质',
  `clsl` int(11) DEFAULT NULL COMMENT '材料数量',
  `cldj` varchar(10) DEFAULT NULL COMMENT '材料单价',
  `cllx` varchar(10) DEFAULT NULL COMMENT '材料类型',
  `ghs` varchar(10) DEFAULT NULL COMMENT '供货商',
  `mi` varchar(10) DEFAULT NULL COMMENT '密度',
  `clxz` varchar(10) DEFAULT NULL COMMENT '材料形状',
  `kd` int(10) DEFAULT '0' COMMENT '宽度',
  `gd` int(10) DEFAULT '0' COMMENT '高度',
  `cd` int(10) DEFAULT '0' COMMENT '长度',
  `clly` varchar(10) DEFAULT NULL COMMENT '材料来源',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='材料信息表';

-- ----------------------------
-- Records of scglxt_t_cl
-- ----------------------------
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800010', '黄铜', '', null, '0.037', '', '', '8.5', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800011', '紫铜（棒）', '', null, '0.044', '', '', '8.9', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800012', '紫铜（板）', '', null, '0.055', '', '', '8.9', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800013', '无氧铜', '', null, '0.055', '', '', '8.9', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800014', '锡青铜', '', null, '0.07', '', '', '8.69', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800015', '不锈钢（304）', '', null, '0.02', '', '', '7.85', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800016', '环氧棒', '', null, '0.045', '', '', '2.15', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800017', '环氧板', '', null, '0.026', '', '', '2.15', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800018', '聚四氟（国产）', '', null, '0.055', '', '', '2.3', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800019', '聚四氟(进口)', '', null, '0.065', '', '', '2.3', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800020', 'ABS', '', null, '0.028', '', '', '1.05', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800021', '尼龙', '', null, '0.028', '', '', '1.15', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800022', '铁板A3', '', null, '0.005', '', '', '7.8', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800023', '钢45#', '', null, '0.005', '', '', '7.85', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800024', 'PE', '', null, '0.025', '', '', '0.93', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800025', '有机玻璃板', '', null, '0.05', '', '', '1.2', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800026', '防静电POM-ESD（国产）', '', null, '0.077', '', '', '1.43', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800027', '防静电POM-ESD（进口）', '', null, '0.185', '', '', '1.43', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800028', '导电POM-ESD（国产）', '', null, '0.077', '', '', '1.43', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800029', '导电POM-ESD（进口）', '', null, '0.185', '', '', '1.43', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800030', 'POM-C（国产）', '', null, '0.079', '', '', '1.43', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800031', 'POM-C（进口）', '', null, '0.31', '', '', '1.43', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800032', 'POM-H（国产）', '', null, '0.02', '', '', '1.43', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800033', 'POM-H（进口）', '', null, '0.06', '', '', '1.43', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800034', 'POM（透明）（国产）', '', null, '0.065', '', '', '1.43', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800035', 'POM（透明）（进口）', '', null, '0.08', '', '', '1.43', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800036', 'PEEK', '', null, '1.2', '', '', '1.5', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800037', 'PP', '', null, '0.017', '', '', '0.91', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800038', 'PEI', '', null, '0.15', '', '', '1.35', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800039', '模具钢718#', '', null, '0.024', '', '', '7.8', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800040', '模具钢P20', '', null, '0.015', '', '', '7.8', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800041', '模具钢Grmn', '', null, '0.013', '', '', '7.8', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800042', '模具钢Cr12', '', null, '0.02', '', '', '7.8', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800043', '模具钢42CrMo', '', null, '0.02', '', '', '7.85', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800044', '2Cr13', '', null, '0.018', '', '', '7.75', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800045', '铸钢', '', null, '0.0105', '', '', '7.8', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800046', 'dir', '', null, '0.03', '', '', '1.323', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800047', '铝5052', '', null, '0.02', '', '', '2.73', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800048', '铝6061', '', null, '0.021', '', '', '2.73', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800049', '纯铝', '', null, '0.025', '', '', '2.73', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800050', '铝板7075', '', null, '0.045', '', '', '2.73', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800051', '铝棒7075', '', null, '0.035', '', '', '2.73', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800052', '铝LY12', '', null, '0.038', '', '', '2.73', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800053', '铸铝', '', null, '0.043', '', '', '2.73', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800054', '聚砜', '', null, '0.11', '', '', '1.24', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800055', '红电木', '', null, '0.028', '', '', '1.45', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800056', '纤丝板', '', null, '0.065', '', '', '2.8', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800057', 'PVC蓝', '', null, '0.02', '', '', '1.7', '', null, null, null, '');
INSERT INTO `scglxt_t_cl` VALUES ('20160901104410800058', 'PVC透明', '', null, '0.24', '', '', '1.34', '', null, null, null, '');

-- ----------------------------
-- Table structure for scglxt_t_dd
-- ----------------------------
DROP TABLE IF EXISTS `scglxt_t_dd`;
CREATE TABLE `scglxt_t_dd` (
  `id` varchar(50) NOT NULL COMMENT 'ID',
  `ssht` varchar(50) NOT NULL COMMENT '所属合同',
  `xmname` varchar(50) DEFAULT NULL COMMENT '项目名称',
  `ddlevel` varchar(20) DEFAULT NULL COMMENT '订单级别',
  `jhdate` date DEFAULT NULL COMMENT '交货日期',
  `planstarttime` date DEFAULT NULL COMMENT '计划开始时间',
  `planendtime` date DEFAULT NULL COMMENT '计划结束时间',
  `realstarttime` date DEFAULT NULL COMMENT '实际开始时间',
  `realendtime` date DEFAULT NULL COMMENT '实际结束时间',
  `zgs` varchar(20) DEFAULT NULL COMMENT '所用总工时',
  `dqjd` varchar(20) DEFAULT NULL COMMENT '当前进度',
  `tz` varchar(50) DEFAULT NULL COMMENT '图纸',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `xmlxr` varchar(50) DEFAULT NULL COMMENT '项目联系人',
  `xmfzr` varchar(50) DEFAULT NULL COMMENT '项目负责人',
  `ckzt` varchar(50) DEFAULT NULL COMMENT '出库状态',
  `ckdate` date DEFAULT NULL COMMENT '出库时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单管理';

-- ----------------------------
-- Records of scglxt_t_dd
-- ----------------------------

-- ----------------------------
-- Table structure for scglxt_t_ghs
-- ----------------------------
DROP TABLE IF EXISTS `scglxt_t_ghs`;
CREATE TABLE `scglxt_t_ghs` (
  `GSMC` varchar(60) DEFAULT NULL COMMENT '公司名称',
  `GSDZ` varchar(80) DEFAULT NULL COMMENT '公司地址',
  `SPMC` varchar(200) DEFAULT NULL COMMENT '提供商品信息',
  `ID` varchar(40) NOT NULL DEFAULT '' COMMENT 'ID',
  `LXR` varchar(40) DEFAULT NULL COMMENT '联系人',
  `LXFS` varchar(60) DEFAULT NULL COMMENT '联系方式',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供货商';

-- ----------------------------
-- Records of scglxt_t_ghs
-- ----------------------------

-- ----------------------------
-- Table structure for scglxt_t_gygc
-- ----------------------------
DROP TABLE IF EXISTS `scglxt_t_gygc`;
CREATE TABLE `scglxt_t_gygc` (
  `bomid` varchar(40) DEFAULT NULL COMMENT 'BOM(子订单)ID',
  `gyid` varchar(40) DEFAULT NULL COMMENT '工艺ID',
  `id` varchar(40) NOT NULL DEFAULT '' COMMENT '工艺过程表ID',
  `gynr` varchar(100) DEFAULT NULL COMMENT '工艺内容',
  `edgs` int(11) DEFAULT NULL COMMENT '额定工时',
  `stsj` date DEFAULT NULL COMMENT '受图时间',
  `jhwcsj` datetime DEFAULT NULL COMMENT '计划完成时间',
  `sjwcsj` datetime DEFAULT NULL COMMENT '实际完成时间',
  `jyryid` varchar(40) DEFAULT NULL COMMENT '检验人员',
  `czryid` varchar(40) DEFAULT NULL COMMENT '操作人员',
  `jlsj` date DEFAULT NULL COMMENT '记录时间',
  `serial` decimal(10,0) DEFAULT NULL COMMENT '工艺过程排序',
  `sbid` varchar(50) DEFAULT NULL COMMENT '所用设备id',
  `KSSJ` datetime DEFAULT NULL COMMENT '该工艺过程实际开始时间',
  `JSSJ` datetime DEFAULT NULL COMMENT '该工艺过程实际结束时间',
  `JHKSSJ` datetime DEFAULT NULL COMMENT '计划开始时间',
  `SFJY` int(11) DEFAULT '0' COMMENT '是否检验',
  `JYSJ` datetime DEFAULT NULL COMMENT '检验时间',
  `kjgjs` int(11) DEFAULT '0' COMMENT '待/需要加工件数',
  `yjgjs` int(11) DEFAULT '0' COMMENT '已检验合格件数',
  `bfjs` int(11) DEFAULT '0' COMMENT '报废件数',
  `SJJS` int(11) DEFAULT '0' COMMENT '送检件数',
  `ZYSX` varchar(200) DEFAULT NULL COMMENT '资源属性',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工艺过程';

-- ----------------------------
-- Records of scglxt_t_gygc
-- ----------------------------

-- ----------------------------
-- Table structure for scglxt_t_gzsj
-- ----------------------------
DROP TABLE IF EXISTS `scglxt_t_gzsj`;
CREATE TABLE `scglxt_t_gzsj` (
  `ID` varchar(40) NOT NULL DEFAULT '' COMMENT 'ID',
  `GZSJ` int(3) DEFAULT NULL COMMENT '每天工作分钟数',
  `SFQY` int(1) DEFAULT NULL COMMENT '是否启用',
  `SJ` datetime DEFAULT NULL COMMENT '数据更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of scglxt_t_gzsj
-- ----------------------------
INSERT INTO `scglxt_t_gzsj` VALUES ('01', '6', '1', '2015-01-01 10:00:00');
INSERT INTO `scglxt_t_gzsj` VALUES ('02', '72', '0', '2015-01-01 10:00:00');
INSERT INTO `scglxt_t_gzsj` VALUES ('03', '84', '0', '2015-01-01 10:00:00');
INSERT INTO `scglxt_t_gzsj` VALUES ('04', '120', '0', '2015-01-01 10:00:00');

-- ----------------------------
-- Table structure for scglxt_t_hkjl
-- ----------------------------
DROP TABLE IF EXISTS `scglxt_t_hkjl`;
CREATE TABLE `scglxt_t_hkjl` (
  `id` varchar(50) NOT NULL COMMENT 'ID',
  `ssht` varchar(50) NOT NULL COMMENT '所属合同',
  `fkdate` date DEFAULT NULL COMMENT '付款日期',
  `fklx` varchar(50) DEFAULT NULL COMMENT '付款类型',
  `fkbfb` float DEFAULT NULL COMMENT '付款百分比',
  `fkje` float DEFAULT NULL COMMENT '付款金额',
  `fkyh` varchar(50) DEFAULT NULL COMMENT '付款银行',
  `fkr` varchar(50) DEFAULT NULL COMMENT '付款人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='付款记录表';

-- ----------------------------
-- Records of scglxt_t_hkjl
-- ----------------------------

-- ----------------------------
-- Table structure for scglxt_t_ht
-- ----------------------------
DROP TABLE IF EXISTS `scglxt_t_ht`;
CREATE TABLE `scglxt_t_ht` (
  `id` varchar(50) NOT NULL COMMENT 'ID',
  `mc` varchar(50) NOT NULL COMMENT '合同编号',
  `htbh` varchar(50) DEFAULT NULL COMMENT '合同编号',
  `ywlx` varchar(50) DEFAULT NULL COMMENT '业务类型',
  `htje` varchar(20) DEFAULT NULL COMMENT '当前进度',
  `qssj` date DEFAULT NULL COMMENT '签署时间',
  `dqjd` varchar(5) DEFAULT NULL COMMENT '当前进度',
  `fkzt` varchar(50) DEFAULT NULL COMMENT '付款状态',
  `jkbfb` varchar(5) DEFAULT NULL COMMENT '当前进度',
  `jkje` varchar(20) DEFAULT NULL COMMENT '当前进度',
  `jscb` float DEFAULT NULL COMMENT '计算成本',
  `hkzh` varchar(50) DEFAULT NULL COMMENT '汇款账号',
  `hkkhh` varchar(50) DEFAULT NULL COMMENT '汇款开户行',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `htmx` varchar(1500) DEFAULT NULL COMMENT '合同明细',
  `khid` varchar(45) DEFAULT NULL COMMENT '客户id',
  `jssj` date DEFAULT NULL COMMENT '预计结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='合同信息表';

-- ----------------------------
-- Records of scglxt_t_ht
-- ----------------------------

-- ----------------------------
-- Table structure for scglxt_t_jggl
-- ----------------------------
DROP TABLE IF EXISTS `scglxt_t_jggl`;
CREATE TABLE `scglxt_t_jggl` (
  `id` varchar(60) NOT NULL COMMENT 'id字段',
  `jgryid` varchar(45) DEFAULT NULL COMMENT '加工人员id',
  `jgjs` int(11) DEFAULT NULL COMMENT '加工件数',
  `jyryid` varchar(45) DEFAULT NULL COMMENT '检验人员ID',
  `bfjs` int(11) DEFAULT NULL COMMENT '报废件数',
  `jgkssj` datetime DEFAULT NULL COMMENT '加工开始时间',
  `jgjssj` datetime DEFAULT NULL COMMENT '加工结束时间',
  `jysj` datetime DEFAULT NULL COMMENT '检验时间',
  `bz` varchar(45) DEFAULT NULL COMMENT '备注',
  `sbid` varchar(45) DEFAULT NULL COMMENT '生产设备ID',
  `gygcid` varchar(45) DEFAULT NULL COMMENT '工艺过程ID',
  `SFJY` varchar(2) DEFAULT '0' COMMENT '是否检验',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='加工管理表';

-- ----------------------------
-- Records of scglxt_t_jggl
-- ----------------------------

-- ----------------------------
-- Table structure for scglxt_t_jggy
-- ----------------------------
DROP TABLE IF EXISTS `scglxt_t_jggy`;
CREATE TABLE `scglxt_t_jggy` (
  `id` varchar(50) NOT NULL COMMENT '工艺ID',
  `gymc` varchar(50) DEFAULT NULL COMMENT '工艺名称',
  `gydh` varchar(50) DEFAULT NULL COMMENT '工艺代号',
  `fzbz` varchar(50) DEFAULT NULL COMMENT '工艺班组',
  `gxsx` varchar(45) DEFAULT NULL,
  `sfwx` varchar(40) DEFAULT NULL COMMENT '是否外协',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工序表';

-- ----------------------------
-- Records of scglxt_t_jggy
-- ----------------------------
INSERT INTO `scglxt_t_jggy` VALUES ('201609010949574021', '线切割', '', '759007553955134000001', '', '0');
INSERT INTO `scglxt_t_jggy` VALUES ('201609010949574022', '铣', '', '759007553955134000002', '', '0');
INSERT INTO `scglxt_t_jggy` VALUES ('201609010949574023', '注塑', '', '759007553955134000004', '', '0');
INSERT INTO `scglxt_t_jggy` VALUES ('201609010949574024', '车', '', '759007553955134000005', '', '0');
INSERT INTO `scglxt_t_jggy` VALUES ('201609010949574025', '钳', '', '759007553955134000006', '', '0');
INSERT INTO `scglxt_t_jggy` VALUES ('201609010949574026', 'CNC', '', '759007553955134000007', '', '0');
INSERT INTO `scglxt_t_jggy` VALUES ('201609010949574027', '电火花', '', '759007553955134000008', '', '0');
INSERT INTO `scglxt_t_jggy` VALUES ('201609010949574028', '磨', '', '759007553955134000012', '', '0');

-- ----------------------------
-- Table structure for scglxt_t_kh
-- ----------------------------
DROP TABLE IF EXISTS `scglxt_t_kh`;
CREATE TABLE `scglxt_t_kh` (
  `id` varchar(50) NOT NULL COMMENT 'ID',
  `mc` varchar(100) NOT NULL COMMENT '客户名称',
  `lx` varchar(50) DEFAULT NULL COMMENT '客户类型',
  `dw` varchar(200) DEFAULT NULL COMMENT '客户单位',
  `dz` varchar(200) DEFAULT NULL COMMENT '单位地址',
  `gx` varchar(50) DEFAULT NULL COMMENT '合作关系',
  `iscj` varchar(50) DEFAULT NULL COMMENT '是否成交',
  `starttime` date DEFAULT NULL COMMENT '开始合作时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户信息表';

-- ----------------------------
-- Records of scglxt_t_kh
-- ----------------------------
INSERT INTO `scglxt_t_kh` VALUES ('20160830173817127', 'JOT自动化设备（北京）有限公司', '3001', '外资企业', '北京经济技术开发区 | 景园街10号 | 大琛科技园A座 ', '供应商', '1', '2007-05-18', '');

-- ----------------------------
-- Table structure for scglxt_t_lj
-- ----------------------------
DROP TABLE IF EXISTS `scglxt_t_lj`;
CREATE TABLE `scglxt_t_lj` (
  `ID` varchar(50) NOT NULL COMMENT '工具id',
  `lx` varchar(45) DEFAULT NULL COMMENT '工具类型',
  `mc` varchar(200) DEFAULT NULL,
  `cc` varchar(45) DEFAULT NULL COMMENT '尺寸',
  `zsl` varchar(45) DEFAULT NULL COMMENT '总数量',
  `kcsl` varchar(45) DEFAULT NULL COMMENT '库存数量',
  `dj` varchar(45) DEFAULT NULL COMMENT '单价',
  `ghs` varchar(45) DEFAULT NULL COMMENT '供货商',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of scglxt_t_lj
-- ----------------------------

-- ----------------------------
-- Table structure for scglxt_t_lxr
-- ----------------------------
DROP TABLE IF EXISTS `scglxt_t_lxr`;
CREATE TABLE `scglxt_t_lxr` (
  `id` varchar(50) NOT NULL COMMENT 'ID',
  `mc` varchar(50) NOT NULL COMMENT '联系人名称',
  `sj` varchar(100) DEFAULT NULL COMMENT '联系人手机',
  `zj` varchar(100) DEFAULT NULL COMMENT '联系人座机',
  `yx` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `zw` varchar(50) DEFAULT NULL COMMENT '职位',
  `sjkh` varchar(50) DEFAULT NULL COMMENT '所属客户',
  `sfxmlxr` varchar(50) DEFAULT NULL COMMENT '是否为项目联系人',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='联系人信息表';

-- ----------------------------
-- Records of scglxt_t_lxr
-- ----------------------------

-- ----------------------------
-- Table structure for scglxt_t_ry
-- ----------------------------
DROP TABLE IF EXISTS `scglxt_t_ry`;
CREATE TABLE `scglxt_t_ry` (
  `id` varchar(50) NOT NULL COMMENT 'ID',
  `rymc` varchar(50) DEFAULT NULL COMMENT '人员名称',
  `rynl` varchar(10) DEFAULT NULL COMMENT '人员年龄',
  `jsjb` varchar(60) DEFAULT NULL COMMENT '技术级别',
  `rzsj` date DEFAULT NULL COMMENT '入职时间',
  `ssbz` varchar(60) DEFAULT NULL COMMENT '所属班组',
  `dqgz` float DEFAULT NULL COMMENT '当前工资',
  `password` varchar(45) DEFAULT NULL COMMENT '密码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='人员信息表';

-- ----------------------------
-- Records of scglxt_t_ry
-- ----------------------------
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000000', 'admin', '', '020103', null, '759007553955134000000', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000011', '付鸿艺', '', '020103', null, '759007553955134000000', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000012', '缪春娣', '', '020103', null, '759007553955134000000', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000013', '杨占国', '', '020103', null, '759007553955134000000', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000014', '付盈', '', '020103', null, '759007553955134000000', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000015', '徐青春', '', '020103', null, '759007553955134000000', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000016', '李勇', '', '020103', null, '759007553955134000000', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000017', '付爱林', '', '020103', null, '759007553955134000000', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000018', '王增锋', '', '020103', null, '759007553955134000000', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000019', '石庆国', '', '020103', null, '759007553955134000011', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000020', '邵志献', '', '020103', null, '759007553955134000011', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000021', '高志福', '', '020103', null, '759007553955134000008', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000022', '吕福召', '', '020103', null, '759007553955134000008', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000023', '问波', '', '020103', null, '759007553955134000006', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000024', '郑斌', '', '020103', null, '759007553955134000006', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000025', '张小东', '', '020103', null, '759007553955134000006', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000026', '马晓龙', '', '020103', null, '759007553955134000006', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000027', '刘欢庆', '', '020103', null, '759007553955134000006', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000028', '余精华', '', '020103', null, '759007553955134000006', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000029', '王铁栓', '', '020103', null, '759007553955134000006', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000030', '彭公健', '', '020103', null, '759007553955134000006', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000031', '李红斌', '', '020103', null, '759007553955134000002', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000032', '邓东江', '', '020103', null, '759007553955134000002', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000033', '李华波', '', '020103', null, '759007553955134000002', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000034', '徐豪杰', '', '020103', null, '759007553955134000004', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000035', '刘志强', '', '020103', null, '759007553955134000009', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000036', '闫宝良', '', '020103', null, '759007553955134000005', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000037', '王建平', '', '020103', null, '759007553955134000005', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000038', '常海文', '', '020103', null, '759007553955134000005', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000039', '姜羽浩', '', '020103', null, '759007553955134000007', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000040', '曾剑锋', '', '020103', null, '759007553955134000007', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000041', '张宏宇', '', '020103', null, '759007553955134000007', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000042', '张强', '', '020103', null, '759007553955134000007', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000043', '张彭', '', '020103', null, '759007553955134000007', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000044', '刘鸿', '', '020103', null, '759007553955134000007', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000045', '张目根', '', '020103', null, '759007553955134000007', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000046', '郭全顺', '', '020103', null, '759007553955134000007', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000047', '邓宏丰', '', '020103', null, '759007553955134000007', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000048', '赵国升', '', '020103', null, '759007553955134000007', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000049', '杜凯', '', '020103', null, '759007553955134000007', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000050', '岳海霆', '', '020103', null, '759007553955134000007', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000051', '余田', '', '020103', null, '759007553955134000007', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000052', '王玉合', '', '020103', null, '', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000053', '凡秀玲', '', '020103', null, '759007553955134000004', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000054', '杨斌', '', '020103', null, '759007553955134000010', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000055', '张益国', '', '020103', null, '759007553955134000010', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000056', '张海涛', '', '020103', null, '', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000057', '张宝平', '', '020103', null, '', null, '123456');
INSERT INTO `scglxt_t_ry` VALUES ('201609101108000058', '蒋超', '', '020103', null, '759007553955134000001', null, '123456');

-- ----------------------------
-- Table structure for scglxt_t_sb
-- ----------------------------
DROP TABLE IF EXISTS `scglxt_t_sb`;
CREATE TABLE `scglxt_t_sb` (
  `id` varchar(100) NOT NULL COMMENT 'ID',
  `sblx` varchar(50) DEFAULT NULL COMMENT '设备类型',
  `sbmc` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '设备名称',
  `cgsj` date DEFAULT NULL COMMENT '设备采购时间',
  `bxjssj` date DEFAULT NULL COMMENT '设备保修结束时间',
  `sbszd` varchar(100) DEFAULT NULL COMMENT '设备所在地',
  `dqzt` varchar(10) DEFAULT NULL COMMENT '设备当前状态',
  `wxjl` varchar(1000) DEFAULT NULL COMMENT '设备维修记录',
  `remark` varchar(1000) DEFAULT NULL COMMENT '备注',
  `BZID` varchar(60) DEFAULT NULL COMMENT '设备所属班组',
  `SCCJ` varchar(200) DEFAULT NULL COMMENT '生产厂家',
  `SCCJDETAIL` varchar(500) DEFAULT NULL,
  `sbxh` varchar(255) DEFAULT NULL COMMENT '设备型号',
  `ccbh` varchar(255) DEFAULT NULL COMMENT '出厂编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备表';

-- ----------------------------
-- Records of scglxt_t_sb
-- ----------------------------
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100010', '010101', '数控车床', null, null, '车床区', '010201', '', '', '759007553955134000005', '广州数控', '卧式1380×1400×1420', 'SC6125', '1102753');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100011', '010101', '数控车床', null, null, '车床区', '010201', '', '', '759007553955134000005', '广州数控', '卧式1380×1400×1420', 'SC6126', '1102664');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100012', '010101', '数控车床', null, null, '车床区', '010201', '', '', '759007553955134000005', '济南第一机床厂', '1865x1350x1850', 'CK6136i', 'J81090457');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100013', '010101', '普通卧式车床', null, null, '车床区', '010201', '', '', '759007553955134000005', '云南机床厂', '2500*600*1890（mm）', 'CY6250/1000', '');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100014', '010101', '普通卧式车床', null, null, '车床区', '010201', '', '', '759007553955134000005', '滕州机床厂', '2400*900*1540', 'C616-1D', '200301001');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100015', '010101', '精密机床', null, null, '车床区', '010201', '', '', '759007553955134000005', '济南第一机床厂', '1409*670*1180（mm）', 'J1CM6125', 'C10115560');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100016', '010101', '精密机床', null, null, '车床区', '010201', '', '', '759007553955134000005', '济南第一机床厂', '1409*670*1180（mm）', 'J1CM6125', 'C8035133');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100017', '010101', '精密数显铣床', null, null, '铣床区', '010201', '', '', '759007553955134000002', '森达成数控机械有限公司', '1770*1680*2150', '森达成M5', '121078');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100018', '010101', '精密数显铣床', null, null, '铣床区', '010201', '', '', '759007553955134000002', '森达成数控机械有限公司', '1770*1680*2150', '森达成M4', '');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100019', '010101', '精密数显铣床', null, null, '铣床区', '010201', '', '', '759007553955134000002', '永裕昌（莆田）机械制造有限公司', '1770*1680*2150', '永裕昌CMP', '');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100020', '010101', '精密数显铣床', null, null, '铣床区', '010201', '', '', '759007553955134000002', '森达数控机械', '1770*1680*2150', '森达M5', '61131');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100021', '010101', '万能摇臂铣床', null, null, '铣床区', '010201', '', '', '759007553955134000002', '上海建亚机床有限公司', '1600*1730*2210mm', '上海建亚M4', '701072');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100022', '010101', '万能升降台铣床', null, null, '铣床区', '010201', '', '', '759007553955134000002', '北京第一机床厂', '2294*1770*1665', 'X62W', '703267');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100023', '010101', '立式铣床', null, null, '铣床区', '010201', '', '', '759007553955134000002', '北京第一机床厂', '2556x2159x2258', 'X53K', '720822');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100024', '010101', '摇臂钻床', null, null, '光室区', '010201', '', '', '', '沈阳金山机床厂', '1800?60?100', 'ZQ3040x12', '110106');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100025', '010101', '加工中心', null, null, 'CNC二区', '010201', '', '', '759007553955134000007', '台湾加育工业股份有限公司', '3000?190?460', 'MVC1160', '091029');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100026', '010101', '加工中心', null, null, 'CNC二区', '010201', '', '', '759007553955134000007', '台湾加育工业股份有限公司', '3000?190?460', 'MVC1160', '061287');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100027', '010101', '加工中心', null, null, 'CNC二区', '010201', '', '', '759007553955134000007', '台湾加育工业股份有限公司', '3400?480?800', 'MVC1370', '073018');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100028', '010101', '龙门数控', null, null, 'CNC二区', '010201', '', '', '759007553955134000007', '台湾高锋工业股份有限公司', '7800?460?380', 'B-2616', '760185');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100029', '010101', '加工中心', null, null, 'CNC一区', '010201', '', '', '759007553955134000007', 'HAAS AUTOMATION INC.OXNARD.CA93030 USA.', '2997?794?985', 'VF-3', '1085944');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100030', '010101', '加工中心', null, null, 'CNC一区', '010201', '', '', '759007553955134000007', 'HAAS AUTOMATION INC.OXNARD.CA93031 USA.', '2235?522?654', 'VF-2', '1085474');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100031', '010101', '加工中心', null, null, 'CNC一区', '010201', '', '', '759007553955134000007', 'HAAS AUTOMATION INC.OXNARD.CA93031 USA.', '1727?515?616', 'DT-1', '1085812');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100032', '010101', '加工中心', null, null, 'CNC一区', '010201', '', '', '759007553955134000007', 'HARBOR PERCISE INDUSTRIES CO.,LTD.', '2110?260?620', 'JHV-550\nBC-250PTSB4', '146259');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100033', '010101', '加工中心', null, null, 'CNC一区', '010201', '', '', '759007553955134000007', '山东威达机械股份公司', '1930?220?610', 'NC-560', '');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100034', '010101', '数控线切割机床', null, null, '线切割区', '010201', '', '', '759007553955134000001', '泰州市江洲机床厂', '1200x800x1200', 'DK7720', '01020538');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100035', '010101', '数控线切割机床', null, null, '线切割区', '010201', '', '', '759007553955134000001', '泰州市江洲机床厂', '1200x800x1200', 'DK7720', '06031908');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100036', '010101', '数控线切割机床', null, null, '线切割区', '010201', '', '', '759007553955134000001', '泰州市江洲机床厂', '1200x800x1200', 'DK7720', '05010478');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100037', '010101', '数控线切割机床', null, null, '线切割区', '010201', '', '', '759007553955134000001', '泰州市江洲机床厂', '1200x800x1200', 'DK7720', '05010458');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100038', '010101', '数控线切割机床', null, null, '线切割区', '010201', '', '', '759007553955134000001', '泰州市江洲机床厂', '1720*1680*1700', 'DK7750', '01031250');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100039', '010101', '数控线切割机床', null, null, '线切割区', '010201', '', '', '759007553955134000001', '泰州市江洲机床厂', '1550*1170*1700', 'DK7732', '01031038');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100040', '010101', '电火花机', null, null, '电火花区', '010201', '', '', '759007553955134000008', '泰州市江洲机床厂', '1100*1400*2120', 'D7132', '321998');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100041', '010101', '电火花机', null, null, '电火花区', '010201', '', '', '759007553955134000008', '泰州市江洲机床厂', '1500*1500*2250mm ', 'D7145', '45018');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100042', '010101', '电火花穿孔机', null, null, '电火花区', '010201', '', '', '759007553955134000008', '泰州市江洲机床厂', '1070*710*1970mm', 'DS-703A', '');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100043', '010101', '磨床', null, null, '磨床区', '010201', '', '', '759007553955134000012', '杭州机床厂', '2800*1830*2480（mm）', '7130', '');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100044', '010101', '磨床', null, null, '磨床区', '010201', '', '', '759007553955134000012', '杭州机床厂', '2800*1830*2480（mm）', '7130', '9068');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100045', '010101', '磨床', null, null, '磨床区', '010201', '', '', '759007553955134000012', '永裕昌（莆田）机械制造有限公司', '1300X1150X1980 ', '618', '');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100046', '010101', '磨床', null, null, '磨床区', '010201', '', '', '759007553955134000012', '国营望江机器制造厂', '2120?220?600', 'M115W', '');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100047', '010101', '注塑机', null, null, '注塑车间', '010201', '', '', '759007553955134000004', '泰坦机械', '4.6*1.06*1.76 ', 'T-120', 'OK-A062331');
INSERT INTO `scglxt_t_sb` VALUES ('13082420160910100048', '010101', '注塑机', null, null, '注塑车间', '010201', '', '', '759007553955134000004', '震得塑料机械有限公司', '5.2*1.3*1.9', 'EM180-V', 'MB41024-552800');

-- ----------------------------
-- View structure for v_scglxt_pc_sb_tb
-- ----------------------------
DROP VIEW IF EXISTS `v_scglxt_pc_sb_tb`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_scglxt_pc_sb_tb` AS select round(((sum((`v_scglxt_pc_tb`.`edgs` * `v_scglxt_pc_tb`.`jgsl`)) / 60) / (select `scglxt_t_gzsj`.`GZSJ` AS `gzsj` from `scglxt_t_gzsj` where (`scglxt_t_gzsj`.`SFQY` = 1))),2) AS `v`,`v_scglxt_pc_tb`.`bzid` AS `c`,`v_scglxt_pc_tb`.`sb` AS `k`,`v_scglxt_pc_tb`.`sbid` AS `id` from `v_scglxt_pc_tb` group by `v_scglxt_pc_tb`.`sbid` order by `v_scglxt_pc_tb`.`kssj`,`v_scglxt_pc_tb`.`bzid` ;

-- ----------------------------
-- View structure for v_scglxt_pc_tb
-- ----------------------------
DROP VIEW IF EXISTS `v_scglxt_pc_tb`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_scglxt_pc_tb` AS select `gygc`.`id` AS `gyid`,`bom`.`id` AS `bomid`,`bz`.`id` AS `bzid`,`sb`.`id` AS `sbid`,`bz`.`bzmc` AS `bzmc`,`sb`.`sbmc` AS `sbmc`,(`bom`.`jgsl` - `gygc`.`yjgjs`) AS `jgsl`,`gygc`.`edgs` AS `edgs`,`gygc`.`KSSJ` AS `kssj`,`gygc`.`JSSJ` AS `jssj`,concat(`bz`.`bzmc`,'--',`sb`.`sbmc`) AS `sb` from (((`scglxt_t_bz` `bz` join `scglxt_t_sb` `sb`) join `scglxt_t_gygc` `gygc`) join `scglxt_t_bom` `bom`) where ((`bz`.`id` = `sb`.`BZID`) and (`bom`.`id` = `gygc`.`bomid`) and (`gygc`.`sbid` = `sb`.`id`) and isnull(`gygc`.`JSSJ`)) order by `gygc`.`KSSJ` ;

-- ----------------------------
-- View structure for v_scglxt_pc_tb_info
-- ----------------------------
DROP VIEW IF EXISTS `v_scglxt_pc_tb_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_scglxt_pc_tb_info` AS select `bom`.`zddmc` AS `zddmc`,`bom`.`jgsl` AS `jgsl`,`gygc`.`serial` AS `serial`,`gygc`.`id` AS `gygcid`,`jggy`.`gymc` AS `gymc`,`gygc`.`JHKSSJ` AS `jhkssj`,`gygc`.`edgs` AS `edgs`,`gygc`.`KSSJ` AS `kssj`,`bz`.`bzmc` AS `bzmc`,`ry`.`rymc` AS `rymc`,`sb`.`sbmc` AS `sbmc`,`ry`.`id` AS `ryid`,`sb`.`id` AS `sbid` from (((((`scglxt_t_bom` `bom` join `scglxt_t_bz` `bz`) join `scglxt_t_ry` `ry`) join `scglxt_t_gygc` `gygc`) join `scglxt_t_jggy` `jggy`) join `scglxt_t_sb` `sb`) where ((`bom`.`id` = `gygc`.`bomid`) and (`gygc`.`sbid` = `sb`.`id`) and (`gygc`.`czryid` = `ry`.`id`) and (`sb`.`BZID` = `bz`.`id`) and (`gygc`.`gyid` = `jggy`.`id`) and isnull(`gygc`.`JSSJ`)) order by `bom`.`zddmc`,`gygc`.`serial`,`gygc`.`JHKSSJ`,`gygc`.`KSSJ` ;

-- ----------------------------
-- Procedure structure for procedure1
-- ----------------------------
DROP PROCEDURE IF EXISTS `procedure1`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure1`()
BEGIN
    DECLARE _outuserid VARCHAR(50);
    DECLARE _kubauserid VARCHAR(50);
    DECLARE flag INT;
    DECLARE update_cursor CURSOR 
    FOR 
    SELECT outuserid,kubauserid FROM ecuser_cooperationuser;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag=1;
    SET flag=0;
    OPEN update_cursor;
    REPEAT  
    FETCH update_cursor INTO _outuserid,_kubauserid;
     
    
    UNTIL flag 
    END REPEAT;
    CLOSE update_cursor ;
            
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for fun_dqgygc
-- ----------------------------
DROP FUNCTION IF EXISTS `fun_dqgygc`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fun_dqgygc`(zddid varchar (60)) RETURNS varchar(2000) CHARSET utf8
BEGIN
  DECLARE gy varchar (200) ;
  DECLARE flag int ;
  DECLARE result varchar (1000) ;
  declare param_kjgjs int ;
  declare param_yjgjs int ;
  declare param_bfjs int ;
  DECLARE update_cursor CURSOR FOR 
  SELECT 
    CONCAT(
      jggy.gymc,
      '(',
      CAST(gygc.bfjs AS CHAR),
      '/',
      CAST(gygc.yjgjs AS CHAR),
      '/',
      CAST(gygc.kjgjs AS CHAR),
      ')'
    ) gy,
    gygc.bfjs,
    gygc.yjgjs,
    gygc.kjgjs 
  FROM
    scglxt_t_gygc gygc,
    scglxt_t_jggy jggy,
    scglxt_t_bom bom 
  WHERE bomid = zddid 
    AND jggy.id = gygc.gynr
    AND bom.id = gygc.bomid 
  ORDER BY serial ;
  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET flag = NULL ;
  SET flag = 0 ;
  SET result = '' ;
  OPEN update_cursor ;
  REPEAT
    FETCH update_cursor INTO gy,
    param_bfjs,
    param_yjgjs,
    param_kjgjs ;
    if param_bfjs + param_yjgjs = param_kjgjs 
    then set result = CONCAT(
      result,
      '<span style="color: green;">',
      gy,
      '</span><span>--></span>'
    ) ;
    elseif param_kjgjs = 0 
    THEN set result = CONCAT(
      result,
      '<span style="color: gray;">',
      gy,
      '</span><span>--></span>'
    ) ;
    else set result = CONCAT(
      result,
      '<span style="color: blue;">',
      gy,
      '</span><span>--></span>'
    ) ;
    end if ;
    UNTIL flag IS NULL 
  END REPEAT ;
  CLOSE update_cursor ;
  RETURN result ;
END
;;
DELIMITER ;
