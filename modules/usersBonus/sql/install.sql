CREATE TABLE IF NOT EXISTS `__users_bonus` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `users_id` INT(11) UNSIGNED NOT NULL,
  `orders_id` INT(10) UNSIGNED NOT NULL,
  `bonus` DECIMAL(10,2) NULL DEFAULT NULL,
  `created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `users_id`, `orders_id`),
  INDEX `fk_users_bonus_e_users1_idx` (`users_id` ASC),
  INDEX `fk_users_bonus_e_orders1_idx` (`orders_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;