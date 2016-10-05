CREATE TABLE IF NOT EXISTS `__orders` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `oid` VARCHAR(45) NULL DEFAULT NULL,
  `status_id` INT(10) UNSIGNED NOT NULL,
  `manager_id` INT(11) NULL DEFAULT NULL,
  `one_click` TINYINT(1) UNSIGNED NULL DEFAULT '0',
  `users_id` INT(11) UNSIGNED NOT NULL,
  `users_group_id` TINYINT(3) UNSIGNED NOT NULL,
  `languages_id` TINYINT(3) UNSIGNED NOT NULL,
  `currency_id` TINYINT(3) UNSIGNED NOT NULL,
  `comment` VARCHAR(255) NULL DEFAULT NULL,
  `currency_rate` DECIMAL(10,4) NOT NULL,
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
  PRIMARY KEY (`id`, `users_id`, `users_group_id`, `languages_id`, `currency_id`),
  UNIQUE INDEX `oid` (`oid` ASC),
  INDEX `status_id` (`status_id` ASC),
  INDEX `external_id` (`external_id` ASC),
  INDEX `ex_date` (`ex_date` ASC),
  INDEX `edited` (`edited` ASC),
  INDEX `fk_e_orders_e_users1_idx` (`users_id` ASC, `languages_id` ASC, `users_group_id` ASC),
  CONSTRAINT `fk_e_orders_e_users1`
    FOREIGN KEY (`users_id` , `languages_id` , `users_group_id`)
    REFERENCES `__users` (`id` , `languages_id` , `group_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
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
  INDEX `fk_e_orders_products_e_orders1_idx` (`orders_id` ASC),
  INDEX `fk_e_orders_products_e_content1_idx` (`products_id` ASC),
  CONSTRAINT `fk_e_orders_products_e_orders1`
    FOREIGN KEY (`orders_id`)
    REFERENCES `__orders` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_orders_products_e_content1`
    FOREIGN KEY (`products_id`)
    REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 105
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__orders_status` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `bg_color` CHAR(7) NULL DEFAULT NULL,
  `txt_color` VARCHAR(7) NULL DEFAULT NULL,
  `on_site` TINYINT(1) UNSIGNED NULL DEFAULT NULL,
  `external_id` VARCHAR(64) NULL DEFAULT NULL,
  `is_main` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `external_id_2` (`external_id` ASC),
  INDEX `on_site` (`on_site` ASC),
  INDEX `external_id` (`external_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__orders_status_info` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `languages_id` TINYINT(3) UNSIGNED NOT NULL,
  `status_id` INT(10) UNSIGNED NOT NULL,
  `status` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `languages_id`, `status_id`),
  INDEX `fk_e_orders_status_info_e_orders_status_idx` (`status_id` ASC),
  INDEX `fk_e_orders_status_info_e_languages1_idx` (`languages_id` ASC),
  CONSTRAINT `fk_e_orders_status_info_e_orders_status`
    FOREIGN KEY (`status_id`)
    REFERENCES `__orders_status` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_orders_status_info_e_languages1`
    FOREIGN KEY (`languages_id`)
    REFERENCES `__languages` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__orders_status_history` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `orders_id` INT(10) UNSIGNED NOT NULL,
  `status_id` INT(10) UNSIGNED NOT NULL,
  `manager_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `comment` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `orders_id`, `status_id`),
  INDEX `manager_id` (`manager_id` ASC),
  INDEX `fk_e_orders_status_history_e_orders1_idx` (`orders_id` ASC),
  INDEX `fk_e_orders_status_history_e_orders_status1_idx` (`status_id` ASC),
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
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

INSERT INTO `__orders_status` (`id`, `bg_color`, `txt_color`, `on_site`, `external_id`, `is_main`) VALUES
(1, '#bef50c', '#ffffff', 1, 'blank', 0),
(2, '#066e0e', '#ffffff', 1, 'new', 1),
(3, '#04440d', '#f3f20c', 1, 'accepted', 0),
(4, '#fe0000', '#b7ff09', 1, 'canceled', 0),
(6, '#ffffff', '#000000', 1, 'ok', 0),
(7, '#00a808', '#000000', 1, 'send', 0),
(8, '#0bd0e7', '#000000', 1, 'delivered', 0),
(11, '#2ffc17', '#633af2', 0, 'close', 0);


INSERT INTO `__orders_status_info` (`id`, `status_id`, `languages_id`, `status`) VALUES
(1, 1, 1, 'Чорновик'),
(2, 2, 1, 'Нове'),
(3, 3, 1, 'Опрацьовується менеджером'),
(4, 4, 1, 'Скасовано'),
(5, 6, 1, 'Перевірено'),
(6, 7, 1, 'Відправлено'),
(7, 8, 1, 'Отримано'),
(8, 11, 1, 'Закрито');

CREATE TABLE IF NOT EXISTS `__orders_kits` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `orders_id` INT(10) UNSIGNED NOT NULL,
  `kits_id` INT(10) UNSIGNED NOT NULL,
  `kits_products_id` INT(10) UNSIGNED NOT NULL,
  `kits_products_price` DECIMAL(10,2) UNSIGNED NULL DEFAULT NULL,
  `quantity` TINYINT(3) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `orders_id`, `kits_id`, `kits_products_id`),
  INDEX `fk_e_orders_kits_e_orders_idx` (`orders_id` ASC),
  INDEX `fk_e_orders_kits_e_kits1_idx1` (`kits_id` ASC, `kits_products_id` ASC),
  CONSTRAINT `fk_e_orders_kits_e_orders`
    FOREIGN KEY (`orders_id`)
    REFERENCES `__orders` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_orders_kits_e_kits1`
    FOREIGN KEY (`kits_id` , `kits_products_id`)
    REFERENCES `__kits` (`id` , `products_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
CREATE TABLE IF NOT EXISTS `__orders_kits_products` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `orders_kits_id` INT(10) UNSIGNED NOT NULL,
  `price_original` DECIMAL(10,2) NULL DEFAULT NULL,
  `discount` TINYINT(3) NULL DEFAULT NULL,
  `price` DECIMAL(10,2) NULL DEFAULT NULL,
  `kits_products_id` INT(11) UNSIGNED NOT NULL,
  `kits_products_kits_id` INT(10) UNSIGNED NOT NULL,
  `kits_products_products_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `orders_kits_id`, `kits_products_id`, `kits_products_kits_id`, `kits_products_products_id`),
  INDEX `fk_e_orders_kits_products_e_orders_kits1_idx1` (`orders_kits_id` ASC),
  INDEX `fk_e_orders_kits_products_e_kits_products1_idx` (`kits_products_id` ASC, `kits_products_kits_id` ASC, `kits_products_products_id` ASC),
  CONSTRAINT `fk_e_orders_kits_products_e_orders_kits1`
    FOREIGN KEY (`orders_kits_id`)
    REFERENCES `__orders_kits` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_orders_kits_products_e_kits_products1`
    FOREIGN KEY (`kits_products_id` , `kits_products_kits_id` , `kits_products_products_id`)
    REFERENCES `__kits_products` (`id` , `kits_id` , `products_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

INSERT INTO `__content_types` (`parent_id`, `isfolder`, `type`, `name`, `is_main`, `settings`) VALUES
(1, 0, 'checkout', 'Checkout', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}'),
(1, 0, 'cart', 'Cart', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}');