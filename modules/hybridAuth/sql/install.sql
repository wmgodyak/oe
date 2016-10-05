CREATE TABLE IF NOT EXISTS `__users_hybridauth` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `provider` VARCHAR(15) NULL DEFAULT NULL,
  `profile_id` INT(10) UNSIGNED NOT NULL,
  `meta` TEXT NULL DEFAULT NULL,
  `__users_id` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `__users_id`),
  INDEX `fk_e_users_hybridauth_e_users_idx` (`__users_id` ASC),
  CONSTRAINT `fk_e_users_hybridauth_e_users`
    FOREIGN KEY (`__users_id`)
    REFERENCES `__users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;