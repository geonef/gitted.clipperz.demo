/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `onetimepassword` (
  `onetimepasswordid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `onetimepasswordstatusid` int(11) NOT NULL,
  `reference` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `key_checksum` varchar(255) NOT NULL,
  `data` text NOT NULL,
  `version` varchar(255) NOT NULL,
  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `request_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `usage_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`onetimepasswordid`),
  KEY `userid` (`userid`,`onetimepasswordstatusid`)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

