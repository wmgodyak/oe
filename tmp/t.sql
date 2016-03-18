CREATE TABLE IF NOT EXISTS `content_relationship` (
  `id` INT NOT NULL,
  `content_id` INT(10) UNSIGNED NOT NULL,
  `categories_id` INT(10) UNSIGNED NOT NULL,
  `is_main` TINYINT(1) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `content_id`, `categories_id`),
  INDEX `fk_content_relationship_content1_idx` (`content_id` ASC),
  INDEX `fk_content_relationship_content2_idx` (`categories_id` ASC),
  CONSTRAINT `fk_content_relationship_content1`
  FOREIGN KEY (`content_id`)
  REFERENCES `content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_content_relationship_content2`
  FOREIGN KEY (`categories_id`)
  REFERENCES `content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB;