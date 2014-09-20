/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `srp_s` varchar(255) NOT NULL,
  `srp_v` varchar(255) NOT NULL,
  `header` longtext NOT NULL,
  `statistics` longtext NOT NULL,
  `auth_version` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `lock` varchar(255) NOT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=MyISAM AUTO_INCREMENT=52 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

