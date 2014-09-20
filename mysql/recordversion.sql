/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recordversion` (
  `recordversionid` int(11) NOT NULL AUTO_INCREMENT,
  `recordid` int(11) NOT NULL,
  `reference` varchar(255) NOT NULL,
  `header` longtext NOT NULL,
  `data` longtext NOT NULL,
  `version` varchar(255) NOT NULL,
  `previous_version_key` varchar(255) NOT NULL,
  `previous_version_id` int(11) NOT NULL,
  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `access_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`recordversionid`),
  KEY `recordid` (`recordid`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

