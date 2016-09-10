CREATE TABLE IF NOT EXISTS `e_products_similar` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `categories_id` INT(10) UNSIGNED NOT NULL,
  `features_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `categories_id`, `features_id`),
  INDEX `fk_e_products_similar_e_content1_idx` (`categories_id` ASC),
  INDEX `fk_e_products_similar_e_features1_idx` (`features_id` ASC),
  CONSTRAINT `fk_e_products_similar_e_content1`
  FOREIGN KEY (`categories_id`)
  REFERENCES `e_content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_products_similar_e_features1`
  FOREIGN KEY (`features_id`)
  REFERENCES `e_features` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8;