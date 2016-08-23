CREATE TABLE IF NOT EXISTS `__products_prices` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `content_id` INT(10) UNSIGNED NOT NULL,
  `group_id` TINYINT(3) UNSIGNED NOT NULL,
  `price` DECIMAL(10,2) NULL DEFAULT NULL,
  `price_old` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `content_id`, `group_id`),
  INDEX `fk_products_prices_users_group1_idx` (`group_id` ASC),
  INDEX `fk_e_products_prices_e_content1_idx` (`content_id` ASC),
  INDEX `fk_e_products_prices_e_users_group1_idx` (`group_id` ASC),
  CONSTRAINT `fk_e_products_prices_e_content1`
    FOREIGN KEY (`content_id`)
    REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_products_prices_e_users_group1`
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
  INDEX `fk_e_products_variants_e_content1_idx` (`content_id` ASC),
  CONSTRAINT `fk_e_products_variants_e_content1`
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
  INDEX `fk_e_products_variants_features_e_products_variants1_idx` (`variants_id` ASC),
  INDEX `fk_e_products_variants_features_e_features1_idx` (`features_id` ASC),
  INDEX `fk_e_products_variants_features_e_features2_idx` (`values_id` ASC),
  CONSTRAINT `fk_e_products_variants_features_e_products_variants1`
    FOREIGN KEY (`variants_id`)
    REFERENCES `__products_variants` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_products_variants_features_e_features1`
    FOREIGN KEY (`features_id`)
    REFERENCES `__features` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_products_variants_features_e_features2`
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
  INDEX `fk_e_products_variants_prices_e_products_variants1_idx` (`variants_id` ASC),
  INDEX `fk_e_products_variants_prices_e_content1_idx` (`content_id` ASC),
  INDEX `fk_e_products_variants_prices_e_users_group1_idx` (`group_id` ASC),
  CONSTRAINT `fk_e_products_variants_prices_e_products_variants1`
    FOREIGN KEY (`variants_id`)
    REFERENCES `__products_variants` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_products_variants_prices_e_content1`
    FOREIGN KEY (`content_id`)
    REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_products_variants_prices_e_users_group1`
    FOREIGN KEY (`group_id`)
    REFERENCES `__users_group` (`id`)
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
  PRIMARY KEY (`id`, `__search_history_id`),
  UNIQUE INDEX `search_history_id` (`date` ASC),
  INDEX `fk_e_search_history_stat_e_search_history_idx` (`__search_history_id` ASC),
  CONSTRAINT `fk_e_search_history_stat_e_search_history`
    FOREIGN KEY (`__search_history_id`)
    REFERENCES `__search_history` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;
