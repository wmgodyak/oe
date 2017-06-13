INSERT INTO `__content_types` (`parent_id`, `isfolder`, `type`, `name`, `is_main`, `settings`) VALUES
  (0, 0, 'shop_product', 'Shop category', NULL, NULL),
  (0, 0, 'shop_category', 'Shop categories', NULL, NULL);

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
