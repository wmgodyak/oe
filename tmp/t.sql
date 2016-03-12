CREATE TABLE IF NOT EXISTS `features_content` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `features_id` INT(10) UNSIGNED NOT NULL,
  `content_types_id` TINYINT(3) UNSIGNED NOT NULL,
  `content_subtypes_id` TINYINT(3) UNSIGNED NULL,
  `content_id` INT(10) UNSIGNED NULL,
  `position` TINYINT(3) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `features_id`, `content_types_id`, `content_subtypes_id`, `content_id`),
  INDEX `fk_content_features_idx` (`features_id` ASC),
  INDEX `features_content` (`content_id` ASC, `content_types_id` ASC, `content_subtypes_id` ASC),
  CONSTRAINT `fk_content_features_idx`
  FOREIGN KEY (`features_id`)
  REFERENCES `features` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8