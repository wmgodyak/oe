CREATE TABLE IF NOT EXISTS `__newsletter_subscribers` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NULL,
  `status` ENUM('unconfirmed', 'confirmed', 'ban') NULL DEFAULT 'unconfirmed',
  `code` VARCHAR(45) NULL,
  `created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `confirmdate` TIMESTAMP NULL,
  `ip` VARCHAR(20) NULL,
  `form` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC))
ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `__newsletter_subscribers_meta` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `subscribers_id` INT UNSIGNED NOT NULL,
  `meta_k` VARCHAR(45) NULL,
  `meta_v` VARCHAR(500) NULL,
  PRIMARY KEY (`id`, `subscribers_id`),
  INDEX `fk_newsletter_subscribers_meta_newsletter_subscribers1_idx` (`subscribers_id` ASC),
  CONSTRAINT `fk_newsletter_subscribers_meta_newsletter_subscribers1`
  FOREIGN KEY (`subscribers_id`)
  REFERENCES `__newsletter_subscribers` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `__newsletter_subscribers_group` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id`))
  ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `__newsletter_subscribers_group_subscribers` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `group_id` INT UNSIGNED NOT NULL,
  `subscribers_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `group_id`, `subscribers_id`),
  INDEX `fk_newsletter_subscribers_group_subscribers_newsletter_subs_idx` (`group_id` ASC),
  INDEX `fk_newsletter_subscribers_group_subscribers_newsletter_subs_idx1` (`subscribers_id` ASC),
  CONSTRAINT `fk_newsletter_subscribers_group_subscribers_newsletter_subscr1`
  FOREIGN KEY (`group_id`)
  REFERENCES `__newsletter_subscribers_group` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_newsletter_subscribers_group_subscribers_newsletter_subscr2`
  FOREIGN KEY (`subscribers_id`)
  REFERENCES `__newsletter_subscribers` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `__newsletter_campaigns` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `sender_name` VARCHAR(45) NULL DEFAULT NULL,
  `sender_email` VARCHAR(45) NULL DEFAULT NULL ,
  `status` ENUM('new','in_progress','completed') NULL DEFAULT 'new',
  PRIMARY KEY (`id`)
  )
  ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `__newsletter_campaigns_info` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `campaigns_id` INT UNSIGNED NOT NULL,
  `languages_id` TINYINT(3) UNSIGNED NOT NULL,
  `subject` VARCHAR(255) NULL DEFAULT NULL,
  `textbody` TEXT NULL DEFAULT NULL,
  `htmlbody` TEXT NULL,
  PRIMARY KEY (`id`, `campaigns_id`, `languages_id`),
  INDEX `fk_campaigns_info_campaigns1_idx` (`campaigns_id` ASC),
  INDEX `fk_campaigns_info_languages1_idx` (`languages_id` ASC),
  CONSTRAINT `fk_campaigns_info_campaigns1`
  FOREIGN KEY (`campaigns_id`)
  REFERENCES `__newsletter_campaigns` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_campaigns_info_e_languages1`
  FOREIGN KEY (`languages_id`)
  REFERENCES `__languages` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `__newsletter_campaigns_subscribers_groups` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `campaigns_id` INT(10) UNSIGNED NOT NULL,
  `group_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `campaigns_id`, `group_id`),
  INDEX `fk_e_newsletter_campaigns_subscribers_groups_newsletter_c_idx` (`campaigns_id` ASC),
  INDEX `fk_e_newsletter_campaigns_subscribers_groups_newsletter_s_idx` (`group_id` ASC),
  CONSTRAINT `fk_e_newsletter_campaigns_subscribers_groups_newsletter_cam1`
  FOREIGN KEY (`campaigns_id`)
  REFERENCES `__newsletter_campaigns` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_newsletter_campaigns_subscribers_groups_newsletter_sub1`
  FOREIGN KEY (`group_id`)
  REFERENCES `__newsletter_subscribers_group` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `__newsletter_queues` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `campaigns_id` INT(10) UNSIGNED NOT NULL,
  `subscribers_id` INT(10) UNSIGNED NOT NULL,
  `processed` TINYINT(1) UNSIGNED NULL,
  `sent` TINYINT(1) UNSIGNED NULL,
  `sent_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `campaigns_id`, `subscribers_id`),
  INDEX `fk_e_newsletter_queues_newsletter_campaigns1_idx` (`campaigns_id` ASC),
  INDEX `fk_e_newsletter_queues_newsletter_subscribers1_idx` (`subscribers_id` ASC),
  CONSTRAINT `fk_e_newsletter_queues_newsletter_campaigns1`
  FOREIGN KEY (`campaigns_id`)
  REFERENCES `__newsletter_campaigns` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_newsletter_queues_newsletter_subscribers1`
  FOREIGN KEY (`subscribers_id`)
  REFERENCES `__newsletter_subscribers` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE `__newsletter_subscribers_group_subscribers` ADD UNIQUE( `group_id`, `subscribers_id`);
