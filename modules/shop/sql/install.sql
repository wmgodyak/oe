CREATE TABLE IF NOT EXISTS `__search_history` (
  `id` int(10) unsigned NOT NULL,
  `q` varchar(45) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `__search_history_stat` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `search_history_id` int(10) unsigned NOT NULL,
  `date` date DEFAULT CURRENT_DATE,
  `hits` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


ALTER TABLE `e_search_history_stat`
ADD CONSTRAINT `fk_search_history_stat_search_guery1` FOREIGN KEY (`search_history_id`)
REFERENCES `e_search_history` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;