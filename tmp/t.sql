ALTER TABLE `products_variants`
DROP COLUMN `price`;

CREATE TABLE IF NOT EXISTS `products_variants_prices` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `products_variants_id` INT(10) UNSIGNED NOT NULL,
  `content_id` INT(10) UNSIGNED NOT NULL,
  `group_id` TINYINT(3) UNSIGNED NOT NULL,
  `price` DECIMAL UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `products_variants_id`, `content_id`, `group_id`),
  INDEX `fk_products_variants_prices_products_variants1_idx` (`products_variants_id` ASC, `content_id` ASC),
  INDEX `fk_products_variants_prices_users_group1_idx` (`group_id` ASC),
  CONSTRAINT `fk_products_variants_prices_products_variants1`
  FOREIGN KEY (`products_variants_id` , `content_id`)
  REFERENCES `products_variants` (`id` , `content_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_products_variants_prices_users_group1`
  FOREIGN KEY (`group_id`)
  REFERENCES `users_group` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8
  COLLATE = utf8_general_ci;
