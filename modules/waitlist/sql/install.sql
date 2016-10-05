CREATE TABLE IF NOT EXISTS `__waitlist` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `products_id` INT(10) UNSIGNED NOT NULL,
  `variants_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `products_id`),
  UNIQUE INDEX `products_id` (`products_id` ASC, `variants_id` ASC, `email` ASC),
  INDEX `fk_waitlist_e_content1_idx` (`products_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8