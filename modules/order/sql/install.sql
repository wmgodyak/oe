CREATE TABLE IF NOT EXISTS `e_orders` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `oid` VARCHAR(45) NULL DEFAULT NULL,
  `languages_id` TINYINT(3) UNSIGNED NOT NULL,
  `manager_id` INT(11) NULL DEFAULT NULL,
  `one_click` TINYINT(1) UNSIGNED NULL DEFAULT 0,
  `users_id` INT(11) UNSIGNED NOT NULL,
  `users_group_id` TINYINT(3) UNSIGNED NOT NULL,
  `comment` VARCHAR(255) NULL DEFAULT NULL,
  `created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `paid` TINYINT(1) UNSIGNED NULL DEFAULT NULL,
  `paid_date` TIMESTAMP NULL DEFAULT NULL,
  `payment_id` TINYINT(3) NULL DEFAULT NULL,
  `delivery_id` TINYINT(3) NULL DEFAULT NULL,
  `delivery_state_id` INT(11) NULL DEFAULT NULL,
  `delivery_city_id` INT(11) NULL DEFAULT NULL,
  `delivery_department_id` INT(11) NULL DEFAULT NULL,
  `delivery_cost` DECIMAL(10,2) NULL DEFAULT NULL,
  `prepayment` DECIMAL(10,2) NULL DEFAULT NULL,
  `delivery_address` VARCHAR(45) NULL DEFAULT NULL,
  `pay_shipping` VARCHAR(45) NULL DEFAULT NULL,
  `pay_return_shipping` VARCHAR(45) NULL DEFAULT NULL,
  `delivery_back` VARCHAR(45) NULL DEFAULT NULL,
  `edited` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `languages_id`, `users_id`, `users_group_id`),
  INDEX `fk_orders_languages1_idx` (`languages_id` ASC),
  INDEX `fk_orders_users1_idx` (`users_id` ASC, `users_group_id` ASC),
  CONSTRAINT `fk_orders_languages1`
    FOREIGN KEY (`languages_id`)
    REFERENCES `e_languages` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_users1`
    FOREIGN KEY (`users_id` , `users_group_id`)
    REFERENCES `e_users` (`id` , `group_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `orders_products` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `orders_id` INT(10) UNSIGNED NOT NULL,
  `products_id` INT(10) UNSIGNED NOT NULL,
  `variants_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `quantity` INT(10) UNSIGNED NULL DEFAULT NULL,
  `price` DECIMAL(10,2) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `orders_id`, `products_id`),
  INDEX `fk_orders_products_orders1_idx` (`orders_id` ASC),
  INDEX `fk_orders_products_content1_idx` (`products_id` ASC),
  CONSTRAINT `fk_orders_products_orders1`
    FOREIGN KEY (`orders_id`)
    REFERENCES `e_orders` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_products_content1`
    FOREIGN KEY (`products_id`)
    REFERENCES `e_content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
  COLLATE = utf8_general_ci;