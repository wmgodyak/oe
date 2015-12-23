
CREATE TABLE IF NOT EXISTS `languages` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `code` char(2) NOT NULL,
  `name` varchar(30) NOT NULL,
  `is_main` tinyint(1) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `is_main` (`is_main`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


CREATE TABLE IF NOT EXISTS `users_group` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` tinyint(3) unsigned NOT NULL,
  `rang` smallint(3) unsigned NOT NULL,
  `sort` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`parent_id`),
  KEY `sort` (`sort`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `users_group_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` tinyint(3) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` tinytext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`languages_id`),
  KEY `fk_users_group_info_users_group1_idx` (`group_id`),
  KEY `fk_users_group_info_languages1_idx` (`languages_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` tinyint(3) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `sessid` char(35) NOT NULL,
  `name` varchar(60) NOT NULL,
  `surname` varchar(60) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(60) NOT NULL,
  `password` varchar(64) NOT NULL,
  `skey` varchar(35) NOT NULL,
  `created` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `edited` datetime NOT NULL,
  PRIMARY KEY (`id`,`group_id`,`languages_id`),
  UNIQUE KEY `phone` (`phone`,`email`),
  KEY `fk_users_group1_idx` (`group_id`),
  KEY `fk_users_languages1_idx` (`languages_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `value` varchar(45) NOT NULL,
  `description` varchar(160) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sname` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

INSERT INTO `settings` (`id`, `name`, `value`, `description`) VALUES
  (1, 'autofil_title', '1', 'Автоматично заповнювати title в стоірнках на основі назви'),
  (2, 'autotranslit_alias', '1', 'Автоматично генерувати аліас'),
  (3, 'editor_language', 'uk', 'Мова редактора по замовчуванню'),
  (4, 'editor_bodyId', 'cms_content', 'ID body в шаблоні '),
  (5, 'editor_bodyClass', 'cms_content', 'Клас контенту для редкатора'),
  (6, 'editor_contentsCss', '/themes/default/assets/css/style.css', 'Шлях до стилів сайту, можна задавати через кому декілька'),
  (7, 'products_list_update_price', '1', 'Оновляти ціни в списку товарів\r\n'),
  (8, 'languages_create_info', '1', 'При створенні мови, автоматично згенерувати переклади у всіх розділах системи'),
  (9, 'app_theme_current', 'default', 'Тема по замовчуванню для сайту'),
  (10, 'app_views_path', 'views/', 'Шлях до шаблонів'),
  (11, 'app_chunks_path', 'chunks/', 'Шлях до чанків'),
  (12, 'themes_path', 'themes/', 'Папка з темами'),
  (13, 'content_images_dir', '/uploads/content/', 'Шлях до зображень'),
  (14, 'content_images_thumb_dir', 'thumbnails/', 'Шлях до превюшок'),
  (15, 'content_images_source_dir', 'source/', 'Шлях до sources'),
  (16, 'translator', 'google', 'Google or yandex'),
  (17, 'engine_theme_current', 'engine', 'Активна тема engine'),
  (18, 'mod_path', '\\controllers\\modules\\', 'Абсолютний шлях до модулів '),
  (19, 'page_404', '4522', 'Ід сторінки 404'),
  (20, 'img_source_size', '1600x1200', 'Розмір зображень source по замовчуванню'),
  (21, 'et_header', '', 'Глобальний header '),
  (22, 'et_footer', '', 'Глобальний footer'),
  (23, 'google_ananytics_id', '', 'Google Analytics ID'),
  (24, 'google_webmaster_id', '', 'G.Webmaster ID'),
  (25, 'yandex_webmaster_id', '', 'Yandex Webmaster ID'),
  (26, 'yandex_metrika', '', 'Yandex Metrika ID'),
  (27, 'version', '6.01.02', 'Версія змін адра.бд.системи'),
  (28, 'version_update', '1', 'Автоматичне оновлення версій системи');

ALTER TABLE `users`
ADD CONSTRAINT `fk_users_languages1` FOREIGN KEY (`languages_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_users_users_group1` FOREIGN KEY (`group_id`) REFERENCES `users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `users_group_info`
ADD CONSTRAINT `fk_users_group_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_users_group_info_users_group1` FOREIGN KEY (`group_id`) REFERENCES `users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;