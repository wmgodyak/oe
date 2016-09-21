ALTER TABLE `e_content_meta` CHANGE `meta_v` `meta_v` VARCHAR(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL;
ALTER TABLE `e_content_meta` ADD INDEX(`meta_v`);
ALTER TABLE `e_content` ADD INDEX(`in_stock`);
ALTER TABLE `e_content` ADD INDEX(`currency_id`);