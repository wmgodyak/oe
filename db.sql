-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Мар 17 2016 г., 11:30
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=62 ;

--
-- Дамп данных таблицы `components`
--

INSERT INTO `components` (`id`, `parent_id`, `isfolder`, `icon`, `author`, `version`, `controller`, `position`, `published`, `rang`, `settings`, `created`) VALUES
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
(58, 0, 0, 'fa-flag', 'Volodymyr Hodiak', '1.0.0', 'languages', 0, 1, 300, NULL, '2016-03-16 15:26:13'),
(59, 45, 0, 'fa-file-code-o', 'Volodymyr Hodiak', '1.0.0', 'backup', 0, 1, 300, NULL, '2016-03-16 15:26:21'),
(60, 0, 1, 'fa-puzzle-piece', 'Volodymyr Hodiak', '1.0.0', 'componentsGroup', 0, 1, 300, NULL, '2016-03-17 07:52:27'),
(61, 0, 0, 'fa-cogs', 'Volodymyr Hodiak', '1.0.0', 'settings', 0, 1, 300, NULL, '2016-03-17 07:54:17');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Дамп данных таблицы `content`
--

INSERT INTO `content` (`id`, `types_id`, `subtypes_id`, `owner_id`, `parent_id`, `isfolder`, `position`, `created`, `updated`, `published`, `status`) VALUES
(1, 1, 1, 2, 0, 1, 0, '2016-03-15 09:25:57', NULL, '2016-03-15', 'published'),
(2, 1, 1, 2, 1, 0, 0, '2016-03-15 09:26:43', NULL, '2016-03-15', 'published'),
(5, 1, 1, 2, 1, 0, 0, '2016-03-16 09:45:20', NULL, '2016-03-16', 'published');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=70 ;

--
-- Дамп данных таблицы `content_features`
--

INSERT INTO `content_features` (`id`, `content_id`, `features_id`, `values_id`, `languages_id`, `value`) VALUES
(1, 2, 84, NULL, 1, 'ret'),
(2, 2, 96, NULL, 1, 'retertert'),
(3, 2, 97, NULL, 0, '/uploads/avatars/c4ca4238a0b923820dcc509a6f75849b.png'),
(5, 2, 93, NULL, 1, 'reter'),
(15, 2, 85, 92, 0, NULL),
(16, 2, 85, 91, 0, NULL),
(17, 2, 98, NULL, 1, 'цукцук'),
(25, 2, 100, NULL, 0, '/uploads/avatars/0.png'),
(26, 2, 87, 90, 0, NULL),
(27, 2, 99, NULL, 0, '1'),
(28, 5, 84, NULL, 1, ''),
(29, 5, 108, NULL, 1, ''),
(30, 5, 109, NULL, 1, ''),
(31, 5, 110, NULL, 1, ''),
(32, 5, 112, NULL, 1, ''),
(33, 5, 113, NULL, 1, ''),
(34, 5, 114, NULL, 1, ''),
(35, 5, 120, NULL, 1, ''),
(36, 5, 119, NULL, 1, ''),
(37, 5, 106, NULL, 1, ''),
(38, 5, 105, NULL, 1, ''),
(39, 5, 96, NULL, 1, ''),
(40, 5, 97, NULL, 0, ''),
(41, 5, 98, NULL, 1, ''),
(42, 5, 100, NULL, 0, ''),
(43, 5, 101, NULL, 1, ''),
(44, 5, 102, NULL, 1, ''),
(45, 5, 103, NULL, 1, ''),
(46, 5, 104, NULL, 1, ''),
(47, 5, 121, NULL, 1, 'sadasd'),
(48, 5, 87, 88, 0, NULL),
(49, 5, 93, NULL, 1, ''),
(50, 5, 124, NULL, 1, 'dasdsad'),
(51, 5, 125, NULL, 1, 'фів'),
(52, 2, 109, NULL, 1, ''),
(53, 2, 110, NULL, 1, ''),
(54, 2, 112, NULL, 1, ''),
(55, 2, 113, NULL, 1, ''),
(56, 2, 114, NULL, 1, ''),
(57, 2, 120, NULL, 1, ''),
(58, 2, 119, NULL, 1, ''),
(59, 2, 121, NULL, 1, 'іва'),
(60, 2, 108, NULL, 1, ''),
(61, 2, 106, NULL, 1, ''),
(62, 2, 105, NULL, 1, ''),
(63, 2, 101, NULL, 1, ''),
(64, 2, 102, NULL, 1, ''),
(65, 2, 103, NULL, 1, ''),
(66, 2, 104, NULL, 1, ''),
(67, 2, 124, NULL, 1, 'в'),
(68, 2, 111, 132, 0, NULL),
(69, 2, 133, NULL, 0, '3336');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `content_images`
--

INSERT INTO `content_images` (`id`, `content_id`, `path`, `image`, `position`, `created`) VALUES
(1, 2, 'uploads/content/2016/03/15/', 'cute-winter-wallpaper-1920x1080-101112152-ebeieeiya-2x.jpg', 1, '2016-03-15 09:27:23'),
(2, 5, 'uploads/content/2016/03/16/', 'cute-winter-wallpaper-1920x1080-101112150-ebeieeiya-5x.jpg', 1, '2016-03-16 11:44:05');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Дамп данных таблицы `content_images_sizes`
--

INSERT INTO `content_images_sizes` (`id`, `size`, `width`, `height`) VALUES
(8, 'post', 200, 200),
(9, 'small', 160, 120),
(10, 'test', 120, 90),
(11, 'test2', 120, 90),
(12, 'a', 200, 100),
(13, 'ss', 320, 240);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=41 ;

--
-- Дамп данных таблицы `content_info`
--

INSERT INTO `content_info` (`id`, `content_id`, `languages_id`, `name`, `url`, `h1`, `title`, `keywords`, `description`, `content`) VALUES
(38, 1, 1, 'Головна', 'golovna', '', 'Головна', '', '', NULL),
(39, 2, 1, 'Про проект', 'pro-proekt', '', 'Про проект', '', '', '<p>reteert</p>\n'),
(40, 5, 1, 'Допомогти', 'dopomogty', '', 'Допомогти', '', '', '');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `content_types`
--

INSERT INTO `content_types` (`id`, `parent_id`, `isfolder`, `type`, `name`, `is_main`, `settings`) VALUES
(1, 0, 0, 'pages', 'Сторінки', 1, 'a:1:{s:9:"parent_id";s:1:"0";}'),
(2, 0, 1, 'blog', 'Блог', NULL, 'a:1:{s:9:"parent_id";s:1:"0";}'),
(3, 2, 0, 'cat', 'Категорії', NULL, 'a:1:{s:9:"parent_id";s:1:"0";}'),
(4, 2, 0, 'post', 'Статті', NULL, 'a:1:{s:9:"parent_id";s:1:"0";}');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

--
-- Дамп данных таблицы `content_types_images_sizes`
--

INSERT INTO `content_types_images_sizes` (`id`, `types_id`, `images_sizes_id`) VALUES
(17, 1, 9),
(18, 1, 11),
(19, 1, 12);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=134 ;

--
-- Дамп данных таблицы `features`
--

INSERT INTO `features` (`id`, `parent_id`, `type`, `code`, `multiple`, `on_filter`, `required`, `owner_id`, `created`, `status`) VALUES
(84, 0, 'text', 'feature_1457967964', 0, 0, 0, 2, '2016-03-14 15:06:04', 'published'),
(85, 0, 'select', 'feature_1457968007', 1, 0, 0, 2, '2016-03-14 15:06:47', 'published'),
(86, 0, 'folder', 'feature_1457968029', 0, 0, 0, 2, '2016-03-14 15:07:09', 'published'),
(87, 86, 'select', 'feature_1457968043', 0, 0, 0, 2, '2016-03-14 15:07:23', 'published'),
(88, 87, 'value', 'ebcc805a9d004ef49fb710baf92cac51', NULL, NULL, 0, 2, '2016-03-14 15:07:59', 'published'),
(89, 87, 'value', 'fac3c711f4d3df1affbbabdbcae43a78', NULL, NULL, 0, 2, '2016-03-14 15:08:01', 'published'),
(90, 87, 'value', 'efb927dbeee0f1d9a4fd305a089fb68a', NULL, NULL, 0, 2, '2016-03-14 15:08:09', 'published'),
(91, 85, 'value', '02cb709925182bb6fc87b4e90201ab2f', NULL, NULL, 0, 2, '2016-03-14 15:08:24', 'published'),
(92, 85, 'value', 'c78b9754c268702eeee30667b4b5259f', NULL, NULL, 0, 2, '2016-03-14 15:08:27', 'published'),
(93, 86, 'text', 'feature_1457968111', 0, 0, 0, 2, '2016-03-14 15:08:31', 'published'),
(94, 0, 'text', 'tekstove_pole', 0, 0, 0, 2, '2016-03-15 11:48:39', 'published'),
(95, 0, 'text', 'she_odne_tekstove_pole', 0, 0, 0, 2, '2016-03-15 11:49:36', 'published'),
(96, 0, 'textarea', 'tekstovyj_blok', 0, 0, 0, 2, '2016-03-15 12:03:53', 'published'),
(97, 0, 'file', 'fajl', 0, 0, 0, 2, '2016-03-15 12:58:57', 'published'),
(98, 0, 'textarea', 'hz', 0, 0, 0, 2, '2016-03-16 08:56:24', 'published'),
(99, 0, 'checkbox', 'chekboks', 0, 0, 0, 2, '2016-03-16 09:01:27', 'published'),
(100, 0, 'file', 'fajl2', 0, 0, 0, 2, '2016-03-16 09:12:53', 'published'),
(101, 86, 'text', 'asdsadasd', 0, 0, 0, 2, '2016-03-16 09:24:18', 'published'),
(102, 86, 'text', 'sdfsdfdsfsdfdsf', 0, 0, 0, 2, '2016-03-16 09:24:41', 'published'),
(103, 86, 'text', 'aaa', 0, 0, 0, 2, '2016-03-16 09:24:51', 'published'),
(104, 86, 'text', 'ddd', 0, 0, 0, 2, '2016-03-16 09:25:42', 'published'),
(105, 86, 'text', 'ccc', 0, 0, 0, 2, '2016-03-16 09:26:46', 'published'),
(106, 86, 'text', 'vvv', 0, 0, 0, 2, '2016-03-16 09:27:06', 'published'),
(108, 86, 'text', 'bbbb', 0, 0, 0, 2, '2016-03-16 09:28:35', 'published'),
(109, 0, 'text', 'ryrtyrtyrty', 0, 0, 0, 2, '2016-03-16 09:31:26', 'published'),
(110, 0, 'text', 'zzz', 0, 0, 0, 2, '2016-03-16 09:31:56', 'published'),
(111, 86, 'select', 'bbnnn', 1, 0, 0, 2, '2016-03-16 09:32:24', 'published'),
(112, 86, 'text', 'eeee', 0, 0, 0, 2, '2016-03-16 09:33:52', 'published'),
(113, 86, 'text', 'ttt', 0, 0, 0, 2, '2016-03-16 09:34:29', 'published'),
(114, 86, 'text', 'yyy', 0, 0, 0, 2, '2016-03-16 09:34:37', 'published'),
(115, 86, 'folder', 'group_34343', 0, 0, 0, 2, '2016-03-16 09:34:45', 'published'),
(119, 0, 'text', '456456aaa', 0, 0, 0, 2, '2016-03-16 09:37:19', 'published'),
(120, 115, 'text', 'tretertretertert', 0, 0, 0, 2, '2016-03-16 09:37:27', 'published'),
(121, 0, 'text', 'feature_1458121404', 0, 0, 1, 2, '2016-03-16 09:43:24', 'published'),
(123, 0, NULL, 'feature_1458121433', NULL, NULL, 0, 2, '2016-03-16 09:43:53', 'blank'),
(124, 0, 'text', 'asdasdaaaaaa', 0, 0, 1, 2, '2016-03-16 09:47:22', 'published'),
(125, 0, 'text', 'til_ky_dlya_dopomogty', 0, 0, 1, 2, '2016-03-16 09:48:41', 'published'),
(128, 111, 'value', '6984ae55ffc4de0cd2058db94de73605', NULL, NULL, 0, 2, '2016-03-16 10:03:25', 'published'),
(129, 111, 'value', 'b0f820cb3753c03b1ce485977ffe8283', NULL, NULL, 0, 2, '2016-03-16 10:07:50', 'published'),
(130, 111, 'value', '9a2531cb148bff7bd5084a496d486dea', NULL, NULL, 0, 2, '2016-03-16 10:08:14', 'published'),
(131, 111, 'value', 'ede039bb4e0c92dcf3a966d36a2b18c1', NULL, NULL, 0, 2, '2016-03-16 10:08:19', 'published'),
(132, 111, 'value', 'dc9d0d89ea6326c7167515de9d656e0d', NULL, NULL, 0, 2, '2016-03-16 10:08:33', 'published'),
(133, 0, 'number', 'chyslove_pole', 0, 0, 0, 2, '2016-03-16 10:15:30', 'published');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=48 ;

--
-- Дамп данных таблицы `features_content`
--

INSERT INTO `features_content` (`id`, `features_id`, `content_types_id`, `content_subtypes_id`, `content_id`, `position`) VALUES
(15, 84, 1, 0, 0, NULL),
(17, 93, 2, 0, 0, NULL),
(18, 86, 1, 0, 0, 1),
(19, 85, 1, 0, 0, 2),
(20, 85, 2, 0, 0, 1),
(21, 96, 1, 1, 0, NULL),
(22, 97, 1, 1, 0, NULL),
(23, 98, 1, 1, 0, NULL),
(24, 99, 1, 1, 0, NULL),
(25, 100, 1, 1, 0, NULL),
(26, 101, 1, 1, 0, NULL),
(27, 102, 1, 1, 0, NULL),
(28, 103, 1, 1, 0, NULL),
(29, 104, 1, 1, 0, NULL),
(30, 105, 1, 1, 0, NULL),
(31, 106, 1, 1, 0, NULL),
(32, 108, 1, 1, 0, NULL),
(33, 109, 1, 1, 0, NULL),
(34, 110, 1, 1, 0, NULL),
(35, 111, 1, 1, 0, NULL),
(36, 112, 1, 1, 0, NULL),
(37, 113, 1, 1, 0, NULL),
(38, 114, 1, 1, 0, NULL),
(39, 115, 1, 1, 0, NULL),
(40, 119, 1, 1, 0, NULL),
(41, 120, 1, 1, 0, NULL),
(43, 123, 1, 0, 0, NULL),
(44, 121, 1, 0, 0, NULL),
(45, 124, 1, 1, 0, NULL),
(46, 125, 1, 1, 5, NULL),
(47, 133, 1, 1, 0, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=145 ;

--
-- Дамп данных таблицы `features_info`
--

INSERT INTO `features_info` (`id`, `features_id`, `languages_id`, `name`) VALUES
(99, 84, 1, 'a'),
(100, 85, 1, 'b'),
(101, 86, 1, 'c'),
(102, 87, 1, 'ca'),
(103, 88, 1, '1'),
(104, 89, 1, '2'),
(105, 90, 1, '3'),
(106, 91, 1, '1'),
(107, 92, 1, '2'),
(108, 93, 1, 'c2'),
(109, 94, 1, 'Текстове поле'),
(110, 95, 1, 'ще одне текстове поле'),
(111, 96, 1, 'Текстовий блок'),
(112, 97, 1, 'файл'),
(113, 98, 1, 'хз'),
(114, 99, 1, 'чекбокс'),
(115, 100, 1, 'файл2'),
(116, 101, 1, 'asdsadasd'),
(117, 102, 1, 'sdfsdfdsfsdfdsf'),
(118, 103, 1, 'aaa'),
(119, 104, 1, 'ddd'),
(120, 105, 1, 'ccc'),
(121, 106, 1, 'vvv'),
(122, 108, 1, 'bbbb'),
(123, 109, 1, 'ryrtyrtyrty'),
(124, 110, 1, 'zzz'),
(125, 111, 1, 'bbnnn'),
(126, 112, 1, 'eeee'),
(127, 113, 1, 'ttt'),
(128, 114, 1, 'yyy'),
(129, 115, 1, 'group 34343'),
(133, 119, 1, '456456aaa'),
(134, 120, 1, 'tretertretertert'),
(135, 121, 1, 'обовязкове поле'),
(136, 124, 1, 'asdasdaaaaaa'),
(137, 125, 1, 'Тільки для допомогти'),
(139, 128, 1, 'werwerwer'),
(140, 129, 1, 'tbnnnn'),
(141, 130, 1, '345435hh'),
(142, 131, 1, 'ww'),
(143, 132, 1, 'g'),
(144, 133, 1, 'Числове поле');

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
  `place` enum('top','main','meta','params','bottom','sidebar') NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `rang` int(4) unsigned DEFAULT NULL,
  `settings` text,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `published` (`published`),
  KEY `module` (`controller`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- Дамп данных таблицы `plugins`
--

INSERT INTO `plugins` (`id`, `icon`, `author`, `version`, `controller`, `place`, `published`, `rang`, `settings`, `created`) VALUES
(14, 'fa-folder-o', 'Volodymyr Hodiak', '1.0.0', 'pagesTree', 'sidebar', 1, 300, NULL, '2016-03-03 14:58:57'),
(15, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'adminsGroup', 'sidebar', 1, 300, NULL, '2016-03-03 14:59:05'),
(16, 'fa-picture-o', 'Volodymyr Hodiak', '1.0.0', 'contentImages', 'params', 1, 300, NULL, '2016-03-09 11:26:40');

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `settings`
--

CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `value` varchar(45) NOT NULL,
  `group` enum('common','images','themes','editor','content') NOT NULL,
  `type` enum('text','textarea') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sname` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

--
-- Дамп данных таблицы `settings`
--

INSERT INTO `settings` (`id`, `name`, `value`, `group`, `type`) VALUES
(1, 'autofil_title', '1', 'common', 'text'),
(2, 'autofill_url', '1', 'common', 'text'),
(4, 'editor_bodyId', 'cms_content', 'editor', 'text'),
(5, 'editor_body_class', 'cms_content', 'editor', 'text'),
(6, 'editor_contents_css', '/themes/default/assets/css/style.css', 'editor', 'textarea'),
(8, 'languages_create_info', '1', 'common', 'text'),
(9, 'app_theme_current', 'default', 'themes', 'text'),
(10, 'app_views_path', 'views/', 'themes', 'text'),
(11, 'app_chunks_path', 'chunks/', 'themes', 'text'),
(12, 'themes_path', 'themes/', 'themes', 'text'),
(13, 'content_images_dir', 'uploads/content/', 'images', 'text'),
(14, 'content_images_thumb_dir', 'thumbs/', 'images', 'text'),
(15, 'content_images_source_dir', 'source/', 'images', 'text'),
(17, 'engine_theme_current', 'engine', 'themes', 'text'),
(19, 'page_404', '0', 'common', 'text'),
(20, 'content_images_source_size', '1600x1200', 'images', 'text'),
(21, 'content_images_thumbs_size', '125x125', 'images', 'text'),
(23, 'content_images_quality', '70', 'images', 'text');

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
(2, 1, 0, '3a0g9sltj0jtbafpc1ssp63577', 'Володимир', 'Годяк', '380676736242', 'wmgodyak@gmail.com', 'MTTuFPm3y4m2o', NULL, NULL, '2016-03-03 13:25:08', '0000-00-00 00:00:00', '2016-03-17 07:17:03', 'active');

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
