
CREATE TABLE IF NOT EXISTS `orders_status` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bg_color` char(7) DEFAULT NULL,
  `txt_color` varchar(7) DEFAULT NULL,
  `on_site` tinyint(1) unsigned DEFAULT NULL,
  `external_id` varchar(64) DEFAULT NULL,
  `notify` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_main` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `on_site` (`on_site`),
  KEY `external_id` (`external_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `orders_status_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status_id` int(10) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`,`status_id`,`languages_id`),
  KEY `fk_orders_status_info_languages1_idx` (`languages_id`),
  KEY `fk_orders_status_info_orders_status1_idx` (`status_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

ALTER TABLE `orders_status_info`
ADD CONSTRAINT `fk_orders_status_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_orders_status_info_orders_status1` FOREIGN KEY (`status_id`) REFERENCES `orders_status` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;