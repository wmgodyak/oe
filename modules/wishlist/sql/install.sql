CREATE TABLE IF NOT EXISTS `__wishlist` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `users_id` INT(11) UNSIGNED NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `users_id`),
  INDEX `fk_e_wishlist_e_users_idx` (`users_id` ASC),
  CONSTRAINT `fk_e_wishlist_e_users`
    FOREIGN KEY (`users_id`)
    REFERENCES `__users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__wishlist_products` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `wishlist_id` INT(10) UNSIGNED NOT NULL,
  `products_id` INT(10) UNSIGNED NOT NULL,
  `variants_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `wishlist_id`, `products_id`),
  UNIQUE INDEX `wishlist_id` (`variants_id` ASC),
  INDEX `variants_id` (`variants_id` ASC),
  INDEX `fk_e_wishlist_products_e_wishlist1_idx` (`wishlist_id` ASC),
  INDEX `fk_e_wishlist_products_e_content1_idx` (`products_id` ASC),
  CONSTRAINT `fk_e_wishlist_products_e_wishlist1`
    FOREIGN KEY (`wishlist_id`)
    REFERENCES `__wishlist` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_wishlist_products_e_content1`
    FOREIGN KEY (`products_id`)
    REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;