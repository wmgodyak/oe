CREATE TABLE IF NOT EXISTS `__comments` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `content_id` INT(10) UNSIGNED NOT NULL,
  `users_id` INT(11) UNSIGNED NOT NULL,
  `parent_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `isfolder` TINYINT(3) UNSIGNED NOT NULL,
  `message` TEXT NOT NULL,
  `rate` DECIMAL(2,1) UNSIGNED NOT NULL DEFAULT '1.0',
  `likes` INT(10) UNSIGNED NOT NULL,
  `dislikes` INT(10) UNSIGNED NOT NULL,
  `status` ENUM('approved','spam','new') NOT NULL DEFAULT 'new',
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` CHAR(15) NULL DEFAULT NULL,
  `skey` VARCHAR(64) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `content_id`, `users_id`),
  INDEX `approved` (`status` ASC),
  INDEX `token` (`skey` ASC),
  INDEX `isfolder` (`isfolder` ASC),
  INDEX `fk_e_comments_e_content_idx` (`content_id` ASC),
  INDEX `fk_e_comments_e_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_e_comments_e_content`
    FOREIGN KEY (`content_id`)
    REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_comments_e_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `__users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__comments_likers` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `comments_id` INT(10) UNSIGNED NOT NULL,
  `users_id` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `comments_id`, `users_id`),
  INDEX `fk_e_comments_likers_e_comments1_idx` (`comments_id` ASC, `users_id` ASC),
  CONSTRAINT `fk_e_comments_likers_e_comments1`
    FOREIGN KEY (`comments_id` , `users_id`)
    REFERENCES `__comments` (`id` , `users_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__comments_subscribers` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `content_id` INT(10) UNSIGNED NOT NULL,
  `users_id` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `content_id`, `users_id`),
  INDEX `fk_comments_subscribe_content1_idx` (`content_id` ASC),
  INDEX `fk_e_comments_subscribers_e_content1_idx` (`content_id` ASC),
  INDEX `fk_e_comments_subscribers_e_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_e_comments_subscribers_e_content1`
    FOREIGN KEY (`content_id`)
    REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_comments_subscribers_e_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `__users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;