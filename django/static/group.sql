-- MySQL dump 10.13  Distrib 5.1.71, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: django_autodeploy
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
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add Product Deploy & Upgrade',7,'add_productdeployment'),(20,'Can change Product Deploy & Upgrade',7,'change_productdeployment'),(21,'Can delete Product Deploy & Upgrade',7,'delete_productdeployment'),(22,'Can add Product Deploy & Upgrade History',8,'add_productdeploymenthistory'),(23,'Can change Product Deploy & Upgrade History',8,'change_productdeploymenthistory'),(24,'Can delete Product Deploy & Upgrade History',8,'delete_productdeploymenthistory'),(25,'Can add Component Deploy & Upgrade Hitory',9,'add_componentdeploymenthistory'),(26,'Can change Component Deploy & Upgrade Hitory',9,'change_componentdeploymenthistory'),(27,'Can delete Component Deploy & Upgrade Hitory',9,'delete_componentdeploymenthistory'),(28,'Can add Deploy & Upgrade Config Item History',10,'add_configitem'),(29,'Can change Deploy & Upgrade Config Item History',10,'change_configitem'),(30,'Can delete Deploy & Upgrade Config Item History',10,'delete_configitem'),(31,'Can add Product',11,'add_product'),(32,'Can change Product',11,'change_product'),(33,'Can delete Product',11,'delete_product'),(34,'Can add deploy kit',12,'add_deploykit'),(35,'Can change deploy kit',12,'change_deploykit'),(36,'Can delete deploy kit',12,'delete_deploykit'),(37,'Can add component',13,'add_component'),(38,'Can change component',13,'change_component'),(39,'Can delete component',13,'delete_component'),(40,'Can add Product Version',14,'add_productversion'),(41,'Can change Product Version',14,'change_productversion'),(42,'Can delete Product Version',14,'delete_productversion'),(43,'Can add Component Package',15,'add_componentpackage'),(44,'Can change Component Package',15,'change_componentpackage'),(45,'Can delete Component Package',15,'delete_componentpackage'),(46,'Can add Config Template Item',16,'add_configtemplateitem'),(47,'Can change Config Template Item',16,'change_configtemplateitem'),(48,'Can delete Config Template Item',16,'delete_configtemplateitem'),(49,'Can add Service Provider',17,'add_serviceprovider'),(50,'Can change Service Provider',17,'change_serviceprovider'),(51,'Can delete Service Provider',17,'delete_serviceprovider'),(52,'Can add environment',18,'add_environment'),(53,'Can change environment',18,'change_environment'),(54,'Can delete environment',18,'delete_environment'),(55,'Can add server',19,'add_server'),(56,'Can change server',19,'change_server'),(57,'Can delete server',19,'delete_server');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;
