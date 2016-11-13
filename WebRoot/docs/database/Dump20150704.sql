CREATE DATABASE  IF NOT EXISTS `scpc` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `scpc`;
-- MySQL dump 10.13  Distrib 5.6.19, for osx10.7 (i386)
--
-- Host: 127.0.0.1       Database: scpc
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='子订单管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scglxt_t_bom`
--

LOCK TABLES `scglxt_t_bom` WRITE;
/*!40000 ALTER TABLE `scglxt_t_bom` DISABLE KEYS */;
INSERT INTO `scglxt_t_bom` VALUES ('1','子订单','材质','PEI',NULL,NULL,NULL,2,'表面处理',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'备料(40)-磨(20)-洗(30)-抛光1(40)-抛光2(50)'),('2','2','2','2','2',2,2,2,'2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
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
INSERT INTO `scglxt_t_bz` VALUES ('01','生产技术部','李大明'),('02','技术管理班','李明'),('23572898806652434482','质量管理组','蕾蕾');
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
INSERT INTO `scglxt_t_cl` VALUES ('1','材料名称','不锈钢',0,'100','材料类型','供货商','密度','材料形状',0,0,0,NULL);
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
INSERT INTO `scglxt_t_ghs` VALUES ('大兴','北京市大兴区','null','0009090','孙武','990898'),('乡村爱情','永泉山庄','null','03484424990487635955','赵四','888888'),(NULL,NULL,'电子测绘计算机','9089887','陆伟','990089');
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
  `id` varchar(40) NOT NULL DEFAULT '' COMMENT 'ID',
  `gynr` varchar(100) DEFAULT NULL COMMENT '工艺内容',
  `edgs` int(11) DEFAULT NULL COMMENT '额定工时',
  `stsj` date DEFAULT NULL COMMENT '受图时间',
  `jhwcsj` date DEFAULT NULL COMMENT '计划完成时间',
  `sjwcsj` date DEFAULT NULL COMMENT '时间完成时间',
  `jyryid` varchar(40) DEFAULT NULL COMMENT '检验人员',
  `czryid` varchar(40) DEFAULT NULL COMMENT '操作人员',
  `jlsj` date DEFAULT NULL COMMENT '记录时间',
  `serial` decimal(10,0) DEFAULT NULL COMMENT '工艺过程排序',
  `sbid` varchar(50) DEFAULT NULL COMMENT '所用设备id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工艺过程';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scglxt_t_gygc`
--

LOCK TABLES `scglxt_t_gygc` WRITE;
/*!40000 ALTER TABLE `scglxt_t_gygc` DISABLE KEYS */;
INSERT INTO `scglxt_t_gygc` VALUES ('1',NULL,'20150701215309327','洗',30,NULL,NULL,NULL,NULL,NULL,NULL,2,'1003'),('1',NULL,'20150701215309546','抛光2',50,NULL,NULL,NULL,NULL,NULL,NULL,4,'1004'),('1',NULL,'20150701215309670','抛光1',40,NULL,NULL,NULL,NULL,NULL,NULL,3,'1004'),('1',NULL,'20150701215309772','备料',40,NULL,NULL,NULL,NULL,NULL,NULL,0,'1001'),('1',NULL,'20150701215309975','磨',20,NULL,NULL,NULL,NULL,NULL,NULL,1,'1002');
/*!40000 ALTER TABLE `scglxt_t_gygc` ENABLE KEYS */;
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='合同信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scglxt_t_ht`
--

LOCK TABLES `scglxt_t_ht` WRITE;
/*!40000 ALTER TABLE `scglxt_t_ht` DISABLE KEYS */;
INSERT INTO `scglxt_t_ht` VALUES ('1','测试合同','ht10012','',100000,'2015-02-02',0,'',0,10000,0,'','',''),('20140928','测试合同2',NULL,'未知',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('20140929','销售合同',NULL,'未知',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `scglxt_t_ht` ENABLE KEYS */;
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工序表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scglxt_t_jggy`
--

LOCK TABLES `scglxt_t_jggy` WRITE;
/*!40000 ALTER TABLE `scglxt_t_jggy` DISABLE KEYS */;
INSERT INTO `scglxt_t_jggy` VALUES ('1001','备料','1001',NULL,NULL),('1002','磨','1002',NULL,NULL),('1003','洗','1003',NULL,NULL),('1004','抛光','1004',NULL,NULL);
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
INSERT INTO `scglxt_t_kh` VALUES ('20141126184253409','小明','3003','北京','北京','','1',NULL,''),('20141126184435235','老王','3002','上海','上海','老客户','0',NULL,'');
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
INSERT INTO `scglxt_t_ry` VALUES ('00022345','王清','24','020101','2014-10-24','01',3456),('000dddadda','霍晓琳','22','020101','2014-10-19','08',4453),('13522355007400449103','孙武','22','020101','2014-10-24','02',33),('2234q34afsdf','孙武','22','020101','2014-10-24','02',122222),('27764990421680532721','ceshi','23','020102','2014-10-24','08',23),('31540912553091342559','ceshi','23','020102','2014-10-24','08',23),('32894383099026725431','ceshi','23','020102','2014-10-24','08',23),('35116045172477029238','ceshi','23','020102','2014-10-24','08',23),('42733190192064118704','ceshi','23','020102','2014-10-24','08',23),('45734530454740714472','海淀驾校','23','020101','2014-10-06','02',2345),('49904133657880056631','ceshi','23','020102','2014-10-24','08',23),('53122394822487637279','李连杰','22','020101','2014-10-24','08',33),('54060408895830333675','成龙之子','22','020101','2014-10-24','08',22),('71119443320212307664','ceshi','23','020102','2014-10-24','08',23),('82089522645608624504','木困','22','020101','2014-10-24','01',22),('90631146921226422326','ceshi','23','020102','2014-10-24','08',23),('97284335866862337505','麻辣烫不是人','22','020101','2014-10-24','08',22),('98204702819311449641','ceshi','23','020102','2014-10-24','08',23),('ddasdfasdfadsadf','天元','33','020101','2014-10-24','01',3333);
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
  `wxjl` varchar(10) DEFAULT NULL COMMENT '设备维修记录',
  `remark` varchar(50) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='设备表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scglxt_t_sb`
--

LOCK TABLES `scglxt_t_sb` WRITE;
/*!40000 ALTER TABLE `scglxt_t_sb` DISABLE KEYS */;
INSERT INTO `scglxt_t_sb` VALUES ('20157446297795941195','010103','采购时间','2014-10-07','2014-10-20','孙XX家','010201','维修过上百次','采购的'),('30389193644491380861','010103','回龙观鑫地市场','2014-10-07','2014-10-30','机器存放','010201','维修过三次','没事没事'),('31416881095062269910','010101','东方时尚驾校','2014-10-06','2014-10-08','无','010201','无','良好是被'),('48346034678697573610','010101','设备ABCD','2014-10-07','2014-10-03','南库机房','010201','维修过2次','没有备注信息'),('74527338015029728441','010103','采购时间','2014-10-07','2014-10-20','可以使中文','010201','中文','采购的'),('84867674270000170973945','010101','cesgi','0000-00-00','0000-00-00','','010201','',''),('84867674270000170973946','010101','cesgi','2012-00-00','0000-00-00','','010201','',''),('84867674270170973945','010101','cesgi','0000-00-00','0000-00-00','','010201','',''),('85793762843260249878','010101','设备ABCD','2014-10-07','2014-10-03','南库机房','010201','维修过2次','没有备注信息'),('9088767','010101','生产设备','2014-10-20','2014-10-20','二车间','010202','没有维修过',NULL),('9980899','010102','生产机床','2014-10-20','2014-10-20','一车间','010201','没有维修过','备注');
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-07-04 22:30:29
