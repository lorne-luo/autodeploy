-- MySQL dump 10.13  Distrib 5.1.71, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: django_autodeploy
-- ------------------------------------------------------
-- Server version	5.1.71


--
-- Dumping data for table `product_component`
--

LOCK TABLES `product_component` WRITE;
/*!40000 ALTER TABLE `product_component` DISABLE KEYS */;
INSERT INTO `product_component` VALUES (1,'app','',1,'config/deploy.config','2013-12-31 01:59:07'),(2,'dataimport','',1,'config/deploy.config','2013-12-31 03:35:46'),(3,'web','',1,'config/deploy.config','2013-12-31 05:22:41'),(4,'stshost','',1,'config/deploy.config','2013-12-31 05:26:35'),(5,'ftpproc','',1,'config/deploy.config','2013-12-31 05:43:44'),(6,'backendcalc','',1,'config/deploy.config','2013-12-31 05:46:17');
/*!40000 ALTER TABLE `product_component` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `product_configtemplateitem`
--

LOCK TABLES `product_configtemplateitem` WRITE;
/*!40000 ALTER TABLE `product_configtemplateitem` DISABLE KEYS */;
INSERT INTO `product_configtemplateitem` VALUES (1,1,'SpDbDatabase','REMInformation_%ENV%_%SPNAME%','for Component','REM information sp db name'),(2,1,'SpDbServerIP','','for Component','REM information sp db server ip or name'),(3,1,'SpDbUser','','for Component','REM information sp db username'),(4,1,'SpDbPassword','','for Component','REM information sp db password'),(5,1,'SpDbMaxPoolSize','100','for Component','REM information sp db max pool size'),(6,1,'MetaDbDatabase','REMMetadata_%ENV%_%SPNAME%','for Component','REM metadata db name'),(7,1,'MetaDbServerIP','','for Component','REM metadata db server ip or name'),(8,1,'MetaDbUser','','for Component','REM metadata sp db username'),(9,1,'MetaDbPassword','','for Component','REM metadata sp db password'),(10,1,'MetaDbMaxPoolSize','100','for Component','REM metadata sp db max pool size'),(11,1,'AppFabricServerHosts','','for Component','AppFabric server ip, separated with ;'),(12,1,'OTSEndPoint','http://ots.aliyuncs.com','for Component',''),(13,1,'OTSAccessId','','for Component',''),(14,1,'OTSAccessKey','','for Component',''),(15,1,'ProxyHost','','for Component',''),(16,1,'ProxyPort','','for Component',''),(17,1,'ProxyUserName','','for Component',''),(18,1,'ProxyPassword','','for Component',''),(19,1,'WebUrlPath','','for Component','web invocation uri. eg. \"http://domain/web/\"'),(20,1,'DemoTemplate','','for Component',''),(21,1,'LoginQueryMode','ServiceProvider','for Component','ServiceProvider/Metadata/All'),(22,1,'SpId','%SPID%','for Component',''),(23,1,'CacheVersion','','for Component',''),(24,1,'SmtpServerIP','','for Component','SMTP server ip'),(25,1,'TagRawDataTableName','','for Component','TagRawData'),(26,1,'TagDataTableName','','for Component','TagData'),(27,1,'CostHierarchyDataTableName','CostHierarchyData','for Component',''),(28,1,'CostSystemDimensionDataTableName','CostSystemDimensionData','for Component',''),(29,1,'CostAreaDimensionDataTableName','CostAreaDimensionData','for Component',''),(30,1,'TBDataTableName','TBData','for Component',''),(31,1,'TBUnitDataTableName','TBUnitData','for Component',''),(32,1,'StandardCoalDataTableName','StandardCoalData','for Component',''),(33,1,'StandardCoalTBDataTableName','StandardCoalTBData','for Component',''),(34,1,'CostHierarchyTBDataTableName','CostHierarchyTBData','for Component',''),(35,1,'CostSystemDimensionTBDataTableName','CostSystemDimensionTBData','for Component',''),(36,1,'CostAreaDimensionTBDataTableName','CostAreaDimensionTBData','for Component',''),(37,1,'EnergyConsumptionHierarchyDataTableName','EnergyConsumptionHierarchyData','for Component',''),(38,1,'EnergyConsumptionSystemDimensionDataTableName','EnergyConsumptionSystemData','for Component',''),(39,1,'EnergyConsumptionBenchMarkDataTableName','EnergyConsumptionBenchMarkData','for Component',''),(40,1,'CostBenchMarkDataTableName','CostBenchMarkData','for Component',''),(41,1,'StandardCoalBenchMarkDataTableName','StandardCoalBenchMarkData','for Component',''),(42,1,'LabelingDataTableName','LabellingData','for Component',''),(43,2,'SpDbDatabase','REMInformation','for Component','REM information sp db name'),(44,2,'SpDbServerIP','','for Component','REM information sp db server ip or name'),(45,2,'SpDbUser','','for Component','REM information sp db username'),(46,2,'SpDbPassword','','for Component','REM information sp db password'),(47,2,'SpDbMaxPoolSize','100','for Component','REM information sp db max pool size'),(48,2,'MetaDbDatabase','REMMetadata','for Component','REM metadata db name'),(49,2,'MetaDbServerIP','','for Component','REM metadata db server ip or name'),(50,2,'MetaDbUser','','for Component','REM metadata sp db username'),(51,2,'MetaDbPassword','','for Component','REM metadata sp db password'),(52,2,'MetaDbMaxPoolSize','100','for Component','REM metadata sp db max pool size'),(53,2,'AppFabricServerHosts','','for Component','AppFabric server ip, separated with ;'),(54,2,'OTSEndPoint','http://ots.aliyuncs.com','for Component','OTS endpoint address'),(55,2,'OTSAccessId','','for Component',''),(56,2,'OTSAccessKey','','for Component',''),(57,2,'ProxyHost','','for Component',''),(58,2,'ProxyPort','','for Component',''),(59,2,'ProxyUserName','','for Component',''),(60,2,'ProxyPassword','','for Component',''),(61,2,'TagRawDataTableName','TagRawData','for Component',''),(62,3,'ResourceCompression','true','for Component','resource files(js,css) will be compressed'),(63,3,'DefaultAppServiceProtocol','TCP','for Component','options, TCP/HTTP/Pipe'),(64,3,'AppFabricServerHosts','','for Component','AppFabric server ip, separated with ;'),(65,3,'CertificateThumbprint','','for Component','Cert thumbprint of ssl '),(66,3,'MailSmtp','smtp.hz.rem.cn.se.com','for Component','smtp server ip'),(67,3,'WcfHTTP','','for Component','wcf http endpoint. eg. http://appserver:port/APP/'),(68,3,'WcfTCP','','for Component','wcf tcp endpoint. eg. net.tcp://appserver:808/APP/'),(69,3,'WcfPIPE','','for Component','wcf pip endpoint. eg. net.pipe://appserver/APP/'),(70,3,'WifAudienceUris','','for Component','audience uri eg. http://domain/web/'),(71,3,'WifFederationIssuer','','for Component','issuer uri eg. http://domain/stshost/default.aspx'),(72,3,'WifFederationRealm','','for Component','realm uri eg. http://domain/web/'),(73,4,'CertificateThumbprint','','for Component','cert thumbprint for sts'),(74,4,'DefaultAppServiceProtocol','TCP','for Component','options TCP/HTTP/Pipe'),(75,4,'AllowDemo','false','for Component','Allow demo function'),(76,4,'WcfHTTP','','for Component',''),(77,4,'WcfTCP','','for Component',''),(78,4,'WcfPIPE','','for Component','');
/*!40000 ALTER TABLE `product_configtemplateitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `product_product`
--

LOCK TABLES `product_product` WRITE;
/*!40000 ALTER TABLE `product_product` DISABLE KEYS */;
INSERT INTO `product_product` VALUES (1,'Jazz','','2013-12-31 01:58:45');
/*!40000 ALTER TABLE `product_product` ENABLE KEYS */;
UNLOCK TABLES;

-- Dump completed on 2013-12-31 13:58:24
