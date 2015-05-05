-- MySQL dump 10.13  Distrib 5.1.71, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: autodeploy
-- ------------------------------------------------------
-- Server version	5.1.71

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
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'Maintenance'),(2,'ProjectManager'),(3,'Developer'),(4,'Tester');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (1,1,19),(2,1,22),(3,1,23),(4,1,24),(5,1,49),(6,1,50),(7,1,51),(8,1,20),(9,1,21),(10,1,54),(11,1,55),(12,1,56),(13,1,57),(14,1,25),(15,1,27),(16,1,52),(17,1,26),(18,1,53),(19,2,32),(20,2,33),(21,2,34),(22,2,35),(23,2,36),(24,2,37),(25,2,38),(26,2,39),(27,2,40),(28,2,41),(29,2,42),(30,2,44),(31,2,50),(32,2,20),(33,2,53),(34,2,23),(35,2,56),(36,2,26),(37,2,31),(38,3,32),(39,3,34),(40,3,35),(41,3,36),(42,3,38),(43,3,40),(44,3,41),(45,3,42),(46,3,43),(47,3,44),(48,3,45),(49,4,32),(50,4,41),(51,4,35),(52,4,44),(53,4,38);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `development_deployment_componentdeploymenthistory`
--

LOCK TABLES `development_deployment_componentdeploymenthistory` WRITE;
/*!40000 ALTER TABLE `development_deployment_componentdeploymenthistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `development_deployment_componentdeploymenthistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `development_deployment_configitem`
--

LOCK TABLES `development_deployment_configitem` WRITE;
/*!40000 ALTER TABLE `development_deployment_configitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `development_deployment_configitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `development_deployment_productdeployment`
--

LOCK TABLES `development_deployment_productdeployment` WRITE;
/*!40000 ALTER TABLE `development_deployment_productdeployment` DISABLE KEYS */;
/*!40000 ALTER TABLE `development_deployment_productdeployment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `development_deployment_productdeploymenthistory`
--

LOCK TABLES `development_deployment_productdeploymenthistory` WRITE;
/*!40000 ALTER TABLE `development_deployment_productdeploymenthistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `development_deployment_productdeploymenthistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `development_metadata_environment`
--

LOCK TABLES `development_metadata_environment` WRITE;
/*!40000 ALTER TABLE `development_metadata_environment` DISABLE KEYS */;
INSERT INTO `development_metadata_environment` VALUES ('development'),('testing');
/*!40000 ALTER TABLE `development_metadata_environment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `development_metadata_server`
--

LOCK TABLES `development_metadata_server` WRITE;
/*!40000 ALTER TABLE `development_metadata_server` DISABLE KEYS */;
INSERT INTO `development_metadata_server` VALUES (1,'App','10.160.53.220','112.124.39.40','testing',NULL),(2,'Web','10.160.55.216','112.124.56.137','testing',NULL),(3,'DB','10.161.169.159','115.29.189.198','testing',NULL);
/*!40000 ALTER TABLE `development_metadata_server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `development_metadata_serviceprovider`
--

LOCK TABLES `development_metadata_serviceprovider` WRITE;
/*!40000 ALTER TABLE `development_metadata_serviceprovider` DISABLE KEYS */;
INSERT INTO `development_metadata_serviceprovider` VALUES (1,'sp1','Beijing','','','2014-01-08 07:25:39','2014-01-07 07:18:36'),(2,'sp2','','','','2014-01-08 07:25:45','2014-01-08 07:25:45'),(3,'sp3','','','','2014-01-08 07:25:49','2014-01-08 07:25:49');
/*!40000 ALTER TABLE `development_metadata_serviceprovider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2014-01-06 03:09:09',1,18,'development','development',1,''),(2,'2014-01-06 03:09:13',1,18,'testing','testing',1,''),(3,'2014-01-07 06:20:45',1,13,'6','[6]BackendCalc for Jazz',2,'Changed name.'),(4,'2014-01-07 07:05:59',1,13,'5','[5]FtpProc for Jazz',2,'Changed name. Added Config Template Item \"[FtpProc:config]SpId\".'),(5,'2014-01-07 07:07:13',1,13,'5','[5]FtpProc for Jazz',2,'Added Config Template Item \"[FtpProc:config]FtpServer\". Added Config Template Item \"[FtpProc:config]FtpDownUser\". Added Config Template Item \"[FtpProc:config]FtpDownPwd\". Added Config Template Item \"[FtpProc:config]FtpDownPath\". Added Config Template Item \"[FtpProc:config]FtpUpDir\". Added Config Template Item \"[FtpProc:config]FtpDownDir\".'),(6,'2014-01-07 07:08:41',1,13,'2','[2]DataImport for Jazz',2,'Changed name. Added Config Template Item \"[DataImport:config]DICollectorDir\". Added Config Template Item \"[DataImport:config]DIExtractorDir\". Added Config Template Item \"[DataImport:config]DIConvertorDir\". Added Config Template Item \"[DataImport:config]DIImporterDir\". Added Config Template Item \"[DataImport:config]FtpServer\". Added Config Template Item \"[DataImport:config]FtpDownUser\". Added Config Template Item \"[DataImport:config]FtpDownPwd\". Added Config Template Item \"[DataImport:config]FtpDownPath\".'),(7,'2014-01-07 07:09:40',1,13,'5','[5]FtpProc for Jazz',2,'Deleted Config Template Item \"[FtpProc:config]FtpServer\". Deleted Config Template Item \"[FtpProc:config]FtpDownUser\". Deleted Config Template Item \"[FtpProc:config]FtpDownPwd\". Deleted Config Template Item \"[FtpProc:config]FtpDownPath\".'),(8,'2014-01-07 07:10:55',1,13,'2','[2]DataImport for Jazz',2,'Added Config Template Item \"[DataImport:config]SpId\".'),(9,'2014-01-07 07:12:59',1,13,'1','[1]App for Jazz',2,'Changed name.'),(10,'2014-01-07 07:18:36',1,17,'1','[SP1]SEChina',1,''),(11,'2014-01-08 01:22:20',1,19,'1','[1]App',1,''),(12,'2014-01-08 01:23:11',1,19,'2','[2]Web',1,''),(13,'2014-01-08 01:29:05',1,19,'3','[3]DB',1,''),(14,'2014-01-08 07:25:39',1,17,'1','[SP1]sp1',2,'Changed name.'),(15,'2014-01-08 07:25:45',1,17,'2','[SP2]sp2',1,''),(16,'2014-01-08 07:25:49',1,17,'3','[SP3]sp3',1,'');
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `product_component`
--

LOCK TABLES `product_component` WRITE;
/*!40000 ALTER TABLE `product_component` DISABLE KEYS */;
INSERT INTO `product_component` VALUES (1,'App','',1,'config/deploy.config','2013-12-31 01:59:07'),(2,'DataImport','',1,'config/deploy.config','2013-12-31 03:35:46'),(3,'web','',1,'config/deploy.config','2013-12-31 05:22:41'),(4,'stshost','',1,'config/deploy.config','2013-12-31 05:26:35'),(5,'FtpProc','',1,'config/deploy.config','2013-12-31 05:43:44'),(6,'BackendCalc','',1,'config/deploy.config','2013-12-31 05:46:17');
/*!40000 ALTER TABLE `product_component` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `product_componentpackage`
--

LOCK TABLES `product_componentpackage` WRITE;
/*!40000 ALTER TABLE `product_componentpackage` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_componentpackage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `product_configtemplateitem`
--

LOCK TABLES `product_configtemplateitem` WRITE;
/*!40000 ALTER TABLE `product_configtemplateitem` DISABLE KEYS */;
INSERT INTO `product_configtemplateitem` VALUES (1,1,'SpDbDatabase','REMInformation_%ENV%_%SPNAME%','for Component','REM information sp db name'),(2,1,'SpDbServerIP','','for Component','REM information sp db server ip or name'),(3,1,'SpDbUser','','for Component','REM information sp db username'),(4,1,'SpDbPassword','','for Component','REM information sp db password'),(5,1,'SpDbMaxPoolSize','100','for Component','REM information sp db max pool size'),(6,1,'MetaDbDatabase','REMMetadata_%ENV%_%SPNAME%','for Component','REM metadata db name'),(7,1,'MetaDbServerIP','','for Component','REM metadata db server ip or name'),(8,1,'MetaDbUser','','for Component','REM metadata sp db username'),(9,1,'MetaDbPassword','','for Component','REM metadata sp db password'),(10,1,'MetaDbMaxPoolSize','100','for Component','REM metadata sp db max pool size'),(11,1,'AppFabricServerHosts','','for Component','AppFabric server ip, separated with ;'),(12,1,'OTSEndPoint','http://ots.aliyuncs.com','for Component',''),(13,1,'OTSAccessId','','for Component',''),(14,1,'OTSAccessKey','','for Component',''),(15,1,'ProxyHost','','for Component',''),(16,1,'ProxyPort','','for Component',''),(17,1,'ProxyUserName','','for Component',''),(18,1,'ProxyPassword','','for Component',''),(19,1,'WebUrlPath','','for Component','web invocation uri. eg. \"http://domain/web/\"'),(20,1,'DemoTemplate','','for Component',''),(21,1,'LoginQueryMode','ServiceProvider','for Component','ServiceProvider/Metadata/All'),(22,1,'SpId','%SPID%','for Component',''),(23,1,'CacheVersion','','for Component',''),(24,1,'SmtpServerIP','','for Component','SMTP server ip'),(25,1,'TagRawDataTableName','','for Component','TagRawData'),(26,1,'TagDataTableName','','for Component','TagData'),(27,1,'CostHierarchyDataTableName','CostHierarchyData','for Component',''),(28,1,'CostSystemDimensionDataTableName','CostSystemDimensionData','for Component',''),(29,1,'CostAreaDimensionDataTableName','CostAreaDimensionData','for Component',''),(30,1,'TBDataTableName','TBData','for Component',''),(31,1,'TBUnitDataTableName','TBUnitData','for Component',''),(32,1,'StandardCoalDataTableName','StandardCoalData','for Component',''),(33,1,'StandardCoalTBDataTableName','StandardCoalTBData','for Component',''),(34,1,'CostHierarchyTBDataTableName','CostHierarchyTBData','for Component',''),(35,1,'CostSystemDimensionTBDataTableName','CostSystemDimensionTBData','for Component',''),(36,1,'CostAreaDimensionTBDataTableName','CostAreaDimensionTBData','for Component',''),(37,1,'EnergyConsumptionHierarchyDataTableName','EnergyConsumptionHierarchyData','for Component',''),(38,1,'EnergyConsumptionSystemDimensionDataTableName','EnergyConsumptionSystemData','for Component',''),(39,1,'EnergyConsumptionBenchMarkDataTableName','EnergyConsumptionBenchMarkData','for Component',''),(40,1,'CostBenchMarkDataTableName','CostBenchMarkData','for Component',''),(41,1,'StandardCoalBenchMarkDataTableName','StandardCoalBenchMarkData','for Component',''),(42,1,'LabelingDataTableName','LabellingData','for Component',''),(43,2,'SpDbDatabase','REMInformation','for Component','REM information sp db name'),(44,2,'SpDbServerIP','','for Component','REM information sp db server ip or name'),(45,2,'SpDbUser','','for Component','REM information sp db username'),(46,2,'SpDbPassword','','for Component','REM information sp db password'),(47,2,'SpDbMaxPoolSize','100','for Component','REM information sp db max pool size'),(48,2,'MetaDbDatabase','REMMetadata','for Component','REM metadata db name'),(49,2,'MetaDbServerIP','','for Component','REM metadata db server ip or name'),(50,2,'MetaDbUser','','for Component','REM metadata sp db username'),(51,2,'MetaDbPassword','','for Component','REM metadata sp db password'),(52,2,'MetaDbMaxPoolSize','100','for Component','REM metadata sp db max pool size'),(53,2,'AppFabricServerHosts','','for Component','AppFabric server ip, separated with ;'),(54,2,'OTSEndPoint','http://ots.aliyuncs.com','for Component','OTS endpoint address'),(55,2,'OTSAccessId','','for Component',''),(56,2,'OTSAccessKey','','for Component',''),(57,2,'ProxyHost','','for Component',''),(58,2,'ProxyPort','','for Component',''),(59,2,'ProxyUserName','','for Component',''),(60,2,'ProxyPassword','','for Component',''),(61,2,'TagRawDataTableName','TagRawData','for Component',''),(62,3,'ResourceCompression','true','for Component','resource files(js,css) will be compressed'),(63,3,'DefaultAppServiceProtocol','TCP','for Component','options, TCP/HTTP/Pipe'),(64,3,'AppFabricServerHosts','','for Component','AppFabric server ip, separated with ;'),(65,3,'CertificateThumbprint','','for Component','Cert thumbprint of ssl '),(66,3,'MailSmtp','smtp.hz.rem.cn.se.com','for Component','smtp server ip'),(67,3,'WcfHTTP','','for Component','wcf http endpoint. eg. http://appserver:port/APP/'),(68,3,'WcfTCP','','for Component','wcf tcp endpoint. eg. net.tcp://appserver:808/APP/'),(69,3,'WcfPIPE','','for Component','wcf pip endpoint. eg. net.pipe://appserver/APP/'),(70,3,'WifAudienceUris','','for Component','audience uri eg. http://domain/web/'),(71,3,'WifFederationIssuer','','for Component','issuer uri eg. http://domain/stshost/default.aspx'),(72,3,'WifFederationRealm','','for Component','realm uri eg. http://domain/web/'),(73,4,'CertificateThumbprint','','for Component','cert thumbprint for sts'),(74,4,'DefaultAppServiceProtocol','TCP','for Component','options TCP/HTTP/Pipe'),(75,4,'AllowDemo','false','for Component','Allow demo function'),(76,4,'WcfHTTP','','for Component',''),(77,4,'WcfTCP','','for Component',''),(78,4,'WcfPIPE','','for Component',''),(79,5,'SpId','','for Component',''),(94,2,'SpId','','for Component',''),(84,5,'FtpUpDir','','for Component',''),(85,5,'FtpDownDir','','for Component',''),(86,2,'DICollectorDir','','for Component',''),(87,2,'DIExtractorDir','','for Component',''),(88,2,'DIConvertorDir','','for Component',''),(89,2,'DIImporterDir','','for Component',''),(90,2,'FtpServer','','for Component',''),(91,2,'FtpDownUser','','for Component',''),(92,2,'FtpDownPwd','','for Component',''),(93,2,'FtpDownPath','','for Component','');
/*!40000 ALTER TABLE `product_configtemplateitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `product_deploykit`
--

LOCK TABLES `product_deploykit` WRITE;
/*!40000 ALTER TABLE `product_deploykit` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_deploykit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `product_product`
--

LOCK TABLES `product_product` WRITE;
/*!40000 ALTER TABLE `product_product` DISABLE KEYS */;
INSERT INTO `product_product` VALUES (1,'Jazz','','2013-12-31 01:58:45');
/*!40000 ALTER TABLE `product_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `product_productversion`
--

LOCK TABLES `product_productversion` WRITE;
/*!40000 ALTER TABLE `product_productversion` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_productversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `production_deployment_componentdeploymenthistory`
--

LOCK TABLES `production_deployment_componentdeploymenthistory` WRITE;
/*!40000 ALTER TABLE `production_deployment_componentdeploymenthistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `production_deployment_componentdeploymenthistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `production_deployment_configitem`
--

LOCK TABLES `production_deployment_configitem` WRITE;
/*!40000 ALTER TABLE `production_deployment_configitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `production_deployment_configitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `production_deployment_productdeployment`
--

LOCK TABLES `production_deployment_productdeployment` WRITE;
/*!40000 ALTER TABLE `production_deployment_productdeployment` DISABLE KEYS */;
/*!40000 ALTER TABLE `production_deployment_productdeployment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `production_deployment_productdeploymenthistory`
--

LOCK TABLES `production_deployment_productdeploymenthistory` WRITE;
/*!40000 ALTER TABLE `production_deployment_productdeploymenthistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `production_deployment_productdeploymenthistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `production_metadata_environment`
--

LOCK TABLES `production_metadata_environment` WRITE;
/*!40000 ALTER TABLE `production_metadata_environment` DISABLE KEYS */;
/*!40000 ALTER TABLE `production_metadata_environment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `production_metadata_server`
--

LOCK TABLES `production_metadata_server` WRITE;
/*!40000 ALTER TABLE `production_metadata_server` DISABLE KEYS */;
/*!40000 ALTER TABLE `production_metadata_server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `production_metadata_serviceprovider`
--

LOCK TABLES `production_metadata_serviceprovider` WRITE;
/*!40000 ALTER TABLE `production_metadata_serviceprovider` DISABLE KEYS */;
/*!40000 ALTER TABLE `production_metadata_serviceprovider` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-01-09  9:41:06
