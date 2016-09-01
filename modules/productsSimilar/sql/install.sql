CREATE TABLE IF NOT EXISTS `products_similar` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `products_id` INT(10) UNSIGNED NOT NULL,
  `features_id` INT(10) UNSIGNED NOT NULL,
  `values_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `products_id`, `features_id`, `values_id`),
  INDEX `fk_products_similar_e_content1_idx` (`products_id` ASC),
  INDEX `fk_products_similar_e_features1_idx` (`features_id` ASC),
  INDEX `fk_products_similar_e_features2_idx` (`values_id` ASC),
  CONSTRAINT `fk_products_similar_e_content1`
    FOREIGN KEY (`products_id`)
    REFERENCES `e_content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_products_similar_e_features1`
    FOREIGN KEY (`features_id`)
    REFERENCES `e_features` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_products_similar_e_features2`
    FOREIGN KEY (`values_id`)
    REFERENCES `e_features` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;