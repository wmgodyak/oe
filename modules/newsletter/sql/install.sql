CREATE TABLE IF NOT EXISTS `e_newsletter_subscribers` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NULL,
  `status` ENUM('unconfirmed', 'confirmed', 'ban', 'unsubscribed') NULL DEFAULT 'unconfirmed',
  `code` VARCHAR(45) NULL,
  `created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `confirmdate` TIMESTAMP NULL,
  `ip` VARCHAR(20) NULL,
  `form` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `e_newsletter_subscribers_meta` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `subscribers_id` INT UNSIGNED NOT NULL,
  `meta_k` VARCHAR(45) NULL,
  `meta_v` VARCHAR(500) NULL,
  PRIMARY KEY (`id`, `subscribers_id`),
  INDEX `fk_newsletter_subscribers_meta_newsletter_subscribers1_idx` (`subscribers_id` ASC),
  CONSTRAINT `fk_newsletter_subscribers_meta_newsletter_subscribers1`
  FOREIGN KEY (`subscribers_id`)
  REFERENCES `e_newsletter_subscribers` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `e_newsletter_subscribers_group` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id`))
  ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `e_newsletter_subscribers_group_subscribers` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `group_id` INT UNSIGNED NOT NULL,
  `subscribers_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `group_id`, `subscribers_id`),
  INDEX `fk_newsletter_subscribers_group_subscribers_newsletter_subs_idx` (`group_id` ASC),
  INDEX `fk_newsletter_subscribers_group_subscribers_newsletter_subs_idx1` (`subscribers_id` ASC),
  CONSTRAINT `fk_newsletter_subscribers_group_subscribers_newsletter_subscr1`
  FOREIGN KEY (`group_id`)
  REFERENCES `e_newsletter_subscribers_group` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_newsletter_subscribers_group_subscribers_newsletter_subscr2`
  FOREIGN KEY (`subscribers_id`)
  REFERENCES `e_newsletter_subscribers` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `e_newsletter_campaigns` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `status` ENUM('active', 'closed') NULL DEFAULT 'active',
  PRIMARY KEY (`id`))
  ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `e_newsletter_campaigns_info` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `campaigns_id` INT UNSIGNED NOT NULL,
  `e_languages_id` TINYINT(3) UNSIGNED NOT NULL,
  `textbody` TEXT NULL DEFAULT NULL,
  `htmlbody` TEXT NULL,
  PRIMARY KEY (`id`, `campaigns_id`, `e_languages_id`),
  INDEX `fk_campaigns_info_campaigns1_idx` (`campaigns_id` ASC),
  INDEX `fk_campaigns_info_e_languages1_idx` (`e_languages_id` ASC),
  CONSTRAINT `fk_campaigns_info_campaigns1`
  FOREIGN KEY (`campaigns_id`)
  REFERENCES `e_newsletter_campaigns` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_campaigns_info_e_languages1`
  FOREIGN KEY (`e_languages_id`)
  REFERENCES `e_languages` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB;
