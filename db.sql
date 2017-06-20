-- MySQL dump 10.13  Distrib 5.5.54, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: engine_shop
-- ------------------------------------------------------
-- Server version	5.5.54-0ubuntu0.14.04.1-log

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
-- Table structure for table `x_content`
--

DROP TABLE IF EXISTS `x_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `types_id` tinyint(3) unsigned NOT NULL,
  `subtypes_id` tinyint(3) unsigned NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `parent_id` int(10) unsigned DEFAULT '0',
  `isfolder` tinyint(1) unsigned DEFAULT '0',
  `position` tinyint(3) unsigned DEFAULT '0',
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT NULL,
  `published` date DEFAULT NULL,
  `settings` text,
  `status` enum('blank','hidden','published','deleted') DEFAULT 'blank',
  `external_id` varchar(60) NOT NULL,
  PRIMARY KEY (`id`,`types_id`,`subtypes_id`,`owner_id`),
  KEY `fk_content_owner_idx` (`owner_id`),
  KEY `status` (`status`),
  KEY `published` (`published`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_content`
--

LOCK TABLES `x_content` WRITE;
/*!40000 ALTER TABLE `x_content` DISABLE KEYS */;
INSERT INTO `x_content` VALUES (1,1,5,1,0,1,0,'2017-03-09 08:13:35','2017-05-25 10:04:25','2017-03-09',NULL,'published',''),(2,1,1,1,1,1,0,'2017-03-09 08:13:35','2017-05-25 10:04:30','2017-03-09',NULL,'published',''),(3,1,1,1,1,0,0,'2017-03-09 08:13:44','2017-05-25 10:04:45','2017-03-09',NULL,'published',''),(4,4,4,1,0,1,0,'2017-05-15 16:01:48','2017-05-15 16:01:48','2017-05-15',NULL,'published',''),(5,1,1,1,2,0,0,'2017-05-15 16:05:11','2017-05-25 13:59:27','2017-05-15',NULL,'published',''),(6,1,1,1,1,0,0,'2017-05-15 16:05:23','2017-05-25 10:05:16','2017-05-15',NULL,'published',''),(7,4,4,1,4,0,0,'2017-05-15 16:07:17','2017-05-15 16:07:17','2017-05-15',NULL,'published',''),(8,4,4,1,4,0,0,'2017-05-15 16:07:31','2017-05-15 16:07:31','2017-05-15',NULL,'published',''),(9,1,1,1,1,1,0,'2017-05-15 16:09:01','2017-05-15 16:09:06','2017-05-15',NULL,'published',''),(11,1,1,1,9,0,0,'2017-05-15 16:09:11','2017-05-15 16:09:43','2017-05-15',NULL,'published',''),(12,3,3,1,0,0,0,'2017-05-16 15:06:52','2017-05-16 15:07:17','2017-05-16',NULL,'published',''),(13,3,3,1,0,0,0,'2017-05-16 15:07:31','2017-05-16 15:07:50','2017-05-16',NULL,'published',''),(14,3,3,1,0,0,0,'2017-05-16 15:07:52','2017-05-16 15:11:15','2017-05-16',NULL,'published',''),(16,3,3,1,0,0,0,'2017-05-16 15:12:13','2017-05-16 15:17:14','2017-05-16',NULL,'published',''),(18,7,7,1,0,1,0,'2017-06-12 15:38:51','2017-06-12 15:38:51','2017-06-12',NULL,'published',''),(19,7,7,1,18,0,0,'2017-06-12 15:45:06','2017-06-12 15:45:06','2017-06-12',NULL,'published',''),(20,7,7,1,18,0,0,'2017-06-12 15:45:18','2017-06-12 15:45:18','2017-06-12',NULL,'published',''),(21,7,7,1,18,0,0,'2017-06-12 15:45:29','2017-06-12 15:45:29','2017-06-12',NULL,'published',''),(22,7,7,1,18,0,0,'2017-06-12 15:45:57','2017-06-14 14:49:15','2017-06-12',NULL,'published',''),(23,7,7,1,18,0,0,'2017-06-12 15:46:07','2017-06-12 15:46:07','2017-06-12',NULL,'published',''),(24,7,7,1,18,0,0,'2017-06-12 15:47:12','2017-06-12 15:47:12','2017-06-12',NULL,'published',''),(26,7,7,1,0,1,0,'2017-06-12 15:47:58','2017-06-12 15:48:39','2017-06-12',NULL,'published',''),(27,7,7,1,26,0,0,'2017-06-12 15:48:48','2017-06-12 15:49:41','2017-06-12',NULL,'published',''),(28,7,7,1,26,0,0,'2017-06-12 15:50:07','2017-06-12 15:50:07','2017-06-12',NULL,'deleted',''),(35,6,6,1,0,0,0,'2017-06-12 16:07:00','2017-06-19 14:01:13','2017-06-19',NULL,'published',''),(36,2,2,1,0,1,0,'2017-06-13 16:20:23','2017-06-13 16:20:36','2017-06-13',NULL,'published','units'),(37,2,2,1,36,0,0,'2017-06-13 16:20:45','2017-06-13 16:20:45','2017-06-13',NULL,'published',''),(38,9,9,1,0,0,0,'2017-06-15 07:08:48','2017-06-15 07:23:15','2017-06-15',NULL,'published',''),(39,9,9,1,0,0,0,'2017-06-15 07:13:10','2017-06-15 07:13:16','2017-06-15',NULL,'published',''),(40,9,9,1,0,0,0,'2017-06-15 07:13:20','2017-06-20 11:57:07','2017-06-15',NULL,'published',''),(41,6,6,1,0,0,0,'2017-06-15 12:42:59','2017-06-19 14:00:15','2017-06-19',NULL,'published',''),(42,6,6,1,0,0,0,'2017-06-15 12:43:19','2017-06-15 14:21:57','2017-06-15',NULL,'published',''),(43,6,6,1,0,0,0,'2017-06-16 11:20:47','2017-06-19 14:00:34','2017-06-19',NULL,'published',''),(44,6,6,1,0,0,0,'2017-06-16 11:21:42','2017-06-19 14:00:28','2017-06-19',NULL,'published',''),(45,6,6,1,0,0,0,'2017-06-16 11:23:31','2017-06-19 14:00:21','2017-06-19',NULL,'published',''),(46,6,6,1,0,0,0,'2017-06-16 11:23:56','2017-06-19 14:01:07','2017-06-19',NULL,'published',''),(47,6,6,1,0,0,0,'2017-06-16 11:24:17','2017-06-20 11:54:13','2017-06-20',NULL,'published',''),(48,6,6,1,0,0,0,'2017-06-16 11:24:43','2017-06-19 14:00:49','2017-06-19',NULL,'published',''),(49,6,6,1,0,0,0,'2017-06-16 11:25:11','2017-06-19 14:01:00','2017-06-19',NULL,'published',''),(50,6,6,1,0,0,0,'2017-06-16 11:25:31','2017-06-19 14:00:07','2017-06-19',NULL,'published','');
/*!40000 ALTER TABLE `x_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_content_features`
--

DROP TABLE IF EXISTS `x_content_features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_content_features` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `features_id` int(10) unsigned NOT NULL,
  `content_id` int(10) unsigned NOT NULL,
  `values_id` int(10) unsigned DEFAULT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `value` text,
  PRIMARY KEY (`id`,`features_id`,`content_id`),
  KEY `fk_content_features_content1_idx` (`content_id`),
  KEY `fk_content_features_features1_idx` (`features_id`),
  CONSTRAINT `fk_content_features_content1` FOREIGN KEY (`content_id`) REFERENCES `x_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_content_features_features1` FOREIGN KEY (`features_id`) REFERENCES `x_features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_content_features`
--

LOCK TABLES `x_content_features` WRITE;
/*!40000 ALTER TABLE `x_content_features` DISABLE KEYS */;
INSERT INTO `x_content_features` VALUES (6,11,47,15,0,NULL),(7,13,47,17,0,NULL),(8,12,47,18,0,NULL),(9,11,50,14,0,NULL),(10,12,50,18,0,NULL),(11,13,50,17,0,NULL),(12,11,41,15,0,NULL),(13,12,41,18,0,NULL),(14,13,41,16,0,NULL),(15,11,45,14,0,NULL),(16,12,45,18,0,NULL),(17,13,45,16,0,NULL),(18,11,44,15,0,NULL),(19,12,44,18,0,NULL),(20,13,44,17,0,NULL),(21,11,43,15,0,NULL),(22,12,43,18,0,NULL),(23,13,43,16,0,NULL),(24,11,48,15,0,NULL),(25,12,48,18,0,NULL),(26,13,48,17,0,NULL),(27,11,49,15,0,NULL),(28,12,49,18,0,NULL),(29,13,49,16,0,NULL),(30,11,46,14,0,NULL),(31,12,46,18,0,NULL),(32,13,46,16,0,NULL),(33,11,35,14,0,NULL),(34,12,35,18,0,NULL),(35,13,35,16,0,NULL);
/*!40000 ALTER TABLE `x_content_features` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_content_images`
--

DROP TABLE IF EXISTS `x_content_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_content_images` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` int(10) unsigned NOT NULL,
  `path` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `position` tinyint(5) unsigned NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`content_id`),
  KEY `position` (`position`),
  KEY `fk_content_images_content1_idx` (`content_id`),
  CONSTRAINT `fk_content_images_content1` FOREIGN KEY (`content_id`) REFERENCES `x_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_content_images`
--

LOCK TABLES `x_content_images` WRITE;
/*!40000 ALTER TABLE `x_content_images` DISABLE KEYS */;
INSERT INTO `x_content_images` VALUES (1,16,'uploads/content/2017/05/17/','slide3-16x.jpg',1,'2017-05-17 13:58:22'),(2,12,'uploads/content/2017/05/17/','slide3-12x.jpg',1,'2017-05-17 13:58:25'),(3,14,'uploads/content/2017/05/17/','slide1-3-14x.jpg',1,'2017-05-17 13:58:30'),(4,42,'uploads/content/2017/06/15/','1-42x.jpg',1,'2017-06-15 14:08:42'),(5,41,'uploads/content/2017/06/15/','5-41x.jpg',1,'2017-06-15 14:57:16'),(6,35,'uploads/content/2017/06/15/','9-35x.jpg',1,'2017-06-15 14:57:22'),(7,43,'uploads/content/2017/06/16/','8-43x.jpg',1,'2017-06-16 11:21:31'),(8,44,'uploads/content/2017/06/16/','9-44x.jpg',1,'2017-06-16 11:23:17'),(9,45,'uploads/content/2017/06/16/','8-45x.jpg',1,'2017-06-16 11:23:52'),(10,46,'uploads/content/2017/06/16/','4-46x.jpg',1,'2017-06-16 11:24:16'),(11,47,'uploads/content/2017/06/16/','9-47x.jpg',1,'2017-06-16 11:24:41'),(12,48,'uploads/content/2017/06/16/','7-48x.jpg',1,'2017-06-16 11:25:02'),(13,49,'uploads/content/2017/06/16/','6-49x.jpg',1,'2017-06-16 11:25:30'),(14,50,'uploads/content/2017/06/16/','7-50x.jpg',1,'2017-06-16 11:25:46');
/*!40000 ALTER TABLE `x_content_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_content_images_sizes`
--

DROP TABLE IF EXISTS `x_content_images_sizes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_content_images_sizes` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `size` varchar(16) NOT NULL,
  `width` int(5) unsigned NOT NULL,
  `height` int(5) unsigned NOT NULL,
  `quality` tinyint(3) unsigned NOT NULL,
  `watermark` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `watermark_position` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `size` (`size`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_content_images_sizes`
--

LOCK TABLES `x_content_images_sizes` WRITE;
/*!40000 ALTER TABLE `x_content_images_sizes` DISABLE KEYS */;
INSERT INTO `x_content_images_sizes` VALUES (1,'post',640,480,80,0,0),(2,'product',600,600,80,0,0);
/*!40000 ALTER TABLE `x_content_images_sizes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_content_info`
--

DROP TABLE IF EXISTS `x_content_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_content_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` int(10) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `h1` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `intro` text,
  `content` text,
  PRIMARY KEY (`id`,`content_id`,`languages_id`),
  UNIQUE KEY `languages_id` (`languages_id`,`url`),
  KEY `fk_content_info_content1_idx` (`content_id`),
  KEY `fk_content_info_languages1_idx` (`languages_id`),
  CONSTRAINT `fk_content_info_content1` FOREIGN KEY (`content_id`) REFERENCES `x_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_content_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `x_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_content_info`
--

LOCK TABLES `x_content_info` WRITE;
/*!40000 ALTER TABLE `x_content_info` DISABLE KEYS */;
INSERT INTO `x_content_info` VALUES (1,1,1,'Home','','','Home','','','',''),(2,2,1,'About','about','','About','','','',''),(3,3,1,'404','404','','404','','','',''),(4,4,1,'Blog','blog','','Blog','','',NULL,NULL),(5,5,1,'Sub page','about/sub-page','','Sub page','','','',''),(6,6,1,'Contacts','contacts','','Contacts','','','',''),(7,7,1,'Lorem ipsum dolor','lorem-ipsum-dolor','','Lorem ipsum dolor','','',NULL,NULL),(8,8,1,'Donec vel condimentum','donec-vel-condimentum','','Donec vel condimentum','','',NULL,NULL),(9,9,1,'Account','account','','Account','','','',''),(10,11,1,'My Wishlist','account/my-wishlist','','My Wishlist','','','',''),(11,12,1,'Lorem ipsum dolor sit amet, consectetur adipiscing elit.','lorem-ipsum-dolor-sit-amet-consectetur-adipiscing-elit','','Lorem ipsum dolor sit amet, consectetur adipiscing elit.','','','','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque efficitur, massa in laoreet auctor, quam metus gravida mauris, eget blandit orci ligula sit amet arcu. Maecenas vel lacus ullamcorper, posuere nisi eget, faucibus felis. Aliquam vulputate nec risus a commodo. Sed eu orci vitae dolor dignissim suscipit. Etiam at velit maximus, tempus ligula sit amet, efficitur libero. Integer ultrices egestas bibendum. Aenean arcu justo, efficitur quis fringilla id, tristique eget turpis. Donec molestie fringilla elementum. Suspendisse lacinia neque in dui iaculis accumsan. Integer lobortis pretium interdum. Morbi enim mi, finibus non fringilla id, auctor vel lacus. Vestibulum interdum pulvinar sollicitudin. Ut mattis, diam sit amet faucibus bibendum, lorem felis luctus justo, ac molestie ipsum justo et justo. Phasellus vestibulum tincidunt arcu, id dictum erat ultrices ut. Vestibulum rutrum eros ac eros finibus facilisis.</p> \n<p>Duis in nunc consequat, aliquet nunc at, scelerisque leo. Sed varius euismod est. Aliquam non rhoncus magna. Etiam massa est, rhoncus vel scelerisque sed, scelerisque congue enim. Etiam quis arcu tincidunt, aliquet neque ac, ornare lacus. In varius odio nisl, at efficitur enim cursus in. Pellentesque sit amet purus ac mauris cursus sollicitudin. Donec sed nulla imperdiet leo ultrices placerat nec et magna.</p> \n<p>Curabitur ac finibus mi, et finibus ex. Curabitur nec eros vel lacus hendrerit facilisis eu in neque. Suspendisse fringilla tortor magna, id varius nulla vehicula sit amet. Donec venenatis magna nisl, eget imperdiet orci imperdiet a. Cras vel felis eu mi ullamcorper molestie. Vivamus mauris odio, elementum sit amet consequat a, pharetra eget orci. Morbi volutpat elementum velit vel fringilla. Nulla facilisi. Suspendisse finibus lobortis magna vel dignissim. Maecenas lacinia ullamcorper tortor et elementum. Nullam facilisis suscipit arcu, eget convallis nibh ultrices nec. Integer venenatis velit lorem, et vulputate arcu pretium ac. Suspendisse potenti. Vestibulum sem dolor, mollis at magna ut, molestie scelerisque justo. Praesent in semper enim.</p> \n<p>Fusce ac dui suscipit, tincidunt odio eu, bibendum eros. Maecenas ornare velit at dolor semper, et mattis dui porttitor. Nam pretium lacus et tortor sollicitudin viverra. Duis cursus ullamcorper sodales. Sed velit lorem, scelerisque tincidunt nulla sit amet, varius dapibus leo. Suspendisse justo justo, pulvinar a velit et, ornare elementum velit. Suspendisse erat urna, suscipit non lorem id, maximus ornare est. Praesent metus orci, rutrum et tortor vitae, sodales fermentum risus. Suspendisse sed nulla aliquet, volutpat sapien sit amet, faucibus lectus.</p> \n<p>Aliquam ac leo augue. Aliquam erat volutpat. Nulla vitae felis vitae massa ullamcorper faucibus. Aliquam lacinia ornare lorem, vitae gravida libero malesuada convallis. Sed velit neque, ultricies sed dapibus quis, luctus in nisl. Sed porttitor erat nec leo maximus pretium. Curabitur faucibus sem ac orci iaculis, vitae iaculis augue mattis. Aenean gravida, urna in mollis ullamcorper, justo turpis viverra lorem, in efficitur eros neque nec metus. Aenean quis mauris at purus porttitor fringilla. Aenean ut risus vitae ex tempor fermentum vitae vitae eros. Vestibulum lacinia, odio non hendrerit interdum, felis ipsum faucibus est, id condimentum nunc felis ac ligula. Suspendisse purus ligula, finibus nec vulputate in, finibus eget ligula. Ut luctus, nulla eget viverra eleifend, metus erat posuere arcu, nec pulvinar tellus metus at massa. Sed scelerisque sit amet nibh ut accumsan. Morbi lorem elit, scelerisque ut vulputate sed, lobortis nec lectus.</p> \n'),(12,13,1,'Curabitur mattis aliquet porta.','curabitur-mattis-aliquet-porta','','Curabitur mattis aliquet porta.','','','','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget tellus eget libero mattis pellentesque id vitae nulla. Vestibulum sollicitudin sagittis molestie. Phasellus eleifend velit lorem, eget scelerisque mi sollicitudin at. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque eu fermentum dui. Phasellus egestas metus vitae eros rhoncus, non placerat sapien efficitur. Donec pretium tortor et eros egestas, sit amet posuere lorem bibendum. Curabitur mattis aliquet porta.<br />\nPraesent feugiat mauris vitae ullamcorper cursus. Ut sed lorem quis turpis facilisis tincidunt. Nulla vel massa vel nibh finibus faucibus vitae quis dolor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Duis sodales mauris id rutrum accumsan. Praesent quis urna vitae turpis euismod lobortis eu sed dolor. Aenean non scelerisque mauris, vitae laoreet nunc. Fusce at erat nisl. Etiam finibus id erat nec tincidunt. Aenean vitae iaculis turpis, sit amet scelerisque quam. Ut malesuada est vitae quam cursus ullamcorper. Morbi sed hendrerit nisl. Donec ornare eros ipsum, id laoreet purus porttitor lacinia. Nunc interdum, magna a consequat scelerisque, nisl nibh hendrerit nisi, ac interdum dui metus ac augue. Donec dictum blandit auctor.<br />\nSuspendisse aliquam ac sapien et posuere. Nullam at sollicitudin eros. Nunc porttitor non risus nec scelerisque. Donec aliquet ullamcorper ex nec bibendum. Donec lobortis vitae velit quis consequat. Vestibulum nec leo vitae metus finibus maximus in vitae velit. Nullam porta gravida ultricies. Vivamus porta magna nec arcu vehicula, at dapibus nibh finibus. Curabitur a elementum mi. Integer nec hendrerit lorem, eget molestie augue. Vestibulum eget rhoncus nulla. Ut eget lorem aliquam, euismod erat sit amet, malesuada urna. Fusce sodales magna id hendrerit congue. Aliquam est felis, volutpat venenatis blandit et, bibendum a eros.<br />\nDuis laoreet, urna at pulvinar scelerisque, turpis lorem mattis augue, et dictum mauris lectus non est. Nulla vehicula porta ullamcorper. Nunc consectetur et erat at sodales. Proin accumsan libero sed convallis euismod. Cras a justo urna. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Maecenas pretium nisi ut scelerisque laoreet. Curabitur dictum nunc nec turpis placerat eleifend. Ut lacinia sed neque id tempor. Donec tincidunt, sem eu eleifend rhoncus, felis orci scelerisque nisi, in porta felis nibh sed nibh. Nunc facilisis libero vel vulputate molestie. Curabitur quis eleifend eros. Donec non euismod nulla. Vestibulum nisl arcu, rhoncus in consequat vitae, luctus ut dolor.<br />\nPraesent magna massa, aliquam nec nisi id, tincidunt vulputate felis. Donec arcu orci, dignissim eget nisl quis, imperdiet faucibus eros. Suspendisse potenti. Vivamus et iaculis risus, sed convallis urna. Nunc ultrices convallis urna ac pharetra. Nulla a felis metus. Nullam eu tellus egestas, sodales lacus eu, pharetra ex. Vestibulum eget tellus ut urna maximus ultricies ut at sem. Morbi tempor sem nec felis fermentum, sodales euismod orci iaculis. Sed pharetra eros tempus massa porttitor, a ultrices erat tristique. In accumsan eros erat, sed ornare leo aliquam sit amet.<br />\n&nbsp;</p>\n'),(13,14,1,'laoreet nec tincidunt sit amet','laoreet-nec-tincidunt-sit-amet','','laoreet nec tincidunt sit amet','','','','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec lobortis magna imperdiet nibh vehicula luctus. Vestibulum fringilla a dolor non lobortis. In nibh tellus, fringilla et orci eu, varius vulputate nibh. Fusce vitae magna bibendum, pharetra odio ac, malesuada purus. Vestibulum ornare ornare vestibulum. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nam nec lacinia eros. Pellentesque fermentum ante erat, fermentum suscipit neque sollicitudin vel. Integer mollis pulvinar tristique. Nam fringilla augue eu lectus gravida tristique. In egestas urna risus, vel bibendum leo porta in. Pellentesque vestibulum vel mauris vel dapibus. Vivamus porttitor libero at aliquam venenatis.</p> \n<p>Sed ullamcorper malesuada risus sed posuere. Phasellus quis aliquet erat. Nulla scelerisque vehicula tempor. Maecenas mauris sapien, laoreet nec tincidunt sit amet, facilisis nec mauris. Quisque vitae justo vitae metus vulputate suscipit id in orci. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Praesent hendrerit ultrices purus. Donec eu scelerisque velit, nec accumsan velit.</p> \n<p>Ut orci erat, pulvinar vitae viverra non, vulputate vitae ante. In non lacus at libero venenatis vehicula et nec metus. Ut maximus non metus sagittis interdum. Morbi a lacus elit. Vestibulum dapibus faucibus nisl id pulvinar. Pellentesque a dolor id ante posuere consequat a nec mauris. Praesent ultrices sed lorem ut malesuada. Fusce in placerat ipsum, quis elementum tellus. Morbi gravida a odio a blandit. Curabitur tristique nisl sit amet elit ultricies feugiat.</p> \n<p>Vestibulum in nisi tincidunt, finibus dui vitae, fringilla magna. Nunc at interdum ligula, molestie aliquam urna. Suspendisse potenti. Suspendisse eget risus non sapien pulvinar sagittis. Nullam volutpat augue et lectus eleifend condimentum. Nunc a euismod nulla. Vestibulum laoreet magna turpis, eget lobortis quam fermentum et. Quisque et metus nec lacus pretium malesuada. Etiam rutrum, elit vitae pulvinar maximus, est turpis dictum mi, lacinia ornare ipsum justo sit amet massa. Aliquam sit amet dolor arcu. Fusce lorem quam, consequat ac diam a, iaculis malesuada quam. Phasellus congue augue at odio vestibulum convallis. Phasellus id justo diam.</p> \n<p>Cras consectetur vehicula enim, vel vestibulum dolor convallis faucibus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed vestibulum ex. Pellentesque mattis sapien a iaculis aliquet. Pellentesque posuere sagittis nulla, et consectetur nibh placerat at. Maecenas sapien ipsum, placerat a est non, vestibulum faucibus libero. Suspendisse luctus risus vitae maximus feugiat. Nunc tincidunt, tellus non facilisis tincidunt, nulla ex ultrices mi, vel scelerisque lorem velit quis nulla.</p> \n'),(14,16,1,'Morbi vitae hendrerit risus, scelerisque volutpat lorem','morbi-vitae-hendrerit-risus-scelerisque-volutpat-lorem','','Morbi vitae hendrerit risus, scelerisque volutpat lorem','','','','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed lorem tellus, rutrum sed justo vestibulum, lobortis dignissim libero. Curabitur convallis turpis sit amet erat lacinia, sit amet venenatis lacus tristique. In volutpat tristique ex, eleifend ornare mauris. Quisque semper arcu ut pretium accumsan. Mauris quis dolor eget lectus pharetra varius non vel velit. Aenean molestie ligula dui. Donec sapien nisi, aliquet eleifend bibendum non, dictum sit amet nunc. Pellentesque non massa a diam hendrerit auctor non quis massa.</p> \n<p>Morbi vitae hendrerit risus, scelerisque volutpat lorem. Vestibulum id metus interdum, accumsan erat nec, congue nisl. Sed rhoncus aliquet augue, a egestas risus dapibus id. Aliquam erat volutpat. Morbi mauris felis, hendrerit nec egestas eu, tempus eu tortor. Quisque at aliquet dui, id sagittis metus. Donec fermentum vitae turpis eget tempor. Cras ut odio feugiat, blandit orci consequat, interdum augue. Etiam rhoncus imperdiet nisl, sit amet aliquet lectus rhoncus ut. In eu ante in ligula dapibus consectetur. Etiam quis accumsan lectus, facilisis interdum felis. Donec non dignissim metus, in placerat justo. Nunc est orci, congue sit amet nunc quis, aliquet molestie enim. Proin convallis turpis et ligula bibendum, et sagittis justo vehicula.</p> \n<p>Morbi id tortor laoreet, luctus sem in, pharetra leo. Proin non consectetur risus, sit amet interdum est. Phasellus feugiat non leo a hendrerit. Sed fringilla dapibus est ac commodo. Nam mattis at odio ac scelerisque. Proin dolor mauris, rhoncus ac imperdiet nec, elementum a lectus. Nullam ex velit, accumsan ut nisl vitae, dapibus lacinia nunc. Vestibulum placerat lorem vitae purus efficitur aliquam. Integer velit risus, gravida in euismod at, sagittis quis massa. Nam tempus scelerisque elit eu pellentesque. In luctus libero quis sapien fringilla, blandit congue erat vestibulum.</p> \n<p>Cras vehicula nisl et nisi interdum viverra. Nunc placerat est in velit iaculis pellentesque. Vivamus bibendum non nulla vel aliquet. Maecenas feugiat purus nec suscipit placerat. Nam iaculis elit nulla, eu mattis magna accumsan eget. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nam sollicitudin augue ut imperdiet vehicula. Sed eros libero, ultrices ut nisl eu, vulputate facilisis nunc. Nam vehicula, purus sed aliquam tempor, enim erat scelerisque justo, sed tincidunt velit est accumsan turpis. Phasellus vel tempor ligula. Vivamus et orci libero. Maecenas lacinia eros nec metus condimentum, quis mattis est pulvinar. Nunc at hendrerit enim. In bibendum sagittis diam non euismod. Suspendisse potenti. Etiam nec molestie velit.</p> \n<p>Suspendisse sollicitudin lorem ac lectus tempor, et porttitor metus vulputate. Etiam aliquam vehicula mi id imperdiet. Morbi dapibus ultrices ex a feugiat. Quisque mattis sodales ipsum ac dapibus. Pellentesque imperdiet felis id mi fermentum finibus. Duis efficitur sem non magna sagittis, sed feugiat nulla viverra. Curabitur egestas, nulla sit amet pretium volutpat, ante arcu eleifend tortor, ut convallis lacus ipsum ut lectus. Mauris a lorem et arcu tempus mattis vel in libero. Quisque interdum, quam et imperdiet iaculis, felis neque tempus nisl, aliquet sodales massa justo non justo. Aenean vitae neque dolor. Etiam mattis ligula quis enim venenatis tincidunt. Vestibulum sodales finibus venenatis. Morbi mauris ante, cursus ut feugiat vitae, vestibulum hendrerit ligula.</p> \n'),(15,1,2,'Home','','','Home','','','',''),(16,2,2,'About','about','','About','','','',''),(17,5,2,'Sub page','about/sub-page','','Sub page','','','',''),(18,3,2,'404','404','','404','','','',''),(19,6,2,'Contacts','contacts','','Contacts','','','',''),(20,18,1,'Women','women','','Women','','',NULL,NULL),(21,18,2,'Women','women','','Women','','',NULL,NULL),(22,19,1,'Clothing','clothing','','Clothing','','',NULL,NULL),(23,19,2,'Clothing','clothing','','Clothing','','',NULL,NULL),(24,20,1,'Shoes','shoes','','Shoes','','',NULL,NULL),(25,20,2,'Shoes','shoes','','Shoes','','',NULL,NULL),(26,21,1,'Jewelry','jewelry','','Jewelry','','',NULL,NULL),(27,21,2,'Jewelry','jewelry','','Jewelry','','',NULL,NULL),(28,22,1,'Watches','watches','','Watches','','','',''),(29,22,2,'Watches','watches','','Watches','','','',''),(30,23,1,'Handbags & Wallets','handbags-wallets','','Handbags & Wallets','','',NULL,NULL),(31,23,2,'Handbags & Wallets','handbags-wallets','','Handbags & Wallets','','',NULL,NULL),(32,24,1,'Accessories','accessories','','Accessories','','',NULL,NULL),(33,24,2,'Accessories','accessories','','Accessories','','',NULL,NULL),(34,26,1,'Men','men','','Men','','','',''),(35,26,2,'Men','men','','Men','','','',''),(36,27,1,'Clothing','men/clothing','','Clothing','','','',''),(37,27,2,'Clothing','men/clothing','','Clothing','','','',''),(38,28,1,'aaaaa','aaaaa','','aaaaa','','',NULL,NULL),(39,28,2,'aaaaa','aaaaa','','aaaaa','','',NULL,NULL),(40,35,1,'Original Penguin Men\'s the Viper Aviator Sunglasses, Black, 56 mm','original-penguin-men-s-the-viper-aviator-sunglasses-black-56-mm','','Original Penguin Men\'s the Viper Aviator Sunglasses, Black, 56 mm','','','',''),(41,35,2,'Original Penguin Men\'s the Viper Aviator Sunglasses, Black, 56 mm','original-penguin-men-s-the-viper-aviator-sunglasses-black-56-mm','','Original Penguin Men\'s the Viper Aviator Sunglasses, Black, 56 mm','','','',''),(42,36,1,'Units','units','','Units','','',NULL,NULL),(43,36,2,'Units','units','','Units','','',NULL,NULL),(44,37,1,'Pt','pt','','Pt','','',NULL,NULL),(45,37,2,'Pt','pt','','Pt','','',NULL,NULL),(46,38,1,'Acer','acer','','Acer','','','',''),(47,38,2,'Acer','acer','','Acer','','','',''),(48,39,1,'Apple','apple','','Apple','','','',''),(49,39,2,'Apple','apple','','Apple','','','',''),(50,40,1,'Asus','asus','','Asus','','','',''),(51,40,2,'Asus','asus','','Asus','','','',''),(52,41,1,'BB Dakota Women\'s Curren Off the Shoulder Lace Top','bb-dakota-women-s-curren-off-the-shoulder-lace-top','','BB Dakota Women\'s Curren Off the Shoulder Lace Top','','','',''),(53,41,2,'BB Dakota Women\'s Curren Off the Shoulder Lace Top','bb-dakota-women-s-curren-off-the-shoulder-lace-top','','BB Dakota Women\'s Curren Off the Shoulder Lace Top','','','',''),(54,42,1,'BB Dakota Women\'s Curren Off the Shoulder Lace','bb-dakota-women-s-curren-off-the-shoulder-lace','','BB Dakota Women\'s Curren Off the Shoulder Lace','','','',''),(55,42,2,'BB Dakota Women\'s Curren Off the Shoulder Lace','bb-dakota-women-s-curren-off-the-shoulder-lace','','BB Dakota Women\'s Curren Off the Shoulder Lace','','','',''),(56,43,1,'Lorem ipsum sit amet, consectetur adipiscing elit.','lorem-ipsum-sit-amet-consectetur-adipiscing-elit','','Lorem ipsum sit amet, consectetur adipiscing elit.','','','','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sed ligula vel ante efficitur pulvinar. Ut tempor, elit at suscipit laoreet, mauris turpis tempor mauris, et iaculis ante metus quis enim. Aenean vitae magna ac justo laoreet molestie vitae quis ex. Mauris ut sem rhoncus, egestas nisi vel, volutpat sapien. Morbi elementum neque sit amet nunc efficitur dictum. Sed malesuada sem in dolor sagittis malesuada. Proin facilisis enim ut lectus laoreet eleifend.</p>\n\n<p>Etiam felis sapien, sagittis quis dictum ac, scelerisque a enim. Praesent placerat elementum ex, eget dignissim mauris vehicula et. Nunc pellentesque congue tincidunt. Nam ante tortor, feugiat eleifend fringilla et, tincidunt et mi. Aliquam euismod lectus nec velit porta dignissim. Sed iaculis nisl non vehicula ultrices. Aliquam fermentum orci arcu, vel placerat sem vestibulum a.</p>\n\n<p>Aenean nec leo id lacus euismod mattis. Nam porttitor magna vel tortor porta vehicula. Nulla non egestas felis. Vivamus accumsan justo quis felis pellentesque tempor. Nunc sagittis bibendum ipsum sit amet vulputate. Aliquam lobortis congue purus ultricies suscipit. Cras vel ultricies lectus. Praesent id orci vel ante molestie congue vitae sed risus.</p>\n\n<p>Vivamus quis ligula sit amet urna lobortis aliquet malesuada ut enim. Maecenas vitae purus accumsan, venenatis odio sed, bibendum lectus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus viverra, diam vitae mattis ultrices, lectus neque finibus risus, non malesuada nunc eros sed dui. Nullam at lorem orci. Aliquam erat volutpat. Sed pulvinar elit eu tortor convallis, quis posuere metus consequat. Curabitur convallis, mauris a fermentum feugiat, erat mi efficitur arcu, malesuada tincidunt erat mi at tellus. Ut nulla odio, faucibus ut urna et, blandit dictum nulla. Etiam non quam blandit sapien porttitor fermentum ac vitae dui.</p>\n\n<p>Donec elementum dolor et dolor faucibus, dictum dapibus nibh tristique. Maecenas finibus sollicitudin eros in consequat. Quisque erat arcu, molestie et cursus faucibus, varius quis ante. Vestibulum ullamcorper gravida odio, sed facilisis dui ultrices ac. Etiam porttitor egestas mi, vitae imperdiet erat vulputate ut. Quisque non aliquam ligula. Suspendisse ultrices pharetra turpis pulvinar sodales. Morbi consectetur neque quis nulla vehicula, at euismod ante euismod. Curabitur interdum, ipsum vitae finibus pretium, enim nisl iaculis nisl, ac tempus nunc turpis in felis. Maecenas ex erat, convallis quis magna nec, tempus porttitor odio. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aliquam malesuada justo tellus, non pharetra ex tristique quis. Suspendisse potenti. In hac habitasse platea dictumst. Maecenas eu tellus eu orci imperdiet sagittis et non lectus.</p>\n'),(57,43,2,'Lorem ipsum sit amet, consectetur adipiscing elit.','lorem-ipsum-sit-amet-consectetur-adipiscing-elit','','Lorem ipsum sit amet, consectetur adipiscing elit.','','','',''),(58,44,1,'Cras vel ultricies lectus.','cras-vel-ultricies-lectus','','Cras vel ultricies lectus.','','','',''),(59,44,2,'Cras vel ultricies lectus.','cras-vel-ultricies-lectus','','Cras vel ultricies lectus.','','','',''),(60,45,1,'Cras vel ultricies .','cras-vel-ultricies','','Cras vel ultricies .','','','',''),(61,45,2,'Cras vel ultricies .','cras-vel-ultricies','','Cras vel ultricies .','','','',''),(62,46,1,'Maecenas vitae purus accumsan','maecenas-vitae-purus-accumsan','','Maecenas vitae purus accumsan','','','',''),(63,46,2,'Maecenas vitae purus accumsan','maecenas-vitae-purus-accumsan','','Maecenas vitae purus accumsan','','','',''),(64,47,1,' Maecenas finibus sollicitudin eros in','maecenas-finibus-sollicitudin-eros-in','',' Maecenas finibus sollicitudin eros in','','','',''),(65,47,2,' Maecenas finibus sollicitudin eros in','maecenas-finibus-sollicitudin-eros-in','',' Maecenas finibus sollicitudin eros in','','','',''),(66,48,1,'Maecenas eu tellus eu orci imperdiet sagittis et non lectus','maecenas-eu-tellus-eu-orci-imperdiet-sagittis-et-non-lectus','','Maecenas eu tellus eu orci imperdiet sagittis et non lectus','','','',''),(67,48,2,'Maecenas eu tellus eu orci imperdiet sagittis et non lectus','maecenas-eu-tellus-eu-orci-imperdiet-sagittis-et-non-lectus','','Maecenas eu tellus eu orci imperdiet sagittis et non lectus','','','',''),(68,49,1,'Maecenas finibus sollicitudin','maecenas-finibus-sollicitudin','','Maecenas finibus sollicitudin','','','',''),(69,49,2,'Maecenas finibus sollicitudin','maecenas-finibus-sollicitudin','','Maecenas finibus sollicitudin','','','',''),(70,50,1,'Vestibulum ullamcorper gravida odio','vestibulum-ullamcorper-gravida-odio','','Vestibulum ullamcorper gravida odio','','','',''),(71,50,2,'Vestibulum ullamcorper gravida odio','vestibulum-ullamcorper-gravida-odio','','Vestibulum ullamcorper gravida odio','','','','');
/*!40000 ALTER TABLE `x_content_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_content_meta`
--

DROP TABLE IF EXISTS `x_content_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_content_meta` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` int(10) unsigned NOT NULL,
  `meta_k` varchar(45) DEFAULT NULL,
  `meta_v` text,
  PRIMARY KEY (`id`,`content_id`),
  KEY `meta_k` (`meta_k`),
  KEY `fk_content_meta_content1_idx` (`content_id`),
  CONSTRAINT `fk_content_meta_content1` FOREIGN KEY (`content_id`) REFERENCES `x_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_content_meta`
--

LOCK TABLES `x_content_meta` WRITE;
/*!40000 ALTER TABLE `x_content_meta` DISABLE KEYS */;
INSERT INTO `x_content_meta` VALUES (1,16,'views','30'),(2,12,'views','3'),(3,14,'views','19'),(4,42,'bestseller','1'),(5,42,'new','1'),(6,44,'hit','1');
/*!40000 ALTER TABLE `x_content_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_content_relationship`
--

DROP TABLE IF EXISTS `x_content_relationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_content_relationship` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` int(10) unsigned NOT NULL,
  `categories_id` int(10) unsigned NOT NULL,
  `is_main` tinyint(1) unsigned DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`,`content_id`,`categories_id`),
  KEY `fk_content_relationship_content2_idx` (`categories_id`),
  KEY `is_main` (`is_main`),
  KEY `fk_content_relationship_content1_idx` (`content_id`),
  CONSTRAINT `fk_content_relationship_content1` FOREIGN KEY (`content_id`) REFERENCES `x_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_content_relationship_content2` FOREIGN KEY (`categories_id`) REFERENCES `x_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_content_relationship`
--

LOCK TABLES `x_content_relationship` WRITE;
/*!40000 ALTER TABLE `x_content_relationship` DISABLE KEYS */;
INSERT INTO `x_content_relationship` VALUES (1,12,7,0,'blog_post'),(2,13,7,0,'blog_post'),(3,14,8,0,'blog_post'),(4,16,7,0,'blog_post'),(15,35,22,0,NULL),(28,35,19,1,NULL),(29,41,19,1,NULL),(30,42,19,1,NULL),(31,43,19,1,NULL),(32,44,19,1,NULL),(33,45,19,1,NULL),(34,46,19,1,NULL),(35,47,19,1,NULL),(36,50,19,1,NULL),(37,48,19,1,NULL),(38,49,19,1,NULL);
/*!40000 ALTER TABLE `x_content_relationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_content_types`
--

DROP TABLE IF EXISTS `x_content_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_content_types` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` tinyint(3) unsigned DEFAULT '0',
  `isfolder` tinyint(1) unsigned DEFAULT '0',
  `type` varchar(45) NOT NULL,
  `name` varchar(60) NOT NULL,
  `is_main` tinyint(1) unsigned DEFAULT NULL,
  `settings` text,
  PRIMARY KEY (`id`),
  KEY `is_main` (`is_main`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_content_types`
--

LOCK TABLES `x_content_types` WRITE;
/*!40000 ALTER TABLE `x_content_types` DISABLE KEYS */;
INSERT INTO `x_content_types` VALUES (1,0,1,'pages','Pages',1,NULL),(2,0,0,'guide','Guides',NULL,NULL),(3,0,0,'blog_post','Posts',NULL,NULL),(4,0,0,'blog_category','PostsCategories',NULL,'a:2:{s:7:\"ext_url\";s:1:\"0\";s:9:\"parent_id\";s:0:\"\";}'),(5,1,0,'home','Home 8',NULL,'a:2:{s:7:\"ext_url\";s:1:\"0\";s:9:\"parent_id\";s:0:\"\";}'),(6,0,0,'shop_product','Product',NULL,NULL),(7,0,0,'shop_category','Products Categories',NULL,NULL),(9,0,0,'shop_manufacturer','Shop Manufacturer',NULL,'a:2:{s:7:\"ext_url\";s:1:\"0\";s:9:\"parent_id\";s:0:\"\";}');
/*!40000 ALTER TABLE `x_content_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_content_types_images_sizes`
--

DROP TABLE IF EXISTS `x_content_types_images_sizes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_content_types_images_sizes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `types_id` tinyint(3) unsigned NOT NULL,
  `images_sizes_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`,`types_id`,`images_sizes_id`),
  KEY `fk_content_types_images_sizes_content_images_sizes1_idx` (`images_sizes_id`),
  CONSTRAINT `fk_content_types_images_sizes_content_images_sizes1` FOREIGN KEY (`images_sizes_id`) REFERENCES `x_content_images_sizes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_content_types_images_sizes`
--

LOCK TABLES `x_content_types_images_sizes` WRITE;
/*!40000 ALTER TABLE `x_content_types_images_sizes` DISABLE KEYS */;
INSERT INTO `x_content_types_images_sizes` VALUES (1,3,1),(2,6,2);
/*!40000 ALTER TABLE `x_content_types_images_sizes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_currency`
--

DROP TABLE IF EXISTS `x_currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_currency` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `code` char(3) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `symbol` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `rate` decimal(7,3) DEFAULT NULL,
  `is_main` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `on_site` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `code` (`code`),
  KEY `is_main` (`is_main`),
  KEY `on_site` (`on_site`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_currency`
--

LOCK TABLES `x_currency` WRITE;
/*!40000 ALTER TABLE `x_currency` DISABLE KEYS */;
INSERT INTO `x_currency` VALUES (1,'Dollar','USD','$',1.000,1,1),(2,'AED','AED','aed',2.000,0,0);
/*!40000 ALTER TABLE `x_currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_features`
--

DROP TABLE IF EXISTS `x_features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_features` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `type` enum('text','textarea','select','file','folder','value','checkbox','number','image') DEFAULT NULL,
  `code` varchar(45) NOT NULL,
  `multiple` tinyint(1) DEFAULT NULL,
  `on_filter` tinyint(1) DEFAULT NULL,
  `on_list` tinyint(1) NOT NULL DEFAULT '0',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `hide` tinyint(1) NOT NULL DEFAULT '0',
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('blank','published','hidden') DEFAULT 'blank',
  `position` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`,`owner_id`),
  UNIQUE KEY `code_UNIQUE` (`code`),
  KEY `fk_features_users1_idx` (`owner_id`),
  KEY `position` (`position`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_features`
--

LOCK TABLES `x_features` WRITE;
/*!40000 ALTER TABLE `x_features` DISABLE KEYS */;
INSERT INTO `x_features` VALUES (11,0,1,'select','aaaa',0,1,0,0,0,'2017-06-19 13:57:27','published',0),(12,0,1,'select','bbbb',0,1,0,0,0,'2017-06-19 13:57:39','published',0),(13,0,1,'select','cccc',0,1,0,0,0,'2017-06-19 13:57:50','published',0),(14,11,1,'value','8582c16027da800dac3c6ba825979136',NULL,NULL,0,0,0,'2017-06-19 13:57:55','published',0),(15,11,1,'value','dd87fd8aea5a718fb5206a97e5ac68de',NULL,NULL,0,0,0,'2017-06-19 13:57:58','published',0),(16,13,1,'value','4d8a5b2c8724de7e2b2805eb3ce6048f',NULL,NULL,0,0,0,'2017-06-19 13:58:04','published',0),(17,13,1,'value','4da127967a273d277d293e14bd5f9c6b',NULL,NULL,0,0,0,'2017-06-19 13:58:09','published',0),(18,12,1,'value','a8f2d4b1baaa1eb2f122c8fe6a490955',NULL,NULL,0,0,0,'2017-06-19 13:58:13','published',0);
/*!40000 ALTER TABLE `x_features` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_features_content`
--

DROP TABLE IF EXISTS `x_features_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_features_content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `features_id` int(10) unsigned NOT NULL,
  `content_types_id` tinyint(3) unsigned NOT NULL,
  `content_subtypes_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `content_id` int(10) unsigned NOT NULL DEFAULT '0',
  `position` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`,`features_id`,`content_types_id`,`content_subtypes_id`,`content_id`),
  KEY `fk_features_content_features1_idx` (`features_id`),
  KEY `fk_features_content_content_types1_idx` (`content_types_id`),
  CONSTRAINT `fk_features_content_content_types1` FOREIGN KEY (`content_types_id`) REFERENCES `x_content_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_features_content_features1` FOREIGN KEY (`features_id`) REFERENCES `x_features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_features_content`
--

LOCK TABLES `x_features_content` WRITE;
/*!40000 ALTER TABLE `x_features_content` DISABLE KEYS */;
INSERT INTO `x_features_content` VALUES (13,11,7,7,19,NULL),(14,12,7,7,19,NULL),(15,13,7,7,19,NULL);
/*!40000 ALTER TABLE `x_features_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_features_info`
--

DROP TABLE IF EXISTS `x_features_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_features_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `features_id` int(10) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`features_id`,`languages_id`),
  KEY `fk_features_info_languages_idx` (`languages_id`),
  KEY `fk_features_info_features1_idx` (`features_id`),
  CONSTRAINT `fk_features_info_features1` FOREIGN KEY (`features_id`) REFERENCES `x_features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_features_info_languages` FOREIGN KEY (`languages_id`) REFERENCES `x_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_features_info`
--

LOCK TABLES `x_features_info` WRITE;
/*!40000 ALTER TABLE `x_features_info` DISABLE KEYS */;
INSERT INTO `x_features_info` VALUES (19,11,1,'AAAA'),(20,11,2,'AAAA'),(21,12,1,'BBBB'),(22,12,2,'BBBB'),(23,13,1,'CCCC'),(24,13,2,'CCCC'),(25,14,1,'1'),(26,14,2,'1'),(27,15,1,'2'),(28,15,2,'2'),(29,16,1,'1'),(30,16,2,'1'),(31,17,1,'2'),(32,17,2,'2'),(33,18,1,'1'),(34,18,2,'1');
/*!40000 ALTER TABLE `x_features_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_languages`
--

DROP TABLE IF EXISTS `x_languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_languages` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `code` char(2) NOT NULL,
  `name` varchar(30) NOT NULL,
  `is_main` tinyint(1) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `is_main` (`is_main`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_languages`
--

LOCK TABLES `x_languages` WRITE;
/*!40000 ALTER TABLE `x_languages` DISABLE KEYS */;
INSERT INTO `x_languages` VALUES (1,'en','English',1),(2,'uk','Ukr',0);
/*!40000 ALTER TABLE `x_languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_nav`
--

DROP TABLE IF EXISTS `x_nav`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_nav` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `code` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_nav`
--

LOCK TABLES `x_nav` WRITE;
/*!40000 ALTER TABLE `x_nav` DISABLE KEYS */;
INSERT INTO `x_nav` VALUES (1,'Main','main');
/*!40000 ALTER TABLE `x_nav` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_nav_items`
--

DROP TABLE IF EXISTS `x_nav_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_nav_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nav_id` tinyint(3) unsigned NOT NULL,
  `content_id` int(10) unsigned NOT NULL DEFAULT '0',
  `parent_id` int(10) unsigned DEFAULT '0',
  `isfolder` tinyint(3) unsigned DEFAULT '0',
  `position` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `url` varchar(160) DEFAULT NULL,
  `display_children` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `published` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `css_class` varchar(30) DEFAULT NULL,
  `target` enum('_blank','_self') NOT NULL DEFAULT '_self',
  PRIMARY KEY (`id`,`nav_id`,`content_id`),
  KEY `fk_nav_items_nav1_idx` (`nav_id`),
  KEY `position` (`position`),
  KEY `published` (`published`),
  CONSTRAINT `fk_nav_items_nav1` FOREIGN KEY (`nav_id`) REFERENCES `x_nav` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_nav_items`
--

LOCK TABLES `x_nav_items` WRITE;
/*!40000 ALTER TABLE `x_nav_items` DISABLE KEYS */;
INSERT INTO `x_nav_items` VALUES (3,1,6,0,0,1,NULL,0,1,NULL,'_self'),(4,1,4,0,0,2,NULL,0,1,NULL,'_self'),(5,1,2,0,0,0,'',1,1,'','_self');
/*!40000 ALTER TABLE `x_nav_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_nav_items_info`
--

DROP TABLE IF EXISTS `x_nav_items_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_nav_items_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nav_items_id` int(10) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `title` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`,`nav_items_id`,`languages_id`),
  KEY `fk_nav_items_info_nav_items1_idx` (`nav_items_id`),
  KEY `fk_nav_items_info_languages1_idx` (`languages_id`),
  CONSTRAINT `fk_nav_items_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `x_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_nav_items_info_nav_items1` FOREIGN KEY (`nav_items_id`) REFERENCES `x_nav_items` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_nav_items_info`
--

LOCK TABLES `x_nav_items_info` WRITE;
/*!40000 ALTER TABLE `x_nav_items_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `x_nav_items_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_posts_tags`
--

DROP TABLE IF EXISTS `x_posts_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_posts_tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `posts_id` int(10) unsigned NOT NULL,
  `tags_id` int(10) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`,`posts_id`,`tags_id`,`languages_id`),
  KEY `fk_tags_posts_tags1_idx` (`tags_id`),
  KEY `fk_e_posts_tags_e_content_idx` (`posts_id`),
  KEY `fk_e_posts_tags_e_tags1_idx` (`tags_id`),
  KEY `fk_e_posts_tags_e_languages1_idx` (`languages_id`),
  CONSTRAINT `fk_e_posts_tags_e_content` FOREIGN KEY (`posts_id`) REFERENCES `x_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_e_posts_tags_e_languages1` FOREIGN KEY (`languages_id`) REFERENCES `x_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_e_posts_tags_e_tags1` FOREIGN KEY (`tags_id`) REFERENCES `x_tags` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_posts_tags`
--

LOCK TABLES `x_posts_tags` WRITE;
/*!40000 ALTER TABLE `x_posts_tags` DISABLE KEYS */;
INSERT INTO `x_posts_tags` VALUES (1,12,1,1),(2,16,1,1);
/*!40000 ALTER TABLE `x_posts_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_products`
--

DROP TABLE IF EXISTS `x_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` int(10) unsigned NOT NULL,
  `manufacturers_id` int(10) unsigned NOT NULL DEFAULT '0',
  `currency_id` tinyint(3) unsigned NOT NULL,
  `sku` varchar(60) DEFAULT NULL,
  `unit_id` int(10) unsigned DEFAULT NULL,
  `in_stock` tinyint(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`,`content_id`,`manufacturers_id`,`currency_id`),
  KEY `fk_x_products_x_content1_idx` (`content_id`),
  KEY `fk_x_products_x_currency1_idx` (`currency_id`),
  KEY `fk_x_products_x_content2_idx` (`manufacturers_id`),
  CONSTRAINT `fk_x_products_x_content1` FOREIGN KEY (`content_id`) REFERENCES `x_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_x_products_x_content2` FOREIGN KEY (`manufacturers_id`) REFERENCES `x_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_x_products_x_currency1` FOREIGN KEY (`currency_id`) REFERENCES `x_currency` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_products`
--

LOCK TABLES `x_products` WRITE;
/*!40000 ALTER TABLE `x_products` DISABLE KEYS */;
INSERT INTO `x_products` VALUES (1,35,40,1,'35werwerwerwerwer',37,0),(2,41,40,1,'41',37,0),(3,42,40,1,'42',37,1),(4,43,40,1,'43',37,0),(5,44,40,1,'44',37,0),(6,45,40,1,'45',37,0),(7,46,38,1,'46',37,0),(8,47,40,1,'47',37,0),(9,48,40,1,'48',37,0),(10,49,39,1,'49',37,0),(11,50,40,1,'50',37,0);
/*!40000 ALTER TABLE `x_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_products_prices`
--

DROP TABLE IF EXISTS `x_products_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_products_prices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `group_id` tinyint(3) unsigned NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `price_old` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`,`product_id`,`group_id`),
  UNIQUE KEY `product_id` (`product_id`,`group_id`),
  KEY `fk_products_prices_content1_idx` (`product_id`),
  KEY `fk_products_prices_users_group1_idx` (`group_id`),
  CONSTRAINT `fk_products_prices_content1` FOREIGN KEY (`product_id`) REFERENCES `x_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_products_prices_users_group1` FOREIGN KEY (`group_id`) REFERENCES `x_users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_products_prices`
--

LOCK TABLES `x_products_prices` WRITE;
/*!40000 ALTER TABLE `x_products_prices` DISABLE KEYS */;
INSERT INTO `x_products_prices` VALUES (1,35,2,23.00,NULL),(2,35,3,20.00,NULL),(3,41,2,12.00,NULL),(4,41,3,11.00,NULL),(5,42,2,14.00,NULL),(6,42,3,12.00,NULL),(7,43,2,50.00,NULL),(8,43,3,45.00,NULL),(9,44,2,10.00,NULL),(10,44,3,11.00,NULL),(11,45,2,15.00,NULL),(12,45,3,15.00,NULL),(13,46,2,12.00,NULL),(14,46,3,11.00,NULL),(15,47,2,12.00,NULL),(16,47,3,11.00,NULL),(17,48,2,14.00,NULL),(18,48,3,15.00,NULL),(19,49,2,12.00,NULL),(20,49,3,11.00,NULL),(21,50,2,12.00,NULL),(22,50,3,22.00,NULL);
/*!40000 ALTER TABLE `x_products_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_settings`
--

DROP TABLE IF EXISTS `x_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `value` longtext,
  `block` enum('company','common','images','themes','editor','content','seo','analitycs','robots','mail','') DEFAULT NULL,
  `type` enum('text','textarea','') DEFAULT NULL,
  `required` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `display` tinyint(1) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sname` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_settings`
--

LOCK TABLES `x_settings` WRITE;
/*!40000 ALTER TABLE `x_settings` DISABLE KEYS */;
INSERT INTO `x_settings` VALUES (1,'autofil_title','1','common','text',1,1),(2,'autofill_url','1','common','text',1,1),(3,'backend_url','cp','','text',1,0),(4,'editor_bodyId','cms_content','editor','text',1,1),(5,'editor_body_class','cms_content','editor','text',1,1),(6,'editor_contents_css','/themes/default/assets/css/style.css','editor','textarea',1,1),(9,'app_theme_current','shop','themes','text',1,1),(12,'themes_path','themes/','themes','text',1,1),(13,'content_images_dir','uploads/content/','images','text',1,1),(14,'content_images_thumb_dir','thumbs/','images','text',1,1),(15,'content_images_source_dir','source/','images','text',1,1),(17,'backend_theme','backend','themes','text',1,0),(19,'page_404','3','common','text',1,1),(20,'content_images_source_size','1600x1200','images','text',1,1),(21,'content_images_thumbs_size','125x125','images','text',1,1),(23,'content_images_quality','90','images','text',1,1),(24,'active','1','common','text',1,1),(25,'site_index','1','robots','text',1,1),(26,'robots_index_sample','# цей файл створено автоматично. Не редагуйте його вручну. Змінити його ви можете в розділі налаштування\n\nUser-agent: *\nDisallow:\n\nUser-agent: Yandex\nDisallow:\nHost: {app}\n\nSitemap: {appurl}route/XmlSitemap/index','robots','textarea',1,1),(28,'robots_no_index_sample','# цей файл створено автоматично. Не редагуйте його вручну. Змінити його ви можете в розділі налаштування\n\nUser-agent: *\nDisallow: /','robots','textarea',1,1),(29,'google_analytics_id','','analitycs','text',0,1),(30,'google_webmaster','','analitycs','text',0,1),(31,'yandex_webmaster','','analitycs','text',0,1),(32,'yandex_metric','','analitycs','text',0,1),(36,'mail_email_from','vh@otakoyi.com','mail','text',1,1),(37,'mail_email_to','vh@otakoyi.com','mail','text',1,1),(38,'mail_from_name','Simple Shop','mail','text',1,1),(39,'mail_header','','mail','textarea',0,1),(40,'mail_footer','','mail','textarea',0,1),(41,'mail_smtp_on','0','mail','text',1,1),(42,'mail_smtp_host','','mail','text',0,1),(43,'mail_smtp_port','','mail','text',0,1),(44,'mail_smtp_user','','mail','text',0,1),(45,'mail_smtp_password','','mail','text',0,1),(46,'mail_smtp_secure','tls','mail','text',0,1),(47,'company_name','Simple Shop','company','text',1,1),(48,'company_phone','','company','text',1,1),(50,'home_id','1','common','text',1,1),(52,'modules','a:4:{s:4:\"Blog\";a:1:{s:6:\"status\";s:7:\"enabled\";}s:5:\"Users\";a:1:{s:6:\"status\";s:7:\"enabled\";}s:8:\"Currency\";a:1:{s:6:\"status\";s:7:\"enabled\";}s:7:\"Catalog\";a:1:{s:6:\"status\";s:7:\"enabled\";}}','common','text',1,NULL),(53,'watermark_src','','images','text',1,NULL);
/*!40000 ALTER TABLE `x_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_tags`
--

DROP TABLE IF EXISTS `x_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tag` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_tags`
--

LOCK TABLES `x_tags` WRITE;
/*!40000 ALTER TABLE `x_tags` DISABLE KEYS */;
INSERT INTO `x_tags` VALUES (1,'lorem');
/*!40000 ALTER TABLE `x_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_users`
--

DROP TABLE IF EXISTS `x_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` tinyint(3) unsigned NOT NULL,
  `sessid` char(35) DEFAULT NULL,
  `name` varchar(60) NOT NULL,
  `surname` varchar(60) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(60) NOT NULL,
  `password` varchar(64) NOT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `skey` varchar(64) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime NOT NULL,
  `lastlogin` timestamp NULL DEFAULT NULL,
  `status` enum('active','ban','deleted') NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`,`group_id`),
  KEY `status` (`status`),
  KEY `skey` (`skey`),
  KEY `fk_users_users_group1_idx` (`group_id`),
  CONSTRAINT `fk_users_users_group1` FOREIGN KEY (`group_id`) REFERENCES `x_users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_users`
--

LOCK TABLES `x_users` WRITE;
/*!40000 ALTER TABLE `x_users` DISABLE KEYS */;
INSERT INTO `x_users` VALUES (1,1,'c9h42jqr61h0qblhs5eeuc7vs1','Admin','','','vh@otakoyi.com','MTTuFPm3y4m2o','/uploads/avatars/c4ca4238a0b923820dcc509a6f75849b.png','YToxNjp7czoyOiJpZCI7czoxOiIxIjtzOjg6Imdyb3VwX2lkIjtzOjE6IjEiO3M6','2017-05-15 15:37:36','2017-06-07 15:32:42','2017-06-20 11:54:00','active'),(4,2,'','Vlad','BBB','','vd1@otakoyi.com','MTTuFPm3y4m2o',NULL,'YToxNjp7czoyOiJpZCI7czoxOiI0IjtzOjg6Imdyb3VwX2lkIjtzOjE6IjIiO3M6','2017-06-07 07:01:05','2017-06-07 14:52:13','2017-06-07 10:21:55','active'),(5,2,'9k8r5ach7uulsvnk6jlmi3bjp3','Гривня','Hodiak','','zz@otakoyi.com','MjQCkqQenXh9E',NULL,NULL,'2017-06-09 13:21:23','2017-06-09 16:21:49','2017-06-09 13:21:23','active');
/*!40000 ALTER TABLE `x_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_users_group`
--

DROP TABLE IF EXISTS `x_users_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_users_group` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` tinyint(3) unsigned NOT NULL,
  `isfolder` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `backend` tinyint(1) unsigned DEFAULT NULL,
  `permissions` text,
  `position` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`parent_id`),
  KEY `sort` (`position`),
  KEY `isfolder` (`isfolder`),
  KEY `backend` (`backend`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_users_group`
--

LOCK TABLES `x_users_group` WRITE;
/*!40000 ALTER TABLE `x_users_group` DISABLE KEYS */;
INSERT INTO `x_users_group` VALUES (1,0,0,1,'a:1:{s:11:\"full_access\";s:1:\"1\";}',1),(2,0,0,0,'N;',0),(3,0,0,0,'N;',0);
/*!40000 ALTER TABLE `x_users_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_users_group_info`
--

DROP TABLE IF EXISTS `x_users_group_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_users_group_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` tinyint(3) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`,`group_id`,`languages_id`),
  KEY `fk_users_group_info_languages1_idx` (`languages_id`),
  KEY `fk_users_group_info_users_group_idx` (`group_id`),
  CONSTRAINT `fk_users_group_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `x_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_users_group_info_users_group` FOREIGN KEY (`group_id`) REFERENCES `x_users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_users_group_info`
--

LOCK TABLES `x_users_group_info` WRITE;
/*!40000 ALTER TABLE `x_users_group_info` DISABLE KEYS */;
INSERT INTO `x_users_group_info` VALUES (1,1,1,'Admins'),(2,2,1,'Guests'),(3,2,2,'Guests'),(4,3,1,'Dealer'),(5,3,2,'Dealer');
/*!40000 ALTER TABLE `x_users_group_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_users_meta`
--

DROP TABLE IF EXISTS `x_users_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `x_users_meta` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(11) unsigned NOT NULL,
  `meta_k` varchar(45) DEFAULT NULL,
  `meta_v` text,
  PRIMARY KEY (`id`,`users_id`),
  KEY `meta_k` (`meta_k`),
  KEY `fk_users_meta_users_idx` (`users_id`),
  CONSTRAINT `fk_users_meta_users` FOREIGN KEY (`users_id`) REFERENCES `x_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_users_meta`
--

LOCK TABLES `x_users_meta` WRITE;
/*!40000 ALTER TABLE `x_users_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `x_users_meta` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-20 16:02:10
