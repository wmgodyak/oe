CREATE TABLE IF NOT EXISTS `__banners_places` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(45) NULL DEFAULT NULL,
  `name` VARCHAR(60) NULL DEFAULT NULL,
  `width` INT(11) NULL DEFAULT NULL,
  `height` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__banners` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `places_id` INT(10) UNSIGNED NOT NULL,
  `languages_id` TINYINT(3) UNSIGNED NOT NULL,
  `skey` VARCHAR(32) NOT NULL,
  `img` VARCHAR(255) NULL DEFAULT NULL,
  `name` VARCHAR(40) NOT NULL,
  `published` TINYINT(1) UNSIGNED NULL DEFAULT 1,
  `permanent` TINYINT(1) UNSIGNED NULL DEFAULT 1,
  `df` DATE NULL DEFAULT NULL,
  `dt` DATE NULL DEFAULT NULL,
  `url` VARCHAR(200) NULL DEFAULT NULL,
  `target` ENUM('_blank','_self') NULL DEFAULT '_self',
  PRIMARY KEY (`id`, `places_id`, `languages_id`),
  UNIQUE INDEX `skey_UNIQUE` (`skey` ASC),
  INDEX `fk_e_banners_e_banners_places_idx` (`places_id` ASC),
  INDEX `fk_e_banners_e_languages1_idx` (`languages_id` ASC),
  CONSTRAINT `fk_e_banners_e_banners_places`
    FOREIGN KEY (`places_id`)
    REFERENCES `__banners_places` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_banners_e_languages1`
    FOREIGN KEY (`languages_id`)
    REFERENCES `__languages` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;