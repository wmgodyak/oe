
CREATE TABLE IF NOT EXISTS `__tags` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tag` VARCHAR(60) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__posts_tags` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `posts_id` INT(10) UNSIGNED NOT NULL,
  `tags_id` INT(10) UNSIGNED NOT NULL,
  `languages_id` TINYINT(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `posts_id`, `tags_id`, `languages_id`),
  INDEX `fk_tags_posts_tags1_idx` (`tags_id` ASC),
  INDEX `fk_e_posts_tags_e_content_idx` (`posts_id` ASC),
  INDEX `fk_e_posts_tags_e_tags1_idx` (`tags_id` ASC),
  INDEX `fk_e_posts_tags_e_languages1_idx` (`languages_id` ASC),
  CONSTRAINT `fk_e_posts_tags_e_content`
  FOREIGN KEY (`posts_id`)
  REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_posts_tags_e_tags1`
  FOREIGN KEY (`tags_id`)
  REFERENCES `__tags` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_posts_tags_e_languages1`
  FOREIGN KEY (`languages_id`)
  REFERENCES `__languages` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8;

INSERT INTO `__content_types` (`parent_id`, `isfolder`, `type`, `name`, `is_main`, `settings`) VALUES
  ( 0, 0, 'blog_post', 'Posts', NULL, NULL),
  ( 0, 0, 'blog_category', 'PostsCategories', NULL, NULL);