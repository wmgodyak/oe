CREATE TABLE IF NOT EXISTS `__currency` (
  `id` tinyint(3) unsigned NOT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `symbol` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_main` tinyint(1) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `e_currency` (`id`, `name`, `code`, `symbol`, `is_main`) VALUES
(1, 'Доляр', 'USD', '$', 1),
(2, 'Гривня', 'UAH', '₴', 0);

CREATE TABLE IF NOT EXISTS `__currency_rate` (
  `id` int(10) unsigned NOT NULL,
  `currency_id` tinyint(3) unsigned NOT NULL,
  `to_currency_id` tinyint(3) unsigned NOT NULL,
  `rate` decimal(10,4) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

ALTER TABLE `__currency`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `is_main` (`is_main`);

ALTER TABLE `__currency_rate`
  ADD PRIMARY KEY (`id`,`currency_id`,`to_currency_id`),
  ADD KEY `fk_currency_rate_currency1_idx` (`currency_id`),
  ADD KEY `fk_currency_rate_currency2_idx` (`to_currency_id`);

ALTER TABLE `__currency`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;

ALTER TABLE `__currency_rate`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
ALTER TABLE `__currency_rate`
  ADD CONSTRAINT `fk_currency_rate_currency1` FOREIGN KEY (`currency_id`) REFERENCES `__currency` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_currency_rate_currency2` FOREIGN KEY (`to_currency_id`) REFERENCES `__currency` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
