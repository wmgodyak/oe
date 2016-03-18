-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Мар 18 2016 г., 17:29
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `chunks`
--

INSERT INTO `chunks` (`id`, `name`, `template`) VALUES
(1, 'aaasa', 'a');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=68 ;

--
-- Дамп данных таблицы `components`
--

INSERT INTO `components` (`id`, `parent_id`, `isfolder`, `icon`, `author`, `version`, `controller`, `position`, `published`, `rang`, `settings`, `created`) VALUES
(1, 0, 0, 'fa-home', 'Volodymyr Hodiak', '1.0.0', 'dashboard', 0, 1, 300, NULL, '2016-03-18 15:27:32'),
(43, 0, 0, 'fa-file-text', 'Volodymyr Hodiak', '1.0.0', 'content/Pages', 0, 1, 300, NULL, '2016-03-16 15:09:36'),
(45, 0, 1, 'fa-cogs', 'Volodymyr Hodiak', '1.0.0', 'tools', 0, 1, 300, NULL, '2016-03-16 15:10:15'),
(46, 45, 0, 'fa-bars', 'Volodymyr Hodiak', '1.0.0', 'nav', 0, 1, 300, NULL, '2016-03-16 15:18:30'),
(47, 60, 1, 'fa-puzzle-piece', 'Volodymyr Hodiak', '1.0.0', 'components', 0, 1, 300, NULL, '2016-03-16 15:18:54'),
(48, 60, 0, 'fa-puzzle-piece', 'Volodymyr Hodiak', '1.0.0', 'plugins', 0, 1, 300, NULL, '2016-03-16 15:19:05'),
(49, 45, 0, 'fa-television', 'Volodymyr Hodiak', '1.0.0', 'themes', 0, 1, 300, NULL, '2016-03-16 15:21:51'),
(50, 45, 0, 'fa-file-code-o', 'Volodymyr Hodiak', '1.0.0', 'chunks', 0, 1, 300, NULL, '2016-03-16 15:21:56'),
(51, 0, 0, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'admins', 0, 1, 300, NULL, '2016-03-16 15:22:03'),
(52, 45, 0, 'fa-file-code-o', 'Volodymyr Hodiak', '1.0.0', 'features', 0, 1, 300, NULL, '2016-03-16 15:24:22'),
(53, 45, 0, 'fa-globe', 'Volodymyr Hodiak', '1.0.0', 'translations', 0, 1, 300, NULL, '2016-03-16 15:24:52'),
(54, 45, 0, 'fa-book', 'Volodymyr Hodiak', '1.0.0', 'guides', 0, 1, 300, NULL, '2016-03-16 15:25:16'),
(55, 0, 0, 'fa-trash', 'Volodymyr Hodiak', '1.0.0', 'trash', 0, 1, 300, NULL, '2016-03-16 15:25:45'),
(56, 45, 0, 'fa-book', 'Volodymyr Hodiak', '1.0.0', 'contentImagesSizes', 0, 1, 300, NULL, '2016-03-16 15:25:52'),
(57, 45, 0, 'fa-cubes', 'Volodymyr Hodiak', '1.0.0', 'contentTypes', 0, 1, 300, NULL, '2016-03-16 15:26:02'),
(58, 65, 0, 'fa-flag', 'Volodymyr Hodiak', '1.0.0', 'languages', 0, 1, 300, NULL, '2016-03-16 15:26:13'),
(59, 45, 0, 'fa-file-code-o', 'Volodymyr Hodiak', '1.0.0', 'backup', 0, 1, 300, NULL, '2016-03-16 15:26:21'),
(60, 0, 1, 'fa-puzzle-piece', 'Volodymyr Hodiak', '1.0.0', 'componentsGroup', 0, 1, 300, NULL, '2016-03-17 07:52:27'),
(61, 65, 0, 'fa-cogs', 'Volodymyr Hodiak', '1.0.0', 'settings', 0, 1, 300, NULL, '2016-03-17 07:54:17'),
(63, 0, 0, 'fa-pencil', 'Volodymyr Hodiak', '1.0.0', 'content/Posts', 0, 1, 300, NULL, '2016-03-17 15:25:19'),
(64, 45, 0, 'fa-envelope-o', 'Volodymyr Hodiak', '1.0.0', 'mailTemplates', 0, 1, 300, NULL, '2016-03-18 10:14:32'),
(65, 0, 1, 'fa-cogs', 'Volodymyr Hodiak', '1.0.0', 'settingsGroup', 0, 1, 300, NULL, '2016-03-18 11:41:11');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=27 ;

--
-- Дамп данных таблицы `content`
--

INSERT INTO `content` (`id`, `types_id`, `subtypes_id`, `owner_id`, `parent_id`, `isfolder`, `position`, `created`, `updated`, `published`, `status`) VALUES
(1, 1, 1, 2, 0, 1, 0, '2016-03-17 15:49:09', NULL, '2016-03-17', 'published'),
(2, 2, 2, 2, 0, 0, 0, '2016-03-17 15:49:38', NULL, '2016-03-18', 'published'),
(3, 2, 2, 2, 0, 0, 0, '2016-03-17 15:49:49', NULL, '2016-03-17', 'published'),
(4, 2, 2, 2, 0, 0, 0, '2016-03-17 15:50:29', NULL, '2016-03-17', 'published'),
(5, 2, 2, 2, 0, 0, 0, '2016-03-17 15:50:40', NULL, '2016-03-17', 'published'),
(6, 2, 2, 2, 0, 0, 0, '2016-03-17 15:51:22', NULL, '2016-03-17', 'published'),
(7, 3, 3, 2, 0, 0, 0, '2016-03-18 07:24:33', NULL, '1970-01-01', 'published'),
(8, 3, 3, 2, 0, 1, 0, '2016-03-18 07:26:22', NULL, '2016-03-18', 'published'),
(9, 3, 3, 2, 0, 1, 0, '2016-03-18 07:29:41', NULL, '2016-03-18', 'published'),
(10, 3, 3, 2, 0, 0, 0, '2016-03-18 07:29:50', NULL, '2016-03-18', 'published'),
(11, 3, 3, 2, 0, 0, 0, '2016-03-18 07:30:03', NULL, '2016-03-18', 'published'),
(12, 3, 3, 2, 0, 0, 0, '2016-03-18 07:31:02', NULL, '2016-03-18', 'published'),
(13, 3, 3, 2, 0, 0, 0, '2016-03-18 07:31:54', NULL, '2016-03-18', 'published'),
(14, 3, 3, 2, 0, 0, 0, '2016-03-18 07:32:07', NULL, '2016-03-18', 'published'),
(15, 3, 3, 2, 0, 0, 0, '2016-03-18 07:36:52', NULL, '2016-03-18', 'published'),
(16, 3, 3, 2, 0, 0, 0, '2016-03-18 07:37:50', NULL, '2016-03-18', 'deleted'),
(17, 3, 3, 2, 8, 0, 0, '2016-03-18 07:45:56', NULL, '2016-03-18', 'published'),
(18, 3, 3, 2, 8, 0, 0, '2016-03-18 07:46:06', NULL, '2016-03-18', 'published'),
(19, 3, 3, 2, 9, 0, 0, '2016-03-18 07:46:16', NULL, '2016-03-18', 'published'),
(20, 3, 3, 2, 9, 0, 0, '2016-03-18 07:46:24', NULL, '2016-03-18', 'published'),
(21, 1, 1, 2, 1, 0, 0, '2016-03-18 09:19:29', NULL, '2016-03-18', 'published'),
(23, 2, 2, 2, 0, 0, 0, '2016-03-18 09:21:43', NULL, '2016-03-18', 'hidden'),
(26, 2, 2, 2, 0, 0, 0, '2016-03-18 09:24:23', NULL, NULL, 'blank');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `content_features`
--

INSERT INTO `content_features` (`id`, `content_id`, `features_id`, `values_id`, `languages_id`, `value`) VALUES
(1, 1, 1, NULL, 0, '/uploads/files/settings.sql');

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
  UNIQUE KEY `url_uq` (`content_id`,`languages_id`,`url`),
  KEY `fk_content_info_content1_idx` (`content_id`),
  KEY `fk_content_info_languages1_idx` (`languages_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=67 ;

--
-- Дамп данных таблицы `content_info`
--

INSERT INTO `content_info` (`id`, `content_id`, `languages_id`, `name`, `url`, `h1`, `title`, `keywords`, `description`, `content`) VALUES
(43, 1, 1, 'Головна', '', '', 'Головна', '', '', '<p>6456456ertretret&nbsp;bbb 45 645 654b6 45 54fct5454dt45fg45g45g54&nbsp;</p>\n\n<p>fsdfsdfsdf</p>\n\n<p>dsfs dfds f sdf sdf</p>\n'),
(44, 2, 1, 'Стаття 1', 'stattya-1', '', 'Стаття 1', '', '', '<p>wetertrertewtretwret</p>\n'),
(45, 3, 1, 'Стаття 2', 'stattya-2', '', 'Стаття 2', '', '', ''),
(46, 4, 1, 'Стаття 3', 'stattya-3', '', 'Стаття 3', '', '', ''),
(47, 5, 1, 'Стаття 5', 'stattya-5', '', 'Стаття 5', '', '', ''),
(48, 6, 1, 'Стаття 6', 'stattya-6', '', 'Стаття 6', '', '', ''),
(49, 7, 1, 'Без категорії', 'bez-kategoriї', '', 'Без категорії', '', '', NULL),
(50, 8, 1, 'Ктаегорія 1', 'ktaegoriya-1', '', 'Ктаегорія 1', '', '', NULL),
(51, 9, 1, 'Категорія 2', 'kategoriya-2', '', 'Категорія 2', '', '', NULL),
(52, 10, 1, 'Категорія 2', 'kategoriya-2', '', 'Категорія 2', '', '', NULL),
(53, 11, 1, 'Категорія 3', 'kategoriya-3', '', 'Категорія 3', '', '', NULL),
(54, 12, 1, 'Категорія 3', 'kategoriya-3', '', 'Категорія 3', '', '', NULL),
(55, 13, 1, 'Категорія 4', 'kategoriya-4', '', 'Категорія 4', '', '', NULL),
(56, 14, 1, 'Категорія 5', 'kategoriya-5', '', 'Категорія 5', '', '', NULL),
(57, 15, 1, 'Категорія 6', 'kategoriya-6', '', 'Категорія 6', '', '', NULL),
(58, 16, 1, 'Категорія 7an', 'kategoriya-7an', '', 'Категорія 7', '', '', NULL),
(59, 17, 1, 'Категорія 1.1', 'kategoriya-1-1', '', 'Категорія 1.1', '', '', NULL),
(60, 18, 1, 'Категорія 1.2', 'kategoriya-1-2', '', 'Категорія 1.2', '', '', NULL),
(61, 19, 1, 'Категорія 2.1', 'kategoriya-2-1', '', 'Категорія 2.1', '', '', NULL),
(62, 20, 1, 'Категорія 2.2', 'kategoriya-2-2', '', 'Категорія 2.2', '', '', NULL),
(63, 21, 1, 'Про нас', 'pro-nas', '', 'Про нас', '', '', ''),
(64, 23, 1, 'Стаття для категорії 19', 'stattya-dlya-kategoriї-19', '', 'Стаття для категорії 19', '', '', ''),
(66, 1, 3, '5434', '5434', '', '5434', '', '', '<p>ter treter t</p>\n\n<p>dasas</p>\n');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Дамп данных таблицы `content_relationship`
--

INSERT INTO `content_relationship` (`id`, `content_id`, `categories_id`, `is_main`) VALUES
(4, 2, 19, 0),
(6, 23, 19, 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Дамп данных таблицы `content_types`
--

INSERT INTO `content_types` (`id`, `parent_id`, `isfolder`, `type`, `name`, `is_main`, `settings`) VALUES
(1, 0, 0, 'pages', 'Сторінки', NULL, 'a:1:{s:9:"parent_id";s:0:"";}'),
(2, 0, 0, 'posts', 'Статті', NULL, 'a:1:{s:9:"parent_id";s:0:"";}'),
(3, 0, 0, 'posts_categories', 'Категорії статтей', NULL, 'a:1:{s:9:"parent_id";s:0:"";}');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `features`
--

INSERT INTO `features` (`id`, `parent_id`, `type`, `code`, `multiple`, `on_filter`, `required`, `owner_id`, `created`, `status`) VALUES
(1, 0, 'file', 'wewe', 0, 0, 0, 2, '2016-03-18 13:12:34', 'published');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `features_content`
--

INSERT INTO `features_content` (`id`, `features_id`, `content_types_id`, `content_subtypes_id`, `content_id`, `position`) VALUES
(1, 1, 1, 1, 0, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `features_info`
--

INSERT INTO `features_info` (`id`, `features_id`, `languages_id`, `name`) VALUES
(1, 1, 1, 'wewe');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Дамп данных таблицы `languages`
--

INSERT INTO `languages` (`id`, `code`, `name`, `is_main`) VALUES
(1, 'uk', 'Українська', 1),
(3, 'ru', 'Rus', 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Дамп данных таблицы `mail_templates`
--

INSERT INTO `mail_templates` (`id`, `code`, `name`) VALUES
(5, 'asfas', 'fsafasf');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Дамп данных таблицы `mail_templates_info`
--

INSERT INTO `mail_templates_info` (`id`, `templates_id`, `languages_id`, `subject`, `body`) VALUES
(6, 5, 1, 'asfsa1111', '<p>111qqqdsf ds sdfsd</p>\n'),
(10, 5, 3, 'qwewq eqw 2323', '<p>232323qweqwe</p>\n');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
(19, 'page_404', '0', 'common', 'text', 1),
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
(2, 1, 0, '3divete6uar1ogiua5tj6etfm6', 'Володимир', 'Годяк', '380676736242', 'wmgodyak@gmail.com', 'MTTuFPm3y4m2o', NULL, NULL, '2016-03-03 13:25:08', '2016-03-17 14:49:28', '2016-03-18 15:15:38', 'active');

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
