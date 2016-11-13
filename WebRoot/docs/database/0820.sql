/*
SQLyog Enterprise v12.08 (64 bit)
MySQL - 5.1.40-community : Database - scpc
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`scpc` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `scpc`;

/*Table structure for table `scglxt_gx_bom_cl` */

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

/*Data for the table `scglxt_gx_bom_cl` */

/*Table structure for table `scglxt_mk_scpc` */

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

/*Data for the table `scglxt_mk_scpc` */

/*Table structure for table `scglxt_t_bom` */

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

/*Data for the table `scglxt_t_bom` */

insert  into `scglxt_t_bom`(`id`,`zddmc`,`zddcz`,`clxz`,`cldx`,`cltj`,`clje`,`jgsl`,`bmcl`,`starttime`,`endtime`,`gs`,`blqk`,`blkssj`,`bljssj`,`clzt`,`cgry`,`cgsj`,`ddtz`,`rksj`,`bfjs`,`bhgjs`,`gxnr`,`SSDD`) values ('20160521101853803','对对对','1','1','',0,78,100,'不用处理','2016-08-31 00:00:00','2016-05-12 18:15:00','null','1',NULL,'2016-05-21 13:10:50','0',NULL,NULL,NULL,NULL,NULL,NULL,'备(45)-铣(32)-加工中心 (54)','20160521100415400'),('20160521131913268','我的测试子订单','20160818231650480','2','3,5',23.55,581685,33,'33','2016-05-21 13:20:00','2016-05-20 15:15:00','null','2',NULL,'2016-05-21 13:20:21',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'备(23)-铣(33)-铣(3223)-铣(233)','20160521100415400'),('20160819131625292','908876543','20160818231650480','1','',18.84,2344,23,'镀金','2016-08-19 21:34:00','2016-08-24 14:15:00','null','1',NULL,'2016-08-19 21:34:46','1',NULL,NULL,NULL,NULL,NULL,NULL,'备(23)-铣(120)-加工中心 (130)','20160521100415400'),('20160819213809303','放平心态测试','1','1','',24,3,34,'啊啊啊','2016-08-19 22:35:50','2016-08-30 17:30:00','null','1',NULL,'2016-08-19 22:35:50','1',NULL,NULL,NULL,NULL,NULL,NULL,'备(2)-铣(2)-加工中心 (2)-钳(2)-镀(2)','20160521100415400'),('20160820113856104','BOM778767','7','1','5,5,5',125,45000,23,'无','2016-08-20 11:43:58','2016-08-20 03:35:00','null','1',NULL,'2016-08-20 11:43:58',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'铣(2)-加工中心 (3)-钳(4)-镀(5)','20160820104841339');

/*Table structure for table `scglxt_t_bz` */

DROP TABLE IF EXISTS `scglxt_t_bz`;

CREATE TABLE `scglxt_t_bz` (
  `id` varchar(50) NOT NULL COMMENT 'ID',
  `bzmc` varchar(50) DEFAULT NULL COMMENT '班组名称',
  `bzfzr` varchar(10) DEFAULT NULL COMMENT '班组负责人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工作班组表';

/*Data for the table `scglxt_t_bz` */

insert  into `scglxt_t_bz`(`id`,`bzmc`,`bzfzr`) values ('01','生产备料部','孙浩'),('02','铣工组','李明'),('03','加工中心','蕾蕾'),('04','钳组','素丽'),('05','电镀组','李晨'),('11647495641795407949','创新组','陈剑锋');

/*Table structure for table `scglxt_t_cl` */

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

/*Data for the table `scglxt_t_cl` */

insert  into `scglxt_t_cl`(`id`,`clmc`,`clcz`,`clsl`,`cldj`,`cllx`,`ghs`,`mi`,`clxz`,`kd`,`gd`,`cd`,`clly`) values ('1','铁','不锈钢',0,'12','材料类型','供货商','10','阿斯顿发',0,0,0,''),('20160818225717845','铜','铁',0,'120','科学','卫星研究所','15','易碎',23,32,23,'购买'),('20160818231650480','金','',0,'1235','','','20','',1,1,1,''),('7','银','asfd',0,'12','asdf','asdf','30','asdf',0,0,10,'0');

/*Table structure for table `scglxt_t_dd` */

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

/*Data for the table `scglxt_t_dd` */

insert  into `scglxt_t_dd`(`id`,`ssht`,`xmname`,`ddlevel`,`jhdate`,`planstarttime`,`planendtime`,`realstarttime`,`realendtime`,`zgs`,`dqjd`,`tz`,`remark`,`xmlxr`,`xmfzr`,`ckzt`,`ckdate`) values ('20160521100415400','20140929','SW0001','高级','2016-05-28','2016-08-18','2016-08-18',NULL,NULL,'340','csd','阿斯顿发','阿斯顿发','订单','大多数非','大师傅','2016-05-19'),('20160818220505637','20140928','阿斯顿发','订单级别','2016-08-18','2016-08-18','2016-08-18',NULL,NULL,'232','啊','地方硕大的','地方硕大的','地方','收到','第三方','2016-08-18'),('20160818224455888','20160820103140682','XXX000d','紧急','2016-08-18','2016-08-18','2016-08-18',NULL,NULL,'23','已完成','无备注','无备注','爱的','阿萨德','未出库','2016-08-18'),('20160820104841339','20160820103140682','BOM000098','高级','2016-08-08','2016-08-24','2016-08-06',NULL,NULL,'234','未开始','无备注2222','无备注2222','孙武22','苏武2','未出库','2016-08-20');

/*Table structure for table `scglxt_t_ghs` */

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

/*Data for the table `scglxt_t_ghs` */

insert  into `scglxt_t_ghs`(`GSMC`,`GSDZ`,`SPMC`,`ID`,`LXR`,`LXFS`) values ('大兴','北京市大兴区','商品是永辉超市买的','0009090','孙武','990898'),('乡村爱情','永泉山庄','修正后的商品描述','03484424990487635955','赵四','888888'),('开发人员测试数据','开发人员测试数据','该商品暂时不用','30990255780365113237','卖彩票的','133999443323'),('形容','额','','39646821861821331968','的','大'),('','','电子测绘计算机','9089887','陆伟','990089');

/*Table structure for table `scglxt_t_gygc` */

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

/*Data for the table `scglxt_t_gygc` */

insert  into `scglxt_t_gygc`(`bomid`,`gyid`,`id`,`gynr`,`edgs`,`stsj`,`jhwcsj`,`sjwcsj`,`jyryid`,`czryid`,`jlsj`,`serial`,`sbid`,`KSSJ`,`JSSJ`,`JHKSSJ`,`SFJY`,`JYSJ`,`kjgjs`,`yjgjs`,`bfjs`,`SJJS`,`ZYSX`) values ('009',NULL,'20160423112953290','1004',3,NULL,NULL,NULL,NULL,NULL,NULL,'2','05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'大数据'),('009',NULL,'20160423112953296','1005',5,NULL,NULL,NULL,NULL,NULL,NULL,'3','10093403427839111804',NULL,NULL,NULL,NULL,NULL,0,0,0,0,'水淀粉'),('009',NULL,'20160423112953473','1003',1,NULL,NULL,NULL,NULL,NULL,NULL,'1','42691179464839647152',NULL,NULL,NULL,NULL,NULL,4,4,0,0,'阿斯蒂芬'),('009',NULL,'20160423112953741','1001',6,NULL,NULL,NULL,NULL,NULL,NULL,'4','64425997594440958365',NULL,NULL,NULL,NULL,NULL,0,0,0,0,'谁是大神'),('20160521101853803',NULL,'20160521130850625','1001',45,NULL,NULL,NULL,NULL,NULL,NULL,'0','64425997594440958365',NULL,NULL,NULL,NULL,NULL,100,100,0,0,''),('20160521101853803',NULL,'20160521130850755','1002',32,NULL,NULL,NULL,NULL,NULL,NULL,'1','10093403427839111804',NULL,NULL,NULL,NULL,NULL,100,100,0,0,''),('20160521101853803',NULL,'20160521130850795','1003',54,NULL,NULL,NULL,NULL,NULL,NULL,'2','03498297362005925005',NULL,NULL,NULL,NULL,NULL,126,126,0,0,''),('20160521131913268',NULL,'20160521131958257','1002',33,NULL,NULL,NULL,NULL,NULL,NULL,'1','10093403427839111804',NULL,NULL,NULL,0,NULL,33,35,0,0,''),('20160521131913268',NULL,'20160521131958340','1002',3223,NULL,NULL,NULL,NULL,NULL,NULL,'3','58964558298908159384',NULL,NULL,NULL,0,NULL,0,0,0,0,''),('20160521131913268',NULL,'20160521131958461','1001',23,NULL,NULL,NULL,NULL,NULL,NULL,'0','05',NULL,NULL,NULL,0,NULL,33,33,0,0,''),('20160521131913268',NULL,'20160521131958588','1002',233,NULL,NULL,NULL,NULL,NULL,NULL,'4','10',NULL,NULL,NULL,0,NULL,0,0,0,0,''),('20160819131625292',NULL,'20160819131833469','1002',120,NULL,NULL,NULL,NULL,NULL,NULL,'1','10093403427839111804',NULL,NULL,NULL,0,NULL,23,13,4,0,'注意天气'),('20160819131625292',NULL,'20160819131833512','1001',23,NULL,NULL,NULL,NULL,NULL,NULL,'0','10093403427839111804',NULL,NULL,NULL,0,NULL,23,23,0,0,'注意表面处理'),('20160819131625292',NULL,'20160819131833784','1003',130,NULL,NULL,NULL,NULL,NULL,NULL,'2','01245906542771474997',NULL,NULL,NULL,0,NULL,13,7,5,0,'注意工具'),('20160819213809303',NULL,'20160819222248469','1001',2,NULL,NULL,NULL,NULL,NULL,NULL,'0','05',NULL,NULL,NULL,0,NULL,34,34,0,0,''),('20160819213809303',NULL,'20160819222249055','1003',2,NULL,NULL,NULL,NULL,NULL,NULL,'2','10093403427839111804',NULL,NULL,NULL,0,NULL,22,0,0,0,''),('20160819213809303',NULL,'20160819222249141','1005',2,NULL,NULL,NULL,NULL,NULL,NULL,'4','09',NULL,NULL,NULL,0,NULL,0,0,0,0,''),('20160819213809303',NULL,'20160819222249530','1004',2,NULL,NULL,NULL,NULL,NULL,NULL,'3','02345685343370576383',NULL,NULL,NULL,0,NULL,0,0,0,0,''),('20160819213809303',NULL,'20160819222249833','1002',2,NULL,NULL,NULL,NULL,NULL,NULL,'1','64425997594440958365',NULL,NULL,NULL,0,NULL,34,22,0,0,''),('20160820113856104',NULL,'20160820114001027','1002',2,NULL,NULL,NULL,NULL,NULL,NULL,'1','64425997594440958365',NULL,NULL,NULL,0,NULL,23,0,0,0,'9'),('20160820113856104',NULL,'20160820114001180','1003',3,NULL,NULL,NULL,NULL,NULL,NULL,'2','01245906542771474997',NULL,NULL,NULL,0,NULL,0,0,0,0,'9'),('20160820113856104',NULL,'20160820114001456','1004',4,NULL,NULL,NULL,NULL,NULL,NULL,'3','05',NULL,NULL,NULL,0,NULL,0,0,0,0,'9'),('20160820113856104',NULL,'20160820114002112','1005',5,NULL,NULL,NULL,NULL,NULL,NULL,'4','07',NULL,NULL,NULL,0,NULL,0,0,0,0,'9');

/*Table structure for table `scglxt_t_gzsj` */

DROP TABLE IF EXISTS `scglxt_t_gzsj`;

CREATE TABLE `scglxt_t_gzsj` (
  `ID` varchar(40) NOT NULL DEFAULT '' COMMENT 'ID',
  `GZSJ` int(3) DEFAULT NULL COMMENT '每天工作分钟数',
  `SFQY` int(1) DEFAULT NULL COMMENT '是否启用',
  `SJ` datetime DEFAULT NULL COMMENT '数据更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `scglxt_t_gzsj` */

insert  into `scglxt_t_gzsj`(`ID`,`GZSJ`,`SFQY`,`SJ`) values ('01',6,1,'2015-01-01 10:00:00'),('02',72,0,'2015-01-01 10:00:00'),('03',84,0,'2015-01-01 10:00:00'),('04',120,0,'2015-01-01 10:00:00');

/*Table structure for table `scglxt_t_hkjl` */

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

/*Data for the table `scglxt_t_hkjl` */

/*Table structure for table `scglxt_t_ht` */

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
  `htmx` varchar(500) DEFAULT NULL COMMENT '合同明细',
  `khid` varchar(45) DEFAULT NULL COMMENT '客户id',
  `jssj` date DEFAULT NULL COMMENT '预计结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='合同信息表';

/*Data for the table `scglxt_t_ht` */

insert  into `scglxt_t_ht`(`id`,`mc`,`htbh`,`ywlx`,`htje`,`qssj`,`dqjd`,`fkzt`,`jkbfb`,`jkje`,`jscb`,`hkzh`,`hkkhh`,`remark`,`htmx`,`khid`,`jssj`) values ('20140928','测试合同2','XLA00034','3101','40','2016-07-21','','3202','7.5','3',NULL,'2223232','民生银行','最终测试','                                ','20141126184435235','2016-07-21'),('20140929','销售合同','HTAAAAA','3101','23000','2016-08-18','','1401','0.02','5',NULL,'','','','                                ','20141126184435235','2016-08-19'),('20160510091837957','北京天露','TC北京天','3102','45000000','2016-05-03','','3202','0.76','340000',0,'622509087865','招商银行回龙观支行','无','                                ',NULL,'2016-05-03'),('20160820102822261','兴隆合同',' AAAS0009','3102','23434','2016-08-20','','3203','0.05','12',0,'223343334303987654','西二旗支行','无','安抚  无              ',NULL,'2016-08-22'),('20160820103140682','兴隆合同','BBS0009','3101','2','2016-08-20','','3203','50','1',0,'2233433343039876542','西二旗','无A','1111111',NULL,'2016-08-20');

/*Table structure for table `scglxt_t_jggl` */

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

/*Data for the table `scglxt_t_jggl` */

insert  into `scglxt_t_jggl`(`id`,`jgryid`,`jgjs`,`jyryid`,`bfjs`,`jgkssj`,`jgjssj`,`jysj`,`bz`,`sbid`,`gygcid`,`SFJY`) values ('F001000325838956072599040399642300169829','01',76,'02',0,'2016-05-21 13:21:23','2016-08-20 13:12:08','2016-05-21 13:25:25',NULL,'01245906542771474997','20160521130850755','1'),('F020834349200386059781517238960727772344','33155418726113245300',6,'02',0,'2016-08-20 13:38:44','2016-08-20 13:38:53','2016-08-20 13:39:03',NULL,'05','20160819131833784','1'),('F037211798801906282384597955160923368881','01',2,'02',1,'2016-08-20 14:07:31','2016-08-20 14:07:37','2016-08-20 14:07:45',NULL,'05','20160819131833784','1'),('F070627730947473478348431867759360547918','01',2,'02',0,'2016-08-20 13:19:46','2016-08-20 14:04:04','2016-08-20 13:20:09',NULL,'03','20160819131833469','1'),('F124213309994861463947927474742003205369','01',2,'02',0,'2016-08-20 13:27:44','2016-08-20 14:04:04','2016-08-20 13:28:32',NULL,'03','20160819131833469','1'),('F144711434954600431084106945367395283633','01',2,'02',0,'2016-08-20 14:03:05','2016-08-20 14:04:04','2016-08-20 14:03:29',NULL,'03','20160819131833469','1'),('F312378424987484711206121885761899346191','01',2,'02',2,'2016-08-20 14:03:55','2016-08-20 14:04:04','2016-08-20 14:04:30',NULL,'03','20160819131833469','1'),('F350140941354809110955917244976263589356','01',2,'02',0,'2016-08-20 13:36:49','2016-08-20 14:04:04','2016-08-20 13:37:05',NULL,'03','20160819131833469','1'),('F350487721094653037667831865316189137376','33155418726113245300',2,'02',0,'2016-08-20 13:17:42','2016-08-20 14:05:20','2016-08-20 13:18:25',NULL,'05','20160819131833469','1'),('F356256955336473119255438039524779578891','01',2,'02',1,'2016-08-20 13:37:27','2016-08-20 14:04:04','2016-08-20 13:37:45',NULL,'03','20160819131833469','1'),('F378776039332985806099375573082362737507','02',13,'02',0,'2016-04-23 11:07:08','2016-04-23 11:07:21','2016-04-23 11:07:33',NULL,'03498297362005925005','20150401215309975','1'),('F419464713738388769561533898726367715655','33155418726113245300',2,'02',0,'2016-08-20 13:59:09','2016-08-20 14:05:20','2016-08-20 13:59:34',NULL,'05','20160819131833469','1'),('F430074804241735784317250600763409179352','01',48,'02',0,'2016-08-20 13:15:00','2016-08-20 13:15:09','2016-08-20 13:15:14',NULL,'06','20160521130850795','1'),('F462656021680113665757065730079431446048','02',2,'02',0,'2016-05-21 15:17:17','2016-05-21 15:17:36','2016-05-21 15:17:42',NULL,'03','20160521130850795','1'),('F486800876741131347603786476822013329361','01',33,'02',0,'2016-08-19 22:45:52','2016-08-19 22:49:57','2016-08-19 22:47:34',NULL,'06','20160521131958257','1'),('F488042774338688127403095346718133079143','02',3,'02',0,'2016-08-20 13:39:16','2016-08-20 13:39:23','2016-08-20 13:39:30',NULL,'03498297362005925005','20160819131833469','1'),('F511320211119666298183291305858558890752','01',48,'02',0,'2016-08-20 13:13:51','2016-08-20 13:15:09','2016-08-20 13:14:35',NULL,'06','20160521130850795','1'),('F586143910045443759734210332878904604564','01',76,'02',0,'2016-08-19 22:59:02','2016-08-20 13:12:08','2016-08-19 22:59:31',NULL,'01245906542771474997','20160521130850755','1'),('F596590373721193014346327858350678891779','33155418726113245300',2,'02',1,'2016-08-20 14:05:13','2016-08-20 14:05:20','2016-08-20 14:05:28',NULL,'05','20160819131833469','1'),('F613073250593386864844389690983944902498','33155418726113245300',NULL,NULL,NULL,'2016-08-19 22:46:05',NULL,NULL,NULL,NULL,'20160521131958257','0'),('F616708297740255803519110622299665424496','02',NULL,NULL,NULL,'2016-08-19 22:46:00',NULL,NULL,NULL,NULL,'20160521131958257','0'),('F634166346213688618139748223565811385913','01',2,'02',2,'2016-08-20 13:42:10','2016-08-20 14:07:37','2016-08-20 13:42:40',NULL,'05','20160819131833784','1'),('F757168347797681464383873248998119887513','01',76,'02',0,'2016-08-20 13:11:16','2016-08-20 13:12:08','2016-08-20 13:13:17',NULL,'01245906542771474997','20160521130850755','1'),('F773259522637182210052113601009522342887','01',22,'02',0,'2016-08-19 23:01:34','2016-08-19 23:01:53','2016-08-19 23:02:23',NULL,'04','20160819222249833','1'),('F790758553532562522666831549889663931864','02',3,'02',0,'2016-08-19 23:02:50','2016-08-20 13:39:23','2016-08-19 23:03:06',NULL,'03498297362005925005','20160819131833469','1'),('F794282369615500351348322609905169040146','01',1,'02',0,'2016-03-05 10:22:03','2016-03-05 10:33:11',NULL,NULL,'05','20150401215309975','1'),('F822518970327036742232559503335159506626','01',33,'02',0,'2016-08-19 22:48:20','2016-08-19 22:49:57','2016-08-19 22:50:13',NULL,'06','20160521131958257','1'),('F866387379065875340148435181868522121129','01',2,'02',2,'2016-08-20 14:06:31','2016-08-20 14:07:37','2016-08-20 14:07:06',NULL,'05','20160819131833784','1'),('F940344535555303018219214910262253657861','01',1,'02',0,'2016-03-05 10:33:00','2016-03-05 10:33:11','2016-03-05 10:33:34',NULL,'05','20150401215309975','1');

/*Table structure for table `scglxt_t_jggy` */

DROP TABLE IF EXISTS `scglxt_t_jggy`;

CREATE TABLE `scglxt_t_jggy` (
  `id` varchar(50) NOT NULL COMMENT '工艺ID',
  `gymc` varchar(50) DEFAULT NULL COMMENT '工艺名称',
  `gydh` varchar(10) DEFAULT NULL COMMENT '工艺代号',
  `fzbz` varchar(10) DEFAULT NULL COMMENT '工艺班组',
  `gxsx` varchar(45) DEFAULT NULL,
  `sfwx` varchar(40) DEFAULT NULL COMMENT '是否外协',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工序表';

/*Data for the table `scglxt_t_jggy` */

insert  into `scglxt_t_jggy`(`id`,`gymc`,`gydh`,`fzbz`,`gxsx`,`sfwx`) values ('1001','备','1001','03',NULL,'1'),('1002','铣','1002','01',NULL,'1'),('1003','加工中心 ','1003','05',NULL,'1'),('1004','钳','1004','04',NULL,'1'),('1005','镀','1005','123',NULL,'0'),('20160820114824104','测试',NULL,'123',NULL,'1');

/*Table structure for table `scglxt_t_kh` */

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

/*Data for the table `scglxt_t_kh` */

insert  into `scglxt_t_kh`(`id`,`mc`,`lx`,`dw`,`dz`,`gx`,`iscj`,`starttime`,`remark`) values ('20160509220933353','北京天五软件','3002','北京天天向鼓楼大街店','复兴路209号院','供货商','0','2016-05-10','已经合作过'),('20160729090044613','我最终测试的客户信息','3004','中国石油总公司','望京西街390','良好的合作','1','2016-07-20','最终测试'),('20160820100716105','兴隆模具','3002','北京市2','北京市海淀区231号','合作','1','2016-08-18','无');

/*Table structure for table `scglxt_t_lj` */

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

/*Data for the table `scglxt_t_lj` */

insert  into `scglxt_t_lj`(`ID`,`lx`,`mc`,`cc`,`zsl`,`kcsl`,`dj`,`ghs`) values ('1','2',NULL,'3','4','5','6','7'),('2','刀片',NULL,'8号','18','5','100',NULL),('20160820162906099','工具A','工具','32','23','3','23','1');

/*Table structure for table `scglxt_t_lxr` */

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

/*Data for the table `scglxt_t_lxr` */

/*Table structure for table `scglxt_t_ry` */

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

/*Data for the table `scglxt_t_ry` */

insert  into `scglxt_t_ry`(`id`,`rymc`,`rynl`,`jsjb`,`rzsj`,`ssbz`,`dqgz`,`password`) values ('01','李勇','24','020102','2014-10-24','11647495641795407949',3400,'123456'),('02','admin','22','020101','2014-10-24','01',4453,'123456'),('33155418726113245300','陈若琳','23','020101','2016-08-18','02',32000,NULL);

/*Table structure for table `scglxt_t_sb` */

DROP TABLE IF EXISTS `scglxt_t_sb`;

CREATE TABLE `scglxt_t_sb` (
  `id` varchar(50) NOT NULL COMMENT 'ID',
  `sblx` varchar(50) DEFAULT NULL COMMENT '设备类型',
  `sbmc` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '设备名称',
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

/*Data for the table `scglxt_t_sb` */

insert  into `scglxt_t_sb`(`id`,`sblx`,`sbmc`,`cgsj`,`bxjssj`,`sbszd`,`dqzt`,`wxjl`,`remark`,`BZID`,`SCCJ`,`SCCJDETAIL`) values ('01245906542771474997','010103','兴隆设备','2016-08-20','2016-08-19','朝阳','010201','2222','安抚','03','2323','安抚'),('02','010101','备料设备B','2014-10-07','2014-10-30','机器存放','010202','维修过三次','没事没事','04',NULL,NULL),('02345685343370576383','010101','5月11日设备','2016-05-12','2016-05-11','库房','010201','a','阿斯顿发','01','2542345','324234'),('03','010101','铣设备A','2014-10-06','2014-10-08','无','010201','无','良好是被','02',NULL,NULL),('03498297362005925005','010103','备料设备A','2014-10-07','2014-10-20','孙','010201','维修过上百次','采购的',NULL,NULL,NULL),('04','010101','铣设备B','2014-10-07','2014-10-03','南库机房','010201','维修过2次','没有备注信息','02',NULL,NULL),('05','010103','加工中心设备A','2014-10-07','2014-10-20','可以使中文','010201','中文','采购的','03',NULL,NULL),('06','010101','加工中心设备B','0000-00-00','0000-00-00','','010201','','','03',NULL,NULL),('07','010101','加工中心设备C','2012-00-00','0000-00-00','','010201','','','04',NULL,NULL),('08','010101','加工中心设备D','1900-12-14','1900-12-07','电厂路','010201','维修过三次','无','01',NULL,NULL),('09','010101','钳设A','2014-10-07','2014-10-03','南库机房','010201','维修过2次','没有备注信息','04',NULL,NULL),('10','010101','钳设B','2014-10-20','2014-10-20','二车间','010202','没有维修过',NULL,'04',NULL,NULL),('10093403427839111804','010101','9月5日测试设备','2014-08-13','2014-08-14','3郝仓库','010201','没有维修过','维修过一次','04',NULL,NULL),('11','010102','镀设A','2014-10-20','2014-10-20','一车间','010201','没有维修过','备注','05',NULL,NULL),('19503876015886209304','010103','备料设备A','2014-10-07','2014-10-20','','010201','维修过上百次','采购的',NULL,NULL,NULL),('31807013118867144805','010103','备料设备A','2014-10-07','2014-10-20','孙XX家','010201','维修过上百次','采购的deded',NULL,NULL,NULL),('41353996961077987502','010103','备料设备A','2014-10-07','2014-10-20','孙XX家','010201','维修过上百次','采购的',NULL,NULL,NULL),('58964558298908159384','010103','备料设备A','2014-10-07','2014-10-20','孙XX家','010201','维修过上百次','采购的',NULL,NULL,NULL),('64425997594440958365','010101','9月4日测试设备','2014-08-20','2014-08-27','2号仓库','010201','维修过3次','没有维修过',NULL,NULL,NULL);

/*Table structure for table `scglxt_tyzd` */

DROP TABLE IF EXISTS `scglxt_tyzd`;

CREATE TABLE `scglxt_tyzd` (
  `XH` varchar(40) DEFAULT NULL COMMENT '序号',
  `ID` varchar(40) NOT NULL DEFAULT '' COMMENT 'ID字段',
  `MC` varchar(60) DEFAULT NULL COMMENT '名称',
  `BZ` varchar(100) DEFAULT NULL COMMENT '备注',
  `JLSJ` datetime DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `scglxt_tyzd` */

insert  into `scglxt_tyzd`(`XH`,`ID`,`MC`,`BZ`,`JLSJ`) values ('01','01','设备字典','设备型号','2014-10-20 19:01:49'),('0101','0101','设备型号','设备型号','2014-10-20 19:05:23'),('010101','010101','备料机器','设备型号01','2014-10-20 19:02:17'),('010102','010102','洗机器','设备型号02','2014-10-20 19:02:49'),('010103','010103','磨机器','设备型号03','2014-10-20 19:03:17'),('010104','010104','抛光机器','用来抛光类型的机器',NULL),('0102','0102','设备状态','设备状态','2014-10-20 19:06:52'),('010201','010201','良好','良好','2014-10-20 19:06:47'),('010202','010202','报废','报废','2014-10-20 19:06:44'),('02','02','人员','人员',NULL),('0201','0201','人员技术级别','人员技术级别',NULL),('020101','020101','技术三级','技术三级',NULL),('020102','020102','技术二级','技术二级',NULL),('020103','020103','技术一级','技术一级',NULL),('03','03','材料形状','圆柱',NULL),('0301','0301','圆柱','圆柱',NULL),('0302','0302','长方体','长方体',NULL),('0303','0303','其它','其它',NULL),('30','30','客户类型','客户类型',NULL),('3001','3001','大客户','大客户',NULL),('3002','3002','中等客户','中等客户',NULL),('3003','3003','政府客户','政府客户',NULL),('3004','3004','小企业客户',NULL,NULL),('31','31','业务类型','业务类型',NULL),('3101','3101','业务类型A','业务类型A',NULL),('3102','3102','业务类型B','业务类型B',NULL),('3103','3103','业务类型C','业务类型C',NULL),('32','32','付款状态','付款状态',NULL),('3201','3201','部分',NULL,NULL),('3202','3202','结清',NULL,NULL),('3203','3203','其它',NULL,NULL);

/* Function  structure for function  `fun_dqgygc` */

/*!50003 DROP FUNCTION IF EXISTS `fun_dqgygc` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `fun_dqgygc`(zddid varchar (60)) RETURNS varchar(2000) CHARSET utf8
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
END */$$
DELIMITER ;

/* Procedure structure for procedure `procedure1` */

/*!50003 DROP PROCEDURE IF EXISTS  `procedure1` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure1`()
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
    REPEAT  /*Ñ­»·*/
    FETCH update_cursor INTO _outuserid,_kubauserid;
     
    /*update set where*/
    UNTIL flag 
    END REPEAT;
    CLOSE update_cursor ;
            
END */$$
DELIMITER ;

/*Table structure for table `v_scglxt_pc_sb_tb` */

DROP TABLE IF EXISTS `v_scglxt_pc_sb_tb`;

/*!50001 DROP VIEW IF EXISTS `v_scglxt_pc_sb_tb` */;
/*!50001 DROP TABLE IF EXISTS `v_scglxt_pc_sb_tb` */;

/*!50001 CREATE TABLE  `v_scglxt_pc_sb_tb`(
 `v` decimal(54,2) ,
 `c` varchar(50) ,
 `k` varchar(152) ,
 `id` varchar(50) 
)*/;

/*Table structure for table `v_scglxt_pc_tb` */

DROP TABLE IF EXISTS `v_scglxt_pc_tb`;

/*!50001 DROP VIEW IF EXISTS `v_scglxt_pc_tb` */;
/*!50001 DROP TABLE IF EXISTS `v_scglxt_pc_tb` */;

/*!50001 CREATE TABLE  `v_scglxt_pc_tb`(
 `gyid` varchar(40) ,
 `bomid` varchar(50) ,
 `bzid` varchar(50) ,
 `sbid` varchar(50) ,
 `bzmc` varchar(50) ,
 `sbmc` varchar(100) ,
 `jgsl` bigint(12) ,
 `edgs` int(11) ,
 `kssj` datetime ,
 `jssj` datetime ,
 `sb` varchar(152) 
)*/;

/*Table structure for table `v_scglxt_pc_tb_info` */

DROP TABLE IF EXISTS `v_scglxt_pc_tb_info`;

/*!50001 DROP VIEW IF EXISTS `v_scglxt_pc_tb_info` */;
/*!50001 DROP TABLE IF EXISTS `v_scglxt_pc_tb_info` */;

/*!50001 CREATE TABLE  `v_scglxt_pc_tb_info`(
 `zddmc` varchar(50) ,
 `jgsl` int(11) ,
 `serial` decimal(10,0) ,
 `gygcid` varchar(40) ,
 `gymc` varchar(50) ,
 `jhkssj` datetime ,
 `edgs` int(11) ,
 `kssj` datetime ,
 `bzmc` varchar(50) ,
 `rymc` varchar(50) ,
 `sbmc` varchar(100) ,
 `ryid` varchar(50) ,
 `sbid` varchar(50) 
)*/;

/*View structure for view v_scglxt_pc_sb_tb */

/*!50001 DROP TABLE IF EXISTS `v_scglxt_pc_sb_tb` */;
/*!50001 DROP VIEW IF EXISTS `v_scglxt_pc_sb_tb` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_scglxt_pc_sb_tb` AS select round(((sum((`v_scglxt_pc_tb`.`edgs` * `v_scglxt_pc_tb`.`jgsl`)) / 60) / (select `scglxt_t_gzsj`.`GZSJ` AS `gzsj` from `scglxt_t_gzsj` where (`scglxt_t_gzsj`.`SFQY` = 1))),2) AS `v`,`v_scglxt_pc_tb`.`bzid` AS `c`,`v_scglxt_pc_tb`.`sb` AS `k`,`v_scglxt_pc_tb`.`sbid` AS `id` from `v_scglxt_pc_tb` group by `v_scglxt_pc_tb`.`sbid` order by `v_scglxt_pc_tb`.`kssj`,`v_scglxt_pc_tb`.`bzid` */;

/*View structure for view v_scglxt_pc_tb */

/*!50001 DROP TABLE IF EXISTS `v_scglxt_pc_tb` */;
/*!50001 DROP VIEW IF EXISTS `v_scglxt_pc_tb` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_scglxt_pc_tb` AS select `gygc`.`id` AS `gyid`,`bom`.`id` AS `bomid`,`bz`.`id` AS `bzid`,`sb`.`id` AS `sbid`,`bz`.`bzmc` AS `bzmc`,`sb`.`sbmc` AS `sbmc`,(`bom`.`jgsl` - `gygc`.`yjgjs`) AS `jgsl`,`gygc`.`edgs` AS `edgs`,`gygc`.`KSSJ` AS `kssj`,`gygc`.`JSSJ` AS `jssj`,concat(`bz`.`bzmc`,'--',`sb`.`sbmc`) AS `sb` from (((`scglxt_t_bz` `bz` join `scglxt_t_sb` `sb`) join `scglxt_t_gygc` `gygc`) join `scglxt_t_bom` `bom`) where ((`bz`.`id` = `sb`.`BZID`) and (`bom`.`id` = `gygc`.`bomid`) and (`gygc`.`sbid` = `sb`.`id`) and isnull(`gygc`.`JSSJ`)) order by `gygc`.`KSSJ` */;

/*View structure for view v_scglxt_pc_tb_info */

/*!50001 DROP TABLE IF EXISTS `v_scglxt_pc_tb_info` */;
/*!50001 DROP VIEW IF EXISTS `v_scglxt_pc_tb_info` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_scglxt_pc_tb_info` AS select `bom`.`zddmc` AS `zddmc`,`bom`.`jgsl` AS `jgsl`,`gygc`.`serial` AS `serial`,`gygc`.`id` AS `gygcid`,`jggy`.`gymc` AS `gymc`,`gygc`.`JHKSSJ` AS `jhkssj`,`gygc`.`edgs` AS `edgs`,`gygc`.`KSSJ` AS `kssj`,`bz`.`bzmc` AS `bzmc`,`ry`.`rymc` AS `rymc`,`sb`.`sbmc` AS `sbmc`,`ry`.`id` AS `ryid`,`sb`.`id` AS `sbid` from (((((`scglxt_t_bom` `bom` join `scglxt_t_bz` `bz`) join `scglxt_t_ry` `ry`) join `scglxt_t_gygc` `gygc`) join `scglxt_t_jggy` `jggy`) join `scglxt_t_sb` `sb`) where ((`bom`.`id` = `gygc`.`bomid`) and (`gygc`.`sbid` = `sb`.`id`) and (`gygc`.`czryid` = `ry`.`id`) and (`sb`.`BZID` = `bz`.`id`) and (`gygc`.`gyid` = `jggy`.`id`) and isnull(`gygc`.`JSSJ`)) order by `bom`.`zddmc`,`gygc`.`serial`,`gygc`.`JHKSSJ`,`gygc`.`KSSJ` */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
