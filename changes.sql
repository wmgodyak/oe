ALTER TABLE  `e_orders_status_history` CHANGE  `id`  `id` INT( 11 ) NOT NULL AUTO_INCREMENT ;
DROP TABLE `e_mail_templates`, `e_mail_templates_info`;
ALTER TABLE `e_content` ADD `quantity` TINYINT(3) UNSIGNED NULL DEFAULT NULL AFTER `unit_id`, ADD INDEX (`quantity`);