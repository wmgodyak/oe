-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Мар 22 2016 г., 15:27
-- Версия сервера: 5.5.47-0ubuntu0.14.04.1
-- Версия PHP: 5.5.9-1ubuntu4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `engine`
--

-- --------------------------------------------------------

--
-- Структура таблицы `chunks`
--

CREATE TABLE IF NOT EXISTS `chunks` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `template` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `template` (`template`),
  KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `chunks`
--

INSERT INTO `chunks` (`id`, `name`, `template`) VALUES
(1, 'head', 'head'),
(2, 'footer', 'footer');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=66 ;

--
-- Дамп данных таблицы `components`
--

INSERT INTO `components` (`id`, `parent_id`, `isfolder`, `icon`, `author`, `version`, `controller`, `position`, `published`, `rang`, `settings`, `created`) VALUES
(1, 0, 0, 'fa-home', 'Volodymyr Hodiak', '1.0.0', 'dashboard', 1, 1, 300, NULL, '2016-03-18 15:27:32'),
(43, 0, 0, 'fa-file-text', 'Volodymyr Hodiak', '1.0.0', 'content/Pages', 43, 1, 300, NULL, '2016-03-16 15:09:36'),
(45, 0, 1, 'fa-cogs', 'Volodymyr Hodiak', '1.0.0', 'tools', 45, 1, 300, NULL, '2016-03-16 15:10:15'),
(46, 45, 0, 'fa-bars', 'Volodymyr Hodiak', '1.0.0', 'nav', 46, 1, 300, NULL, '2016-03-16 15:18:30'),
(47, 60, 1, 'fa-puzzle-piece', 'Volodymyr Hodiak', '1.0.0', 'components', 47, 1, 300, NULL, '2016-03-16 15:18:54'),
(48, 60, 0, 'fa-puzzle-piece', 'Volodymyr Hodiak', '1.0.0', 'plugins', 48, 1, 300, NULL, '2016-03-16 15:19:05'),
(49, 45, 0, 'fa-television', 'Volodymyr Hodiak', '1.0.0', 'themes', 49, 1, 300, NULL, '2016-03-16 15:21:51'),
(50, 45, 0, 'fa-file-code-o', 'Volodymyr Hodiak', '1.0.0', 'chunks', 50, 1, 300, NULL, '2016-03-16 15:21:56'),
(51, 0, 0, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'admins', 51, 1, 300, NULL, '2016-03-16 15:22:03'),
(52, 45, 0, 'fa-file-code-o', 'Volodymyr Hodiak', '1.0.0', 'features', 52, 1, 300, NULL, '2016-03-16 15:24:22'),
(53, 45, 0, 'fa-globe', 'Volodymyr Hodiak', '1.0.0', 'translations', 53, 1, 300, NULL, '2016-03-16 15:24:52'),
(54, 45, 0, 'fa-book', 'Volodymyr Hodiak', '1.0.0', 'guides', 54, 1, 300, NULL, '2016-03-16 15:25:16'),
(55, 45, 0, 'fa-trash', 'Volodymyr Hodiak', '1.0.0', 'trash', 55, 1, 300, NULL, '2016-03-16 15:25:45'),
(56, 45, 0, 'fa-book', 'Volodymyr Hodiak', '1.0.0', 'contentImagesSizes', 56, 1, 300, NULL, '2016-03-16 15:25:52'),
(57, 45, 0, 'fa-cubes', 'Volodymyr Hodiak', '1.0.0', 'contentTypes', 57, 1, 300, NULL, '2016-03-16 15:26:02'),
(58, 65, 0, 'fa-flag', 'Volodymyr Hodiak', '1.0.0', 'languages', 58, 1, 300, NULL, '2016-03-16 15:26:13'),
(59, 45, 0, 'fa-file-code-o', 'Volodymyr Hodiak', '1.0.0', 'backup', 59, 1, 300, NULL, '2016-03-16 15:26:21'),
(60, 0, 1, 'fa-puzzle-piece', 'Volodymyr Hodiak', '1.0.0', 'componentsGroup', 60, 1, 300, NULL, '2016-03-17 07:52:27'),
(61, 65, 0, 'fa-cogs', 'Volodymyr Hodiak', '1.0.0', 'settings', 61, 1, 300, NULL, '2016-03-17 07:54:17'),
(63, 0, 0, 'fa-pencil', 'Volodymyr Hodiak', '1.0.0', 'content/Posts', 63, 1, 300, NULL, '2016-03-17 15:25:19'),
(64, 45, 0, 'fa-envelope-o', 'Volodymyr Hodiak', '1.0.0', 'mailTemplates', 64, 1, 300, NULL, '2016-03-18 10:14:32'),
(65, 0, 1, 'fa-cogs', 'Volodymyr Hodiak', '1.0.0', 'settingsGroup', 65, 1, 300, NULL, '2016-03-18 11:41:11');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Дамп данных таблицы `content`
--

INSERT INTO `content` (`id`, `types_id`, `subtypes_id`, `owner_id`, `parent_id`, `isfolder`, `position`, `created`, `updated`, `published`, `status`) VALUES
(1, 1, 1, 2, 0, 1, 0, '2016-03-21 07:55:55', NULL, '2016-03-21', 'published'),
(2, 1, 1, 2, 1, 0, 0, '2016-03-21 07:56:43', NULL, '2016-03-21', 'published'),
(3, 1, 1, 2, 1, 0, 0, '2016-03-21 07:56:57', NULL, '2016-03-21', 'published'),
(4, 1, 1, 2, 1, 0, 0, '2016-03-21 07:57:10', NULL, '2016-03-21', 'published'),
(5, 1, 1, 2, 1, 0, 0, '2016-03-21 07:57:23', NULL, '2016-03-21', 'published'),
(6, 1, 1, 2, 1, 0, 0, '2016-03-21 07:57:34', NULL, '2016-03-21', 'published'),
(7, 1, 1, 2, 1, 0, 0, '2016-03-21 07:58:13', NULL, '2016-03-21', 'published'),
(8, 1, 1, 2, 1, 0, 0, '2016-03-21 07:58:21', NULL, '2016-03-21', 'published'),
(9, 1, 4, 2, 1, 0, 0, '2016-03-21 12:44:48', NULL, '2016-03-21', 'published'),
(10, 1, 1, 2, 0, 0, 0, '2016-03-21 13:07:47', NULL, NULL, 'blank');

-- --------------------------------------------------------

--
-- Структура таблицы `content_features`
--

CREATE TABLE IF NOT EXISTS `content_features` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` int(10) unsigned NOT NULL,
  `features_id` int(10) unsigned NOT NULL,
  `values_id` int(10) unsigned DEFAULT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`content_id`,`features_id`),
  UNIQUE KEY `content_id` (`content_id`,`features_id`,`values_id`,`languages_id`),
  KEY `fk_content_features_values_content1_idx` (`content_id`),
  KEY `fk_content_features_values_features1_idx` (`features_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `content_images`
--

CREATE TABLE IF NOT EXISTS `content_images` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` int(11) unsigned NOT NULL,
  `path` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `position` tinyint(5) unsigned NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_content_images_content1_idx` (`content_id`),
  KEY `position` (`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `content_images_sizes`
--

CREATE TABLE IF NOT EXISTS `content_images_sizes` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `size` varchar(16) NOT NULL,
  `width` int(5) unsigned NOT NULL,
  `height` int(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `size` (`size`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `content_images_sizes`
--

INSERT INTO `content_images_sizes` (`id`, `size`, `width`, `height`) VALUES
(1, 'post', 320, 240);

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
  `content` text,
  PRIMARY KEY (`id`,`content_id`,`languages_id`),
  UNIQUE KEY `languages_id` (`languages_id`,`url`),
  KEY `fk_content_info_content1_idx` (`content_id`),
  KEY `fk_content_info_languages1_idx` (`languages_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Дамп данных таблицы `content_info`
--

INSERT INTO `content_info` (`id`, `content_id`, `languages_id`, `name`, `url`, `h1`, `title`, `keywords`, `description`, `content`) VALUES
(1, 1, 1, 'Головна', '', '', 'Головна', '', '', ''),
(3, 2, 1, 'Про нас', 'pro-nas', '', 'Про нас', '', '', ''),
(4, 3, 1, 'Новини', 'novyny', '', 'Новини', '', '', ''),
(5, 4, 1, 'Оплата та доставка', 'oplata-ta-dostavka', '', 'Оплата та доставка', '', '', ''),
(6, 5, 1, 'Гарантія та сервіс', 'garantiya-ta-servis', '', 'Гарантія та сервіс', '', '', ''),
(7, 6, 1, 'Діючі акції', 'diyuchi-akciї', '', 'Діючі акції', '', '', ''),
(8, 7, 1, 'Ваканcії', 'vakanciї', '', 'Ваканcії', '', '', ''),
(9, 8, 1, 'Контакти', 'kontakty', '', 'Контакти', '', '', ''),
(10, 9, 1, '404', '404', '', '404', '', '', '');

-- --------------------------------------------------------

--
-- Структура таблицы `content_relationship`
--

CREATE TABLE IF NOT EXISTS `content_relationship` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` int(10) unsigned NOT NULL,
  `categories_id` int(10) unsigned NOT NULL,
  `is_main` tinyint(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`,`content_id`,`categories_id`),
  UNIQUE KEY `content_id` (`content_id`,`categories_id`),
  UNIQUE KEY `content_id_2` (`content_id`,`categories_id`),
  KEY `fk_content_relationship_content1_idx` (`content_id`),
  KEY `fk_content_relationship_content2_idx` (`categories_id`),
  KEY `is_main` (`is_main`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Дамп данных таблицы `content_types`
--

INSERT INTO `content_types` (`id`, `parent_id`, `isfolder`, `type`, `name`, `is_main`, `settings`) VALUES
(1, 0, 1, 'pages', 'Сторінки', NULL, 'a:1:{s:9:"parent_id";s:0:"";}'),
(2, 0, 0, 'posts', 'Статті', NULL, 'a:1:{s:9:"parent_id";s:0:"";}'),
(3, 0, 0, 'posts_categories', 'Категорії статтей', NULL, 'a:1:{s:9:"parent_id";s:0:"";}'),
(4, 1, 0, '404', '404', NULL, 'a:1:{s:9:"parent_id";s:0:"";}'),
(5, 1, 0, 'cpu', 'чпу', NULL, 'a:1:{s:9:"parent_id";s:0:"";}');

-- --------------------------------------------------------

--
-- Структура таблицы `content_types_images_sizes`
--

CREATE TABLE IF NOT EXISTS `content_types_images_sizes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `types_id` tinyint(3) unsigned NOT NULL,
  `images_sizes_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`,`types_id`,`images_sizes_id`),
  KEY `fk_content_types_images_sizes1_idx` (`types_id`),
  KEY `fk_content_types_images_sizes2_idx` (`images_sizes_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `content_types_images_sizes`
--

INSERT INTO `content_types_images_sizes` (`id`, `types_id`, `images_sizes_id`) VALUES
(1, 2, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `features`
--

CREATE TABLE IF NOT EXISTS `features` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `type` enum('text','textarea','select','file','folder','value','checkbox','number') DEFAULT NULL,
  `code` varchar(45) NOT NULL,
  `multiple` tinyint(1) DEFAULT NULL,
  `on_filter` tinyint(1) DEFAULT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `owner_id` int(11) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('blank','published','hidden') DEFAULT 'blank',
  PRIMARY KEY (`id`,`owner_id`),
  UNIQUE KEY `code_UNIQUE` (`code`),
  KEY `fk_features_users1_idx` (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `features_content`
--

CREATE TABLE IF NOT EXISTS `features_content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `features_id` int(10) unsigned NOT NULL,
  `content_types_id` tinyint(3) unsigned NOT NULL,
  `content_subtypes_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `content_id` int(10) unsigned NOT NULL DEFAULT '0',
  `position` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`,`features_id`,`content_types_id`,`content_subtypes_id`,`content_id`),
  UNIQUE KEY `features_id` (`features_id`,`content_types_id`,`content_subtypes_id`,`content_id`),
  KEY `fk_content_features_idx` (`features_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `features_info`
--

CREATE TABLE IF NOT EXISTS `features_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `features_id` int(10) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`features_id`,`languages_id`),
  KEY `fk_features_info_features1_idx` (`features_id`),
  KEY `fk_features_info_languages1_idx` (`languages_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `guides`
--

CREATE TABLE IF NOT EXISTS `guides` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) unsigned NOT NULL,
  `position` tinyint(3) unsigned NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `position` (`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `guides_info`
--

CREATE TABLE IF NOT EXISTS `guides_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `guides_id` int(11) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`,`guides_id`,`languages_id`),
  UNIQUE KEY `guides_id` (`guides_id`,`languages_id`),
  KEY `fk_guides_info_languages2_idx` (`languages_id`),
  KEY `fk_guides_info_guides2_idx` (`guides_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `languages`
--

INSERT INTO `languages` (`id`, `code`, `name`, `is_main`) VALUES
(1, 'uk', 'Українська', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `mail_templates`
--

CREATE TABLE IF NOT EXISTS `mail_templates` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(45) NOT NULL,
  `name` varchar(60) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `mail_templates_info`
--

CREATE TABLE IF NOT EXISTS `mail_templates_info` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `templates_id` tinyint(3) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_mail_templates_info_idx` (`templates_id`),
  KEY `fk_mail_templates_info_languages1_idx` (`languages_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `nav`
--

CREATE TABLE IF NOT EXISTS `nav` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `code` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `nav`
--

INSERT INTO `nav` (`id`, `name`, `code`) VALUES
(1, 'top', 'top');

-- --------------------------------------------------------

--
-- Структура таблицы `nav_items`
--

CREATE TABLE IF NOT EXISTS `nav_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nav_id` tinyint(3) unsigned NOT NULL,
  `content_id` int(11) unsigned NOT NULL,
  `position` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`,`nav_id`,`content_id`),
  UNIQUE KEY `nav_id` (`nav_id`,`content_id`),
  KEY `fk_nav_items_nav1_idx` (`nav_id`),
  KEY `fk_nav_items_content1_idx` (`content_id`),
  KEY `position` (`position`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Дамп данных таблицы `nav_items`
--

INSERT INTO `nav_items` (`id`, `nav_id`, `content_id`, `position`) VALUES
(1, 1, 2, 0),
(2, 1, 3, 1),
(3, 1, 4, 2),
(6, 1, 8, 5);

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
  `place` enum('top','main','after_main','params','after_params','bottom','sidebar','meta','after_meta','after_features','content','after_content','dashboard') NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `rang` int(4) unsigned DEFAULT NULL,
  `settings` text,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `published` (`published`),
  KEY `module` (`controller`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=22 ;

--
-- Дамп данных таблицы `plugins`
--

INSERT INTO `plugins` (`id`, `icon`, `author`, `version`, `controller`, `place`, `published`, `rang`, `settings`, `created`) VALUES
(14, 'fa-folder-o', 'Volodymyr Hodiak', '1.0.0', 'pagesTree', 'sidebar', 1, 300, NULL, '2016-03-03 14:58:57'),
(16, 'fa-picture-o', 'Volodymyr Hodiak', '1.0.0', 'contentImages', 'after_params', 1, 300, NULL, '2016-03-09 11:26:40'),
(17, 'fa-folder-o', 'Volodymyr Hodiak', '1.0.0', 'nav', 'sidebar', 1, 300, NULL, '2016-03-17 11:41:40'),
(18, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'adminsGroup', 'sidebar', 1, 300, NULL, '2016-03-17 14:57:30'),
(19, 'fa-folder-o', 'Volodymyr Hodiak', '1.0.0', 'postsCategories', 'sidebar', 1, 300, NULL, '2016-03-17 15:58:28'),
(20, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'postsCategoriesSelect', 'params', 1, 300, NULL, '2016-03-18 07:53:27'),
(21, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'dashboard', 'dashboard', 1, 300, NULL, '2016-03-18 15:28:13');

-- --------------------------------------------------------

--
-- Структура таблицы `plugins_components`
--

CREATE TABLE IF NOT EXISTS `plugins_components` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugins_id` tinyint(3) unsigned NOT NULL,
  `components_id` tinyint(3) unsigned NOT NULL,
  `position` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`plugins_id`,`components_id`),
  KEY `fk_plugins_components_plugins1_idx` (`plugins_id`),
  KEY `fk_plugins_components_components1_idx` (`components_id`),
  KEY `position` (`position`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Дамп данных таблицы `plugins_components`
--

INSERT INTO `plugins_components` (`id`, `plugins_id`, `components_id`, `position`) VALUES
(1, 17, 43, 0),
(2, 18, 51, 0),
(3, 19, 63, 0),
(4, 20, 63, 0),
(5, 16, 43, 0),
(6, 16, 63, 0),
(7, 21, 1, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `settings`
--

CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `value` text NOT NULL,
  `block` enum('common','images','themes','editor','content','seo','analitycs','robots','mail') NOT NULL,
  `type` enum('text','textarea') NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sname` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=47 ;

--
-- Дамп данных таблицы `settings`
--

INSERT INTO `settings` (`id`, `name`, `value`, `block`, `type`, `required`) VALUES
(1, 'autofil_title', '1', 'common', 'text', 1),
(2, 'autofill_url', '1', 'common', 'text', 1),
(4, 'editor_bodyId', 'cms_content', 'editor', 'text', 1),
(5, 'editor_body_class', 'cms_content', 'editor', 'text', 1),
(6, 'editor_contents_css', '/themes/default/assets/css/style.css', 'editor', 'textarea', 1),
(8, 'languages_create_info', '1', 'common', 'text', 1),
(9, 'app_theme_current', 'default', 'themes', 'text', 1),
(10, 'app_views_path', 'views/', 'themes', 'text', 1),
(11, 'app_chunks_path', 'chunks/', 'themes', 'text', 1),
(12, 'themes_path', 'themes/', 'themes', 'text', 1),
(13, 'content_images_dir', 'uploads/content/', 'images', 'text', 1),
(14, 'content_images_thumb_dir', 'thumbs/', 'images', 'text', 1),
(15, 'content_images_source_dir', 'source/', 'images', 'text', 1),
(17, 'engine_theme_current', 'engine', 'themes', 'text', 1),
(19, 'page_404', '9', 'common', 'text', 1),
(20, 'content_images_source_size', '1600x1200', 'images', 'text', 1),
(21, 'content_images_thumbs_size', '125x125', 'images', 'text', 1),
(23, 'content_images_quality', '70', 'images', 'text', 1),
(24, 'active', '1', 'common', 'text', 1),
(25, 'site_index', '1', 'robots', 'text', 1),
(26, 'robots_index_sample', '# цей файл створено автоматично. Не редагуйте його вручну. Змінити його ви можете в розділі налаштування\n\nUser-agent: *\nDisallow:\n\nUser-agent: Yandex\nDisallow:\nHost: {app}\n\nSitemap: {appurl}route/XmlSitemap/index', 'robots', 'textarea', 1),
(28, 'robots_no_index_sample', '# цей файл створено автоматично. Не редагуйте його вручну. Змінити його ви можете в розділі налаштування\n\nUser-agent: *\nDisallow: /', 'robots', 'textarea', 1),
(29, 'google_analytics_id', '', 'analitycs', 'text', 0),
(30, 'google_webmaster', '', 'analitycs', 'text', 0),
(31, 'yandex_webmaster', '', 'analitycs', 'text', 0),
(32, 'yandex_metric', '', 'analitycs', 'text', 0),
(33, 'ex_site_name', '1', 'seo', 'text', 1),
(34, 'ex_cat_name', '1', 'seo', 'text', 1),
(35, 'ex_delimiter', '/', 'seo', 'text', 1),
(36, 'mail_email_from', 'me@otakoyi.com', 'mail', 'text', 1),
(37, 'mail_email_to', 'me@otakoyi.com', 'mail', 'text', 1),
(38, 'mail_from_name', 'Company Otakoyi.com', 'mail', 'text', 1),
(39, 'mail_header', '', 'mail', 'textarea', 0),
(40, 'mail_footer', '', 'mail', 'textarea', 0),
(41, 'mail_smtp_on', '0', 'mail', 'text', 1),
(42, 'mail_smtp_host', '', 'mail', 'text', 0),
(43, 'mail_smtp_port', '', 'mail', 'text', 0),
(44, 'mail_smtp_user', '', 'mail', 'text', 0),
(45, 'mail_smtp_password', '', 'mail', 'text', 0),
(46, 'mail_smtp_secure', 'tls', 'mail', 'text', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `translations`
--

CREATE TABLE IF NOT EXISTS `translations` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(60) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `translations`
--

INSERT INTO `translations` (`id`, `code`) VALUES
(2, 'go'),
(1, 'hello');

-- --------------------------------------------------------

--
-- Структура таблицы `translations_info`
--

CREATE TABLE IF NOT EXISTS `translations_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `translations_id` int(11) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_translations_info_translations1_idx` (`translations_id`),
  KEY `fk_translations_info_languages1_idx` (`languages_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `translations_info`
--

INSERT INTO `translations_info` (`id`, `translations_id`, `languages_id`, `value`) VALUES
(1, 1, 1, 'Вітаємо'),
(2, 2, 1, 'Вперед!!!');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `group_id`, `languages_id`, `sessid`, `name`, `surname`, `phone`, `email`, `password`, `avatar`, `skey`, `created`, `updated`, `lastlogin`, `status`) VALUES
(2, 1, 0, '3hd0807fu1ga7qokvaf4ds8lb1', 'Володимир', 'Годяк', '380676736242', 'wmgodyak@gmail.com', 'MTTuFPm3y4m2o', NULL, NULL, '2016-03-03 13:25:08', '2016-03-18 17:30:44', '2016-03-22 12:02:01', 'active');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `users_group`
--

INSERT INTO `users_group` (`id`, `parent_id`, `isfolder`, `rang`, `position`) VALUES
(1, 0, 0, 500, 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- Дамп данных таблицы `users_group_info`
--

INSERT INTO `users_group_info` (`id`, `group_id`, `languages_id`, `name`) VALUES
(15, 1, 1, 'Адміністратори');

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
-- Ограничения внешнего ключа таблицы `content_features`
--
ALTER TABLE `content_features`
  ADD CONSTRAINT `fk_content_features_values_content1` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_content_features_values_features1` FOREIGN KEY (`features_id`) REFERENCES `features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `content_images`
--
ALTER TABLE `content_images`
  ADD CONSTRAINT `fk_content_images_content1` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `content_info`
--
ALTER TABLE `content_info`
  ADD CONSTRAINT `fk_content_info_content1` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_content_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `content_relationship`
--
ALTER TABLE `content_relationship`
  ADD CONSTRAINT `fk_content_relationship_content1` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_content_relationship_content2` FOREIGN KEY (`categories_id`) REFERENCES `content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `content_types_images_sizes`
--
ALTER TABLE `content_types_images_sizes`
  ADD CONSTRAINT `fk_content_types_images_sizes1` FOREIGN KEY (`types_id`) REFERENCES `content_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_content_types_images_sizes2` FOREIGN KEY (`images_sizes_id`) REFERENCES `content_images_sizes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `features`
--
ALTER TABLE `features`
  ADD CONSTRAINT `fk_features_users1` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `features_content`
--
ALTER TABLE `features_content`
  ADD CONSTRAINT `fk_content_features_idx` FOREIGN KEY (`features_id`) REFERENCES `features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `features_info`
--
ALTER TABLE `features_info`
  ADD CONSTRAINT `fk_features_info_features1` FOREIGN KEY (`features_id`) REFERENCES `features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_features_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `guides_info`
--
ALTER TABLE `guides_info`
  ADD CONSTRAINT `fk_guides_info_guides2` FOREIGN KEY (`guides_id`) REFERENCES `guides` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_guides_info_languages2` FOREIGN KEY (`languages_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `mail_templates_info`
--
ALTER TABLE `mail_templates_info`
  ADD CONSTRAINT `fk_mail_templates_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_mail_templates_info_mail_templates1` FOREIGN KEY (`templates_id`) REFERENCES `mail_templates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `nav_items`
--
ALTER TABLE `nav_items`
  ADD CONSTRAINT `fk_nav_items_content1` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_nav_items_nav1` FOREIGN KEY (`nav_id`) REFERENCES `nav` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `plugins_components`
--
ALTER TABLE `plugins_components`
  ADD CONSTRAINT `fk_plugins_components_components1` FOREIGN KEY (`components_id`) REFERENCES `components` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_plugins_components_plugins1` FOREIGN KEY (`plugins_id`) REFERENCES `plugins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `translations_info`
--
ALTER TABLE `translations_info`
  ADD CONSTRAINT `fk_translations_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_translations_info_translations1` FOREIGN KEY (`translations_id`) REFERENCES `translations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
