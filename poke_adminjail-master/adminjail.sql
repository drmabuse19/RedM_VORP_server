CREATE TABLE IF NOT EXISTS `user_jail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(100) NOT NULL DEFAULT '0',
  `characterid` INT NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL DEFAULT '0',
  `admin_name` varchar(100) NOT NULL DEFAULT '0',
  `admin_identifier` varchar(100) NOT NULL DEFAULT '0',
  `time` varchar(100) NOT NULL DEFAULT '0',
  `time_s` varchar(100) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
