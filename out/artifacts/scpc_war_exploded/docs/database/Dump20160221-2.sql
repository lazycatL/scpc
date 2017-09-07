CREATE DATABASE  IF NOT EXISTS `scpc` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `scpc`;
-- MySQL dump 10.13  Distrib 5.6.19, for osx10.7 (i386)
--
-- Host: 127.0.0.1    Database: scpc
-- ------------------------------------------------------
-- Server version	5.6.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `scglxt_gx_bom_cl`
--

DROP TABLE IF EXISTS `scglxt_gx_bom_cl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scglxt_gx_bom_cl`
--

LOCK TABLES `scglxt_gx_bom_cl` WRITE;
/*!40000 ALTER TABLE `scglxt_gx_bom_cl` DISABLE KEYS */;
/*!40000 ALTER TABLE `scglxt_gx_bom_cl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scglxt_mk_scpc`
--

DROP TABLE IF EXISTS `scglxt_mk_scpc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scglxt_mk_scpc`
--

LOCK TABLES `scglxt_mk_scpc` WRITE;
/*!40000 ALTER TABLE `scglxt_mk_scpc` DISABLE KEYS */;
/*!40000 ALTER TABLE `scglxt_mk_scpc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scglxt_t_bom`
--

DROP TABLE IF EXISTS `scglxt_t_bom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scglxt_t_bom` (
  `id` varchar(50) NOT NULL COMMENT 'ID',
  `zddmc` varchar(50) DEFAULT NULL COMMENT '子订单名称',
  `zddcz` varchar(10) DEFAULT NULL COMMENT '子订单材质',
  `clxz` varchar(10) DEFAULT NULL COMMENT '料的形状',
  `cldx` varchar(10) DEFAULT NULL COMMENT '料的大小',
  `cltj` float DEFAULT NULL COMMENT '料的体积',
  `clje` float DEFAULT NULL COMMENT '料的金额',
  `jgsl` int(11) DEFAULT NULL COMMENT '加工数量',
  `bmcl` varchar(20) DEFAULT NULL COMMENT '表面处理',
  `starttime` date DEFAULT NULL COMMENT '子订单开始时间',
  `endtime` date DEFAULT NULL COMMENT '子订单结束时间',
  `gs` float DEFAULT NULL COMMENT '子订单工时',
  `blqk` varchar(10) DEFAULT NULL COMMENT '当前备料情况',
  `blkssj` date DEFAULT NULL COMMENT '备料开始时间',
  `bljssj` date DEFAULT NULL COMMENT '备料结束时间',
  `clzt` varchar(10) DEFAULT NULL COMMENT '料的状态',
  `cgry` varchar(50) DEFAULT NULL COMMENT '采购人员',
  `cgsj` varchar(50) DEFAULT NULL COMMENT '采购商家',
  `ddtz` varchar(50) DEFAULT NULL COMMENT '子订单图纸',
  `rksj` date DEFAULT NULL COMMENT '入库时间',
  `bfjs` int(11) DEFAULT NULL COMMENT '报废件数',
  `bhgjs` int(11) DEFAULT NULL COMMENT '不合格件数',
  `gxnr` varchar(50) DEFAULT NULL COMMENT '工序内容',
  `SSDD` varchar(50) DEFAULT NULL COMMENT '所属订单',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='子订单管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scglxt_t_bom`
--

LOCK TABLES `scglxt_t_bom` WRITE;
/*!40000 ALTER TABLE `scglxt_t_bom` DISABLE KEYS */;
INSERT INTO `scglxt_t_bom` VALUES ('001','BM009002.0_0','PEI','PEI',NULL,NULL,NULL,2,'酸洗',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'磨(20)-规格(30)-规格(40)-规格(50)',NULL),('002','BM009002.0_1','红电木','2','2',2,2,2,'水洗',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('003','BM009002.0_2','POM-H',NULL,NULL,NULL,NULL,4,'电镀',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('004','BM009002.0_3','6061',NULL,NULL,NULL,NULL,5,'抛光',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('005','BM009002.0_4','304',NULL,NULL,NULL,NULL,3,'抛光',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('006','BM009002.0_5','POM-C',NULL,NULL,NULL,NULL,2,'抛光',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('007','BM009002.0_8','红电木',NULL,NULL,NULL,NULL,2,'抛光',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('008','BM009002.0_6','6061',NULL,NULL,NULL,NULL,2,'抛光',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('009','BM009002.0_7','黄铜-H59',NULL,NULL,NULL,NULL,4,'抛光',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2(2)',NULL);
/*!40000 ALTER TABLE `scglxt_t_bom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scglxt_t_bz`
--

DROP TABLE IF EXISTS `scglxt_t_bz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scglxt_t_bz` (
  `id` varchar(50) NOT NULL COMMENT 'ID',
  `bzmc` varchar(50) DEFAULT NULL COMMENT '班组名称',
  `bzfzr` varchar(10) DEFAULT NULL COMMENT '班组负责人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工作班组表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scglxt_t_bz`
--

LOCK TABLES `scglxt_t_bz` WRITE;
/*!40000 ALTER TABLE `scglxt_t_bz` DISABLE KEYS */;
INSERT INTO `scglxt_t_bz` VALUES ('01','生产备料部-B','开发测试人员'),('02','铣工组','李明'),('03','加工中心','蕾蕾'),('04','钳组','素丽'),('05','电镀组','李晨');
/*!40000 ALTER TABLE `scglxt_t_bz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scglxt_t_cl`
--

DROP TABLE IF EXISTS `scglxt_t_cl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scglxt_t_cl`
--

LOCK TABLES `scglxt_t_cl` WRITE;
/*!40000 ALTER TABLE `scglxt_t_cl` DISABLE KEYS */;
INSERT INTO `scglxt_t_cl` VALUES ('1','材料名称','不锈钢',0,'100','材料类型','供货商','2','1',0,0,0,NULL),('2','asdf','asdf',1,'200','1','china','320','2',0,0,0,NULL);
/*!40000 ALTER TABLE `scglxt_t_cl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scglxt_t_dd`
--

DROP TABLE IF EXISTS `scglxt_t_dd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scglxt_t_dd` (
  `id` varchar(50) NOT NULL COMMENT 'ID',
  `ssht` varchar(50) NOT NULL COMMENT '所属合同',
  `xmname` varchar(50) DEFAULT NULL COMMENT '项目名称',
  `ddlevel` float DEFAULT NULL COMMENT '订单级别',
  `jhdate` date DEFAULT NULL COMMENT '交货日期',
  `planstarttime` date DEFAULT NULL COMMENT '计划开始时间',
  `planendtime` date DEFAULT NULL COMMENT '计划结束时间',
  `realstarttime` date DEFAULT NULL COMMENT '实际开始时间',
  `realendtime` date DEFAULT NULL COMMENT '实际结束时间',
  `zgs` float DEFAULT NULL COMMENT '所用总工时',
  `dqjd` float DEFAULT NULL COMMENT '当前进度',
  `tz` varchar(50) DEFAULT NULL COMMENT '图纸',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `xmlxr` varchar(50) DEFAULT NULL COMMENT '项目联系人',
  `xmfzr` varchar(50) DEFAULT NULL COMMENT '项目负责人',
  `ckzt` varchar(50) DEFAULT NULL COMMENT '出库状态',
  `ckdate` date DEFAULT NULL COMMENT '出库时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scglxt_t_dd`
--

LOCK TABLES `scglxt_t_dd` WRITE;
/*!40000 ALTER TABLE `scglxt_t_dd` DISABLE KEYS */;
INSERT INTO `scglxt_t_dd` VALUES ('1','20140928','项目8888',1,'0000-00-00','2015-02-03',NULL,NULL,NULL,0,0,'','','小王','小赵','',NULL),('2','20140928','9999订单',2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'备注','小王',NULL,NULL,NULL),('20150208214351018','20140928','8888项目',1,'2015-02-18','2015-02-09','2015-02-10','2015-02-09','2015-02-10',0,0,'','测试数据','小王','小赵','未出库','2015-02-10');
/*!40000 ALTER TABLE `scglxt_t_dd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scglxt_t_ghs`
--

DROP TABLE IF EXISTS `scglxt_t_ghs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scglxt_t_ghs` (
  `GSMC` varchar(60) DEFAULT NULL COMMENT '公司名称',
  `GSDZ` varchar(80) DEFAULT NULL COMMENT '公司地址',
  `SPMC` varchar(200) DEFAULT NULL COMMENT '提供商品信息',
  `ID` varchar(40) NOT NULL DEFAULT '' COMMENT 'ID',
  `LXR` varchar(40) DEFAULT NULL COMMENT '联系人',
  `LXFS` varchar(60) DEFAULT NULL COMMENT '联系方式',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供货商';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scglxt_t_ghs`
--

LOCK TABLES `scglxt_t_ghs` WRITE;
/*!40000 ALTER TABLE `scglxt_t_ghs` DISABLE KEYS */;
INSERT INTO `scglxt_t_ghs` VALUES ('大兴','北京市大兴区','商品是永辉超市买的','0009090','孙武','990898'),('乡村爱情','永泉山庄','修正后的商品描述','03484424990487635955','赵四','888888'),('开发人员测试数据','开发人员测试数据','该商品暂时不用','30990255780365113237','卖彩票的','133999443323'),(NULL,NULL,'电子测绘计算机','9089887','陆伟','990089');
/*!40000 ALTER TABLE `scglxt_t_ghs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scglxt_t_gygc`
--

DROP TABLE IF EXISTS `scglxt_t_gygc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
  `SFJY` int(11) DEFAULT NULL COMMENT '是否检验',
  `JYSJ` datetime DEFAULT NULL COMMENT '检验时间',
  `kjgjs` int(11) DEFAULT NULL COMMENT '待/需要加工件数',
  `yjgjs` int(11) DEFAULT NULL COMMENT '已检验合格件数',
  `bfjs` int(11) DEFAULT NULL COMMENT '报废件数',
  `SJJS` int(11) DEFAULT NULL COMMENT '送检件数',
  `zysx` varchar(100) DEFAULT NULL COMMENT '注意事项',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工艺过程';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scglxt_t_gygc`
--

LOCK TABLES `scglxt_t_gygc` WRITE;
/*!40000 ALTER TABLE `scglxt_t_gygc` DISABLE KEYS */;
INSERT INTO `scglxt_t_gygc` VALUES ('002','1001','20150401215309975','按照要求规格备料注意尺寸',23,NULL,NULL,NULL,NULL,'01',NULL,1,'01',NULL,NULL,'2015-07-14 11:01:02',NULL,NULL,30,24,5,9,NULL),('002','1001','20150701215309974','规格',25,NULL,NULL,NULL,NULL,'01',NULL,2,'01',NULL,NULL,'2015-07-14 11:01:00',NULL,NULL,20,10,1,10,NULL),('002','1003','20150701515309975','规格',34,NULL,NULL,NULL,NULL,'03',NULL,3,'03',NULL,NULL,'2015-07-10 12:01:00',NULL,NULL,10,5,1,6,NULL),('002','1004','20150703215309975','规格',56,NULL,NULL,NULL,NULL,'04',NULL,4,'04',NULL,NULL,'2015-07-14 11:01:00',NULL,NULL,5,2,1,5,NULL),('002','1005','20153701215309975','规格',45,NULL,NULL,NULL,NULL,'05',NULL,4,'05',NULL,NULL,'2015-08-23 11:09:00',NULL,NULL,2,2,0,0,NULL),('001',NULL,'20160216220916048','磨',20,NULL,NULL,NULL,NULL,NULL,NULL,0,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('001',NULL,'20160216220916580','规格',30,NULL,NULL,NULL,NULL,NULL,NULL,1,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('001',NULL,'20160216220916662','规格',50,NULL,NULL,NULL,NULL,NULL,NULL,3,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('001',NULL,'20160216220916712','规格',40,NULL,NULL,NULL,NULL,NULL,NULL,2,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('009',NULL,'20160220114929694','2',2,NULL,NULL,NULL,NULL,NULL,NULL,1,'41353996961077987502',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1');
/*!40000 ALTER TABLE `scglxt_t_gygc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scglxt_t_gzsj`
--

DROP TABLE IF EXISTS `scglxt_t_gzsj`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scglxt_t_gzsj` (
  `ID` varchar(40) NOT NULL DEFAULT '' COMMENT 'ID',
  `GZSJ` int(3) DEFAULT NULL COMMENT '每天工作分钟数',
  `SFQY` int(1) DEFAULT NULL COMMENT '是否启用',
  `SJ` datetime DEFAULT NULL COMMENT '数据更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scglxt_t_gzsj`
--

LOCK TABLES `scglxt_t_gzsj` WRITE;
/*!40000 ALTER TABLE `scglxt_t_gzsj` DISABLE KEYS */;
INSERT INTO `scglxt_t_gzsj` VALUES ('01',6,1,'2015-01-01 10:00:00'),('02',72,0,'2015-01-01 10:00:00'),('03',84,0,'2015-01-01 10:00:00'),('04',120,0,'2015-01-01 10:00:00');
/*!40000 ALTER TABLE `scglxt_t_gzsj` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scglxt_t_hkjl`
--

DROP TABLE IF EXISTS `scglxt_t_hkjl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scglxt_t_hkjl`
--

LOCK TABLES `scglxt_t_hkjl` WRITE;
/*!40000 ALTER TABLE `scglxt_t_hkjl` DISABLE KEYS */;
/*!40000 ALTER TABLE `scglxt_t_hkjl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scglxt_t_ht`
--

DROP TABLE IF EXISTS `scglxt_t_ht`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scglxt_t_ht` (
  `id` varchar(50) NOT NULL COMMENT 'ID',
  `mc` varchar(50) NOT NULL COMMENT '合同编号',
  `htbh` varchar(50) DEFAULT NULL COMMENT '合同编号',
  `ywlx` varchar(50) DEFAULT NULL COMMENT '业务类型',
  `htje` float DEFAULT NULL COMMENT '合同金额',
  `qssj` date DEFAULT NULL COMMENT '签署时间',
  `dqjd` float DEFAULT NULL COMMENT '当前进度',
  `fkzt` varchar(50) DEFAULT NULL COMMENT '付款状态',
  `jkbfb` float DEFAULT NULL COMMENT '结款百分比',
  `jkje` float DEFAULT NULL COMMENT '结款金额',
  `jscb` float DEFAULT NULL COMMENT '计算成本',
  `hkzh` varchar(50) DEFAULT NULL COMMENT '汇款账号',
  `hkkhh` varchar(50) DEFAULT NULL COMMENT '汇款开户行',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `htmx` varchar(500) DEFAULT NULL COMMENT '合同明细',
  `khid` varchar(45) DEFAULT NULL COMMENT '客户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='合同信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scglxt_t_ht`
--

LOCK TABLES `scglxt_t_ht` WRITE;
/*!40000 ALTER TABLE `scglxt_t_ht` DISABLE KEYS */;
INSERT INTO `scglxt_t_ht` VALUES ('1','测试合同','ht10012','',100000,'2015-02-02',0,'',0,10000,0,'','','',NULL,'20141126184435235'),('20140928','测试合同2',NULL,'未知',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'20141126184435235'),('20140929','销售合同',NULL,'未知',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'20141126184435235');
/*!40000 ALTER TABLE `scglxt_t_ht` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scglxt_t_jggl`
--

DROP TABLE IF EXISTS `scglxt_t_jggl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scglxt_t_jggl`
--

LOCK TABLES `scglxt_t_jggl` WRITE;
/*!40000 ALTER TABLE `scglxt_t_jggl` DISABLE KEYS */;
INSERT INTO `scglxt_t_jggl` VALUES ('','',0,NULL,NULL,'2015-11-26 20:11:43','2015-11-26 20:15:02',NULL,NULL,NULL,'','0'),('009087','01',4,'03',0,'2013-09-08 23:09:07','2013-09-08 23:09:07','2013-09-08 23:09:07','无','01','20150401215309975','0'),('0090876','02',5,'03',0,'2013-09-08 23:09:07','2013-09-08 23:09:07','2013-09-08 23:09:07','无','02','20150401215309975','0'),('78877654','03',5,'02',0,'2013-09-08 23:09:07','2013-09-08 23:09:07','2013-09-08 23:09:07','无','03','20150401215309975','0'),('889977','04',5,'01',0,'2013-09-08 23:09:07','2013-09-08 23:09:07','2013-09-08 23:09:07','无','04','20150401215309975','0'),('F118841387096480652655826394430625975225','01',3,NULL,NULL,'2016-02-20 14:32:13','2016-02-20 15:07:21',NULL,NULL,'01','20150701215309974','0'),('F390695505003254567455141884629776709413','01',NULL,NULL,NULL,'2016-02-20 15:08:32',NULL,NULL,NULL,NULL,'20150701515309975','0'),('F479811069953886496132916415916049338774','01',3,NULL,NULL,'2016-02-20 14:32:19','2016-02-20 15:07:21',NULL,NULL,'01','20150701215309974','0'),('F500304705238697665392228239455190416584','01',3,NULL,NULL,'2016-02-20 14:34:09','2016-02-20 15:07:21',NULL,NULL,'01','20150701215309974','0'),('F628112654342820203114295963657500496539','01',3,NULL,NULL,'2016-02-20 15:07:12','2016-02-20 15:07:21',NULL,NULL,'01','20150701215309974','0'),('F870607767501141467305284799935748694246','01',3,NULL,NULL,'2016-02-20 15:07:26','2016-02-20 15:07:35',NULL,NULL,'01','20150701515309975','0'),('F973129755253203695360674708111183135660','01',3,NULL,NULL,'2016-02-20 15:02:07','2016-02-20 15:07:21',NULL,NULL,'01','20150701215309974','0');
/*!40000 ALTER TABLE `scglxt_t_jggl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scglxt_t_jggy`
--

DROP TABLE IF EXISTS `scglxt_t_jggy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scglxt_t_jggy` (
  `id` varchar(50) NOT NULL COMMENT '工艺ID',
  `gymc` varchar(50) DEFAULT NULL COMMENT '工艺名称',
  `gydh` varchar(10) DEFAULT NULL COMMENT '工艺代号',
  `fzbz` varchar(10) DEFAULT NULL COMMENT '工艺班组',
  `gxsx` varchar(45) DEFAULT NULL,
  `sfwx` varchar(1) DEFAULT '0' COMMENT '是否外协',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工序表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scglxt_t_jggy`
--

LOCK TABLES `scglxt_t_jggy` WRITE;
/*!40000 ALTER TABLE `scglxt_t_jggy` DISABLE KEYS */;
INSERT INTO `scglxt_t_jggy` VALUES ('1001','备','1001',NULL,NULL,'0'),('1002','铣','1002',NULL,NULL,'1'),('1003','加工中心 ','1003',NULL,NULL,'0'),('1004','钳','1004',NULL,NULL,'0'),('1005','镀','1005',NULL,NULL,'0');
/*!40000 ALTER TABLE `scglxt_t_jggy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scglxt_t_kh`
--

DROP TABLE IF EXISTS `scglxt_t_kh`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scglxt_t_kh`
--

LOCK TABLES `scglxt_t_kh` WRITE;
/*!40000 ALTER TABLE `scglxt_t_kh` DISABLE KEYS */;
INSERT INTO `scglxt_t_kh` VALUES ('20141126184253409','小明','3003','北京','北京','','1',NULL,''),('20141126184435235','老王','3002','上海','上海','老客户','0',NULL,''),('20160220102625647','测试客户1','3001','北京创新','海淀区复兴路14号','长期合作','1','2016-02-02','dd'),('20160220110025701','测试','3001','a','a','a','1','2016-02-01','d');
/*!40000 ALTER TABLE `scglxt_t_kh` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scglxt_t_lj`
--

DROP TABLE IF EXISTS `scglxt_t_lj`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scglxt_t_lj`
--

LOCK TABLES `scglxt_t_lj` WRITE;
/*!40000 ALTER TABLE `scglxt_t_lj` DISABLE KEYS */;
INSERT INTO `scglxt_t_lj` VALUES ('1','2',NULL,'3','4','5','6','7'),('2','刀片',NULL,'8号','18','5','100',NULL);
/*!40000 ALTER TABLE `scglxt_t_lj` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scglxt_t_lxr`
--

DROP TABLE IF EXISTS `scglxt_t_lxr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scglxt_t_lxr`
--

LOCK TABLES `scglxt_t_lxr` WRITE;
/*!40000 ALTER TABLE `scglxt_t_lxr` DISABLE KEYS */;
/*!40000 ALTER TABLE `scglxt_t_lxr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scglxt_t_ry`
--

DROP TABLE IF EXISTS `scglxt_t_ry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scglxt_t_ry` (
  `id` varchar(50) NOT NULL COMMENT 'ID',
  `rymc` varchar(50) DEFAULT NULL COMMENT '人员名称',
  `rynl` varchar(10) DEFAULT NULL COMMENT '人员年龄',
  `jsjb` varchar(10) DEFAULT NULL COMMENT '技术级别',
  `rzsj` date DEFAULT NULL COMMENT '入职时间',
  `ssbz` varchar(10) DEFAULT NULL COMMENT '所属班组',
  `dqgz` float DEFAULT NULL COMMENT '当前工资',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='人员信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scglxt_t_ry`
--

LOCK TABLES `scglxt_t_ry` WRITE;
/*!40000 ALTER TABLE `scglxt_t_ry` DISABLE KEYS */;
INSERT INTO `scglxt_t_ry` VALUES ('01','王元','240','020102','2014-10-24','01',34),('02','霍晓琳','22','020101','2014-10-19','01',4453),('03','孙武','22','020101','2014-10-24','01',33),('04','素丽','22','020101','2014-10-24','02',122222),('05','戴明','23','020102','2014-10-24','03',23),('06','王伟','23','020102','2014-10-24','03',23),('07','文涛','23','020102','2014-10-24','04',23),('09','艳丽','23','020102','2014-10-24','04',23);
/*!40000 ALTER TABLE `scglxt_t_ry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scglxt_t_sb`
--

DROP TABLE IF EXISTS `scglxt_t_sb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scglxt_t_sb` (
  `id` varchar(50) NOT NULL COMMENT 'ID',
  `sblx` varchar(50) DEFAULT NULL COMMENT '设备类型',
  `sbmc` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '设备名称',
  `cgsj` date DEFAULT NULL COMMENT '设备采购时间',
  `bxjssj` date DEFAULT NULL COMMENT '设备保修结束时间',
  `sbszd` varchar(10) DEFAULT NULL COMMENT '设备所在地',
  `dqzt` varchar(10) DEFAULT NULL COMMENT '设备当前状态',
  `wxjl` varchar(200) DEFAULT NULL COMMENT '设备维修记录',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `BZID` varchar(60) DEFAULT NULL COMMENT '设备所属班组',
  `SCCJ` varchar(60) DEFAULT NULL,
  `SCCJDETAIL` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scglxt_t_sb`
--

LOCK TABLES `scglxt_t_sb` WRITE;
/*!40000 ALTER TABLE `scglxt_t_sb` DISABLE KEYS */;
INSERT INTO `scglxt_t_sb` VALUES ('01','010101','备料设备A','2014-10-07','2014-10-20','孙XX家','010202','3月份维修过一次\r\n4月份维修过一次\r\n5月份维修过一次','开发人员测试数据，\r\n开发人员测试数据','03',NULL,NULL),('02','010103','备料设备B','2014-10-07','2014-10-30','机器存放','010201','维修过三次','没事没事','01',NULL,NULL),('03','010101','铣设备A','2014-10-06','2014-10-08','无','010201','无','良好是被','02',NULL,NULL),('03498297362005925005','010103','备料设备A','2014-10-07','2014-10-20','孙','010201','维修过上百次','采购的',NULL,NULL,NULL),('04','010101','铣设备B','2014-10-07','2014-10-03','南库机房','010201','维修过2次','没有备注信息','02',NULL,NULL),('05','010103','加工中心设备A','2014-10-07','2014-10-20','可以使中文','010201','中文','采购的','03',NULL,NULL),('06','010101','加工中心设备B','0000-00-00','0000-00-00','','010201','','','03',NULL,NULL),('07','010101','加工中心设备C','2012-00-00','0000-00-00','','010201','','','04',NULL,NULL),('08','010101','加工中心设备D','0000-00-00','0000-00-00','','010201','','','01',NULL,NULL),('09','010101','钳设A','2014-10-07','2014-10-03','南库机房','010201','维修过2次','没有备注信息','04',NULL,NULL),('10','010101','钳设B','2014-10-20','2014-10-20','二车间','010202','没有维修过',NULL,'04',NULL,NULL),('10093403427839111804','010101','9月5日测试设备','2014-08-13','2014-08-14','3郝仓库','010201','没有维修过','维修过一次','04',NULL,NULL),('11','010102','镀设A','2014-10-20','2014-10-20','一车间','010201','没有维修过','备注','05',NULL,NULL),('19503876015886209304','010103','备料设备A','2014-10-07','2014-10-20','','010201','维修过上百次','采购的',NULL,NULL,NULL),('31807013118867144805','010103','备料设备A','2014-10-07','2014-10-20','孙XX家','010201','维修过上百次','采购的deded',NULL,NULL,NULL),('41353996961077987502','010103','备料设备A','2014-10-07','2014-10-20','孙XX家','010201','维修过上百次','采购的',NULL,NULL,NULL),('58964558298908159384','010103','备料设备A','2014-10-07','2014-10-20','孙XX家','010201','维修过上百次','采购的',NULL,NULL,NULL),('64425997594440958365','010101','9月4日测试设备','2014-08-20','2014-08-27','2号仓库','010201','维修过3次','没有维修过',NULL,NULL,NULL);
/*!40000 ALTER TABLE `scglxt_t_sb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scglxt_tyzd`
--

DROP TABLE IF EXISTS `scglxt_tyzd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scglxt_tyzd` (
  `XH` varchar(40) DEFAULT NULL COMMENT '序号',
  `ID` varchar(40) NOT NULL DEFAULT '' COMMENT 'ID字段',
  `MC` varchar(60) DEFAULT NULL COMMENT '名称',
  `BZ` varchar(100) DEFAULT NULL COMMENT '备注',
  `JLSJ` datetime DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scglxt_tyzd`
--

LOCK TABLES `scglxt_tyzd` WRITE;
/*!40000 ALTER TABLE `scglxt_tyzd` DISABLE KEYS */;
INSERT INTO `scglxt_tyzd` VALUES ('01','01','设备字典','设备型号','2014-10-20 19:01:49'),('0101','0101','设备型号','设备型号','2014-10-20 19:05:23'),('010101','010101','备料机器','设备型号01','2014-10-20 19:02:17'),('010102','010102','洗机器','设备型号02','2014-10-20 19:02:49'),('010103','010103','磨机器','设备型号03','2014-10-20 19:03:17'),('010104','010104','抛光机器','用来抛光类型的机器',NULL),('0102','0102','设备状态','设备状态','2014-10-20 19:06:52'),('010201','010201','良好','良好','2014-10-20 19:06:47'),('010202','010202','报废','报废','2014-10-20 19:06:44'),('02','02','人员','人员',NULL),('0201','0201','人员技术级别','人员技术级别',NULL),('020101','020101','技术三级','技术三级',NULL),('020102','020102','技术二级','技术二级',NULL),('020103','020103','技术一级','技术一级',NULL),('03','03','材料形状','圆柱',NULL),('0301','0301','圆柱','圆柱',NULL),('0302','0302','长方体','长方体',NULL),('0303','0303','其它','其它',NULL),('30','30','客户类型','客户类型',NULL),('3001','3001','大客户','大客户',NULL),('3002','3002','中等客户','中等客户',NULL),('3003','3003','政府客户','政府客户',NULL),('3004','3004','小企业客户',NULL,NULL);
/*!40000 ALTER TABLE `scglxt_tyzd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_scglxt_pc_tb`
--

DROP TABLE IF EXISTS `v_scglxt_pc_tb`;
/*!50001 DROP VIEW IF EXISTS `v_scglxt_pc_tb`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_scglxt_pc_tb` AS SELECT 
 1 AS `gyid`,
 1 AS `bomid`,
 1 AS `ryid`,
 1 AS `bzid`,
 1 AS `sbid`,
 1 AS `bzmc`,
 1 AS `sbmc`,
 1 AS `rymc`,
 1 AS `jgsl`,
 1 AS `edgs`,
 1 AS `kssj`,
 1 AS `jssj`,
 1 AS `sb`,
 1 AS `ry`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_scglxt_pc_tb_info`
--

DROP TABLE IF EXISTS `v_scglxt_pc_tb_info`;
/*!50001 DROP VIEW IF EXISTS `v_scglxt_pc_tb_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_scglxt_pc_tb_info` AS SELECT 
 1 AS `zddmc`,
 1 AS `jgsl`,
 1 AS `serial`,
 1 AS `gygcid`,
 1 AS `gymc`,
 1 AS `jhkssj`,
 1 AS `edgs`,
 1 AS `kssj`,
 1 AS `bzmc`,
 1 AS `rymc`,
 1 AS `sbmc`,
 1 AS `ryid`,
 1 AS `sbid`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_scglxt_pc_tb`
--

/*!50001 DROP VIEW IF EXISTS `v_scglxt_pc_tb`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_scglxt_pc_tb` AS select `gygc`.`id` AS `gyid`,`bom`.`id` AS `bomid`,`ry`.`id` AS `ryid`,`bz`.`id` AS `bzid`,`sb`.`id` AS `sbid`,`bz`.`bzmc` AS `bzmc`,`sb`.`sbmc` AS `sbmc`,`ry`.`rymc` AS `rymc`,`bom`.`jgsl` AS `jgsl`,`gygc`.`edgs` AS `edgs`,`gygc`.`KSSJ` AS `kssj`,`gygc`.`JSSJ` AS `jssj`,concat(`bz`.`bzmc`,'--',`sb`.`sbmc`) AS `sb`,concat(`bz`.`bzmc`,'--',`ry`.`rymc`) AS `ry` from ((((`scglxt_t_bz` `bz` join `scglxt_t_sb` `sb`) join `scglxt_t_gygc` `gygc`) join `scglxt_t_bom` `bom`) join `scglxt_t_ry` `ry`) where ((`bz`.`id` = `sb`.`BZID`) and (`bom`.`id` = `gygc`.`bomid`) and (`gygc`.`czryid` = `ry`.`id`) and (`gygc`.`sbid` = `sb`.`id`) and isnull(`gygc`.`JSSJ`)) order by `gygc`.`KSSJ` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_scglxt_pc_tb_info`
--

/*!50001 DROP VIEW IF EXISTS `v_scglxt_pc_tb_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_scglxt_pc_tb_info` AS select `bom`.`zddmc` AS `zddmc`,`bom`.`jgsl` AS `jgsl`,`gygc`.`serial` AS `serial`,`gygc`.`id` AS `gygcid`,`jggy`.`gymc` AS `gymc`,`gygc`.`JHKSSJ` AS `jhkssj`,`gygc`.`edgs` AS `edgs`,`gygc`.`KSSJ` AS `kssj`,`bz`.`bzmc` AS `bzmc`,`ry`.`rymc` AS `rymc`,`sb`.`sbmc` AS `sbmc`,`ry`.`id` AS `ryid`,`sb`.`id` AS `sbid` from (((((`scglxt_t_bom` `bom` join `scglxt_t_bz` `bz`) join `scglxt_t_ry` `ry`) join `scglxt_t_gygc` `gygc`) join `scglxt_t_jggy` `jggy`) join `scglxt_t_sb` `sb`) where ((`bom`.`id` = `gygc`.`bomid`) and (`gygc`.`sbid` = `sb`.`id`) and (`gygc`.`czryid` = `ry`.`id`) and (`sb`.`BZID` = `bz`.`id`) and (`gygc`.`gyid` = `jggy`.`id`) and isnull(`gygc`.`JSSJ`)) order by `bom`.`zddmc`,`gygc`.`serial`,`gygc`.`JHKSSJ`,`gygc`.`KSSJ` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-02-21 23:44:01
