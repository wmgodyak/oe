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

-- add content types

-- products accessories

CREATE TABLE IF NOT EXISTS `e_products_accessories` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `products_categories_id` INT(10) UNSIGNED NOT NULL,
  `categories_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `products_categories_id`, `categories_id`),
  INDEX `fk_products_accessories_e_content1_idx` (`products_categories_id` ASC),
  INDEX `fk_products_accessories_e_content2_idx` (`categories_id` ASC),
  CONSTRAINT `fk_products_accessories_e_content1`
    FOREIGN KEY (`products_categories_id`)
    REFERENCES `e_content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_products_accessories_e_content2`
    FOREIGN KEY (`categories_id`)
    REFERENCES `e_content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `e_products_accessories_features` (
  `id` INT NOT NULL,
  `products_accessories_id` INT UNSIGNED NOT NULL,
  `features_id` INT(10) UNSIGNED NOT NULL,
  `values` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `products_accessories_id`, `features_id`),
  INDEX `fk_products_accessories_features_products_accessories1_idx` (`products_accessories_id` ASC),
  INDEX `fk_products_accessories_features_e_features1_idx` (`features_id` ASC),
  CONSTRAINT `fk_products_accessories_features_products_accessories1`
  FOREIGN KEY (`products_accessories_id`)
  REFERENCES `e_products_accessories` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_products_accessories_features_e_features1`
  FOREIGN KEY (`features_id`)
  REFERENCES `e_features` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB;


  CREATE TABLE IF NOT EXISTS `e_kits` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `products_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `products_id`),
  INDEX `fk_kits_e_content1_idx` (`products_id` ASC),
  CONSTRAINT `fk_kits_e_content1`
    FOREIGN KEY (`products_id`)
    REFERENCES `e_content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `e_kits_products` (
  `id` INT NOT NULL,
  `kits_id` INT UNSIGNED NOT NULL,
  `products_id` INT(10) UNSIGNED NOT NULL,
  `discount` TINYINT(3) UNSIGNED NULL,
  PRIMARY KEY (`id`, `kits_id`, `products_id`),
  INDEX `fk_kits_products_kits1_idx` (`kits_id` ASC),
  INDEX `fk_kits_products_e_content1_idx` (`products_id` ASC),
  CONSTRAINT `fk_kits_products_kits1`
    FOREIGN KEY (`kits_id`)
    REFERENCES `e_kits` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_kits_products_e_content1`
    FOREIGN KEY (`products_id`)
    REFERENCES `e_content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `e_orders_kits` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `orders_id` INT(10) UNSIGNED NOT NULL,
  `kits_id` INT(10) UNSIGNED NOT NULL,
  `kits_products_id` INT(10) UNSIGNED NOT NULL,
  `kits_products_price` DECIMAL(10,2) UNSIGNED NULL,
  `quantity` TINYINT UNSIGNED NULL,
  PRIMARY KEY (`id`, `orders_id`, `kits_id`, `kits_products_id`),
  INDEX `fk_e_orders_kits_e_orders1_idx` (`orders_id` ASC),
  INDEX `fk_e_orders_kits_e_kits1_idx` (`kits_id` ASC, `kits_products_id` ASC),
  CONSTRAINT `fk_e_orders_kits_e_orders1`
    FOREIGN KEY (`orders_id`)
    REFERENCES `e_orders` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_orders_kits_e_kits1`
    FOREIGN KEY (`kits_id` , `kits_products_id`)
    REFERENCES `e_kits` (`id` , `products_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `e_orders_kits_products` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `orders_kits_id` INT UNSIGNED NOT NULL,
  `kits_products_id` INT(11) UNSIGNED NOT NULL,
  `kits_products_kits_id` INT(10) UNSIGNED NOT NULL,
  `kits_products_products_id` INT(10) UNSIGNED NOT NULL,
  `price_original` DECIMAL(10,2) NULL,
  `discount` TINYINT(3) NULL,
  `price` DECIMAL(10,2) NULL,
  PRIMARY KEY (`id`, `orders_kits_id`, `kits_products_id`, `kits_products_kits_id`, `kits_products_products_id`),
  INDEX `fk_e_orders_kits_products_e_orders_kits1_idx` (`orders_kits_id` ASC),
  INDEX `fk_e_orders_kits_products1_e_kits_products1_idx` (`kits_products_id` ASC, `kits_products_kits_id` ASC, `kits_products_products_id` ASC),
  CONSTRAINT `fk_e_orders_kits_products_e_orders_kits1`
  FOREIGN KEY (`orders_kits_id`)
  REFERENCES `e_orders_kits` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_orders_kits_products1_e_kits_products1`
  FOREIGN KEY (`kits_products_id` , `kits_products_kits_id` , `kits_products_products_id`)
  REFERENCES `e_kits_products` (`id` , `kits_id` , `products_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB