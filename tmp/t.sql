
CREATE TABLE IF NOT EXISTS `engine`.`features` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `isfolder` TINYINT(1) UNSIGNED NULL DEFAULT 0,
  `type` ENUM('text', 'textarea', 'select', 'file') NULL DEFAULT NULL,
  `code` VARCHAR(45) NOT NULL,
  `multiple` TINYINT(1) NULL DEFAULT NULL,
  `on_filter` TINYINT(1) NULL DEFAULT 0,
  `owner_id` INT(11) UNSIGNED NOT NULL DEFAULT NULL,
  `created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `status` ENUM('blank', 'published') NULL DEFAULT 'blank',
  PRIMARY KEY (`id`, `owner_id`),
  INDEX `fk_features_users1_idx` (`owner_id` ASC),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  CONSTRAINT `fk_features_users1`
    FOREIGN KEY (`owner_id`)
    REFERENCES `engine`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `engine`.`features_info` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `features_id` INT(10) UNSIGNED NOT NULL,
  `languages_id` TINYINT(3) UNSIGNED NOT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `features_id`, `languages_id`),
  INDEX `fk_features_info_features1_idx` (`features_id` ASC),
  INDEX `fk_features_info_languages1_idx` (`languages_id` ASC),
  CONSTRAINT `fk_features_info_features1`
    FOREIGN KEY (`features_id`)
    REFERENCES `engine`.`features` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_features_info_languages1`
    FOREIGN KEY (`languages_id`)
    REFERENCES `engine`.`languages` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `engine`.`content_types_features` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `types_id` TINYINT(3) UNSIGNED NOT NULL,
  `features_id` INT(10) UNSIGNED NOT NULL,
  `position` TINYINT(3) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `types_id`, `features_id`),
  INDEX `fk_content_types_features_content_types1_idx` (`types_id` ASC),
  INDEX `fk_content_types_features_features1_idx` (`features_id` ASC),
  CONSTRAINT `fk_content_types_features_content_types1`
    FOREIGN KEY (`types_id`)
    REFERENCES `engine`.`content_types` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_content_types_features_features1`
    FOREIGN KEY (`features_id`)
    REFERENCES `engine`.`features` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `engine`.`content_features` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `features_id` INT(10) UNSIGNED NOT NULL,
  `content_id` INT(10) UNSIGNED NOT NULL,
  `position` TINYINT(3) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `features_id`, `content_id`),
  INDEX `fk_content_features_features1_idx` (`features_id` ASC),
  INDEX `fk_content_features_content1_idx` (`content_id` ASC),
  CONSTRAINT `fk_content_features_features1`
    FOREIGN KEY (`features_id`)
    REFERENCES `engine`.`features` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_content_features_content1`
    FOREIGN KEY (`content_id`)
    REFERENCES `engine`.`content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `engine`.`content_features_values` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `content_id` INT(10) UNSIGNED NOT NULL,
  `features_id` INT(10) UNSIGNED NOT NULL,
  `languages_id` TINYINT(3) UNSIGNED NOT NULL DEFAULT 0,
  `value` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `content_id`, `features_id`),
  INDEX `fk_content_features_values_content1_idx` (`content_id` ASC),
  INDEX `fk_content_features_values_features1_idx` (`features_id` ASC),
  CONSTRAINT `fk_content_features_values_content1`
    FOREIGN KEY (`content_id`)
    REFERENCES `engine`.`content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_content_features_values_features1`
    FOREIGN KEY (`features_id`)
    REFERENCES `engine`.`features` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;