CREATE TABLE IF NOT EXISTS `engine`.`products_similar` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `products_id` INT(10) UNSIGNED NOT NULL,
  `features_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `products_id`, `features_id`),
  INDEX `fk_products_similar_content1_idx` (`products_id` ASC),
  INDEX `fk_products_similar_features1_idx` (`features_id` ASC),
  CONSTRAINT `fk_products_similar_content1`
  FOREIGN KEY (`products_id`)
  REFERENCES `engine`.`content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_products_similar_features1`
  FOREIGN KEY (`features_id`)
  REFERENCES `engine`.`features` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB