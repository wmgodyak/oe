CREATE TABLE IF NOT EXISTS `__content_images` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `content_id` INT(10) UNSIGNED NOT NULL,
  `path` VARCHAR(255) NOT NULL,
  `image` VARCHAR(255) NOT NULL,
  `position` TINYINT(5) UNSIGNED NOT NULL,
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `content_id`),
  INDEX `position` (`position` ASC),
  INDEX `fk_content_images_content1_idx` (`content_id` ASC),
  CONSTRAINT `fk_content_images_content1`
  FOREIGN KEY (`content_id`)
  REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__content_images_sizes` (
  `id` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `size` VARCHAR(16) NOT NULL,
  `width` INT(5) UNSIGNED NOT NULL,
  `height` INT(5) UNSIGNED NOT NULL,
  `quality` TINYINT(3) UNSIGNED NOT NULL,
  `watermark` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  `watermark_position` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `size` (`size` ASC))
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8;
CREATE TABLE IF NOT EXISTS `__content_types_images_sizes` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `types_id` TINYINT(3) UNSIGNED NOT NULL,
  `images_sizes_id` TINYINT(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `types_id`, `images_sizes_id`),
  INDEX `fk_content_types_images_sizes_content_images_sizes1_idx` (`images_sizes_id` ASC),
  CONSTRAINT `fk_content_types_images_sizes_content_images_sizes1`
  FOREIGN KEY (`images_sizes_id`)
  REFERENCES `__content_images_sizes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8;


