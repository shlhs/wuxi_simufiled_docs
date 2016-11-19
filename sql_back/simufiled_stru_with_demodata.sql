CREATE DATABASE  IF NOT EXISTS `simufiled` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `simufiled`;
-- MySQL dump 10.13  Distrib 5.6.19, for osx10.7 (i386)
--
-- Host: 114.215.90.83    Database: simufiled
-- ------------------------------------------------------
-- Server version	5.6.31-0ubuntu0.14.04.2

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
-- Table structure for table `Scene`
--

DROP TABLE IF EXISTS `Scene`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Scene` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `content` mediumtext,
  `designer` varchar(50) DEFAULT NULL,
  `practiser` varchar(50) DEFAULT NULL,
  `assigner` varchar(50) DEFAULT NULL,
  `parentID` int(4) DEFAULT NULL,
  `practiseStatus` varchar(20) DEFAULT NULL,
  `practiseLog` mediumtext,
  `practiseResult` varchar(20) DEFAULT NULL,
  `practiserCatagory` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2462 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Scene`
--

LOCK TABLES `Scene` WRITE;
/*!40000 ALTER TABLE `Scene` DISABLE KEYS */;
INSERT INTO `Scene` VALUES (2460,'aaa','<?xml version=\"1.0\" encoding=\"gb2312\" standalone=\"yes\" ?>\r\n<Scene>\r\n    <SubScene name=\"aaa\" back=\"\">\r\n        <Devices>\r\n            <Device type=\"监控主机\" name=\"监控主机_01\" use=\"1\" rect=\"105,108,165,162\">\r\n                <Ports>\r\n                    <Port name=\"以太网口\" />\r\n                </Ports>\r\n                <Connections />\r\n            </Device>\r\n            <Device type=\"串口开关\" name=\"串口开关_01\" use=\"1\" rect=\"285,159,357,231\" address=\"1\" BaudRate=\"3\" ByteSize=\"2\" Parity=\"0\" StopBits=\"0\">\r\n                <Ports>\r\n                    <Port name=\"串口\" />\r\n                </Ports>\r\n                <Connections />\r\n                <DataModels />\r\n            </Device>\r\n            <Device type=\"PLC\" name=\"PLC_01\" use=\"1\" rect=\"461,320,732,465\" mode=\"1\" port=\"502\">\r\n                <Ports>\r\n                    <Port name=\"以太网口\" />\r\n                </Ports>\r\n                <Connections>\r\n                    <connection port=\"以太网口\" peerport=\"监控主机_01.以太网口\" />\r\n                </Connections>\r\n                <DataModels />\r\n            </Device>\r\n        </Devices>\r\n    </SubScene>\r\n    <Shixun Aim=\"\" Devices=\"\" Notes=\"\" />\r\n</Scene>\r\n','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2461,'图书馆','<?xml version=\"1.0\" encoding=\"gb2312\" standalone=\"yes\" ?>\r\n<Scene>\r\n    <SubScene name=\"ddd\" back=\"\">\r\n        <Devices />\r\n    </SubScene>\r\n    <SubScene name=\"ddd\" back=\"\">\r\n        <Devices>\r\n            <Device type=\"告警蜂鸣器\" name=\"告警蜂鸣器_01\" use=\"1\" rect=\"296,176,370,249\" address=\"1\" BaudRate=\"3\" ByteSize=\"2\" Parity=\"0\" StopBits=\"0\">\r\n                <Ports>\r\n                    <Port name=\"串口\" />\r\n                </Ports>\r\n                <Connections />\r\n                <DataModels />\r\n            </Device>\r\n        </Devices>\r\n    </SubScene>\r\n    <Shixun Aim=\"\" Devices=\"\" Notes=\"\" />\r\n</Scene>\r\n','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `Scene` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'simufiled'
--

--
-- Dumping routines for database 'simufiled'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-11-18 21:33:50
