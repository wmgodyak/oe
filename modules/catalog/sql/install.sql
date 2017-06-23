INSERT INTO `__content_types` (`parent_id`, `isfolder`, `type`, `name`, `is_main`, `settings`) VALUES
  (0, 0, 'shop_product', 'Shop category', NULL, NULL),
  (0, 0, 'shop_manufacturer', 'Shop manufacturer', NULL, NULL),
  (0, 0, 'shop_category', 'Shop categories', NULL, NULL);

CREATE TABLE IF NOT EXISTS `__products` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `content_id` INT(10) UNSIGNED NOT NULL,
  `manufacturers_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `currency_id` TINYINT(3) UNSIGNED NOT NULL,
  `sku` VARCHAR(60) NULL DEFAULT NULL,
  `unit_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `quantity` TINYINT(3) UNSIGNED NULL DEFAULT NULL,
  `has_variants` TINYINT(1) UNSIGNED NULL DEFAULT NULL,
  `in_stock` TINYINT(1) UNSIGNED NULL DEFAULT NULL,
  `external_id` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `content_id`, `manufacturers_id`, `currency_id`),
  INDEX `fk_x_products_x_content1_idx` (`content_id` ASC),
  INDEX `fk_x_products_x_currency1_idx` (`currency_id` ASC),
  INDEX `fk_x_products_x_content2_idx` (`manufacturers_id` ASC),
  CONSTRAINT `fk_x_products_x_content1`
    FOREIGN KEY (`content_id`)
    REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_x_products_x_currency1`
    FOREIGN KEY (`currency_id`)
    REFERENCES `__currency` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_x_products_x_content2`
    FOREIGN KEY (`manufacturers_id`)
    REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8


CREATE TABLE IF NOT EXISTS `__products_prices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `group_id` tinyint(3) unsigned NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `price_old` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`,`product_id`,`group_id`),
  UNIQUE KEY `product_id` (`product_id`,`group_id`),
  KEY `fk_products_prices_content1_idx` (`product_id`),
  KEY `fk_products_prices_users_group1_idx` (`group_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;

ALTER TABLE `__products_prices`
ADD CONSTRAINT `fk_products_prices_content1` FOREIGN KEY (`product_id`) REFERENCES `__content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_products_prices_users_group1` FOREIGN KEY (`group_id`) REFERENCES `__users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;



CREATE TABLE IF NOT EXISTS `__products_variants` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` int(10) unsigned NOT NULL,
  `sku` VARCHAR( 30 ) DEFAULT NULL ,
  `in_stock` tinyint(1) DEFAULT '1',
  `img` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`content_id`),
  KEY `fk_products_variants_content1_idx` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `__products_variants_features` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `variants_id` int(10) unsigned NOT NULL,
  `features_id` int(10) unsigned NOT NULL,
  `values_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`,`variants_id`,`features_id`,`values_id`),
  UNIQUE KEY `variants_id` (`variants_id`,`features_id`,`values_id`),
  KEY `fk_products_variants_features_features1_idx` (`features_id`),
  KEY `fk_products_variants_features_products_variants1_idx` (`variants_id`),
  KEY `fk_products_variants_features_features2_idx` (`values_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `__products_variants_prices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `variants_id` int(10) unsigned NOT NULL,
  `content_id` int(10) unsigned NOT NULL,
  `group_id` tinyint(3) unsigned NOT NULL,
  `price` decimal(10,2) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`,`variants_id`,`content_id`,`group_id`),
  UNIQUE KEY `variants_id` (`variants_id`,`content_id`,`group_id`),
  KEY `fk_products_variants_prices_products_variants1_idx` (`variants_id`,`content_id`),
  KEY `fk_products_variants_prices_users_group1_idx` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


ALTER TABLE `__products_variants`
ADD CONSTRAINT `fk_products_variants_content1` FOREIGN KEY (`content_id`) REFERENCES `__content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `__products_variants_features`
ADD CONSTRAINT `fk_products_variants_features_features1` FOREIGN KEY (`features_id`) REFERENCES `__features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_products_variants_features_features2` FOREIGN KEY (`values_id`) REFERENCES `__features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_products_variants_features_products_variants1` FOREIGN KEY (`variants_id`) REFERENCES `__products_variants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `__products_variants_prices`
ADD CONSTRAINT `fk_products_variants_prices_products_variants1` FOREIGN KEY (`variants_id`, `content_id`) REFERENCES `__products_variants` (`id`, `content_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_products_variants_prices_users_group1` FOREIGN KEY (`group_id`) REFERENCES `__users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;