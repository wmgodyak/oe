INSERT INTO `__content_types` (`parent_id`, `isfolder`, `type`, `name`, `is_main`, `settings`) VALUES
  (0, 0, 'product', 'Product', NULL, NULL),
  (0, 0, 'products_categories', 'Products Categories', NULL, NULL);

CREATE TABLE IF NOT EXISTS `__products` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `content_id` INT(10) UNSIGNED NOT NULL,
  `currency_id` TINYINT(3) UNSIGNED NOT NULL,
  `sku` VARCHAR(60) NULL,
  `unit_id` INT(10) UNSIGNED NULL,
  `quantity` TINYINT(3) UNSIGNED NULL,
  `has_variants` TINYINT(1) UNSIGNED NULL,
  `in_stock` TINYINT(1) UNSIGNED NULL,
  `external_id` VARCHAR(45) NULL,
  PRIMARY KEY (`id`, `content_id`, `currency_id`),
  INDEX `fk_x_products_x_content1_idx` (`content_id` ASC),
  INDEX `fk_x_products_x_currency1_idx` (`currency_id` ASC),
  CONSTRAINT `fk_x_products_x_content1`
  FOREIGN KEY (`content_id`)
  REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_x_products_x_currency1`
  FOREIGN KEY (`currency_id`)
  REFERENCES `__currency` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `__products_accessories` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `products_categories_id` INT(10) UNSIGNED NOT NULL,
  `categories_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `products_categories_id`, `categories_id`),
  INDEX `fk_products_accessories_e_content1_idx` (`products_categories_id` ASC),
  INDEX `fk_products_accessories_e_content2_idx` (`categories_id` ASC),
  CONSTRAINT `fk_products_accessories_e_content1`
    FOREIGN KEY (`products_categories_id`)
    REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_products_accessories_e_content2`
    FOREIGN KEY (`categories_id`)
    REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `__products_accessories_features` (
  `id` INT NOT NULL,
  `products_accessories_id` INT UNSIGNED NOT NULL,
  `features_id` INT(10) UNSIGNED NOT NULL,
  `features_values` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `products_accessories_id`, `features_id`),
  INDEX `fk_products_accessories_features_products_accessories1_idx` (`products_accessories_id` ASC),
  INDEX `fk_products_accessories_features_e_features1_idx` (`features_id` ASC),
  CONSTRAINT `fk_products_accessories_features_products_accessories1`
  FOREIGN KEY (`products_accessories_id`)
  REFERENCES `__products_accessories` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_products_accessories_features_e_features1`
  FOREIGN KEY (`features_id`)
  REFERENCES `__features` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `__products_prices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` int(10) unsigned NOT NULL,
  `group_id` tinyint(3) unsigned NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `price_old` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`,`content_id`,`group_id`),
  UNIQUE KEY `content_id` (`content_id`,`group_id`),
  KEY `fk_products_prices_content1_idx` (`content_id`),
  KEY `fk_products_prices_users_group1_idx` (`group_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;

ALTER TABLE `__products_prices`
ADD CONSTRAINT `fk_products_prices_content1` FOREIGN KEY (`content_id`) REFERENCES `__content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_products_prices_users_group1` FOREIGN KEY (`group_id`) REFERENCES `__users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE IF NOT EXISTS `__products_variants` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` int(10) unsigned NOT NULL,
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


  CREATE TABLE IF NOT EXISTS `__kits` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `products_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `products_id`),
  INDEX `fk_kits_e_content1_idx` (`products_id` ASC),
  CONSTRAINT `fk_kits_e_content1`
    FOREIGN KEY (`products_id`)
    REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `__kits_products` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `kits_id` INT UNSIGNED NOT NULL,
  `products_id` INT(10) UNSIGNED NOT NULL,
  `discount` TINYINT(3) UNSIGNED NULL,
  PRIMARY KEY (`id`, `kits_id`, `products_id`),
  INDEX `fk_kits_products_kits1_idx` (`kits_id` ASC),
  INDEX `fk_kits_products_e_content1_idx` (`products_id` ASC),
  CONSTRAINT `fk_kits_products_kits1`
    FOREIGN KEY (`kits_id`)
    REFERENCES `__kits` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_kits_products_e_content1`
    FOREIGN KEY (`products_id`)
    REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;