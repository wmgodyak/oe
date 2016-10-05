INSERT INTO `__content_types` (`parent_id`, `isfolder`, `type`, `name`, `is_main`, `settings`) VALUES
  (0, 0, 'products_categories', 'Shop ProductsCategories', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}'),
  (0, 0, 'product', 'Shop Product', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}'),
  (1, 0, 'search', 'Shop Search', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}'),
  (1, 0, 'comparison', 'Shop Products comparison', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}');

CREATE TABLE IF NOT EXISTS `__products_prices` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `content_id` INT(10) UNSIGNED NOT NULL,
  `group_id` TINYINT(3) UNSIGNED NOT NULL,
  `price` DECIMAL(10,2) UNSIGNED NULL DEFAULT 0,
  `price_old` DECIMAL(10,2) UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`id`, `content_id`, `group_id`),
  INDEX `fk_products_prices_users_group1_idx` (`group_id` ASC),
  INDEX `fk_products_prices_content_idx` (`content_id` ASC),
  INDEX `fk_products_prices_users_group1_idx` (`group_id` ASC),
  CONSTRAINT `fk_products_prices_content`
  FOREIGN KEY (`content_id`)
  REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_products_prices_users_group1`
  FOREIGN KEY (`group_id`)
  REFERENCES `__users_group` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__products_variants` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `content_id` INT(10) UNSIGNED NOT NULL,
  `in_stock` TINYINT(1) NULL DEFAULT '1',
  `img` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `content_id`),
  INDEX `fk_products_variants_content_idx` (`content_id` ASC),
  CONSTRAINT `fk_products_variants_content`
  FOREIGN KEY (`content_id`)
  REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__products_variants_features` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `variants_id` INT(10) UNSIGNED NOT NULL,
  `features_id` INT(10) UNSIGNED NOT NULL,
  `values_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `variants_id`, `features_id`, `values_id`),
  INDEX `fk_products_variants_features_features2_idx` (`values_id` ASC),
  INDEX `fk_products_variants_features_products_variants1_idx` (`variants_id` ASC),
  INDEX `fk_products_variants_features_features1_idx` (`features_id` ASC),
  INDEX `fk_products_variants_features_features2_idx` (`values_id` ASC),
  CONSTRAINT `fk_products_variants_features_products_variants1`
  FOREIGN KEY (`variants_id`)
  REFERENCES `__products_variants` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_products_variants_features_features1`
  FOREIGN KEY (`features_id`)
  REFERENCES `__features` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_products_variants_features_features2`
  FOREIGN KEY (`values_id`)
  REFERENCES `__features` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8;
CREATE TABLE IF NOT EXISTS `__products_variants_prices` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `variants_id` INT(10) UNSIGNED NOT NULL,
  `content_id` INT(10) UNSIGNED NOT NULL,
  `group_id` TINYINT(3) UNSIGNED NOT NULL,
  `price` DECIMAL(10,2) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `variants_id`, `content_id`, `group_id`),
  INDEX `fk_products_variants_prices_users_group1_idx` (`group_id` ASC),
  INDEX `fk_e_products_variants_prices_e_products_variants1_idx` (`variants_id` ASC, `content_id` ASC),
  INDEX `fk_e_products_variants_prices_e_users_group1_idx` (`group_id` ASC),
  CONSTRAINT `fk_e_products_variants_prices_e_products_variants1`
  FOREIGN KEY (`variants_id` , `content_id`)
  REFERENCES `__products_variants` (`id` , `content_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_products_variants_prices_e_users_group1`
  FOREIGN KEY (`group_id`)
  REFERENCES `__users_group` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__kits` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `products_id` INT(10) UNSIGNED NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`, `products_id`),
  INDEX `fk_e_kits_e_content_idx` (`products_id` ASC),
  CONSTRAINT `fk_e_kits_e_content`
  FOREIGN KEY (`products_id`)
  REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__kits_products` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `kits_id` INT(10) UNSIGNED NOT NULL,
  `products_id` INT(10) UNSIGNED NOT NULL,
  `discount` TINYINT(3) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `kits_id`, `products_id`),
  INDEX `fk_e_kits_products_e_kits1_idx` (`kits_id` ASC, `products_id` ASC),
  CONSTRAINT `fk_e_kits_products_e_kits1`
  FOREIGN KEY (`kits_id` , `products_id`)
  REFERENCES `__kits` (`id` , `products_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__products_accessories` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `products_categories_id` INT(10) UNSIGNED NOT NULL,
  `categories_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `products_categories_id`, `categories_id`),
  INDEX `fk_products_accessories_e_content2_idx` (`categories_id` ASC),
  INDEX `fk_e_products_accessories_e_content_idx` (`products_categories_id` ASC),
  INDEX `fk_e_products_accessories_e_content1_idx` (`categories_id` ASC),
  CONSTRAINT `fk_e_products_accessories_e_content`
  FOREIGN KEY (`products_categories_id`)
  REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_products_accessories_e_content1`
  FOREIGN KEY (`categories_id`)
  REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__products_accessories_features` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `products_accessories_id` INT(10) UNSIGNED NOT NULL,
  `features_values` TEXT CHARACTER SET 'utf8' NULL DEFAULT NULL,
  `features_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `products_accessories_id`, `features_id`),
  INDEX `fk_products_accessories_features_e_features1_idx` (`features_id` ASC),
  INDEX `fk_e_products_accessories_features_e_products_accessories1_idx` (`products_accessories_id` ASC),
  INDEX `fk_e_products_accessories_features_e_features1_idx` (`features_id` ASC),
  CONSTRAINT `fk_e_products_accessories_features_e_products_accessories1`
  FOREIGN KEY (`products_accessories_id`)
  REFERENCES `__products_accessories` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_products_accessories_features_e_features1`
  FOREIGN KEY (`features_id`)
  REFERENCES `__features` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__search_history` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `q` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `q` (`q` ASC))
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__search_history_stat` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `search_history_id` INT(10) UNSIGNED NOT NULL,
  `date` DATE NULL DEFAULT NULL,
  `hits` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `search_history_id`),
  UNIQUE INDEX `search_history_id` (`date` ASC),
  INDEX `fk_e_search_history_stat_e_search_history_idx` (`search_history_id` ASC),
  CONSTRAINT `fk_e_search_history_stat_e_search_history`
  FOREIGN KEY (`search_history_id`)
  REFERENCES `__search_history` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8;