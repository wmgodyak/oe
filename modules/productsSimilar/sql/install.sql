CREATE TABLE IF NOT EXISTS `__products_similar` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `products_id` INT(10) UNSIGNED NOT NULL,
  `features_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `products_id`, `features_id`),
  INDEX `fk_e_products_similar_e_content1_idx` (`products_id` ASC),
  INDEX `fk_e_products_similar_e_features1_idx` (`features_id` ASC),
  CONSTRAINT `fk_e_products_similar_e_content1`
    FOREIGN KEY (`products_id`)
    REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_products_similar_e_features1`
    FOREIGN KEY (`features_id`)
    REFERENCES `__features` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;