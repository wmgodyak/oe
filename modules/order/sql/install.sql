CREATE TABLE IF NOT EXISTS `__orders_status` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `bg_color` CHAR(7) NULL DEFAULT NULL,
  `txt_color` VARCHAR(7) NULL DEFAULT NULL,
  `on_site` TINYINT(1) UNSIGNED NULL DEFAULT NULL,
  `_xternal_id` VARCHAR(64) NULL DEFAULT NULL,
  `is_main` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `_xternal_id_2` (`_xternal_id` ASC),
  INDEX `on_site` (`on_site` ASC),
  INDEX `_xternal_id` (`_xternal_id` ASC))
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__orders_status_info` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `status_id` INT(10) UNSIGNED NOT NULL,
  `languages_id` TINYINT(3) UNSIGNED NOT NULL,
  `status` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `status_id`, `languages_id`),
  INDEX `fk_orders_status_info_languages1_idx` (`languages_id` ASC),
  INDEX `fk_orders_status_info_orders_status1_idx` (`status_id` ASC),
  CONSTRAINT `fk_orders_status_info_languages1`
  FOREIGN KEY (`languages_id`)
  REFERENCES `__languages` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_status_info_orders_status1`
  FOREIGN KEY (`status_id`)
  REFERENCES `__orders_status` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__orders` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `oid` VARCHAR(45) NULL DEFAULT NULL,
  `languages_id` TINYINT(3) UNSIGNED NOT NULL,
  `status_id` INT(10) UNSIGNED NOT NULL,
  `manager_id` INT(11) NULL DEFAULT NULL,
  `one_click` TINYINT(1) UNSIGNED NULL DEFAULT '0',
  `users_id` INT(11) UNSIGNED NOT NULL,
  `users_group_id` TINYINT(3) UNSIGNED NOT NULL,
  `currency_id` TINYINT(3) UNSIGNED NOT NULL,
  `currency_rate` DECIMAL(10,4) NOT NULL,
  `comment` VARCHAR(255) NULL DEFAULT NULL,
  `created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `paid` TINYINT(1) UNSIGNED NULL DEFAULT NULL,
  `paid_date` TIMESTAMP NULL DEFAULT NULL,
  `payment_id` TINYINT(3) NULL DEFAULT NULL,
  `delivery_id` TINYINT(3) NULL DEFAULT NULL,
  `delivery_region_id` INT(11) NULL DEFAULT NULL,
  `delivery_city_id` INT(11) NULL DEFAULT NULL,
  `delivery_department_id` INT(11) NULL DEFAULT NULL,
  `delivery_cost` DECIMAL(10,2) NULL DEFAULT NULL,
  `prepayment` DECIMAL(10,2) NULL DEFAULT NULL,
  `delivery_address` VARCHAR(45) NULL DEFAULT NULL,
  `pay_shipping` VARCHAR(45) NULL DEFAULT NULL,
  `pay_return_shipping` VARCHAR(45) NULL DEFAULT NULL,
  `delivery_back` VARCHAR(45) NULL DEFAULT NULL,
  `edited` TIMESTAMP NULL DEFAULT NULL,
  `ex_date` TIMESTAMP NULL DEFAULT NULL,
  `external_id` VARCHAR(64) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `languages_id`, `users_id`, `users_group_id`, `currency_id`),
  UNIQUE INDEX `oid` (`oid` ASC),
  INDEX `status_id` (`status_id` ASC),
  INDEX `external_id` (`external_id` ASC),
  INDEX `ex_date` (`ex_date` ASC),
  INDEX `edited` (`edited` ASC))
  ENGINE = InnoDB
  AUTO_INCREMENT = 37
  DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__orders_products` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `orders_id` INT(10) UNSIGNED NOT NULL,
  `products_id` INT(10) UNSIGNED NOT NULL,
  `variants_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `quantity` INT(10) UNSIGNED NULL DEFAULT NULL,
  `price` DECIMAL(10,2) UNSIGNED NULL DEFAULT NULL,
  `external_id` VARCHAR(64) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `orders_id`, `products_id`),
  INDEX `external_id` (`external_id` ASC),
  INDEX `fk_orders_products_content1` (`products_id` ASC),
  INDEX `fk_orders_products_orders1` (`orders_id` ASC),
  CONSTRAINT `fk_orders_products_content1`
  FOREIGN KEY (`products_id`)
  REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_products_orders1`
  FOREIGN KEY (`orders_id`)
  REFERENCES `__orders` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  AUTO_INCREMENT = 8
  DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__orders_status_history` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `orders_id` INT(10) UNSIGNED NOT NULL,
  `status_id` INT(10) UNSIGNED NOT NULL,
  `manager_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `comment` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `status_id`, `orders_id`),
  INDEX `fk_e_orders_status_history_e_orders_status1_idx` (`status_id` ASC),
  INDEX `fk_e_orders_status_history_e_orders1_idx` (`orders_id` ASC),
  INDEX `manager_id` (`manager_id` ASC),
  CONSTRAINT `fk_e_orders_status_history_e_orders1`
  FOREIGN KEY (`orders_id`)
  REFERENCES `__orders` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_orders_status_history_e_orders_status1`
  FOREIGN KEY (`status_id`)
  REFERENCES `__orders_status` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  AUTO_INCREMENT = 10
  DEFAULT CHARACTER SET = utf8;