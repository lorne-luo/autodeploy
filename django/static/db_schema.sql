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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
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
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$12000$Q2Keta2wHaoL$gfr4DoAynxh729dnNU10jfo17gISxX+0uYaMOuhWNuM=','2014-01-06 02:48:32',1,'admin','','','',1,1,'2014-01-06 02:48:32');
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
  `environment_id` varchar(20) DEFAULT NULL,
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `development_metadata_server`
--

LOCK TABLES `development_metadata_server` WRITE;
/*!40000 ALTER TABLE `development_metadata_server` DISABLE KEYS */;
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
  `name` varchar(50) NOT NULL,
  `address` varchar(100) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `last_modified_date` datetime NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `development_metadata_serviceprovider`
--

LOCK TABLES `development_metadata_serviceprovider` WRITE;
/*!40000 ALTER TABLE `development_metadata_serviceprovider` DISABLE KEYS */;
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_component`
--

LOCK TABLES `product_component` WRITE;
/*!40000 ALTER TABLE `product_component` DISABLE KEYS */;
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_configtemplateitem`
--

LOCK TABLES `product_configtemplateitem` WRITE;
/*!40000 ALTER TABLE `product_configtemplateitem` DISABLE KEYS */;
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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_product`
--

LOCK TABLES `product_product` WRITE;
/*!40000 ALTER TABLE `product_product` DISABLE KEYS */;
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
  `environment_id` varchar(20) DEFAULT NULL,
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
  `name` varchar(50) NOT NULL,
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

-- Dump completed on 2014-01-06 10:54:41
