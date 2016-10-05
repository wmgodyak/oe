CREATE TABLE IF NOT EXISTS `__gps` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `value` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__gps_info` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `gps_id` INT(10) UNSIGNED NOT NULL,
  `__languages_id` TINYINT(3) UNSIGNED NOT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `gps_id`, `__languages_id`),
  INDEX `fk_gps_info_gps1_idx` (`gps_id` ASC),
  INDEX `fk_gps_info_languages1_idx` (`__languages_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;