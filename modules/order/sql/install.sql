CREATE TABLE IF NOT EXISTS `e_orders` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `oid` VARCHAR(45) NULL DEFAULT NULL,
  `languages_id` TINYINT(3) UNSIGNED NOT NULL,
  `status_id` INT(10) UNSIGNED NOT NULL,
  `manager_id` INT(11) NULL DEFAULT NULL,
  `one_click` TINYINT(1) UNSIGNED NULL DEFAULT '0',
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
  PRIMARY KEY (`id`, `languages_id`, `status_id`, `users_id`, `users_group_id`),
  UNIQUE INDEX `oid` (`oid` ASC),
  INDEX `fk_orders_languages1_idx` (`languages_id` ASC),
  INDEX `fk_orders_users1_idx` (`users_id` ASC, `users_group_id` ASC),
  INDEX `fk_e_orders_e_orders_status1_idx` (`status_id` ASC),
  CONSTRAINT `fk_orders_languages1`
  FOREIGN KEY (`languages_id`)
  REFERENCES `e_languages` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_users1`
  FOREIGN KEY (`users_id` , `users_group_id`)
  REFERENCES `e_users` (`id` , `group_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_orders_e_orders_status1`
  FOREIGN KEY (`status_id`)
  REFERENCES `e_orders_status` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  AUTO_INCREMENT = 2
  DEFAULT CHARACTER SET = utf8;

ALTER TABLE e_orders ADD CONSTRAINT fk_status_id FOREIGN KEY (status_id) REFERENCES e_orders_status(id);

