
CREATE TABLE IF NOT EXISTS `languages` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `code` char(2) NOT NULL,
  `name` varchar(30) NOT NULL,
  `is_main` tinyint(1) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `is_main` (`is_main`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


CREATE TABLE IF NOT EXISTS `users_group` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` tinyint(3) unsigned NOT NULL,
  `rang` smallint(3) unsigned NOT NULL,
  `sort` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`parent_id`),
  KEY `sort` (`sort`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `users_group_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` tinyint(3) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` tinytext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`languages_id`),
  KEY `fk_users_group_info_users_group1_idx` (`group_id`),
  KEY `fk_users_group_info_languages1_idx` (`languages_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` tinyint(3) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `sessid` char(35) NOT NULL,
  `name` varchar(60) NOT NULL,
  `surname` varchar(60) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(60) NOT NULL,
  `password` varchar(64) NOT NULL,
  `skey` varchar(35) NOT NULL,
  `created` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `edited` datetime NOT NULL,
  PRIMARY KEY (`id`,`group_id`,`languages_id`),
  UNIQUE KEY `phone` (`phone`,`email`),
  KEY `fk_users_group1_idx` (`group_id`),
  KEY `fk_users_languages1_idx` (`languages_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


ALTER TABLE `users`
ADD CONSTRAINT `fk_users_languages1` FOREIGN KEY (`languages_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_users_users_group1` FOREIGN KEY (`group_id`) REFERENCES `users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `users_group_info`
ADD CONSTRAINT `fk_users_group_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_users_group_info_users_group1` FOREIGN KEY (`group_id`) REFERENCES `users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;