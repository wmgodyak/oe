CREATE TABLE IF NOT EXISTS `content_type` (
  `id` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` TINYINT(3) UNSIGNED NULL DEFAULT 0,
  `isfolder` TINYINT(1) UNSIGNED NULL DEFAULT 0,
  `type` VARCHAR(45) NOT NULL,
  `name` VARCHAR(60) NOT NULL,
  `settings` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `type_UNIQUE` (`type` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `content` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `content_type_id` TINYINT(3) UNSIGNED NOT NULL,
  `users_id` INT(11) UNSIGNED NOT NULL,
  `parent_id` INT(10) UNSIGNED NULL DEFAULT 0,
  `isfolder` TINYINT(1) UNSIGNED NULL DEFAULT 0,
  `position` TINYINT(3) UNSIGNED NULL DEFAULT 0,
  `created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `edited` TIMESTAMP NULL DEFAULT NULL,
  `status` ENUM('blank','draft', 'published', 'deleted') NULL DEFAULT 'blank',
  PRIMARY KEY (`id`, `content_type_id`, `users_id`),
  INDEX `fk_content_content_type1_idx` (`content_type_id` ASC),
  INDEX `fk_content_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_content_content_type1`
    FOREIGN KEY (`content_type_id`)
    REFERENCES `content_type` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_content_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `content_info` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `content_id` INT(10) UNSIGNED NOT NULL,
  `languages_id` TINYINT(3) UNSIGNED NOT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `url` VARCHAR(160) NULL DEFAULT NULL,
  `title` VARCHAR(255) NULL DEFAULT NULL,
  `h1` VARCHAR(255) NULL DEFAULT NULL,
  `keywords` VARCHAR(255) NULL DEFAULT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `content_id`, `languages_id`),
  INDEX `fk_content_info_content1_idx` (`content_id` ASC),
  INDEX `fk_content_info_languages1_idx` (`languages_id` ASC),
  CONSTRAINT `fk_content_info_content1`
    FOREIGN KEY (`content_id`)
    REFERENCES `content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_content_info_languages1`
    FOREIGN KEY (`languages_id`)
    REFERENCES `languages` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;