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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'Maintenance'),(2,'ProjectManager'),(3,'Developer'),(4,'Tester');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_5f412f9a` (`group_id`),
  KEY `auth_group_permissions_83d7f98b` (`permission_id`)
) ENGINE=MyISAM AUTO_INCREMENT=54 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (1,1,19),(2,1,22),(3,1,23),(4,1,24),(5,1,49),(6,1,50),(7,1,51),(8,1,20),(9,1,21),(10,1,54),(11,1,55),(12,1,56),(13,1,57),(14,1,25),(15,1,27),(16,1,52),(17,1,26),(18,1,53),(19,2,32),(20,2,33),(21,2,34),(22,2,35),(23,2,36),(24,2,37),(25,2,38),(26,2,39),(27,2,40),(28,2,41),(29,2,42),(30,2,44),(31,2,50),(32,2,20),(33,2,53),(34,2,23),(35,2,56),(36,2,26),(37,2,31),(38,3,32),(39,3,34),(40,3,35),(41,3,36),(42,3,38),(43,3,40),(44,3,41),(45,3,42),(46,3,43),(47,3,44),(48,3,45),(49,4,32),(50,4,41),(51,4,35),(52,4,44),(53,4,38);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_37ef4eb4` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=58 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add Product Deploy & Upgrade',7,'add_productdeployment'),(20,'Can change Product Deploy & Upgrade',7,'change_productdeployment'),(21,'Can delete Product Deploy & Upgrade',7,'delete_productdeployment'),(22,'Can add Product Deploy & Upgrade History',8,'add_productdeploymenthistory'),(23,'Can change Product Deploy & Upgrade History',8,'change_productdeploymenthistory'),(24,'Can delete Product Deploy & Upgrade History',8,'delete_productdeploymenthistory'),(25,'Can add Component Deploy & Upgrade Hitory',9,'add_componentdeploymenthistory'),(26,'Can change Component Deploy & Upgrade Hitory',9,'change_componentdeploymenthistory'),(27,'Can delete Component Deploy & Upgrade Hitory',9,'delete_componentdeploymenthistory'),(28,'Can add Deploy & Upgrade Config Item History',10,'add_configitem'),(29,'Can change Deploy & Upgrade Config Item History',10,'change_configitem'),(30,'Can delete Deploy & Upgrade Config Item History',10,'delete_configitem'),(31,'Can add Product',11,'add_product'),(32,'Can change Product',11,'change_product'),(33,'Can delete Product',11,'delete_product'),(34,'Can add deploy kit',12,'add_deploykit'),(35,'Can change deploy kit',12,'change_deploykit'),(36,'Can delete deploy kit',12,'delete_deploykit'),(37,'Can add component',13,'add_component'),(38,'Can change component',13,'change_component'),(39,'Can delete component',13,'delete_component'),(40,'Can add Product Version',14,'add_productversion'),(41,'Can change Product Version',14,'change_productversion'),(42,'Can delete Product Version',14,'delete_productversion'),(43,'Can add Component Package',15,'add_componentpackage'),(44,'Can change Component Package',15,'change_componentpackage'),(45,'Can delete Component Package',15,'delete_componentpackage'),(46,'Can add Config Template Item',16,'add_configtemplateitem'),(47,'Can change Config Template Item',16,'change_configtemplateitem'),(48,'Can delete Config Template Item',16,'delete_configtemplateitem'),(49,'Can add Service Provider',17,'add_serviceprovider'),(50,'Can change Service Provider',17,'change_serviceprovider'),(51,'Can delete Service Provider',17,'delete_serviceprovider'),(52,'Can add environment',18,'add_environment'),(53,'Can change environment',18,'change_environment'),(54,'Can delete environment',18,'delete_environment'),(55,'Can add server',19,'add_server'),(56,'Can change server',19,'change_server'),(57,'Can delete server',19,'delete_server');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$12000$0saADleSA5kM$whOed+LM8wjtmo5XPqWNlwx66hY3ESzNIe/oPbef42I=','2014-01-09 03:35:12',1,'admin','','','',1,1,'2014-01-09 01:47:59');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_6340c63c` (`user_id`),
  KEY `auth_user_groups_5f412f9a` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_6340c63c` (`user_id`),
  KEY `auth_user_user_permissions_83d7f98b` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `development_deployment_componentdeploymenthistory`
--

DROP TABLE IF EXISTS `development_deployment_componentdeploymenthistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `development_deployment_componentdeploymenthistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `component_package_id` int(11) NOT NULL,
  `service_provider_id` int(11) DEFAULT NULL,
  `action` varchar(10) NOT NULL,
  `environment_id` varchar(20) DEFAULT NULL,
  `server_id` int(11) NOT NULL,
  `deploykit_config_file` varchar(200) DEFAULT NULL,
  `deploykit_config_content` longtext NOT NULL,
  `component_config_file` varchar(200) DEFAULT NULL,
  `component_config_content` longtext NOT NULL,
  `product_deployment_history_id` int(11) DEFAULT NULL,
  `product_deployment_id` int(11) NOT NULL,
  `former_upgrade_id` bigint(20) DEFAULT NULL,
  `operator_id` int(11) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `development_deployment_componentdeploymenthistory_a53bf87c` (`component_package_id`),
  KEY `development_deployment_componentdeploymenthistory_8273c07e` (`service_provider_id`),
  KEY `development_deployment_componentdeploymenthistory_7a9af3ae` (`environment_id`),
  KEY `development_deployment_componentdeploymenthistory_2f18fe12` (`server_id`),
  KEY `development_deployment_componentdeploymenthistory_2c1ba3d6` (`product_deployment_history_id`),
  KEY `development_deployment_componentdeploymenthistory_57c82c0d` (`product_deployment_id`),
  KEY `development_deployment_componentdeploymenthistory_5e7ba3ec` (`operator_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `development_deployment_componentdeploymenthistory`
--

LOCK TABLES `development_deployment_componentdeploymenthistory` WRITE;
/*!40000 ALTER TABLE `development_deployment_componentdeploymenthistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `development_deployment_componentdeploymenthistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `development_deployment_configitem`
--

DROP TABLE IF EXISTS `development_deployment_configitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `development_deployment_configitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_deployment_id` int(11) DEFAULT NULL,
  `component_deploy_id` int(11) DEFAULT NULL,
  `component_package_id` int(11) NOT NULL,
  `config_template_item_id` int(11) DEFAULT NULL,
  `key_name` varchar(30) NOT NULL,
  `value` varchar(200) DEFAULT NULL,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `development_deployment_configitem_57c82c0d` (`product_deployment_id`),
  KEY `development_deployment_configitem_753402bd` (`component_deploy_id`),
  KEY `development_deployment_configitem_a53bf87c` (`component_package_id`),
  KEY `development_deployment_configitem_89d63d64` (`config_template_item_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `development_deployment_configitem`
--

LOCK TABLES `development_deployment_configitem` WRITE;
/*!40000 ALTER TABLE `development_deployment_configitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `development_deployment_configitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `development_deployment_productdeployment`
--

DROP TABLE IF EXISTS `development_deployment_productdeployment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `development_deployment_productdeployment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `service_provider_id` int(11) NOT NULL,
  `environment_id` varchar(20) NOT NULL,
  `current_product_version_id` int(11) NOT NULL,
  `operator_id` int(11) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `service_provider_id` (`service_provider_id`,`environment_id`,`product_id`),
  KEY `development_deployment_productdeployment_7f1b40ad` (`product_id`),
  KEY `development_deployment_productdeployment_8273c07e` (`service_provider_id`),
  KEY `development_deployment_productdeployment_7a9af3ae` (`environment_id`),
  KEY `development_deployment_productdeployment_26c423eb` (`current_product_version_id`),
  KEY `development_deployment_productdeployment_5e7ba3ec` (`operator_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `development_deployment_productdeployment`
--

LOCK TABLES `development_deployment_productdeployment` WRITE;
/*!40000 ALTER TABLE `development_deployment_productdeployment` DISABLE KEYS */;
/*!40000 ALTER TABLE `development_deployment_productdeployment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `development_deployment_productdeploymenthistory`
--

DROP TABLE IF EXISTS `development_deployment_productdeploymenthistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `development_deployment_productdeploymenthistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_version_id` int(11) NOT NULL,
  `service_provider_id` int(11) NOT NULL,
  `action` varchar(10) NOT NULL,
  `environment_id` varchar(20) DEFAULT NULL,
  `puppet_config_file` varchar(200) DEFAULT NULL,
  `puppet_config_content` longtext NOT NULL,
  `product_deployment_id` int(11) NOT NULL,
  `operator_id` int(11) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `development_deployment_productdeploymenthistory_548b866b` (`product_version_id`),
  KEY `development_deployment_productdeploymenthistory_8273c07e` (`service_provider_id`),
  KEY `development_deployment_productdeploymenthistory_7a9af3ae` (`environment_id`),
  KEY `development_deployment_productdeploymenthistory_57c82c0d` (`product_deployment_id`),
  KEY `development_deployment_productdeploymenthistory_5e7ba3ec` (`operator_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `development_deployment_productdeploymenthistory`
--

LOCK TABLES `development_deployment_productdeploymenthistory` WRITE;
/*!40000 ALTER TABLE `development_deployment_productdeploymenthistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `development_deployment_productdeploymenthistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `development_metadata_environment`
--

DROP TABLE IF EXISTS `development_metadata_environment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `development_metadata_environment` (
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `development_metadata_environment`
--

LOCK TABLES `development_metadata_environment` WRITE;
/*!40000 ALTER TABLE `development_metadata_environment` DISABLE KEYS */;
INSERT INTO `development_metadata_environment` VALUES ('development'),('testing');
/*!40000 ALTER TABLE `development_metadata_environment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `development_metadata_server`
--

DROP TABLE IF EXISTS `development_metadata_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `development_metadata_server` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `internal_ip` char(39) DEFAULT NULL,
  `external_ip` char(39) DEFAULT NULL,
  `environment_id` varchar(20) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `development_metadata_server_7a9af3ae` (`environment_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `development_metadata_server`
--

LOCK TABLES `development_metadata_server` WRITE;
/*!40000 ALTER TABLE `development_metadata_server` DISABLE KEYS */;
INSERT INTO `development_metadata_server` VALUES (1,'cnemoptestapp1','10.160.53.220','112.124.39.40','testing',NULL),(2,'cnemoptestweb1','10.160.55.216','112.124.56.137','testing',NULL),(3,'cnemoptestdb1','10.161.169.159','115.29.189.198','testing',NULL),(8,'cnemoptestftp1',NULL,NULL,NULL,NULL),(5,'cnemoptestapp2',NULL,NULL,NULL,NULL),(6,'cnemoptestweb2',NULL,NULL,NULL,NULL),(7,'cnemoptestfab1',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `development_metadata_server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `development_metadata_serviceprovider`
--

DROP TABLE IF EXISTS `development_metadata_serviceprovider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `development_metadata_serviceprovider` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `address` varchar(100) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `last_modified_date` datetime NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `development_metadata_serviceprovider`
--

LOCK TABLES `development_metadata_serviceprovider` WRITE;
/*!40000 ALTER TABLE `development_metadata_serviceprovider` DISABLE KEYS */;
INSERT INTO `development_metadata_serviceprovider` VALUES (1,'sp1','Beijing','','','2014-01-08 07:25:39','2014-01-07 07:18:36'),(2,'sp2','','','','2014-01-08 07:25:45','2014-01-08 07:25:45'),(3,'sp3','','','','2014-01-08 07:25:49','2014-01-08 07:25:49');
/*!40000 ALTER TABLE `development_metadata_serviceprovider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_6340c63c` (`user_id`),
  KEY `django_admin_log_37ef4eb4` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2014-01-06 03:09:09',1,18,'development','development',1,''),(2,'2014-01-06 03:09:13',1,18,'testing','testing',1,''),(3,'2014-01-07 06:20:45',1,13,'6','[6]BackendCalc for Jazz',2,'Changed name.'),(4,'2014-01-07 07:05:59',1,13,'5','[5]FtpProc for Jazz',2,'Changed name. Added Config Template Item \"[FtpProc:config]SpId\".'),(5,'2014-01-07 07:07:13',1,13,'5','[5]FtpProc for Jazz',2,'Added Config Template Item \"[FtpProc:config]FtpServer\". Added Config Template Item \"[FtpProc:config]FtpDownUser\". Added Config Template Item \"[FtpProc:config]FtpDownPwd\". Added Config Template Item \"[FtpProc:config]FtpDownPath\". Added Config Template Item \"[FtpProc:config]FtpUpDir\". Added Config Template Item \"[FtpProc:config]FtpDownDir\".'),(6,'2014-01-07 07:08:41',1,13,'2','[2]DataImport for Jazz',2,'Changed name. Added Config Template Item \"[DataImport:config]DICollectorDir\". Added Config Template Item \"[DataImport:config]DIExtractorDir\". Added Config Template Item \"[DataImport:config]DIConvertorDir\". Added Config Template Item \"[DataImport:config]DIImporterDir\". Added Config Template Item \"[DataImport:config]FtpServer\". Added Config Template Item \"[DataImport:config]FtpDownUser\". Added Config Template Item \"[DataImport:config]FtpDownPwd\". Added Config Template Item \"[DataImport:config]FtpDownPath\".'),(7,'2014-01-07 07:09:40',1,13,'5','[5]FtpProc for Jazz',2,'Deleted Config Template Item \"[FtpProc:config]FtpServer\". Deleted Config Template Item \"[FtpProc:config]FtpDownUser\". Deleted Config Template Item \"[FtpProc:config]FtpDownPwd\". Deleted Config Template Item \"[FtpProc:config]FtpDownPath\".'),(8,'2014-01-07 07:10:55',1,13,'2','[2]DataImport for Jazz',2,'Added Config Template Item \"[DataImport:config]SpId\".'),(9,'2014-01-07 07:12:59',1,13,'1','[1]App for Jazz',2,'Changed name.'),(10,'2014-01-07 07:18:36',1,17,'1','[SP1]SEChina',1,''),(11,'2014-01-08 01:22:20',1,19,'1','[1]App',1,''),(12,'2014-01-08 01:23:11',1,19,'2','[2]Web',1,''),(13,'2014-01-08 01:29:05',1,19,'3','[3]DB',1,''),(14,'2014-01-08 07:25:39',1,17,'1','[SP1]sp1',2,'Changed name.'),(15,'2014-01-08 07:25:45',1,17,'2','[SP2]sp2',1,''),(16,'2014-01-08 07:25:49',1,17,'3','[SP3]sp3',1,''),(17,'2014-01-09 03:36:02',1,13,'3','[3]WEB for Jazz',2,'Changed name.'),(18,'2014-01-09 05:50:20',1,13,'3','[3]WEB for Jazz',2,'Added Config Template Item \"[WEB:config]DeployDir\". Added Config Template Item \"[WEB:config]OldDir\". Added Config Template Item \"[WEB:config]NewDir\". Added Config Template Item \"[WEB:config]WebSiteName\". Added Config Template Item \"[WEB:config]AppPoolName\". Added Config Template Item \"[WEB:config]WebSitePhysicalPath\". Added Config Template Item \"[WEB:config]WebServerIp\". Added Config Template Item \"[WEB:config]WebPath\".'),(19,'2014-01-09 05:50:54',1,13,'3','[3]WEB for Jazz',2,'No fields changed.'),(20,'2014-01-09 05:51:20',1,13,'1','[1]APP for Jazz',2,'Changed name.'),(21,'2014-01-09 06:17:12',1,13,'1','[1]APP for Jazz',2,'Added Config Template Item \"[APP:config]DeployDir\". Added Config Template Item \"[APP:config]OldDir\". Added Config Template Item \"[APP:config]NewDir\". Added Config Template Item \"[APP:config]WebSiteName\". Added Config Template Item \"[APP:config]AppPoolName\". Added Config Template Item \"[APP:config]WebSitePhysicalPath\". Added Config Template Item \"[APP:config]AppUrlPath\". Added Config Template Item \"[APP:config]AppPort\". Added Config Template Item \"[APP:config]AppServerIP\".'),(22,'2014-01-09 06:18:52',1,13,'4','[4]STS for Jazz',2,'Changed name. Added Config Template Item \"[STS:config]DeployDir\". Added Config Template Item \"[STS:config]OldDir\". Added Config Template Item \"[STS:config]NewDir\". Added Config Template Item \"[STS:config]WebSiteName\". Added Config Template Item \"[STS:config]AppPoolName\". Added Config Template Item \"[STS:config]WebSitePhysicalPath\".'),(23,'2014-01-09 06:57:33',1,19,'3','[3]cnemoptestdb1',2,'Changed name.'),(24,'2014-01-09 06:57:43',1,19,'2','[2]cnemoptestweb1',2,'Changed name.'),(25,'2014-01-09 06:57:49',1,19,'1','[1]cnemoptestapp1',2,'Changed name.'),(26,'2014-01-09 07:01:43',1,19,'4','[4]cnemopfab1',1,''),(27,'2014-01-09 07:01:51',1,19,'5','[5]cnemoptestapp2',1,''),(28,'2014-01-09 07:02:05',1,19,'6','[6]cnemoptestweb2',1,''),(29,'2014-01-09 07:02:17',1,19,'7','[7]cnemoptestfab1',1,''),(30,'2014-01-09 07:02:38',1,19,'4','[4]cnemopfab1',3,''),(31,'2014-01-09 07:03:03',1,19,'8','[8]cnemoptestftp1',1,''),(32,'2014-01-09 07:04:43',1,13,'5','[5]FTP for Jazz',2,'Changed name. Added Config Template Item \"[FTP:config]DeployDir\". Added Config Template Item \"[FTP:config]OldDir\". Added Config Template Item \"[FTP:config]NewDir\". Added Config Template Item \"[FTP:config]OldServiceName\". Added Config Template Item \"[FTP:config]NewServiceName\".'),(33,'2014-01-09 07:06:03',1,13,'2','[2]DI for Jazz',2,'Changed name. Added Config Template Item \"[DI:config]DeployDir\". Added Config Template Item \"[DI:config]OldDir\". Added Config Template Item \"[DI:config]NewDir\". Added Config Template Item \"[DI:config]OldServiceName\". Added Config Template Item \"[DI:config]NewServiceName\". Changed type for Config Template Item \"[DI:config]SpId\".'),(34,'2014-01-09 07:06:33',1,13,'7','[7]OTS for Jazz',1,''),(35,'2014-01-09 07:07:07',1,13,'8','[8]APPFABRIC for Jazz',1,'');
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'log entry','admin','logentry'),(2,'permission','auth','permission'),(3,'group','auth','group'),(4,'user','auth','user'),(5,'content type','contenttypes','contenttype'),(6,'session','sessions','session'),(7,'Product Deploy & Upgrade','deployment','productdeployment'),(8,'Product Deploy & Upgrade History','deployment','productdeploymenthistory'),(9,'Component Deploy & Upgrade Hitory','deployment','componentdeploymenthistory'),(10,'Deploy & Upgrade Config Item History','deployment','configitem'),(11,'Product','product','product'),(12,'deploy kit','product','deploykit'),(13,'component','product','component'),(14,'Product Version','product','productversion'),(15,'Component Package','product','componentpackage'),(16,'Config Template Item','product','configtemplateitem'),(17,'Service Provider','metadata','serviceprovider'),(18,'environment','metadata','environment'),(19,'server','metadata','server');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_b7b81f0c` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('356d72xvxgob52q72oyf1yp24muah0ye','Njc1ZThiNDlhOTZiOWVkZjVkMmU2MjQ5ZDUyZmU0YTNmY2MxNWQ1ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-01-23 02:00:49'),('cyrn5ofj06kniqkng3c3oo73cpkhzfza','Njc1ZThiNDlhOTZiOWVkZjVkMmU2MjQ5ZDUyZmU0YTNmY2MxNWQ1ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-01-23 03:35:12');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_component`
--

DROP TABLE IF EXISTS `product_component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_component` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(300) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `config_path` varchar(200) NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_component_7f1b40ad` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_component`
--

LOCK TABLES `product_component` WRITE;
/*!40000 ALTER TABLE `product_component` DISABLE KEYS */;
INSERT INTO `product_component` VALUES (1,'APP','',1,'config/deploy.config','2013-12-31 01:59:07'),(2,'DI','',1,'config/deploy.config','2013-12-31 03:35:46'),(3,'WEB','',1,'config/deploy.config','2013-12-31 05:22:41'),(4,'STS','',1,'config/deploy.config','2013-12-31 05:26:35'),(5,'FTP','',1,'config/deploy.config','2013-12-31 05:43:44'),(6,'BackendCalc','',1,'config/deploy.config','2013-12-31 05:46:17'),(7,'OTS','',1,'config/deploy.config','2014-01-09 07:06:33'),(8,'APPFABRIC','',1,'config/deploy.config','2014-01-09 07:07:07');
/*!40000 ALTER TABLE `product_component` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_componentpackage`
--

DROP TABLE IF EXISTS `product_componentpackage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_componentpackage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `component_id` int(11) NOT NULL,
  `product_version_id` int(11) NOT NULL,
  `package` varchar(100) DEFAULT NULL,
  `package_url` varchar(200) DEFAULT NULL,
  `package_md5` varchar(64) DEFAULT NULL,
  `deploy_kit_id` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_version_id` (`product_version_id`,`component_id`),
  KEY `product_componentpackage_0be65e47` (`component_id`),
  KEY `product_componentpackage_548b866b` (`product_version_id`),
  KEY `product_componentpackage_9c2954fc` (`deploy_kit_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_componentpackage`
--

LOCK TABLES `product_componentpackage` WRITE;
/*!40000 ALTER TABLE `product_componentpackage` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_componentpackage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_configtemplateitem`
--

DROP TABLE IF EXISTS `product_configtemplateitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_configtemplateitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `component_id` int(11) NOT NULL,
  `key_name` varchar(100) NOT NULL,
  `defult_value` varchar(300) DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `component_id` (`component_id`,`key_name`,`type`),
  KEY `product_configtemplateitem_0be65e47` (`component_id`)
) ENGINE=MyISAM AUTO_INCREMENT=128 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_configtemplateitem`
--

LOCK TABLES `product_configtemplateitem` WRITE;
/*!40000 ALTER TABLE `product_configtemplateitem` DISABLE KEYS */;
INSERT INTO `product_configtemplateitem` VALUES (1,1,'SpDbDatabase','REMInformation_%ENV%_%SPNAME%','for Component','REM information sp db name'),(2,1,'SpDbServerIP','','for Component','REM information sp db server ip or name'),(3,1,'SpDbUser','','for Component','REM information sp db username'),(4,1,'SpDbPassword','','for Component','REM information sp db password'),(5,1,'SpDbMaxPoolSize','100','for Component','REM information sp db max pool size'),(6,1,'MetaDbDatabase','REMMetadata_%ENV%_%SPNAME%','for Component','REM metadata db name'),(7,1,'MetaDbServerIP','','for Component','REM metadata db server ip or name'),(8,1,'MetaDbUser','','for Component','REM metadata sp db username'),(9,1,'MetaDbPassword','','for Component','REM metadata sp db password'),(10,1,'MetaDbMaxPoolSize','100','for Component','REM metadata sp db max pool size'),(11,1,'AppFabricServerHosts','','for Component','AppFabric server ip, separated with ;'),(12,1,'OTSEndPoint','http://ots.aliyuncs.com','for Component',''),(13,1,'OTSAccessId','','for Component',''),(14,1,'OTSAccessKey','','for Component',''),(15,1,'ProxyHost','','for Component',''),(16,1,'ProxyPort','','for Component',''),(17,1,'ProxyUserName','','for Component',''),(18,1,'ProxyPassword','','for Component',''),(19,1,'WebUrlPath','','for Component','web invocation uri. eg. \"http://domain/web/\"'),(20,1,'DemoTemplate','','for Component',''),(21,1,'LoginQueryMode','ServiceProvider','for Component','ServiceProvider/Metadata/All'),(22,1,'SpId','%SPID%','for Component',''),(23,1,'CacheVersion','','for Component',''),(24,1,'SmtpServerIP','','for Component','SMTP server ip'),(25,1,'TagRawDataTableName','','for Component','TagRawData'),(26,1,'TagDataTableName','','for Component','TagData'),(27,1,'CostHierarchyDataTableName','CostHierarchyData','for Component',''),(28,1,'CostSystemDimensionDataTableName','CostSystemDimensionData','for Component',''),(29,1,'CostAreaDimensionDataTableName','CostAreaDimensionData','for Component',''),(30,1,'TBDataTableName','TBData','for Component',''),(31,1,'TBUnitDataTableName','TBUnitData','for Component',''),(32,1,'StandardCoalDataTableName','StandardCoalData','for Component',''),(33,1,'StandardCoalTBDataTableName','StandardCoalTBData','for Component',''),(34,1,'CostHierarchyTBDataTableName','CostHierarchyTBData','for Component',''),(35,1,'CostSystemDimensionTBDataTableName','CostSystemDimensionTBData','for Component',''),(36,1,'CostAreaDimensionTBDataTableName','CostAreaDimensionTBData','for Component',''),(37,1,'EnergyConsumptionHierarchyDataTableName','EnergyConsumptionHierarchyData','for Component',''),(38,1,'EnergyConsumptionSystemDimensionDataTableName','EnergyConsumptionSystemData','for Component',''),(39,1,'EnergyConsumptionBenchMarkDataTableName','EnergyConsumptionBenchMarkData','for Component',''),(40,1,'CostBenchMarkDataTableName','CostBenchMarkData','for Component',''),(41,1,'StandardCoalBenchMarkDataTableName','StandardCoalBenchMarkData','for Component',''),(42,1,'LabelingDataTableName','LabellingData','for Component',''),(43,2,'SpDbDatabase','REMInformation','for Component','REM information sp db name'),(44,2,'SpDbServerIP','','for Component','REM information sp db server ip or name'),(45,2,'SpDbUser','','for Component','REM information sp db username'),(46,2,'SpDbPassword','','for Component','REM information sp db password'),(47,2,'SpDbMaxPoolSize','100','for Component','REM information sp db max pool size'),(48,2,'MetaDbDatabase','REMMetadata','for Component','REM metadata db name'),(49,2,'MetaDbServerIP','','for Component','REM metadata db server ip or name'),(50,2,'MetaDbUser','','for Component','REM metadata sp db username'),(51,2,'MetaDbPassword','','for Component','REM metadata sp db password'),(52,2,'MetaDbMaxPoolSize','100','for Component','REM metadata sp db max pool size'),(53,2,'AppFabricServerHosts','','for Component','AppFabric server ip, separated with ;'),(54,2,'OTSEndPoint','http://ots.aliyuncs.com','for Component','OTS endpoint address'),(55,2,'OTSAccessId','','for Component',''),(56,2,'OTSAccessKey','','for Component',''),(57,2,'ProxyHost','','for Component',''),(58,2,'ProxyPort','','for Component',''),(59,2,'ProxyUserName','','for Component',''),(60,2,'ProxyPassword','','for Component',''),(61,2,'TagRawDataTableName','TagRawData','for Component',''),(62,3,'ResourceCompression','true','for Component','resource files(js,css) will be compressed'),(63,3,'DefaultAppServiceProtocol','TCP','for Component','options, TCP/HTTP/Pipe'),(64,3,'AppFabricServerHosts','','for Component','AppFabric server ip, separated with ;'),(65,3,'CertificateThumbprint','','for Component','Cert thumbprint of ssl '),(66,3,'MailSmtp','smtp.hz.rem.cn.se.com','for Component','smtp server ip'),(67,3,'WcfHTTP','','for Component','wcf http endpoint. eg. http://appserver:port/APP/'),(68,3,'WcfTCP','','for Component','wcf tcp endpoint. eg. net.tcp://appserver:808/APP/'),(69,3,'WcfPIPE','','for Component','wcf pip endpoint. eg. net.pipe://appserver/APP/'),(70,3,'WifAudienceUris','','for Component','audience uri eg. http://domain/web/'),(71,3,'WifFederationIssuer','','for Component','issuer uri eg. http://domain/stshost/default.aspx'),(72,3,'WifFederationRealm','','for Component','realm uri eg. http://domain/web/'),(73,4,'CertificateThumbprint','','for Component','cert thumbprint for sts'),(74,4,'DefaultAppServiceProtocol','TCP','for Component','options TCP/HTTP/Pipe'),(75,4,'AllowDemo','false','for Component','Allow demo function'),(76,4,'WcfHTTP','','for Component',''),(77,4,'WcfTCP','','for Component',''),(78,4,'WcfPIPE','','for Component',''),(79,5,'SpId','','for Component',''),(94,2,'SpId','','for Tango',''),(84,5,'FtpUpDir','','for Component',''),(85,5,'FtpDownDir','','for Component',''),(86,2,'DICollectorDir','','for Component',''),(87,2,'DIExtractorDir','','for Component',''),(88,2,'DIConvertorDir','','for Component',''),(89,2,'DIImporterDir','','for Component',''),(90,2,'FtpServer','','for Component',''),(91,2,'FtpDownUser','','for Component',''),(92,2,'FtpDownPwd','','for Component',''),(93,2,'FtpDownPath','','for Component',''),(95,3,'DeployDir','C:\\\\AutoDeploy','for Tango','only for web deploy'),(96,3,'OldDir','','for Tango','only for upgrade'),(97,3,'NewDir','','for Tango','only for upgrade'),(98,3,'WebSiteName','','for Tango',''),(99,3,'AppPoolName','','for Tango',''),(100,3,'WebSitePhysicalPath','','for Tango',''),(101,3,'WebServerIp','','for Tango',''),(102,3,'WebPath','','for Tango',''),(103,1,'DeployDir','','for Tango',''),(104,1,'OldDir','','for Tango',''),(105,1,'NewDir','','for Tango',''),(106,1,'WebSiteName','','for Tango',''),(107,1,'AppPoolName','','for Tango',''),(108,1,'WebSitePhysicalPath','','for Tango',''),(109,1,'AppUrlPath','','for Tango',''),(110,1,'AppPort','','for Tango',''),(111,1,'AppServerIP','','for Tango',''),(112,4,'DeployDir','','for Tango',''),(113,4,'OldDir','','for Tango',''),(114,4,'NewDir','','for Tango',''),(115,4,'WebSiteName','','for Tango',''),(116,4,'AppPoolName','','for Tango',''),(117,4,'WebSitePhysicalPath','','for Tango',''),(118,5,'DeployDir','','for Tango',''),(119,5,'OldDir','','for Tango',''),(120,5,'NewDir','','for Tango',''),(121,5,'OldServiceName','','for Tango',''),(122,5,'NewServiceName','','for Tango',''),(123,2,'DeployDir','','for Tango',''),(124,2,'OldDir','','for Tango',''),(125,2,'NewDir','','for Tango',''),(126,2,'OldServiceName','','for Tango',''),(127,2,'NewServiceName','','for Tango','');
/*!40000 ALTER TABLE `product_configtemplateitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_deploykit`
--

DROP TABLE IF EXISTS `product_deploykit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_deploykit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `version` varchar(50) NOT NULL,
  `package` varchar(100) DEFAULT NULL,
  `package_url` varchar(200) DEFAULT NULL,
  `package_md5` varchar(64) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`version`,`product_id`),
  KEY `product_deploykit_7f1b40ad` (`product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_deploykit`
--

LOCK TABLES `product_deploykit` WRITE;
/*!40000 ALTER TABLE `product_deploykit` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_deploykit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_product`
--

DROP TABLE IF EXISTS `product_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(300) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_product`
--

LOCK TABLES `product_product` WRITE;
/*!40000 ALTER TABLE `product_product` DISABLE KEYS */;
INSERT INTO `product_product` VALUES (1,'Jazz','','2013-12-31 01:58:45');
/*!40000 ALTER TABLE `product_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_productversion`
--

DROP TABLE IF EXISTS `product_productversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_productversion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `version` varchar(50) NOT NULL,
  `package` varchar(100) DEFAULT NULL,
  `package_url` varchar(200) DEFAULT NULL,
  `package_md5` varchar(64) DEFAULT NULL,
  `deploy_kit_id` int(11) NOT NULL,
  `is_release` tinyint(1) NOT NULL,
  `publish_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`,`version`),
  KEY `product_productversion_7f1b40ad` (`product_id`),
  KEY `product_productversion_9c2954fc` (`deploy_kit_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_productversion`
--

LOCK TABLES `product_productversion` WRITE;
/*!40000 ALTER TABLE `product_productversion` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_productversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `production_deployment_componentdeploymenthistory`
--

DROP TABLE IF EXISTS `production_deployment_componentdeploymenthistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `production_deployment_componentdeploymenthistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `component_package_id` int(11) NOT NULL,
  `service_provider_id` int(11) DEFAULT NULL,
  `action` varchar(10) NOT NULL,
  `environment_id` varchar(20) DEFAULT NULL,
  `server_id` int(11) NOT NULL,
  `deploykit_config_file` varchar(200) DEFAULT NULL,
  `deploykit_config_content` longtext NOT NULL,
  `component_config_file` varchar(200) DEFAULT NULL,
  `component_config_content` longtext NOT NULL,
  `product_deployment_history_id` int(11) DEFAULT NULL,
  `product_deployment_id` int(11) NOT NULL,
  `former_upgrade_id` bigint(20) DEFAULT NULL,
  `operator_id` int(11) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `production_deployment_componentdeploymenthistory_a53bf87c` (`component_package_id`),
  KEY `production_deployment_componentdeploymenthistory_8273c07e` (`service_provider_id`),
  KEY `production_deployment_componentdeploymenthistory_7a9af3ae` (`environment_id`),
  KEY `production_deployment_componentdeploymenthistory_2f18fe12` (`server_id`),
  KEY `production_deployment_componentdeploymenthistory_2c1ba3d6` (`product_deployment_history_id`),
  KEY `production_deployment_componentdeploymenthistory_57c82c0d` (`product_deployment_id`),
  KEY `production_deployment_componentdeploymenthistory_5e7ba3ec` (`operator_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `production_deployment_componentdeploymenthistory`
--

LOCK TABLES `production_deployment_componentdeploymenthistory` WRITE;
/*!40000 ALTER TABLE `production_deployment_componentdeploymenthistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `production_deployment_componentdeploymenthistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `production_deployment_configitem`
--

DROP TABLE IF EXISTS `production_deployment_configitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `production_deployment_configitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_deployment_id` int(11) DEFAULT NULL,
  `component_deploy_id` int(11) DEFAULT NULL,
  `component_package_id` int(11) NOT NULL,
  `config_template_item_id` int(11) DEFAULT NULL,
  `key_name` varchar(30) NOT NULL,
  `value` varchar(200) DEFAULT NULL,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `production_deployment_configitem_57c82c0d` (`product_deployment_id`),
  KEY `production_deployment_configitem_753402bd` (`component_deploy_id`),
  KEY `production_deployment_configitem_a53bf87c` (`component_package_id`),
  KEY `production_deployment_configitem_89d63d64` (`config_template_item_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `production_deployment_configitem`
--

LOCK TABLES `production_deployment_configitem` WRITE;
/*!40000 ALTER TABLE `production_deployment_configitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `production_deployment_configitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `production_deployment_productdeployment`
--

DROP TABLE IF EXISTS `production_deployment_productdeployment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `production_deployment_productdeployment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `service_provider_id` int(11) NOT NULL,
  `environment_id` varchar(20) NOT NULL,
  `current_product_version_id` int(11) NOT NULL,
  `operator_id` int(11) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `service_provider_id` (`service_provider_id`,`environment_id`,`product_id`),
  KEY `production_deployment_productdeployment_7f1b40ad` (`product_id`),
  KEY `production_deployment_productdeployment_8273c07e` (`service_provider_id`),
  KEY `production_deployment_productdeployment_7a9af3ae` (`environment_id`),
  KEY `production_deployment_productdeployment_26c423eb` (`current_product_version_id`),
  KEY `production_deployment_productdeployment_5e7ba3ec` (`operator_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `production_deployment_productdeployment`
--

LOCK TABLES `production_deployment_productdeployment` WRITE;
/*!40000 ALTER TABLE `production_deployment_productdeployment` DISABLE KEYS */;
/*!40000 ALTER TABLE `production_deployment_productdeployment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `production_deployment_productdeploymenthistory`
--

DROP TABLE IF EXISTS `production_deployment_productdeploymenthistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `production_deployment_productdeploymenthistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_version_id` int(11) NOT NULL,
  `service_provider_id` int(11) NOT NULL,
  `action` varchar(10) NOT NULL,
  `environment_id` varchar(20) DEFAULT NULL,
  `puppet_config_file` varchar(200) DEFAULT NULL,
  `puppet_config_content` longtext NOT NULL,
  `product_deployment_id` int(11) NOT NULL,
  `operator_id` int(11) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `production_deployment_productdeploymenthistory_548b866b` (`product_version_id`),
  KEY `production_deployment_productdeploymenthistory_8273c07e` (`service_provider_id`),
  KEY `production_deployment_productdeploymenthistory_7a9af3ae` (`environment_id`),
  KEY `production_deployment_productdeploymenthistory_57c82c0d` (`product_deployment_id`),
  KEY `production_deployment_productdeploymenthistory_5e7ba3ec` (`operator_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `production_deployment_productdeploymenthistory`
--

LOCK TABLES `production_deployment_productdeploymenthistory` WRITE;
/*!40000 ALTER TABLE `production_deployment_productdeploymenthistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `production_deployment_productdeploymenthistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `production_metadata_environment`
--

DROP TABLE IF EXISTS `production_metadata_environment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `production_metadata_environment` (
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `production_metadata_environment`
--

LOCK TABLES `production_metadata_environment` WRITE;
/*!40000 ALTER TABLE `production_metadata_environment` DISABLE KEYS */;
/*!40000 ALTER TABLE `production_metadata_environment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `production_metadata_server`
--

DROP TABLE IF EXISTS `production_metadata_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `production_metadata_server` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `internal_ip` char(39) DEFAULT NULL,
  `external_ip` char(39) DEFAULT NULL,
  `environment_id` varchar(20) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `production_metadata_server_7a9af3ae` (`environment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `production_metadata_server`
--

LOCK TABLES `production_metadata_server` WRITE;
/*!40000 ALTER TABLE `production_metadata_server` DISABLE KEYS */;
/*!40000 ALTER TABLE `production_metadata_server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `production_metadata_serviceprovider`
--

DROP TABLE IF EXISTS `production_metadata_serviceprovider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `production_metadata_serviceprovider` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `address` varchar(100) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `last_modified_date` datetime NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

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

-- Dump completed on 2014-01-09 16:38:44
