-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Янв 15 2016 г., 17:54
-- Версия сервера: 5.5.46-0ubuntu0.14.04.2
-- Версия PHP: 5.5.9-1ubuntu4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `e7`
--

-- --------------------------------------------------------

--
-- Структура таблицы `components`
--

CREATE TABLE IF NOT EXISTS `components` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` tinyint(3) unsigned NOT NULL,
  `isfolder` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `icon` varchar(30) DEFAULT NULL,
  `author` varchar(60) DEFAULT NULL,
  `version` varchar(10) DEFAULT NULL,
  `controller` varchar(150) DEFAULT NULL,
  `position` tinyint(3) unsigned DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `rang` int(4) unsigned DEFAULT NULL,
  `type` enum('component','plugin','module') DEFAULT NULL,
  `settings` text,
  `place` varchar(45) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `isfolder` (`isfolder`),
  KEY `position` (`position`),
  KEY `published` (`published`),
  KEY `module` (`controller`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `components`
--

INSERT INTO `components` (`id`, `parent_id`, `isfolder`, `icon`, `author`, `version`, `controller`, `position`, `published`, `rang`, `type`, `settings`, `place`, `created`) VALUES
(1, 1, 0, 'fa-cubes', 'Volodymyr Hodiak', '1.0', 'components', 0, 1, 400, 'component', NULL, NULL, '2016-01-13 16:03:08'),
(4, 0, 0, 'fa fa-users', 'Volodymyr Hodiak', NULL, 'admins', 0, 1, 300, 'component', NULL, NULL, '2016-01-15 14:00:13');

-- --------------------------------------------------------

--
-- Структура таблицы `languages`
--

CREATE TABLE IF NOT EXISTS `languages` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `code` char(2) NOT NULL,
  `name` varchar(30) NOT NULL,
  `is_main` tinyint(1) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `is_main` (`is_main`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=15 ;

--
-- Дамп данных таблицы `languages`
--

INSERT INTO `languages` (`id`, `code`, `name`, `is_main`) VALUES
(1, 'uk', 'Українська', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `settings`
--

CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `value` varchar(45) NOT NULL,
  `description` varchar(160) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sname` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

--
-- Дамп данных таблицы `settings`
--

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

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` tinyint(3) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `sessid` char(35) DEFAULT NULL,
  `name` varchar(60) NOT NULL,
  `surname` varchar(60) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(60) NOT NULL,
  `password` varchar(64) NOT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `skey` varchar(35) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime NOT NULL,
  `lastlogin` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`,`group_id`,`languages_id`),
  UNIQUE KEY `phone` (`phone`,`email`),
  KEY `fk_users_group1_idx` (`group_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `group_id`, `languages_id`, `sessid`, `name`, `surname`, `phone`, `email`, `password`, `avatar`, `skey`, `created`, `updated`, `lastlogin`) VALUES
(1, 1, 0, 'of4lt5ups6i7h98na1pnsnk8b6', 'Володимир', 'Годяк', '380676736242', 'wmgodyak@gmail.com', 'MTTuFPm3y4m2o', '/uploads/avatars/c4ca4238a0b923820dcc509a6f75849b.png', '', '2015-12-24 14:36:04', '2015-12-30 12:22:17', '2016-01-15 12:47:55');

-- --------------------------------------------------------

--
-- Структура таблицы `users_group`
--

CREATE TABLE IF NOT EXISTS `users_group` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` tinyint(3) unsigned NOT NULL,
  `rang` smallint(3) unsigned NOT NULL,
  `sort` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`parent_id`),
  KEY `sort` (`sort`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `users_group`
--

INSERT INTO `users_group` (`id`, `parent_id`, `rang`, `sort`) VALUES
(1, 0, 999, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `users_group_info`
--

CREATE TABLE IF NOT EXISTS `users_group_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` tinyint(3) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`languages_id`),
  KEY `fk_users_group_info_users_group1_idx` (`group_id`),
  KEY `fk_users_group_info_languages1_idx` (`languages_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `users_group_info`
--

INSERT INTO `users_group_info` (`id`, `group_id`, `languages_id`, `name`) VALUES
(1, 1, 1, 'Admins');

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_users_group1` FOREIGN KEY (`group_id`) REFERENCES `users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `users_group_info`
--
ALTER TABLE `users_group_info`
  ADD CONSTRAINT `fk_users_group_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_users_group_info_users_group1` FOREIGN KEY (`group_id`) REFERENCES `users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
