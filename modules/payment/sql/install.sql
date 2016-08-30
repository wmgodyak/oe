CREATE TABLE IF NOT EXISTS `__payment` (
  `id` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `published` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  `module` VARCHAR(60) NOT NULL,
  `settings` TEXT NULL DEFAULT NULL,
  `position` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  INDEX `module` (`module` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__payment_info` (
  `id` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `payment_id` TINYINT(3) UNSIGNED NOT NULL,
  `languages_id` TINYINT(3) UNSIGNED NOT NULL,
  `name` VARCHAR(60) NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `payment_id`, `languages_id`),
  INDEX `fk_e_payment_info_e_payment_idx` (`payment_id` ASC),
  INDEX `fk_e_payment_info_e_languages1_idx` (`languages_id` ASC),
  CONSTRAINT `fk_e_payment_info_e_payment`
    FOREIGN KEY (`payment_id`)
    REFERENCES `__payment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_e_payment_info_e_languages1`
    FOREIGN KEY (`languages_id`)
    REFERENCES `__languages` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;