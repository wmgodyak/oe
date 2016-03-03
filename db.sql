-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Мар 03 2016 г., 10:57
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
  `settings` text,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `isfolder` (`isfolder`),
  KEY `position` (`position`),
  KEY `published` (`published`),
  KEY `module` (`controller`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

--
-- Дамп данных таблицы `components`
--

INSERT INTO `components` (`id`, `parent_id`, `isfolder`, `icon`, `author`, `version`, `controller`, `position`, `published`, `rang`, `settings`, `created`) VALUES
(16, 0, 0, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'admins', 0, 1, 300, NULL, '2016-01-28 12:34:05'),
(17, 0, 0, 'fa-flag', 'Volodymyr Hodiak', '1.0.0', 'languages', 0, 1, 300, NULL, '2016-01-28 12:34:07'),
(19, 0, 0, 'fa-puzzle-piece', 'Volodymyr Hodiak', '1.0.0', 'components', 0, 1, 300, NULL, '2016-01-28 12:37:32'),
(22, 0, 0, 'fa-cubes', 'Volodymyr Hodiak', '1.0.0', 'contentTypes', 0, 1, 300, NULL, '2016-02-05 10:15:28'),
(23, 0, 0, 'fa-puzzle-piece', 'Volodymyr Hodiak', '1.0.0', 'plugins', 0, 1, 300, NULL, '2016-02-12 16:24:27'),
(24, 0, 0, 'fa-file', 'wmgodyak', '1.0', 'content/pages', 1, 1, 300, NULL, '2016-03-02 15:48:31');

-- --------------------------------------------------------

--
-- Структура таблицы `content`
--

CREATE TABLE IF NOT EXISTS `content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `types_id` tinyint(3) unsigned NOT NULL,
  `subtypes_id` tinyint(3) unsigned NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `parent_id` int(10) unsigned DEFAULT '0',
  `isfolder` tinyint(1) unsigned DEFAULT '0',
  `position` tinyint(3) unsigned DEFAULT '0',
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT NULL,
  `published` date DEFAULT NULL,
  `status` enum('blank','hidden','published','deleted') DEFAULT 'blank',
  PRIMARY KEY (`id`,`types_id`,`subtypes_id`,`owner_id`),
  KEY `fk_content_content_types1_idx` (`types_id`),
  KEY `fk_content_content_subtypes1_idx` (`subtypes_id`),
  KEY `fk_content_owner_idx` (`owner_id`),
  KEY `status` (`status`),
  KEY `published` (`published`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

--
-- Дамп данных таблицы `content`
--

INSERT INTO `content` (`id`, `types_id`, `subtypes_id`, `owner_id`, `parent_id`, `isfolder`, `position`, `created`, `updated`, `published`, `status`) VALUES
(1, 1, 1, 1, 0, 1, 0, '2016-03-02 09:42:18', NULL, '2016-03-02', 'published'),
(2, 1, 1, 1, 1, 0, 0, '2016-03-02 10:23:34', NULL, '2016-03-02', 'published'),
(3, 1, 1, 1, 1, 1, 0, '2016-03-02 11:14:49', NULL, '2016-03-02', 'hidden'),
(9, 1, 1, 1, 10, 0, 0, '2016-03-02 14:05:12', NULL, '2016-03-02', 'published'),
(10, 1, 1, 1, 3, 1, 0, '2016-03-02 15:13:03', NULL, '2016-03-02', 'hidden'),
(11, 1, 1, 1, 1, 0, 0, '2016-03-02 15:13:15', NULL, '2016-03-02', 'deleted'),
(13, 1, 1, 1, 3, 0, 0, '2016-03-02 15:13:34', NULL, '2016-03-02', 'published'),
(24, 1, 1, 1, 10, 0, 0, '2016-03-03 07:52:20', NULL, NULL, 'published');

-- --------------------------------------------------------

--
-- Структура таблицы `content_info`
--

CREATE TABLE IF NOT EXISTS `content_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` int(10) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `url` varchar(160) DEFAULT NULL,
  `h1` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`content_id`,`languages_id`),
  UNIQUE KEY `url_uq` (`content_id`,`languages_id`,`url`),
  KEY `fk_content_info_content1_idx` (`content_id`),
  KEY `fk_content_info_languages1_idx` (`languages_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

--
-- Дамп данных таблицы `content_info`
--

INSERT INTO `content_info` (`id`, `content_id`, `languages_id`, `name`, `url`, `h1`, `title`, `keywords`, `description`) VALUES
(1, 1, 1, 'Головна', 'ua', '', '', '', ''),
(2, 1, 2, 'главная', 'ru', '', '', '', ''),
(5, 2, 1, 'Про нас', 'pro-nas', '', '', '', ''),
(6, 2, 2, 'О нас', 'o-nas', '', '', '', ''),
(7, 3, 1, 'Контакти', 'contacty', '', '', '', ''),
(8, 3, 2, 'Контакти', 'contacts', '', '', '', ''),
(17, 9, 1, 'sdfsdfsdf', 'sdfsdfsd', '', '', '', ''),
(18, 9, 2, 'fdsfsdfdsf', 'fsdfsdfsd', '', '', '', ''),
(19, 10, 1, 'Про нас', 'pro-nas', '', 'Про нас', '', ''),
(20, 10, 2, 'Про нас', 'pro-nas', '', 'Про нас', '', ''),
(21, 11, 1, 'Контакти', 'kontakty', '', 'Контакти', '', ''),
(22, 11, 2, 'Контакти', 'kontakti', '', 'Контакти', '', ''),
(23, 13, 1, 'Ваканції', 'vakanciї', '', 'Ваканції', '', ''),
(24, 13, 2, 'Ваканції', 'vakancії', '', 'Ваканції', '', '');

-- --------------------------------------------------------

--
-- Структура таблицы `content_types`
--

CREATE TABLE IF NOT EXISTS `content_types` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` tinyint(3) unsigned DEFAULT '0',
  `isfolder` tinyint(1) unsigned DEFAULT '0',
  `type` varchar(45) NOT NULL,
  `name` varchar(60) NOT NULL,
  `is_main` tinyint(1) unsigned DEFAULT NULL,
  `settings` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `parent_id` (`parent_id`,`type`),
  UNIQUE KEY `parent_id_2` (`parent_id`,`is_main`),
  KEY `is_main` (`is_main`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `content_types`
--

INSERT INTO `content_types` (`id`, `parent_id`, `isfolder`, `type`, `name`, `is_main`, `settings`) VALUES
(1, 0, 0, 'pages', 'Сторінки', 1, 'a:2:{s:9:"parent_id";s:1:"0";s:7:"ext_url";s:1:"0";}');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `languages`
--

INSERT INTO `languages` (`id`, `code`, `name`, `is_main`) VALUES
(1, 'uk', 'Українська', 1),
(2, 'ru', 'Російська', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `plugins`
--

CREATE TABLE IF NOT EXISTS `plugins` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `icon` varchar(30) DEFAULT NULL,
  `author` varchar(60) DEFAULT NULL,
  `version` varchar(10) DEFAULT NULL,
  `controller` varchar(150) DEFAULT NULL,
  `position` tinyint(3) unsigned DEFAULT '0',
  `place` varchar(60) NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `rang` int(4) unsigned DEFAULT NULL,
  `settings` text,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `position` (`position`),
  KEY `published` (`published`),
  KEY `module` (`controller`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `plugins`
--

INSERT INTO `plugins` (`id`, `icon`, `author`, `version`, `controller`, `position`, `place`, `published`, `rang`, `settings`, `created`) VALUES
(3, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'adminsGroup', 0, 'sidebar', 1, 300, NULL, '2016-01-28 14:38:03'),
(4, 'fa-folder-o', 'Volodymyr Hodiak', '1.0.0', 'pagesTree', 0, 'sidebar', 1, 300, NULL, '2016-03-02 15:47:16');

-- --------------------------------------------------------

--
-- Структура таблицы `plugins_components`
--

CREATE TABLE IF NOT EXISTS `plugins_components` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugins_id` tinyint(3) unsigned NOT NULL,
  `components_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`,`plugins_id`,`components_id`),
  KEY `fk_plugins_components_plugins1_idx` (`plugins_id`),
  KEY `fk_plugins_components_components1_idx` (`components_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Дамп данных таблицы `plugins_components`
--

INSERT INTO `plugins_components` (`id`, `plugins_id`, `components_id`) VALUES
(4, 3, 16),
(5, 4, 24);

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
  `status` enum('active','ban','deleted') NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`,`group_id`,`languages_id`),
  UNIQUE KEY `phone` (`phone`,`email`),
  KEY `fk_users_group1_idx` (`group_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `group_id`, `languages_id`, `sessid`, `name`, `surname`, `phone`, `email`, `password`, `avatar`, `skey`, `created`, `updated`, `lastlogin`, `status`) VALUES
(1, 1, 0, 'l207iq5ga2fto4qjmp9cog90b3', 'Володимир', 'Годяк', '+38 (067) 6736242', 'wmgodyak@gmail.com', 'MTTuFPm3y4m2o', '/uploads/avatars/c4ca4238a0b923820dcc509a6f75849b.png', '', '2015-12-24 14:36:04', '2016-01-26 14:54:20', '2016-03-03 07:16:56', 'active');

-- --------------------------------------------------------

--
-- Структура таблицы `users_group`
--

CREATE TABLE IF NOT EXISTS `users_group` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` tinyint(3) unsigned NOT NULL,
  `isfolder` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `rang` smallint(3) unsigned NOT NULL,
  `position` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`parent_id`),
  KEY `sort` (`position`),
  KEY `isfolder` (`isfolder`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Дамп данных таблицы `users_group`
--

INSERT INTO `users_group` (`id`, `parent_id`, `isfolder`, `rang`, `position`) VALUES
(1, 2, 0, 999, 0),
(2, 0, 1, 305, 0),
(3, 2, 1, 150, 0),
(9, 3, 0, 111, 0),
(10, 3, 0, 111, 0),
(11, 3, 0, 111, 0),
(12, 3, 0, 111, 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Дамп данных таблицы `users_group_info`
--

INSERT INTO `users_group_info` (`id`, `group_id`, `languages_id`, `name`) VALUES
(1, 1, 1, 'Admins'),
(2, 2, 1, 'Редактор'),
(3, 3, 1, 'Менеджери a'),
(9, 9, 1, 'subadmins'),
(10, 10, 1, 'aaa'),
(11, 11, 1, 'bbbb'),
(12, 12, 1, 'cccc');

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `content`
--
ALTER TABLE `content`
  ADD CONSTRAINT `fk_content_content_subtypes1` FOREIGN KEY (`subtypes_id`) REFERENCES `content_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_content_content_types1` FOREIGN KEY (`types_id`) REFERENCES `content_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_content_owner_id1` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `content_info`
--
ALTER TABLE `content_info`
  ADD CONSTRAINT `fk_content_info_content1` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_content_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `plugins_components`
--
ALTER TABLE `plugins_components`
  ADD CONSTRAINT `fk_plugins_components_components1` FOREIGN KEY (`components_id`) REFERENCES `components` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_plugins_components_plugins1` FOREIGN KEY (`plugins_id`) REFERENCES `plugins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
