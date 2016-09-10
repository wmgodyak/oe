 -- вигрузити моделі модулів
 -- водяний знак
 INSERT INTO `engine`.`e_settings` (`id`, `name`, `value`, `block`, `type`, `required`, `display`) VALUES (NULL, 'watermark', '', 'images', 'text', '0', '1');
 ALTER TABLE `e_content_images_sizes` ADD `watermark` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' AFTER `quality`, ADD `watermark_opacity` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' AFTER `watermark`, ADD `watermark_position` ENUM('tl','tr','br','bl') NOT NULL AFTER `watermark_opacity`;