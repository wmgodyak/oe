CREATE TABLE IF NOT EXISTS `__delivery` (
  `id` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `free_from` DECIMAL(10,2) UNSIGNED NOT NULL DEFAULT '0.00',
  `price` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  `module` VARCHAR(30) NULL DEFAULT NULL,
  `settings` TEXT NULL DEFAULT NULL,
  `published` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;
CREATE TABLE IF NOT EXISTS `__delivery_info` (
  `id` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `delivery_id` TINYINT(3) UNSIGNED NOT NULL,
  `languages_id` TINYINT(3) UNSIGNED NOT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `delivery_id`, `languages_id`),
  INDEX `fk_e_delivery_info_e_languages_idx` (`languages_id` ASC),
  INDEX `fk_e_delivery_info_e_delivery1_idx` (`delivery_id` ASC),
  CONSTRAINT `fk_e_delivery_info_e_languages`
    FOREIGN KEY (`languages_id`)
    REFERENCES `__languages` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_delivery_info_e_delivery1`
    FOREIGN KEY (`delivery_id`)
    REFERENCES `__delivery` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;