-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Июл 01 2016 г., 17:57
-- Версия сервера: 5.6.30-0ubuntu0.14.04.1-log
-- Версия PHP: 5.5.9-1ubuntu4.17

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
-- Структура таблицы `e_banners`
--

CREATE TABLE IF NOT EXISTS `e_banners` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `places_id` int(10) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `skey` varchar(32) NOT NULL,
  `img` varchar(255) DEFAULT NULL,
  `name` varchar(40) NOT NULL,
  `published` tinyint(1) unsigned DEFAULT '1',
  `permanent` tinyint(1) DEFAULT '1',
  `df` date DEFAULT NULL,
  `dt` date DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `target` enum('_blank','_self') DEFAULT '_self',
  PRIMARY KEY (`id`,`places_id`,`languages_id`),
  UNIQUE KEY `skey_UNIQUE` (`skey`),
  KEY `fk_banners_banners_places1_idx` (`places_id`),
  KEY `fk_banners_languages1_idx` (`languages_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

--
-- Дамп данных таблицы `e_banners`
--

INSERT INTO `e_banners` (`id`, `places_id`, `languages_id`, `skey`, `img`, `name`, `published`, `permanent`, `df`, `dt`, `url`, `target`) VALUES
(18, 7, 1, 'dfb62995840bd01c4065469e055f6d43', '/uploads/content/2016/06/27/6f4922f45568161a8cdf4ad2299f6d23.jpg', '121', 1, 1, '0000-00-00', '0000-00-00', 'http://google.com', '_blank'),
(19, 8, 1, 'e0e118f164839036284c48eb8620fd85', '/uploads/content/2016/06/27/1f0e3dad99908345f7439f8ffabdffc4.jpg', '1', 1, 1, '0000-00-00', '0000-00-00', '1', '_self'),
(20, 8, 1, 'beffc185e3ccca00d4a392d3e75bdfc2', '/uploads/content/2016/06/27/98f13708210194c475687be6106a3b84.jpg', '2', 1, 1, '0000-00-00', '0000-00-00', '2', '_blank'),
(21, 7, 1, '50412b56b8a7d526a8570056d021ad2e', '/uploads/content/2016/06/27/3c59dc048e8850243be8079a5c74d079.jpg', '2', 1, 1, '0000-00-00', '0000-00-00', 'http://yandex.com', '_self'),
(22, 7, 1, 'e3987704a441c4ba12edf29dd0bee622', '/uploads/content/2016/06/27/b6d767d2f8ed5d21a44b0e5886680cb9.jpg', '3', 1, 1, '0000-00-00', '0000-00-00', 'http://otakoyi.com', '_self'),
(23, 7, 1, 'cb8d1658e818735aae8c3f3b5dc258ec', '/uploads/content/2016/06/27/37693cfc748049e45d87b8c7d8b9aacd.jpg', '22', 1, 1, '0000-00-00', '0000-00-00', 'http://ukraine.com', '_self');

-- --------------------------------------------------------

--
-- Структура таблицы `e_banners_places`
--

CREATE TABLE IF NOT EXISTS `e_banners_places` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(45) DEFAULT NULL,
  `name` varchar(60) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Дамп данных таблицы `e_banners_places`
--

INSERT INTO `e_banners_places` (`id`, `code`, `name`, `width`, `height`) VALUES
(7, 'home-top', 'Голоана', 730, 330),
(8, 'home-bottom', 'Головна внизу', 350, 175);

-- --------------------------------------------------------

--
-- Структура таблицы `e_callbacks`
--

CREATE TABLE IF NOT EXISTS `e_callbacks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(10) unsigned DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `name` varchar(45) NOT NULL,
  `message` text NOT NULL,
  `comment` text,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` char(16) NOT NULL,
  `status` enum('processed','spam','new') NOT NULL DEFAULT 'new',
  `manager_id` int(11) DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- Дамп данных таблицы `e_callbacks`
--

INSERT INTO `e_callbacks` (`id`, `users_id`, `phone`, `name`, `message`, `comment`, `created`, `ip`, `status`, `manager_id`, `updated`) VALUES
(1, NULL, '213123123', 'івіаваіва', 'іваіва', 'іваіваіва', '2016-06-24 08:34:30', '', 'spam', 2, '0000-00-00 00:00:00'),
(2, NULL, '213123123', 'івіаваіва', 'іваіва', 'іваіваіва', '2016-06-24 08:34:34', '', 'new', NULL, '0000-00-00 00:00:00'),
(3, NULL, '213123123', 'івіаваіва', 'іваіва', 'іваіваіва', '2016-06-24 08:34:43', '', 'new', NULL, '0000-00-00 00:00:00'),
(4, NULL, '213123123', 'івіаваіва', 'іваіва', 'іваіваіва', '2016-06-24 08:34:43', '', 'new', NULL, '0000-00-00 00:00:00'),
(5, NULL, '213123123', 'івіаваіва', 'іваіва', 'іваіваіва', '2016-06-24 08:34:43', '', 'new', NULL, '0000-00-00 00:00:00'),
(6, NULL, '213123123', 'івіаваіва', 'іваіва', 'іваіваіва', '2016-06-24 08:34:43', '', 'new', NULL, '0000-00-00 00:00:00'),
(7, NULL, '213123123', 'івіаваіва', 'іваіва', 'іваіваіва', '2016-06-24 08:34:43', '', 'new', NULL, '0000-00-00 00:00:00'),
(8, NULL, '213123123', 'івіаваіва', 'іваіва', 'іваіваіва', '2016-06-24 08:34:43', '', 'new', NULL, '0000-00-00 00:00:00'),
(9, NULL, '213123123', 'івіаваіва', 'іваіва', 'іваіваіва', '2016-06-24 08:34:43', '', 'new', NULL, '0000-00-00 00:00:00'),
(10, NULL, '213123123', 'івіаваіва', 'іваіва', 'іваіваіва', '2016-06-24 08:34:43', '', 'new', NULL, '0000-00-00 00:00:00'),
(11, NULL, '213123123', 'івіаваіва', 'іваіва', 'іваіваіва', '2016-06-24 08:34:43', '', 'new', NULL, '0000-00-00 00:00:00'),
(12, NULL, '213123123', 'івіаваіва', 'іваіва', 'іваіваіва', '2016-06-24 08:34:43', '', 'new', NULL, '0000-00-00 00:00:00'),
(13, NULL, '213123123', 'івіаваіва', 'іваіва', 'іваіваіва', '2016-06-24 08:34:43', '', 'new', NULL, '0000-00-00 00:00:00'),
(14, NULL, '213123123', 'івіаваіва', 'іваіва', 'іваіваіва', '2016-06-24 08:34:43', '', 'new', NULL, '0000-00-00 00:00:00'),
(15, NULL, '213123123', 'івіаваіва', 'іваіва', 'ertertertertretret', '2016-06-24 08:34:43', '', 'processed', 2, '2016-06-24 11:34:58'),
(16, NULL, '213123123', 'івіаваіва', 'іваіва', 'ertertret', '2016-06-24 08:34:43', '', 'processed', 2, '2016-06-24 11:34:49');

-- --------------------------------------------------------

--
-- Структура таблицы `e_comments`
--

CREATE TABLE IF NOT EXISTS `e_comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0',
  `isfolder` tinyint(3) unsigned NOT NULL,
  `content_id` int(11) unsigned NOT NULL,
  `users_id` int(11) unsigned NOT NULL,
  `message` text NOT NULL,
  `rate` decimal(2,1) unsigned NOT NULL DEFAULT '1.0',
  `status` enum('approved','spam','new') NOT NULL DEFAULT 'new',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` char(15) DEFAULT NULL,
  `skey` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`,`content_id`),
  KEY `fk_comments_content1_idx` (`content_id`),
  KEY `approved` (`status`),
  KEY `users_id` (`users_id`),
  KEY `token` (`skey`),
  KEY `isfolder` (`isfolder`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=28 ;

--
-- Дамп данных таблицы `e_comments`
--

INSERT INTO `e_comments` (`id`, `parent_id`, `isfolder`, `content_id`, `users_id`, `message`, `rate`, `status`, `created`, `ip`, `skey`) VALUES
(15, 14, 0, 16, 2, 'в якій перерахувала 25 технік генерації ідей для логотипу. Якщо ви її не читали — обов''язково прочитайте :) А потім повертайтеся сюди :)', 1.0, 'approved', '2016-03-31 08:46:30', '127.0.0.1', NULL),
(16, 14, 0, 16, 2, 'обов''язково прочитайте :) А потім повертайтеся сюди :)', 1.0, 'approved', '2016-03-31 08:48:38', '127.0.0.1', NULL),
(17, 13, 0, 16, 2, 'ertertert', 1.0, 'approved', '2016-03-31 08:49:52', '127.0.0.1', NULL),
(18, 13, 0, 16, 2, 'werewrwer', 1.0, 'approved', '2016-03-31 08:49:58', '127.0.0.1', NULL),
(19, 13, 0, 16, 2, 'werwerwer', 1.0, 'approved', '2016-03-31 08:50:04', '127.0.0.1', NULL),
(21, 19, 0, 16, 2, 'dfdsfsd', 1.0, 'approved', '2016-03-31 09:11:27', '127.0.0.1', NULL),
(23, 21, 0, 16, 2, 'rtyr', 1.0, 'approved', '2016-03-31 09:15:54', '127.0.0.1', NULL),
(27, 26, 0, 16, 2, 'a', 1.0, 'approved', '2016-04-13 07:03:34', '127.0.0.1', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `e_comments_subscribers`
--

CREATE TABLE IF NOT EXISTS `e_comments_subscribers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` int(10) unsigned NOT NULL,
  `users_id` int(10) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`content_id`,`users_id`),
  UNIQUE KEY `content_id` (`content_id`,`users_id`),
  KEY `fk_comments_subscribe_content1_idx` (`content_id`),
  KEY `fk_comments_subscribe_users1_idx` (`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `e_components`
--

CREATE TABLE IF NOT EXISTS `e_components` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` tinyint(3) unsigned NOT NULL,
  `isfolder` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `icon` varchar(30) DEFAULT NULL,
  `controller` varchar(150) DEFAULT NULL,
  `position` tinyint(3) unsigned DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `settings` text,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `isfolder` (`isfolder`),
  KEY `position` (`position`),
  KEY `published` (`published`),
  KEY `module` (`controller`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=84 ;

--
-- Дамп данных таблицы `e_components`
--

INSERT INTO `e_components` (`id`, `parent_id`, `isfolder`, `icon`, `controller`, `position`, `published`, `settings`, `created`) VALUES
(1, 0, 0, 'fa-home', 'dashboard', 1, 1, NULL, '2016-03-18 15:27:32'),
(2, 0, 0, 'fa-file-text', 'pages', 2, 1, NULL, '2016-04-25 12:20:14'),
(3, 0, 1, 'fa-th-large', 'tools', 9, 1, NULL, '2016-03-16 15:10:15'),
(4, 0, 1, 'fa-cogs', 'settingsGroup', 12, 1, NULL, '2016-03-18 11:41:11'),
(5, 4, 0, 'fa-cogs', 'seo', 1, 1, NULL, '2016-04-13 13:10:56'),
(6, 4, 0, 'fa-flag', 'languages', 58, 1, NULL, '2016-03-16 15:26:13'),
(7, 3, 0, 'fa-bars', 'nav', 46, 1, NULL, '2016-03-16 15:18:30'),
(8, 3, 0, 'fa-television', 'themes', 49, 1, NULL, '2016-03-16 15:21:51'),
(9, 3, 0, 'fa-file-code-o', 'features', 52, 1, NULL, '2016-03-16 15:24:22'),
(10, 3, 0, 'fa-trash', 'trash', 55, 1, NULL, '2016-03-16 15:25:45'),
(11, 3, 0, 'fa-book', 'contentImagesSizes', 56, 1, NULL, '2016-03-16 15:25:52'),
(12, 3, 0, 'fa-cubes', 'contentTypes', 57, 1, NULL, '2016-03-16 15:26:02'),
(13, 0, 0, 'fa-users', 'admins', 8, 1, NULL, '2016-03-16 15:22:03'),
(14, 3, 0, 'fa-puzzle-piece', 'widgets', 48, 1, NULL, '2016-03-16 15:19:05'),
(47, 60, 1, 'fa-puzzle-piece', 'components', 47, 0, NULL, '2016-03-16 15:18:54'),
(54, 45, 0, 'fa-book', 'guides', 54, 0, NULL, '2016-03-16 15:25:16'),
(59, 45, 0, 'fa-file-code-o', 'backup', 59, 0, NULL, '2016-03-16 15:26:21'),
(60, 0, 1, 'fa-puzzle-piece', 'componentsGroup', 11, 0, NULL, '2016-03-17 07:52:27'),
(61, 4, 0, 'fa-cogs', 'settings', 61, 1, NULL, '2016-03-17 07:54:17'),
(64, 45, 0, 'fa-envelope-o', 'mailTemplates', 64, 0, NULL, '2016-03-18 10:14:32'),
(66, 60, 0, 'fa-puzzle-piece', 'modules', 0, 0, NULL, '2016-03-23 13:50:46'),
(67, 0, 0, 'fa-pencil', 'content/Post', 3, 0, NULL, '2016-03-25 10:43:43'),
(68, 0, 0, 'fa-users', 'customers', 5, 0, NULL, '2016-03-28 07:56:25'),
(69, 0, 0, 'fa-comments', 'comments', 5, 0, NULL, '2016-03-31 07:17:06'),
(70, 0, 1, 'fa-shopping-cart', 'shop', 3, 0, NULL, '2016-04-01 06:30:35'),
(72, 70, 0, 'fa-mobile', 'cProducts', 0, 0, NULL, '2016-04-01 06:38:03'),
(76, 70, 0, 'fa-file-text', 'ProductsCategories', 0, 0, NULL, '2016-04-01 08:10:43'),
(77, 70, 0, 'fa-money', 'currency', 0, 0, NULL, '2016-04-01 10:28:14'),
(78, 70, 0, 'fa-bus', 'delivery', 0, 0, NULL, '2016-04-01 10:55:57'),
(79, 70, 0, 'fa-credit-card', 'payment', 0, 0, NULL, '2016-04-01 11:16:34'),
(81, 0, 0, 'fa-cogs', 'banners', 6, 0, NULL, '2016-04-07 12:06:56'),
(82, 0, 0, 'fa-phone-square', 'callbacks', 5, 0, NULL, '2016-04-11 07:55:03'),
(83, 65, 0, 'fa-bus', 'ordersStatus', 3, 0, NULL, '2016-04-11 11:53:42');

-- --------------------------------------------------------

--
-- Структура таблицы `e_content`
--

CREATE TABLE IF NOT EXISTS `e_content` (
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
  `settings` text,
  `status` enum('blank','hidden','published','deleted') DEFAULT 'blank',
  `code` varchar(60) DEFAULT NULL,
  `currency_id` tinyint(3) unsigned DEFAULT NULL,
  `unit_id` tinyint(3) unsigned DEFAULT NULL,
  `has_variants` tinyint(1) unsigned DEFAULT NULL,
  `in_stock` tinyint(1) unsigned DEFAULT NULL,
  `external_id` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`,`types_id`,`subtypes_id`,`owner_id`),
  KEY `fk_content_content_types1_idx` (`types_id`),
  KEY `fk_content_content_subtypes1_idx` (`subtypes_id`),
  KEY `fk_content_owner_idx` (`owner_id`),
  KEY `status` (`status`),
  KEY `published` (`published`),
  KEY `code` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=164 ;

--
-- Дамп данных таблицы `e_content`
--

INSERT INTO `e_content` (`id`, `types_id`, `subtypes_id`, `owner_id`, `parent_id`, `isfolder`, `position`, `created`, `updated`, `published`, `settings`, `status`, `code`, `currency_id`, `unit_id`, `has_variants`, `in_stock`, `external_id`) VALUES
(1, 1, 6, 2, 0, 1, 0, '2016-03-21 07:55:55', '2016-06-17 17:43:30', '2016-03-21', NULL, 'published', '1', NULL, NULL, NULL, NULL, NULL),
(2, 1, 1, 2, 1, 0, 0, '2016-03-21 07:56:43', '2016-06-17 22:22:03', '2016-03-21', NULL, 'published', '2', NULL, NULL, NULL, NULL, NULL),
(3, 1, 7, 2, 1, 0, 0, '2016-03-21 07:56:57', '2016-03-24 14:04:03', '2016-03-21', NULL, 'published', '3', NULL, NULL, NULL, NULL, NULL),
(4, 1, 1, 2, 1, 0, 0, '2016-03-21 07:57:10', NULL, '2016-03-21', NULL, 'published', '4', NULL, NULL, NULL, NULL, NULL),
(5, 1, 1, 2, 1, 0, 0, '2016-03-21 07:57:23', NULL, '2016-03-21', NULL, 'published', '5', NULL, NULL, NULL, NULL, NULL),
(6, 1, 1, 2, 1, 0, 0, '2016-03-21 07:57:34', NULL, '2016-03-21', NULL, 'published', '6', NULL, NULL, NULL, NULL, NULL),
(7, 1, 1, 2, 1, 0, 0, '2016-03-21 07:58:13', NULL, '2016-03-21', NULL, 'published', '7', NULL, NULL, NULL, NULL, NULL),
(8, 1, 9, 2, 1, 0, 0, '2016-03-21 07:58:21', '2016-03-31 14:00:44', '2016-03-21', NULL, 'published', '8', NULL, NULL, NULL, NULL, NULL),
(9, 1, 4, 2, 1, 0, 0, '2016-03-21 12:44:48', NULL, '2016-03-21', NULL, 'published', '9', NULL, NULL, NULL, NULL, NULL),
(13, 3, 3, 2, 0, 0, 0, '2016-03-24 13:23:43', '2016-03-25 09:56:19', '2016-03-25', NULL, 'published', '13', NULL, NULL, NULL, NULL, NULL),
(14, 3, 3, 2, 0, 0, 0, '2016-03-24 13:24:00', '2016-03-25 09:56:29', '2016-03-25', NULL, 'published', '14', NULL, NULL, NULL, NULL, NULL),
(15, 3, 3, 2, 0, 0, 0, '2016-03-24 13:24:10', '2016-03-24 13:24:10', '2016-03-24', NULL, 'published', '15', NULL, NULL, NULL, NULL, NULL),
(16, 2, 2, 2, 0, 0, 0, '2016-03-24 13:24:14', '2016-06-28 18:52:07', '2016-03-24', NULL, 'published', '16', NULL, NULL, NULL, NULL, NULL),
(17, 2, 2, 2, 0, 0, 0, '2016-03-24 13:30:28', '2016-03-24 13:31:01', '2016-03-24', NULL, 'published', '17', NULL, NULL, NULL, NULL, NULL),
(18, 2, 2, 2, 0, 0, 0, '2016-03-24 13:31:04', '2016-03-25 15:53:18', '2016-03-24', NULL, 'published', '18', NULL, NULL, NULL, NULL, NULL),
(19, 2, 2, 2, 0, 0, 0, '2016-03-24 13:31:33', '2016-03-24 13:32:11', '2016-03-24', NULL, 'published', '19', NULL, NULL, NULL, NULL, NULL),
(20, 2, 2, 2, 0, 0, 0, '2016-03-24 13:32:19', '2016-03-25 13:02:57', '2016-03-24', NULL, 'published', '20', NULL, NULL, NULL, NULL, NULL),
(21, 2, 2, 2, 0, 0, 0, '2016-03-24 13:32:39', '2016-03-24 13:33:06', '2016-03-24', NULL, 'published', '21', NULL, NULL, NULL, NULL, NULL),
(22, 2, 2, 2, 0, 0, 0, '2016-03-24 13:33:07', '2016-03-24 13:33:34', '2016-03-24', NULL, 'published', '22', NULL, NULL, NULL, NULL, NULL),
(23, 2, 2, 2, 0, 0, 0, '2016-03-24 13:33:41', '2016-03-24 13:34:21', '2016-03-24', NULL, 'published', '23', NULL, NULL, NULL, NULL, NULL),
(24, 2, 2, 2, 0, 0, 0, '2016-03-24 13:34:28', '2016-03-24 13:34:46', '2016-03-24', NULL, 'deleted', '24', NULL, NULL, NULL, NULL, NULL),
(25, 1, 1, 2, 1, 0, 0, '2016-03-25 09:45:43', '2016-03-25 09:46:08', '2016-03-25', NULL, 'published', '25', NULL, NULL, NULL, NULL, NULL),
(27, 3, 3, 2, 0, 0, 0, '2016-03-25 11:52:31', '2016-03-25 11:52:31', '2016-03-25', NULL, 'published', '27', NULL, NULL, NULL, NULL, NULL),
(28, 1, 1, 2, 1, 1, 0, '2016-03-28 07:15:17', '2016-03-28 12:41:20', '2016-03-28', NULL, 'published', '28', NULL, NULL, NULL, NULL, NULL),
(29, 1, 8, 2, 28, 0, 0, '2016-03-28 07:19:02', '2016-04-19 14:31:40', '2016-03-28', NULL, 'published', '29', NULL, NULL, NULL, NULL, NULL),
(30, 1, 8, 2, 28, 0, 0, '2016-03-28 07:19:28', '2016-03-28 12:41:33', '2016-03-28', NULL, 'published', '30', NULL, NULL, NULL, NULL, NULL),
(31, 1, 8, 2, 28, 0, 0, '2016-03-28 12:50:28', '2016-03-28 12:50:49', '2016-03-28', NULL, 'published', '31', NULL, NULL, NULL, NULL, NULL),
(34, 1, 8, 2, 28, 0, 0, '2016-03-30 07:40:52', '2016-03-30 07:41:43', '2016-03-30', NULL, 'published', '34', NULL, NULL, NULL, NULL, NULL),
(40, 11, 11, 2, 0, 1, 0, '2016-04-01 07:08:53', '2016-06-29 07:42:55', '2016-06-29', NULL, 'published', '40', NULL, NULL, NULL, NULL, NULL),
(41, 11, 11, 2, 40, 0, 0, '2016-04-01 07:09:00', '2016-06-29 11:03:41', '2016-04-01', NULL, 'published', '41', NULL, NULL, NULL, NULL, NULL),
(42, 11, 11, 2, 0, 0, 0, '2016-04-01 07:10:09', '2016-06-29 07:43:01', '2016-06-29', NULL, 'deleted', '42', NULL, NULL, NULL, NULL, NULL),
(43, 11, 11, 2, 0, 0, 0, '2016-04-01 07:10:40', '2016-04-01 08:26:37', '2016-04-01', NULL, 'published', '43', NULL, NULL, NULL, NULL, NULL),
(44, 11, 11, 2, 0, 0, 0, '2016-04-01 07:10:45', '2016-06-29 11:03:49', '2016-06-29', NULL, 'published', '44', NULL, NULL, NULL, NULL, NULL),
(45, 11, 11, 2, 0, 0, 0, '2016-04-01 07:10:50', '2016-04-01 07:10:50', '2016-04-01', NULL, 'published', '45', NULL, NULL, NULL, NULL, NULL),
(46, 11, 11, 2, 0, 0, 0, '2016-04-01 07:11:00', '2016-04-01 07:11:00', '2016-04-01', NULL, 'deleted', '46', NULL, NULL, NULL, NULL, NULL),
(47, 11, 11, 2, 0, 0, 0, '2016-04-01 07:11:07', '2016-04-01 07:11:07', '2016-04-01', NULL, 'deleted', '47', NULL, NULL, NULL, NULL, NULL),
(48, 11, 11, 2, 0, 1, 0, '2016-04-01 07:11:12', '2016-04-01 07:11:12', '2016-04-01', NULL, 'published', '48', NULL, NULL, NULL, NULL, NULL),
(49, 11, 11, 2, 40, 0, 0, '2016-04-01 08:26:25', '2016-04-01 08:26:25', '2016-04-01', NULL, 'deleted', '49', NULL, NULL, NULL, NULL, NULL),
(52, 10, 10, 2, 0, 0, 0, '2016-04-04 14:41:04', '2016-06-29 14:37:17', '2016-06-29', NULL, 'published', '52', 2, 157, 1, 0, NULL),
(54, 10, 10, 2, 0, 0, 0, '2016-04-04 16:21:23', '2016-04-12 10:57:51', '2016-04-04', NULL, 'published', '54', 2, 2, 0, 0, NULL),
(55, 10, 10, 2, 0, 0, 0, '2016-04-04 16:22:23', '2016-04-04 16:22:41', '2016-04-04', NULL, 'published', '55', NULL, NULL, NULL, NULL, NULL),
(57, 10, 10, 2, 0, 0, 0, '2016-04-05 06:12:57', '2016-04-05 06:13:34', '2016-04-05', NULL, 'published', '57', NULL, NULL, NULL, NULL, NULL),
(59, 10, 10, 2, 0, 0, 0, '2016-04-05 06:27:37', '2016-04-05 06:28:00', '2016-04-05', NULL, 'published', '59', NULL, NULL, NULL, NULL, NULL),
(92, 10, 10, 2, 0, 0, 0, '2016-04-19 08:37:19', '2016-04-19 09:33:42', '2016-04-19', NULL, 'published', '96069', 2, 2, 1, 0, NULL),
(130, 11, 11, 2, 48, 0, 0, '2016-04-20 13:36:07', '2016-04-20 13:36:07', '2016-04-20', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(146, 11, 11, 2, 0, 0, 0, '2016-06-29 07:48:27', '2016-06-29 07:48:27', '2016-06-29', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(147, 10, 10, 2, 0, 0, 0, '2016-06-29 11:54:43', '2016-06-29 11:56:31', '2016-06-29', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(150, 13, 13, 2, 0, 0, 0, '2016-06-29 13:14:24', '2016-06-29 13:14:24', '2016-06-29', NULL, 'deleted', NULL, NULL, NULL, NULL, NULL, NULL),
(151, 13, 13, 2, 0, 0, 0, '2016-06-29 13:15:56', '2016-06-29 13:19:47', '2016-06-29', NULL, 'deleted', NULL, NULL, NULL, NULL, NULL, NULL),
(152, 13, 13, 2, 0, 0, 0, '2016-06-29 13:16:56', '2016-06-29 13:16:56', '2016-06-29', NULL, 'deleted', NULL, NULL, NULL, NULL, NULL, NULL),
(153, 13, 13, 2, 0, 0, 0, '2016-06-29 13:17:23', '2016-06-29 13:17:23', '2016-06-29', NULL, 'deleted', NULL, NULL, NULL, NULL, NULL, NULL),
(154, 13, 13, 2, 0, 0, 0, '2016-06-29 13:17:31', '2016-06-29 13:17:31', '2016-06-29', NULL, 'deleted', NULL, NULL, NULL, NULL, NULL, NULL),
(155, 13, 13, 2, 0, 0, 0, '2016-06-29 13:18:21', '2016-06-29 13:18:21', '2016-06-29', NULL, 'deleted', NULL, NULL, NULL, NULL, NULL, NULL),
(156, 13, 13, 2, 0, 1, 0, '2016-06-29 13:24:09', '2016-06-29 13:45:53', '2016-06-29', NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'units'),
(157, 13, 13, 2, 156, 0, 0, '2016-06-29 13:26:32', '2016-06-29 13:26:32', '2016-06-29', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(158, 13, 13, 2, 156, 0, 0, '2016-06-29 13:26:55', '2016-06-29 13:29:48', '2016-06-29', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(159, 13, 13, 2, 156, 0, 0, '2016-06-29 13:27:09', '2016-06-29 13:27:09', '2016-06-29', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(160, 13, 13, 2, 156, 0, 0, '2016-06-29 13:27:17', '2016-06-29 13:27:17', '2016-06-29', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(161, 13, 13, 2, 156, 0, 0, '2016-06-29 13:27:27', '2016-06-29 13:27:27', '2016-06-29', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(163, 13, 13, 2, 0, 0, 0, '2016-06-29 13:36:28', NULL, NULL, NULL, 'blank', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `e_content_features`
--

CREATE TABLE IF NOT EXISTS `e_content_features` (
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
-- Структура таблицы `e_content_images`
--

CREATE TABLE IF NOT EXISTS `e_content_images` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` int(11) unsigned NOT NULL,
  `path` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `position` tinyint(5) unsigned NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_content_images_content1_idx` (`content_id`),
  KEY `position` (`position`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=28 ;

--
-- Дамп данных таблицы `e_content_images`
--

INSERT INTO `e_content_images` (`id`, `content_id`, `path`, `image`, `position`, `created`) VALUES
(1, 2, 'uploads/content/2016/03/22/', 'office3-2x.png', 1, '2016-03-22 15:14:11'),
(2, 2, 'uploads/content/2016/03/22/', 'office2-2x1.png', 2, '2016-03-22 15:14:11'),
(3, 2, 'uploads/content/2016/03/22/', 'office1-2x2.png', 3, '2016-03-22 15:14:11'),
(4, 16, 'uploads/content/2016/03/24/', 'blogpost3-16x.png', 1, '2016-03-24 14:34:56'),
(5, 17, 'uploads/content/2016/03/24/', 'blogpost2-17x.png', 1, '2016-03-24 14:35:14'),
(6, 18, 'uploads/content/2016/03/24/', 'blogpost2-18x.png', 1, '2016-03-24 14:35:18'),
(7, 19, 'uploads/content/2016/03/24/', 'blogpost1-19x.png', 1, '2016-03-24 14:35:22'),
(8, 21, 'uploads/content/2016/03/24/', 'blogpost2-21x.png', 1, '2016-03-24 14:35:26'),
(9, 22, 'uploads/content/2016/03/24/', 'blogpost3-22x.png', 1, '2016-03-24 14:35:30'),
(10, 1, 'uploads/content/2016/03/25/', 'testimonial5-1x.jpg', 1, '2016-03-25 12:33:08'),
(11, 1, 'uploads/content/2016/03/25/', 'testimonial8-1x10.jpg', 2, '2016-03-25 12:33:08'),
(12, 1, 'uploads/content/2016/03/25/', 'testimonial4-1x11.jpg', 3, '2016-03-25 12:33:08'),
(13, 1, 'uploads/content/2016/03/25/', 'testimonial7-1x12.jpg', 4, '2016-03-25 12:33:08'),
(14, 1, 'uploads/content/2016/03/25/', 'testimonial2-1x13.jpg', 0, '2016-03-25 12:33:08'),
(15, 1, 'uploads/content/2016/03/25/', 'testimonial3-1x14.jpg', 5, '2016-03-25 12:33:08'),
(20, 54, 'uploads/content/2016/04/12/', 'potd-grass_3570487k-54x.jpg', 1, '2016-04-12 08:04:02'),
(21, 52, 'uploads/content/2016/04/12/', 'pictures-38191-52x.jpg', 1, '2016-04-12 08:04:17'),
(22, 57, 'uploads/content/2016/04/12/', 'animals-smile_3379238k-57x.jpg', 1, '2016-04-12 08:04:22'),
(23, 59, 'uploads/content/2016/04/12/', '1443507958_2cd1e26200000578-0-image-a-312_1443424459664-59x.jpg', 1, '2016-04-12 08:04:26'),
(24, 55, 'uploads/content/2016/04/12/', '2fab3e6100000578-3377927-andrew_suryono_bali_i_was_taking_pictures_of_some_orangutans_in_-a-42_1451416773881-55x.jpg', 1, '2016-04-12 08:30:17'),
(25, 1, 'uploads/content/2016/04/19/', 'untitled-1-1x15.png', 6, '2016-04-19 08:02:03'),
(26, 92, 'uploads/content/2016/04/19/', '474561865-92x.jpg', 1, '2016-04-19 08:39:44'),
(27, 92, 'uploads/content/2016/04/19/', '474561835-92x26.jpg', 2, '2016-04-19 08:39:44');

-- --------------------------------------------------------

--
-- Структура таблицы `e_content_images_sizes`
--

CREATE TABLE IF NOT EXISTS `e_content_images_sizes` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `size` varchar(16) NOT NULL,
  `width` int(5) unsigned NOT NULL,
  `height` int(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `size` (`size`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `e_content_images_sizes`
--

INSERT INTO `e_content_images_sizes` (`id`, `size`, `width`, `height`) VALUES
(1, 'post', 636, 311),
(2, 'slider', 935, 450);

-- --------------------------------------------------------

--
-- Структура таблицы `e_content_info`
--

CREATE TABLE IF NOT EXISTS `e_content_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` int(10) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `url` varchar(160) DEFAULT NULL,
  `h1` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `intro` text,
  `content` text,
  PRIMARY KEY (`id`,`content_id`,`languages_id`),
  UNIQUE KEY `languages_id` (`languages_id`,`url`),
  KEY `fk_content_info_content1_idx` (`content_id`),
  KEY `fk_content_info_languages1_idx` (`languages_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=73 ;

--
-- Дамп данных таблицы `e_content_info`
--

INSERT INTO `e_content_info` (`id`, `content_id`, `languages_id`, `name`, `url`, `h1`, `title`, `keywords`, `description`, `intro`, `content`) VALUES
(1, 1, 1, 'Головна', 'home', '', 'Головна', '', '', '', '<p><img alt="" src="http://engine.loc/uploads/avatars/c81e728d9d4c2f636f067f89cc14862c.png" style="width: 128px; height: 128px;" /></p>\n'),
(3, 2, 1, 'Про нас', 'pro-nas', 'Про нас', 'Про нас', '', '<p>httpengine.locuploadsavatarscrtytry rtyrtyr Whether you want to fill this paragraph with some text like I''m doing right now, this place is perfect to describe some features or anything you want - React has a complete solution f</p>\n\n<p> <', '<p>sfd</p>\n', '<div class="row">\n<div class="col-md-12">\n<h1>We care about our work</h1>\n</div>\n</div>\n\n<div class="row">\n<div class="col-md-6">\n<p>Whether you want to fill this paragraph with some text like I&#39;m doing right now, this place is perfect to describe some features or anything you want - React has a complete solution for you.</p>\n\n<p><img alt="" src="http://engine.loc/uploads/avatars/c51ce410c124a10e0db5e4b97fc2af39.png" style="margin-left: 5px; margin-right: 5px; float: left; width: 208px; height: 120px;" />You have complete control over the look &amp; feel of your website, we offer the best quality so you take your site up and running in no time.</p>\n</div>\n\n<div class="col-md-6">\n<p>fhgfh fhgfh<img alt="" src="http://engine.loc/uploads/avatars/c51ce410c124a10e0db5e4b97fc2af39.png" style="width: 208px; height: 120px;" />fghfghfgh</p>\n\n<p>fgfghfghgfh</p>\n\n<p>React is a simple, developer-friendly way to get your site. Full of features, cool documentation ease of use, lots of pages. We want to help bringing cool stuff to people so they can get their projects faster.</p>\n<a class="join-team button button-small" href="#">Join our team</a></div>\n</div>\n\n<div class="row stats">\n<div class="col-sm-3"><strong>13</strong> employees</div>\n\n<div class="col-sm-3"><strong>10k</strong> customers</div>\n\n<div class="col-sm-3"><strong>9</strong> template pages</div>\n\n<div class="col-sm-3"><strong>13k</strong> products sold</div>\n</div>\n'),
(4, 3, 1, 'Новини', 'novyny', '', 'Новини', '', '', NULL, ''),
(5, 4, 1, 'Оплата та доставка', 'oplata-ta-dostavka', '', 'Оплата та доставка', '', '', NULL, ''),
(6, 5, 1, 'Гарантія та сервіс', 'garantiya-ta-servis', '', 'Гарантія та сервіс', '', '', NULL, ''),
(7, 6, 1, 'Діючі акції', 'diyuchi-akciї', '', 'Діючі акції', '', '', NULL, ''),
(8, 7, 1, 'Ваканcії', 'vakanciї', '', 'Ваканcії', '', '', NULL, ''),
(9, 8, 1, 'Контакти', 'kontakty', '', 'Контакти', '', '', NULL, ''),
(10, 9, 1, '404', '404', '', '404', '', '', NULL, ''),
(13, 13, 1, 'Новини', 'blog/novyny', '', 'Новини', '', '', NULL, NULL),
(14, 14, 1, 'Акції', 'akcii', '', 'Акції', '', '', NULL, NULL),
(15, 15, 1, 'Різне', 'rizne', '', 'Різне', '', '', NULL, NULL),
(16, 16, 1, '50 відтінків логотипу. Частина 2', '50-vidtinkiv-logotypu-chastyna-2', '', '50 відтінків логотипу. Частина 2', '', 'Як придумати круте лого: продовжуємо говорити про техніки, які можна використати.\nНещодавно я опублікувала статтю, в якій перерахувала 25 технік генерації ідей для логотипу. Якщо ви її не читали — обов''язково прочитайте :) А потім повертайтеся сюди :)', '', '<p>Як придумати круте лого: продовжуємо говорити про техніки, які можна використати.<br />\nНещодавно я опублікувала статтю, в якій перерахувала 25 технік генерації ідей для логотипу. Якщо ви її не читали &mdash; обов&#39;язково прочитайте :) А потім повертайтеся сюди :)</p>\n'),
(17, 17, 1, 'РЕКУРСИВНЕ ВИДАЛЕННЯ СТАРИХ АРХІВІВ В LINUX', 'rekursyvne-vydalennya-staryh-arhiviv-v-linux', '<p>РЕКУРСИВНЕ ВИДАЛЕННЯ СТАРИХ АРХІВІВ В LINUX</p>\n', 'РЕКУРСИВНЕ ВИДАЛЕННЯ СТАРИХ АРХІВІВ В LINUX', '', '', NULL, '<p>Виникла проблема &mdash; на одному з серверів для збереження бекапів переповнилося місце. Через це на іншому сервері також переповнилося місце. Тому що спочатку робиться архів локально, а потім переміщується на один із серверів бекапів.</p>\n\n<p><img alt="" src="http://engine.loc/uploads/avatars/office1.png" style="width: 932px; height: 450px;" />Але ми адміни ліниві, і вручну перегладати директорії і видаляти архіви понад кількі місяців точно не будемо. Особливо, коли проектів понад 200. Виручить простенький скрипт, який треба повішати на cron.&nbsp;</p>\n'),
(18, 18, 1, '50 ВІДТІНКІВ ЛОГОТИПУ. ЧАСТИНА 1', '50-vidtinkiv-logotypu-chastyna-1', '<p>50 ВІДТІНКІВ ЛОГОТИПУ. ЧАСТИНА 1.2</p>\n', '50 ВІДТІНКІВ ЛОГОТИПУ. ЧАСТИНА 1', '', '', NULL, '<p><strong>Немає єдиного</strong> підходу до створення логотипів. Проте існує великий вибір технік та стилів, якими може скористатися дизайнер, щоб згенерувати справді круте лого.</p>\n\n<p>В цій статті я покажу <em>приклади логотипів</em>, що <strong>належать до різних категорій</strong>: по стилю, формі, глибині, кольорах, техніці виконання, використаних елементах тощо.</p>\n\n<p>Зазвичай логотип водночас належить до кількох категорій. Наприклад, логотип може бути з унікальним шрифтовим накресленням і мати різні кольорові літери, це може бути тривимірна графіка з <s><em>градієнтами</em></s> або ж персонаж чи тваринка, намальовані як імітація дитячого малюнка.</p>\n\n<p>Кажуть, що творчість полягає в здатності несподіваним чином об&#39;єднати добре відомі, звичні речі. Цю думку, принаймні щодо створення логотипів, я вважаю цілком справедливою.</p>\n\n<p>Хороший дизайнер логотипів створює унікальні логотипи за допомогою декількох інструментів, старається поєднати різні форми і техніки. Хороший дизайнер втілює дух і стиль компанії в знаці, який нестиме потрібні асоціації з діяльністю компанії.</p>\n\n<p>Коли замовник захоче спробувати зовсім іншу, кардинально нову концепцію, перегляньте ці 50 категорій &mdash; у вас неодмінно з&rsquo;явиться нове дихання та ідеї для створення ідеального логотипу.</p>\n\n<p>Осягнути всі 50 ідей за раз буває складно (або ж неефективно), тому в цій частині я покажу перші 25 технік, а решту залишу для другої частини статті ;) До речі, вона вже&nbsp;<a href="http://otakoyi.com/uk/blog/layfkhak-yak-pereviryty-adaptyvnist-vykorystovuyuchy-brauzer" target="_blank">тут</a>.&nbsp;</p>\n'),
(19, 19, 1, 'БЕКАП САЙТУ С VPS НА ВІДДАЛЕНИЙ СЕРВЕР ПО FTP', 'bekap-sajtu-s-vps-na-viddalenyj-server-po-ftp', '', 'БЕКАП САЙТУ С VPS НА ВІДДАЛЕНИЙ СЕРВЕР ПО FTP', '', '', NULL, ''),
(20, 20, 1, 'АВТОМАТИЧНИЙ ПЕРЕКЛАД В OYI.ENGINE НЕ ПРАЦЮЄ', 'avtomatychnyj-pereklad-v-oyi-engine-ne-pracyuє', '', 'АВТОМАТИЧНИЙ ПЕРЕКЛАД В OYI.ENGINE НЕ ПРАЦЮЄ', '', '', NULL, '<p>Ця стаття призначена для наших клієнтів, в яких &quot;... не зберігаються сторінки. Я вношу назву, натискаю &quot;Перекласти&quot;. Натискаю &quot;Зберегти&quot; і отримую &quot;Помилка валідації&quot;.&quot;<br />\nПояснення читайте в статті.<br />\nБільшість наших проектів мають кілька мовних версій (від 2 до 25).<br />\nВідповідно для кожної мовної версії потрібно ввести мінімум 3 обов&#39;язкові поля: назву, урл (alias), title. Помилка виникає, якщо ви не заповнюєте ці поля на всіх мовних версіях.<br />\nШвидкість створення 1 сторінки (статті, товару, категорії, ітп) напряму залежить від кількості мовних версій проекту. Щоб зекономити час роботи менеджера, і, відповідно, гроші замовника у нас стандартно<br />\nінтегрована опція автоматичного перекладу контенту на основі Google Translate API || Yandex Translate API. Yandex Translate краще перекладає контент з української на російську і навпаки, Google Translate API інші.</p>\n'),
(21, 21, 1, '6 ПРАКТИЧНИХ ПОРАД ЯК ДИЗАЙНЕРАМ УНИКАТИ КОНФЛІКТІВ З КЛІЄНТАМИ', '6-praktychnyh-porad-yak-dyzajneram-unykaty-konfliktiv-z-kliєntamy', '', '6 ПРАКТИЧНИХ ПОРАД ЯК ДИЗАЙНЕРАМ УНИКАТИ КОНФЛІКТІВ З КЛІЄНТАМИ', '', '', NULL, '<p>Будь-який фрілансер або дизайнерська компанія, незалежно від свого напрямку (веб, графіка, архітектура, 3д-моделювання), рівня цін та професійності, рано чи пізно стикається з конфліктними клієнтами. Творчість взагалі дуже проблемна галузь, залежна від суб&#39;єктивної думки. Тому особливо важливо подбати про захист своїх тилів та уникати проблемних зон у стосунках з клієнтами.</p>\n\n<p>В цій статті ми підготували шість основних питань, про які треба подбати дизайнерській компанії (або фрілансеру) для того, щоб уникнути конфліктів з клієнтами або ж, якщо вони все-таки виникнуть, максимально захистити себе.&nbsp;</p>\n'),
(22, 22, 1, 'ALLOWOVERRIDE ALL HTTPD OPTIONS ALL -INDEXES — ЗАБОРОНА ПЕРЕГЛЯДУ ПАПОК В ISPMANAGER', 'allowoverride-all-httpd-options-all-indexes-—-zaborona-pereglyadu-papok-v-ispmanager', '', 'ALLOWOVERRIDE ALL HTTPD OPTIONS ALL -INDEXES — ЗАБОРОНА ПЕРЕГЛЯДУ ПАПОК В ISPMANAGER', '', '', NULL, ''),
(26, 23, 1, '20 ПРИКЛАДІВ ЦІКАВОГО ДИЗАЙНУ САЙТІВ (ЗА БЕРЕЗЕНЬ)', '20-prykladiv-cikavogo-dyzajnu-sajtiv-za-berezen', '', '20 ПРИКЛАДІВ ЦІКАВОГО ДИЗАЙНУ САЙТІВ (ЗА БЕРЕЗЕНЬ)', '', '', NULL, '<p>Впродовж місяця нам трапляється чимало сайтів, які варті уваги з точки зору дизайну, інформаційної архітектури, інтерактивності тощо. Ми вирішили зібрати їх докупи і поділитися з вами &mdash; тиждень добігає кінця, тож є час пошукати натхнення. Сюди потрапили і звичайні сайти, і портфоліо, і лендінги. Деякі з них здобули відзнаки від&nbsp;<a href="http://www.awwwards.com/" rel="nofollow" target="_blank">Awwwards</a>,&nbsp;<a href="http://www.cssdesignawards.com/" rel="nofollow" target="_blank">CSS Design Awards</a>&nbsp;тощо.</p>\n\n<p>До речі, на прикладі цих сайтів можна простежити за всіма&nbsp;<a href="http://otakoyi.com/blog/10-trendiv-veb-dyzaynu-v-2015-rotsi/">сучасними тенденціями</a>&nbsp;в сфері веб-дизайну.&nbsp;Доведеться трохи скролити, тож будьте терплячими! :)</p>\n'),
(27, 24, 1, 'ЯКОГО БІСА ТИ СКИГЛИШ?', 'yakogo-bisa-ty-skyglysh', '<p>ЯКОГО БІСА ТИ СКИГЛИШ? ГА</p>\n', 'ЯКОГО БІСА ТИ СКИГЛИШ?', '', '', NULL, '<p>Минулого вересня на ми тестили онлайн редагування IT Weekend мені пощастило побувати на доповіді Слави Панкратова зі Школи менеджерів Стратоплан. На тлі інших доповідачів він вирізнявся своєю харизмою та вмінням захопити увагу аудиторії. З того часу мені в очі періодично впадала реклама у фейсбуці, яку я успішно ігнорував. Проте нещодавно, перебуваючи у вимушеній лікарняній відпустці та вкотре гортаючи стрічку новин, вирішив все ж таки залишити свій імейл для завантаження &laquo;Чорної книги менеджера&raquo;.</p>\n\n<p>Не знаю, чи це у мене настрій був такий, чи температура подіяла на мозок, але, на мою думку, ці 18 сторінок брутального тексту &mdash; це найбільш чесні та відверті рядки з усього, що я читав про керування персоналом та роботу в команді. Це чистий концентрат правди для всіх і кожного: починаючи від власників бізнесу, закінчуючи менеджерами всіх рівнів та їхніми підлеглими. Кожен знайде в ній щось для себе.&nbsp;<strong>Цю книгу треба прочитати обов&#39;язково!</strong></p>\n'),
(28, 25, 1, 'Пошук', 'poshuk', '', 'Пошук', '', '', NULL, ''),
(30, 27, 1, 'Всяка всячина', 'vsyaka-vsyachyna', '', 'Всяка всячина', '', '', NULL, NULL),
(31, 28, 1, 'Аккаунт', 'account', '', 'Аккаунт', '', '', NULL, ''),
(32, 29, 1, 'Вхід ', 'account/login', '', '', '', '', NULL, ''),
(33, 30, 1, 'Реєстрація ', 'account/register', '', 'Реєстрація', '', '', NULL, ''),
(34, 31, 1, 'Профіль', 'account/profile', '', 'Профіль', '', '', NULL, ''),
(35, 34, 1, 'Нагадати пароль', 'account/fp', '', 'Нагадати пароль', '', '', NULL, ''),
(37, 40, 1, 'Цифрове фото', 'cyfrove-foto', '', 'Цифрове фото, Планшетні ПК', '', '', NULL, '<p>retert</p>\n'),
(38, 41, 1, 'Цифрові фотоапарати', 'cyfrovi-fotoaparaty', '', 'Цифрові фотоапарати', '', '', '', '<p>dgfdg</p>\n'),
(39, 42, 1, 'Планшетні ПК111', 'planshetni-pk111', '', 'Планшетні ПК', '', '', NULL, NULL),
(40, 43, 1, 'Комп''ютерна периферія', 'komp-yuterna-peryferiya', '', 'Комп''ютерна периферія', '', '', NULL, NULL),
(41, 44, 1, 'Телефони  aa', 'telefony-aa', '', 'Телефони ', '', '', NULL, NULL),
(42, 45, 1, 'Аудіо, портативна техніка', 'audio-portatyvna-tehnika', '', 'Аудіо, портативна техніка', '', '', NULL, NULL),
(43, 46, 1, 'Активний відпочинок, обігрівачі', 'aktyvnyj-vidpochynok-obigrivachi', '', 'Активний відпочинок, обігрівачі', '', '', NULL, NULL),
(44, 47, 1, 'Чохли та супутні товари', 'chohly-ta-suputni-tovary', '', 'Чохли та супутні товари', '', '', NULL, NULL),
(45, 48, 1, 'Годинники', 'godynnyky', '', 'Годинники', '', '', NULL, NULL),
(46, 49, 1, 'Штативи', 'shtatyvy', '', 'Штативи', '', '', NULL, NULL),
(47, 52, 1, 'ACER Iconia A1-840 FHD 8'''' 16 GBrtertertr', 'acer-iconia-a1-840-fhd-8-16-gbrtertertr', '', 'ACER Iconia A1-840 FHD 8'''' 16 GB', '', '', '', ''),
(48, 54, 1, 'Смартфон Samsung J500H Galaxy J5', 'smartfon-samsung-j500h-galaxy-j5', '', 'Смартфон Samsung J500H Galaxy J5', '', '', NULL, ''),
(49, 55, 1, 'Смартфон Keneksi Choice Dual Sim', 'smartfon-keneksi-choice-dual-sim', '', 'Смартфон Keneksi Choice Dual Sim', '', '', NULL, ''),
(51, 57, 1, 'Смартфон Keneksi Choice Dual Sim2', 'smartfon-keneksi-choice-dual-sim2', '', 'Смартфон Keneksi Choice Dual Sim2', '', '', NULL, ''),
(52, 59, 1, 'Смартфон Lenovo A1000 Dual Sim', 'smartfon-lenovo-a1000-dual-sim', '', 'Смартфон Lenovo A1000 Dual Sim', '', '', NULL, ''),
(53, 92, 1, 'PHILIPS E320', 'philips-e320', '', 'PHILIPS E320', '', '', NULL, ''),
(54, 130, 1, 'Іміджеві', 'imidzhevi', '', 'Іміджеві', '', '', NULL, NULL),
(55, 146, 1, 'Аксесуари', 'aksesuary', '', 'Аксесуари', '', '', NULL, NULL),
(56, 147, 1, 'DL2133NMWH BK', 'dl2133nmwh-bk', '', 'DL2133NMWH BK', '', '', '', ''),
(61, 150, 1, 'sdffsdfsdf', 'sdffsdfsdf', '', 'sdffsdfsdf', '', '', NULL, NULL),
(62, 151, 1, 'wБуfsdfdsfsdf', 'wbufsdfdsfsdf', '', 'Буfsdfdsfsdf', '', '', NULL, NULL),
(63, 152, 1, 'retretretert', 'retretretert', '', 'retretretert', '', '', NULL, NULL),
(64, 153, 1, 'werwerewrewr', 'werwerewrewr', '', 'werwerewrewr', '', '', NULL, NULL),
(65, 154, 1, 'aaaaaaaaaaaasssssssss', 'aaaaaaaaaaaasssssssss', '', 'aaaaaaaaaaaasssssssss', '', '', NULL, NULL),
(66, 155, 1, 'dsfsdfdsqaaaaaaaaaa', 'dsfsdfdsqaaaaaaaaaa', '', 'dsfsdfdsqaaaaaaaaaa', '', '', NULL, NULL),
(67, 156, 1, 'Кількість', 'kil-kist', '', 'Кількість', '', '', NULL, NULL),
(68, 157, 1, 'шт.', 'sht', '', 'шт.', '', '', NULL, NULL),
(69, 158, 1, 'уп.', 'up', '', 'уп.', '', '', NULL, NULL),
(70, 159, 1, 'г.', 'g', '', 'г.', '', '', NULL, NULL),
(71, 160, 1, 'кг.', 'kg', '', 'кг.', '', '', NULL, NULL),
(72, 161, 1, 'т.', 't', '', 'т.', '', '', NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `e_content_relationship`
--

CREATE TABLE IF NOT EXISTS `e_content_relationship` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` int(10) unsigned NOT NULL,
  `categories_id` int(10) unsigned NOT NULL,
  `is_main` tinyint(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`,`content_id`,`categories_id`),
  UNIQUE KEY `content_id` (`content_id`,`categories_id`),
  KEY `fk_content_relationship_content1_idx` (`content_id`),
  KEY `fk_content_relationship_content2_idx` (`categories_id`),
  KEY `is_main` (`is_main`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=101 ;

--
-- Дамп данных таблицы `e_content_relationship`
--

INSERT INTO `e_content_relationship` (`id`, `content_id`, `categories_id`, `is_main`) VALUES
(1, 16, 13, 0),
(2, 17, 13, 0),
(3, 18, 13, 0),
(4, 19, 13, 0),
(5, 20, 13, 0),
(6, 21, 13, 0),
(7, 22, 13, 0),
(8, 23, 13, 0),
(9, 24, 13, 0),
(10, 16, 15, 0),
(94, 52, 44, 0),
(29, 57, 41, 1),
(30, 59, 41, 1),
(76, 54, 41, 1),
(89, 92, 44, 1),
(96, 147, 130, 1),
(100, 52, 43, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `e_content_types`
--

CREATE TABLE IF NOT EXISTS `e_content_types` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Дамп данных таблицы `e_content_types`
--

INSERT INTO `e_content_types` (`id`, `parent_id`, `isfolder`, `type`, `name`, `is_main`, `settings`) VALUES
(1, 0, 1, 'pages', 'Сторінки', NULL, NULL),
(2, 0, 0, 'post', 'Стаття', NULL, NULL),
(3, 0, 0, 'posts_categories', 'Категорії статтей', NULL, NULL),
(4, 1, 0, '404', '404', NULL, NULL),
(6, 1, 0, 'main', 'Головна', NULL, NULL),
(7, 1, 0, 'blog', 'Блог', NULL, NULL),
(8, 1, 0, 'account', 'Аккаунт', NULL, NULL),
(9, 1, 1, 'contacts', 'Контакти', NULL, NULL),
(10, 0, 0, 'product', 'Товар', NULL, NULL),
(11, 0, 0, 'products_categories', 'Категорії товарів', NULL, NULL),
(12, 9, 0, 'aaaa', 'qqqa', NULL, NULL),
(13, 0, 0, 'guide', 'guide', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}');

-- --------------------------------------------------------

--
-- Структура таблицы `e_content_types_images_sizes`
--

CREATE TABLE IF NOT EXISTS `e_content_types_images_sizes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `types_id` tinyint(3) unsigned NOT NULL,
  `images_sizes_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`,`types_id`,`images_sizes_id`),
  KEY `fk_content_types_images_sizes1_idx` (`types_id`),
  KEY `fk_content_types_images_sizes2_idx` (`images_sizes_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=33 ;

--
-- Дамп данных таблицы `e_content_types_images_sizes`
--

INSERT INTO `e_content_types_images_sizes` (`id`, `types_id`, `images_sizes_id`) VALUES
(31, 1, 1),
(32, 1, 2),
(25, 2, 1),
(30, 4, 1),
(11, 6, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `e_currency`
--

CREATE TABLE IF NOT EXISTS `e_currency` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `symbol` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rate` decimal(7,3) DEFAULT NULL,
  `is_main` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `code` (`code`),
  KEY `is_main` (`is_main`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `e_currency`
--

INSERT INTO `e_currency` (`id`, `name`, `code`, `symbol`, `rate`, `is_main`) VALUES
(1, 'Гривня', 'UAH', 'грн', 27.000, 0),
(2, 'Долар', 'USD', '$', 1.000, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `e_delivery`
--

CREATE TABLE IF NOT EXISTS `e_delivery` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `free_from` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `module` varchar(30) DEFAULT NULL,
  `settings` text,
  `published` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `e_delivery`
--

INSERT INTO `e_delivery` (`id`, `free_from`, `price`, `module`, `settings`, `published`) VALUES
(1, 500.00, 10.00, '', 'a:2:{s:3:"key";s:1:"1";s:8:"password";s:1:"2";}', 1),
(2, 500.00, 30.00, 'NovaPoshta', 'a:2:{s:3:"key";s:1:"1";s:8:"password";s:1:"2";}', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `e_delivery_info`
--

CREATE TABLE IF NOT EXISTS `e_delivery_info` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `delivery_id` tinyint(3) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`,`delivery_id`,`languages_id`),
  KEY `fk_delivery_info_delivery1_idx` (`delivery_id`),
  KEY `fk_delivery_info_languages1_idx` (`languages_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `e_delivery_info`
--

INSERT INTO `e_delivery_info` (`id`, `delivery_id`, `languages_id`, `name`, `description`) VALUES
(1, 1, 1, 'Самовиз', '12121fds sadsadsa'),
(2, 2, 1, 'Нова пошта', 'Служба доставки нова пошта');

-- --------------------------------------------------------

--
-- Структура таблицы `e_delivery_payment`
--

CREATE TABLE IF NOT EXISTS `e_delivery_payment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `delivery_id` tinyint(3) unsigned NOT NULL,
  `payment_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`,`delivery_id`,`payment_id`),
  UNIQUE KEY `delivery_id` (`delivery_id`,`payment_id`),
  KEY `fk_delivery_payment_delivery1_idx` (`delivery_id`),
  KEY `fk_delivery_payment_payment1_idx` (`payment_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=18 ;

--
-- Дамп данных таблицы `e_delivery_payment`
--

INSERT INTO `e_delivery_payment` (`id`, `delivery_id`, `payment_id`) VALUES
(17, 2, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `e_features`
--

CREATE TABLE IF NOT EXISTS `e_features` (
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
  `position` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`,`owner_id`),
  UNIQUE KEY `code_UNIQUE` (`code`),
  KEY `fk_features_users1_idx` (`owner_id`),
  KEY `position` (`position`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=165 ;

--
-- Дамп данных таблицы `e_features`
--

INSERT INTO `e_features` (`id`, `parent_id`, `type`, `code`, `multiple`, `on_filter`, `required`, `owner_id`, `created`, `status`, `position`) VALUES
(151, 0, 'select', 'feature_1467373010', 0, NULL, 0, 2, '2016-07-01 11:36:50', 'published', 0),
(152, 0, 'select', 'feature_1467374072', 0, NULL, 0, 2, '2016-07-01 11:54:32', 'published', 0),
(153, 0, 'select', 'feature_1467374080', 0, NULL, 0, 2, '2016-07-01 11:54:40', 'published', 0),
(154, 0, 'text', 'feature_1467374090', 0, NULL, 0, 2, '2016-07-01 11:54:50', 'published', 0),
(155, 0, 'select', 'feature_1467374098', 0, NULL, 0, 2, '2016-07-01 11:54:58', 'published', 0),
(156, 0, 'select', 'feature_1467374136', 0, NULL, 0, 2, '2016-07-01 11:55:36', 'published', 0),
(157, 0, 'select', 'balans_bilogo', 0, 0, 0, 2, '2016-07-01 14:13:57', 'published', 0),
(158, 0, 'select', 'serijna_zjomka_kadriv_sek', 0, 0, 0, 2, '2016-07-01 14:16:00', 'published', 0),
(159, 0, 'select', 'maks_rozmir_kadru_kadriv_sek', 0, 0, 0, 2, '2016-07-01 14:16:12', 'published', 0),
(160, 0, 'select', 'lcd_ekran', 0, 1, 1, 2, '2016-07-01 14:20:55', 'published', 0),
(161, 0, 'select', 'sf', 0, 0, 0, 2, '2016-07-01 14:39:19', 'published', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `e_features_content`
--

CREATE TABLE IF NOT EXISTS `e_features_content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `features_id` int(10) unsigned NOT NULL,
  `content_types_id` tinyint(3) unsigned NOT NULL,
  `content_subtypes_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `content_id` int(10) unsigned NOT NULL DEFAULT '0',
  `position` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`,`features_id`,`content_types_id`,`content_subtypes_id`,`content_id`),
  UNIQUE KEY `features_id` (`features_id`,`content_types_id`,`content_subtypes_id`,`content_id`),
  KEY `fk_content_features_idx` (`features_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=90 ;

--
-- Дамп данных таблицы `e_features_content`
--

INSERT INTO `e_features_content` (`id`, `features_id`, `content_types_id`, `content_subtypes_id`, `content_id`, `position`) VALUES
(81, 157, 11, 11, 41, 1),
(82, 159, 11, 11, 41, 2),
(83, 152, 11, 11, 41, 3),
(84, 153, 11, 11, 41, 4),
(85, 160, 11, 11, 41, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `e_features_info`
--

CREATE TABLE IF NOT EXISTS `e_features_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `features_id` int(10) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`features_id`,`languages_id`),
  KEY `fk_features_info_features1_idx` (`features_id`),
  KEY `fk_features_info_languages1_idx` (`languages_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=148 ;

--
-- Дамп данных таблицы `e_features_info`
--

INSERT INTO `e_features_info` (`id`, `features_id`, `languages_id`, `name`) VALUES
(134, 151, 1, 'Кількість мегапікселів'),
(135, 152, 1, 'Максимальний розмір кадру'),
(136, 153, 1, 'Фокусна відстань, 35-мм еквівалент '),
(137, 154, 1, 'Оптичний зум'),
(138, 155, 1, 'Чутливість ISO   авто'),
(139, 156, 1, 'Діапазон витримок, сек '),
(140, 157, 1, 'Баланс білого'),
(141, 158, 1, 'Серійна зйомка, кадрів/сек'),
(142, 159, 1, 'Макс. розмір кадру; кадрів/сек'),
(143, 160, 1, 'LCD-екран'),
(144, 161, 1, 'sf');

-- --------------------------------------------------------

--
-- Структура таблицы `e_feedbacks`
--

CREATE TABLE IF NOT EXISTS `e_feedbacks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `email` varchar(60) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `message` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('new','processed') CHARACTER SET utf8 NOT NULL DEFAULT 'new',
  `ip` char(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `e_guides`
--

CREATE TABLE IF NOT EXISTS `e_guides` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) unsigned NOT NULL,
  `position` tinyint(3) unsigned NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `position` (`position`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Дамп данных таблицы `e_guides`
--

INSERT INTO `e_guides` (`id`, `parent_id`, `position`, `code`) VALUES
(1, 0, 0, 'units'),
(2, 1, 0, ''),
(3, 1, 0, ''),
(4, 1, 0, ''),
(5, 1, 0, ''),
(6, 1, 0, '');

-- --------------------------------------------------------

--
-- Структура таблицы `e_guides_info`
--

CREATE TABLE IF NOT EXISTS `e_guides_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `guides_id` int(11) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`,`guides_id`,`languages_id`),
  UNIQUE KEY `guides_id` (`guides_id`,`languages_id`),
  KEY `fk_guides_info_languages2_idx` (`languages_id`),
  KEY `fk_guides_info_guides2_idx` (`guides_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Дамп данных таблицы `e_guides_info`
--

INSERT INTO `e_guides_info` (`id`, `guides_id`, `languages_id`, `name`) VALUES
(1, 1, 1, 'Кількість'),
(2, 2, 1, 'шт.'),
(3, 3, 1, 'уп.'),
(4, 4, 1, 'г.'),
(5, 5, 1, 'кг.'),
(6, 6, 1, 'т.');

-- --------------------------------------------------------

--
-- Структура таблицы `e_languages`
--

CREATE TABLE IF NOT EXISTS `e_languages` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `code` char(2) NOT NULL,
  `name` varchar(30) NOT NULL,
  `is_main` tinyint(1) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `is_main` (`is_main`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `e_languages`
--

INSERT INTO `e_languages` (`id`, `code`, `name`, `is_main`) VALUES
(1, 'uk', 'Українська', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `e_mail_templates`
--

CREATE TABLE IF NOT EXISTS `e_mail_templates` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(30) NOT NULL,
  `name` varchar(60) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Дамп данных таблицы `e_mail_templates`
--

INSERT INTO `e_mail_templates` (`id`, `code`, `name`) VALUES
(1, 'account_register', 'Реєстрація користувача'),
(2, 'account_fp', 'Відновлення паролю'),
(3, 'comment', 'Новий коментар'),
(4, 'comments_notify_subscribers', 'Сповіщення підписників про новий кеоментар'),
(5, 'feedback', 'feedback'),
(6, 'callback', 'callback');

-- --------------------------------------------------------

--
-- Структура таблицы `e_mail_templates_info`
--

CREATE TABLE IF NOT EXISTS `e_mail_templates_info` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `templates_id` tinyint(3) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_mail_templates_info_idx` (`templates_id`),
  KEY `fk_mail_templates_info_languages1_idx` (`languages_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Дамп данных таблицы `e_mail_templates_info`
--

INSERT INTO `e_mail_templates_info` (`id`, `templates_id`, `languages_id`, `subject`, `body`) VALUES
(1, 1, 1, 'Вітаємо з реєстрацією', '<p>Вітаємо {$data.name}&nbsp;{$data.surname}. Ви успішно зареєстувались на нашому сайті.&nbsp;</p>\n\n<p>Ваш логін:&nbsp;{$data.email}</p>\n\n<p>Ваш пароль:&nbsp;{$data.password}</p>\n\n<p>Бажаєм хороших покупок</p>\n'),
(2, 2, 1, 'Відновлення паролюцйуцйу', '<p>Вітаємо {$data.name}. Ви отримали це повідомлення, так як здійснили запит на відновлення паролю.</p>\n\n<p>Для цього вам необхідно перейти по <a href="{$data.fp_link}">цьому&nbsp;посиланню</a></p>\n'),
(3, 3, 1, 'Новий коментар', '<p>Вітаємо.<br />\nНовий коментар до статі {$data.post_name}.<br />\nІм&#39;я: {$data.user.name}<br />\nEmail: {$data.user.email}<br />\nКоментар: {$data.message}<br />\n<br />\n----------------------------------<br />\nВи можете <a href="{$data.approve_url}">опублікувати коменар</a> або <a href="{$data.delete_url}">видалити</a> його.</p>\n'),
(4, 4, 1, 'Вітаємо. Новий коментар. ', '<p>Вітаємо {$data.name}. Ви отримали це повідомлення, так як слідкуєте за коментарями до статті {$data.page_name}.</p>\n\n<p>Ви можете <a href="{$data.page_url}">переглянути його тут</a>.</p>\n'),
(5, 5, 1, 'Повідолення з форми контактів', '<p>Вітаємо. Нове повідомлення з форми контактів.</p>\n\n<p>Ім&#39;я: {$data.name}</p>\n\n<p>Телефон: {$data.phone}</p>\n\n<p>Email: {$data.email}</p>\n\n<p>Повідомлення</p>\n\n<p>{$data.message}</p>\n'),
(6, 6, 1, 'Новий зворотній дзвінок', '<p>Вітаємо. Замовлено зворотній дзвінок.</p>\n\n<p>Ім&#39;я: {$data.name}</p>\n\n<p>Телефон: {$data.phone}</p>\n\n<p>Повідомлення</p>\n\n<p>{$data.message}</p>\n');

-- --------------------------------------------------------

--
-- Структура таблицы `e_modules`
--

CREATE TABLE IF NOT EXISTS `e_modules` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `icon` varchar(30) DEFAULT NULL,
  `author` varchar(60) DEFAULT NULL,
  `version` varchar(10) DEFAULT NULL,
  `controller` varchar(150) DEFAULT NULL,
  `settings` text,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `controller` (`controller`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Дамп данных таблицы `e_modules`
--

INSERT INTO `e_modules` (`id`, `icon`, `author`, `version`, `controller`, `settings`, `created`) VALUES
(8, 'fa-nav', 'Volodymyr Hodiak', '1.0.0', 'nav', NULL, '2016-03-24 08:44:14'),
(9, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'blog', NULL, '2016-03-24 13:36:39'),
(10, 'fa-user', 'Volodymyr Hodiak', '1.0.0', 'account', NULL, '2016-03-28 07:13:08'),
(11, 'fa-mail', 'Volodymyr Hodiak', '1.0.0', 'feedback', NULL, '2016-03-31 13:55:23');

-- --------------------------------------------------------

--
-- Структура таблицы `e_nav`
--

CREATE TABLE IF NOT EXISTS `e_nav` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `code` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `e_nav`
--

INSERT INTO `e_nav` (`id`, `name`, `code`) VALUES
(1, 'top', 'top'),
(2, 'aaa', 'qqqqqq');

-- --------------------------------------------------------

--
-- Структура таблицы `e_nav_items`
--

CREATE TABLE IF NOT EXISTS `e_nav_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nav_id` tinyint(3) unsigned NOT NULL,
  `content_id` int(11) unsigned NOT NULL,
  `position` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`,`nav_id`,`content_id`),
  UNIQUE KEY `nav_id` (`nav_id`,`content_id`),
  KEY `fk_nav_items_nav1_idx` (`nav_id`),
  KEY `fk_nav_items_content1_idx` (`content_id`),
  KEY `position` (`position`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Дамп данных таблицы `e_nav_items`
--

INSERT INTO `e_nav_items` (`id`, `nav_id`, `content_id`, `position`) VALUES
(8, 2, 30, 0),
(9, 2, 29, 0),
(10, 2, 28, 0),
(12, 2, 31, 0),
(1, 1, 2, 2),
(3, 1, 4, 2),
(2, 1, 3, 3),
(6, 1, 8, 5);

-- --------------------------------------------------------

--
-- Структура таблицы `e_orders_status`
--

CREATE TABLE IF NOT EXISTS `e_orders_status` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bg_color` char(7) DEFAULT NULL,
  `txt_color` varchar(7) DEFAULT NULL,
  `on_site` tinyint(1) unsigned DEFAULT NULL,
  `external_id` varchar(64) DEFAULT NULL,
  `is_main` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `external_id_2` (`external_id`),
  KEY `on_site` (`on_site`),
  KEY `external_id` (`external_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Дамп данных таблицы `e_orders_status`
--

INSERT INTO `e_orders_status` (`id`, `bg_color`, `txt_color`, `on_site`, `external_id`, `is_main`) VALUES
(5, '#f8f5f5', '#000000', 1, '1234234', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `e_orders_status_info`
--

CREATE TABLE IF NOT EXISTS `e_orders_status_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status_id` int(10) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`,`status_id`,`languages_id`),
  KEY `fk_orders_status_info_languages1_idx` (`languages_id`),
  KEY `fk_orders_status_info_orders_status1_idx` (`status_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `e_orders_status_info`
--

INSERT INTO `e_orders_status_info` (`id`, `status_id`, `languages_id`, `status`) VALUES
(4, 5, 1, 'sdfsdfds');

-- --------------------------------------------------------

--
-- Структура таблицы `e_payment`
--

CREATE TABLE IF NOT EXISTS `e_payment` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `published` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `module` varchar(60) NOT NULL,
  `settings` text,
  `position` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `module` (`module`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Дамп данных таблицы `e_payment`
--

INSERT INTO `e_payment` (`id`, `published`, `module`, `settings`, `position`) VALUES
(1, 1, '', 'a:2:{s:9:"yandex_id";s:1:"1";s:13:"yandex_secret";s:1:"2";}', 0),
(2, 1, '', NULL, 0),
(3, 1, 'LiqPay', 'a:5:{s:10:"public_key";s:1:"1";s:11:"private_key";s:1:"2";s:10:"result_url";s:1:"3";s:9:"error_url";s:1:"4";s:7:"sandbox";s:1:"5";}', 0),
(4, 1, 'YandexMoney', 'a:2:{s:9:"yandex_id";s:1:"1";s:13:"yandex_secret";s:1:"2";}', 0),
(5, 1, 'WebMoney', 'a:2:{s:5:"purse";s:1:"1";s:10:"secret_key";s:1:"2";}', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `e_payment_info`
--

CREATE TABLE IF NOT EXISTS `e_payment_info` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `payment_id` tinyint(3) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(60) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`,`payment_id`,`languages_id`),
  KEY `fk_payment_info_payment1_idx` (`payment_id`),
  KEY `fk_payment_info_languages1_idx` (`languages_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Дамп данных таблицы `e_payment_info`
--

INSERT INTO `e_payment_info` (`id`, `payment_id`, `languages_id`, `name`, `description`) VALUES
(1, 1, 1, 'При отриманні', ''),
(2, 2, 1, 'Розрахунковий рахунок', ''),
(3, 3, 1, 'Онлайн LiqPay', ''),
(4, 4, 1, 'Онлайн YandexMoney', ''),
(5, 5, 1, 'WebMoney', '');

-- --------------------------------------------------------

--
-- Структура таблицы `e_plugins`
--

CREATE TABLE IF NOT EXISTS `e_plugins` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=37 ;

--
-- Дамп данных таблицы `e_plugins`
--

INSERT INTO `e_plugins` (`id`, `icon`, `author`, `version`, `controller`, `place`, `published`, `rang`, `settings`, `created`) VALUES
(16, 'fa-picture-o', 'Volodymyr Hodiak', '1.0.0', 'contentImages', 'after_params', 1, 300, NULL, '2016-03-09 11:26:40'),
(18, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'adminsGroup', 'sidebar', 1, 300, NULL, '2016-03-17 14:57:30'),
(21, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'dashboard', 'dashboard', 1, 300, NULL, '2016-03-18 15:28:13'),
(23, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'modules', 'params', 1, 300, NULL, '2016-03-23 15:46:16'),
(24, 'fa-folder-o', 'Volodymyr Hodiak', '1.0.0', 'postsCategories', 'sidebar', 1, 300, NULL, '2016-03-25 10:53:16'),
(25, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'postsCategoriesSelect', 'params', 1, 300, NULL, '2016-03-25 12:03:47'),
(26, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'tags', 'after_params', 1, 300, NULL, '2016-03-25 14:12:23'),
(27, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'customersGroup', 'sidebar', 1, 300, NULL, '2016-03-28 08:33:12'),
(28, 'fa-comments', 'Volodymyr Hodiak', '1.0.0', 'comments', 'after_content', 1, 300, NULL, '2016-03-31 10:26:15'),
(30, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'productsCategoriesSelect', 'main', 1, 300, NULL, '2016-04-01 07:23:48'),
(31, 'fa-folder-o', 'Volodymyr Hodiak', '1.0.0', 'productsCategories', 'sidebar', 1, 300, NULL, '2016-04-01 08:17:04'),
(32, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'productsPrices', 'after_main', 1, 300, NULL, '2016-04-05 10:34:07'),
(33, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'productsVariants', 'after_main', 1, 300, NULL, '2016-04-05 12:29:51'),
(34, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'productsAccessories', 'after_features', 1, 300, NULL, '2016-04-12 06:14:56'),
(35, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'productsSimilar', 'after_params', 1, 300, NULL, '2016-04-12 13:21:46'),
(36, 'fa-folder-o', 'Volodymyr Hodiak', '1.0.0', 'pagesTree', 'sidebar', 1, 300, NULL, '2016-04-25 12:33:16');

-- --------------------------------------------------------

--
-- Структура таблицы `e_plugins_components`
--

CREATE TABLE IF NOT EXISTS `e_plugins_components` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plugins_id` tinyint(3) unsigned NOT NULL,
  `components_id` tinyint(3) unsigned NOT NULL,
  `position` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`plugins_id`,`components_id`),
  KEY `fk_plugins_components_plugins1_idx` (`plugins_id`),
  KEY `fk_plugins_components_components1_idx` (`components_id`),
  KEY `position` (`position`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=28 ;

--
-- Дамп данных таблицы `e_plugins_components`
--

INSERT INTO `e_plugins_components` (`id`, `plugins_id`, `components_id`, `position`) VALUES
(2, 18, 13, 0),
(7, 21, 1, 0),
(9, 24, 67, 0),
(10, 25, 67, 0),
(11, 26, 67, 0),
(12, 27, 68, 0),
(13, 28, 67, 0),
(14, 16, 67, 0),
(15, 16, 72, 0),
(17, 30, 72, 0),
(20, 31, 72, 0),
(21, 31, 76, 0),
(22, 32, 72, 0),
(23, 33, 72, 0),
(24, 34, 72, 0),
(25, 35, 76, 0),
(27, 36, 2, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `e_posts_tags`
--

CREATE TABLE IF NOT EXISTS `e_posts_tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `posts_id` int(11) unsigned NOT NULL,
  `tags_id` int(10) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`,`posts_id`,`tags_id`,`languages_id`),
  UNIQUE KEY `posts_id` (`posts_id`,`tags_id`),
  KEY `fk_tags_content_content1_idx` (`posts_id`),
  KEY `fk_tags_posts_tags1_idx` (`tags_id`),
  KEY `fk_posts_tags_languages1_idx` (`languages_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `e_posts_tags`
--

INSERT INTO `e_posts_tags` (`id`, `posts_id`, `tags_id`, `languages_id`) VALUES
(3, 16, 29, 1),
(4, 16, 30, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `e_products_accessories`
--

CREATE TABLE IF NOT EXISTS `e_products_accessories` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `products_id` int(10) unsigned NOT NULL,
  `accessories_id` int(10) unsigned NOT NULL,
  `position` tinyint(3) DEFAULT NULL,
  PRIMARY KEY (`id`,`products_id`,`accessories_id`),
  KEY `fk_products_accessories_content1_idx` (`products_id`),
  KEY `fk_products_accessories_content2_idx` (`accessories_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=18 ;

--
-- Дамп данных таблицы `e_products_accessories`
--

INSERT INTO `e_products_accessories` (`id`, `products_id`, `accessories_id`, `position`) VALUES
(15, 54, 55, 1),
(16, 54, 59, 2),
(17, 52, 54, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `e_products_prices`
--

CREATE TABLE IF NOT EXISTS `e_products_prices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` int(10) unsigned NOT NULL,
  `group_id` tinyint(3) unsigned NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `price_old` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`,`content_id`,`group_id`),
  UNIQUE KEY `content_id` (`content_id`,`group_id`),
  KEY `fk_products_prices_content1_idx` (`content_id`),
  KEY `fk_products_prices_users_group1_idx` (`group_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Дамп данных таблицы `e_products_prices`
--

INSERT INTO `e_products_prices` (`id`, `content_id`, `group_id`, `price`, `price_old`) VALUES
(1, 52, 20, 11.00, NULL),
(2, 52, 21, 22.00, NULL),
(3, 52, 22, 32.00, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `e_products_similar`
--

CREATE TABLE IF NOT EXISTS `e_products_similar` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `products_id` int(10) unsigned NOT NULL,
  `features_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`,`products_id`,`features_id`),
  KEY `fk_products_similar_content1_idx` (`products_id`),
  KEY `fk_products_similar_features1_idx` (`features_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `e_products_variants`
--

CREATE TABLE IF NOT EXISTS `e_products_variants` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` int(10) unsigned NOT NULL,
  `in_stock` tinyint(1) DEFAULT '1',
  `img` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`content_id`),
  KEY `fk_products_variants_content1_idx` (`content_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

--
-- Дамп данных таблицы `e_products_variants`
--

INSERT INTO `e_products_variants` (`id`, `content_id`, `in_stock`, `img`) VALUES
(22, 92, 1, '/uploads/content/2016/04/19/variants/b6d767d2f8ed5d21a44b0e5886680cb9.png'),
(23, 92, 1, '/uploads/content/2016/04/19/variants/37693cfc748049e45d87b8c7d8b9aacd.png'),
(27, 52, 1, '/uploads/content/2016/04/20/variants/02e74f10e0327ad868d138f2b4fdd6f0.png'),
(28, 52, 1, '/uploads/content/2016/04/21/variants/33e75ff09dd601bbe69f351039152189.png');

-- --------------------------------------------------------

--
-- Структура таблицы `e_products_variants_features`
--

CREATE TABLE IF NOT EXISTS `e_products_variants_features` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `variants_id` int(10) unsigned NOT NULL,
  `features_id` int(10) unsigned NOT NULL,
  `values_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`,`variants_id`,`features_id`,`values_id`),
  UNIQUE KEY `variants_id` (`variants_id`,`features_id`,`values_id`),
  KEY `fk_products_variants_features_features1_idx` (`features_id`),
  KEY `fk_products_variants_features_products_variants1_idx` (`variants_id`),
  KEY `fk_products_variants_features_features2_idx` (`values_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `e_products_variants_prices`
--

CREATE TABLE IF NOT EXISTS `e_products_variants_prices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `variants_id` int(10) unsigned NOT NULL,
  `content_id` int(10) unsigned NOT NULL,
  `group_id` tinyint(3) unsigned NOT NULL,
  `price` decimal(10,0) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`,`variants_id`,`content_id`,`group_id`),
  UNIQUE KEY `variants_id` (`variants_id`,`content_id`,`group_id`),
  KEY `fk_products_variants_prices_products_variants1_idx` (`variants_id`,`content_id`),
  KEY `fk_products_variants_prices_users_group1_idx` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `e_settings`
--

CREATE TABLE IF NOT EXISTS `e_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `value` text NOT NULL,
  `block` enum('company','common','images','themes','editor','content','seo','analitycs','robots','mail') NOT NULL,
  `type` enum('text','textarea') NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sname` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=52 ;

--
-- Дамп данных таблицы `e_settings`
--

INSERT INTO `e_settings` (`id`, `name`, `value`, `block`, `type`, `required`) VALUES
(1, 'autofil_title', '1', 'common', 'text', 1),
(2, 'autofill_url', '1', 'common', 'text', 1),
(4, 'editor_bodyId', 'cms_content', 'editor', 'text', 1),
(5, 'editor_body_class', 'cms_content', 'editor', 'text', 1),
(6, 'editor_contents_css', '/themes/default/assets/css/style.css', 'editor', 'textarea', 1),
(8, 'languages_create_info', '0', 'common', 'text', 1),
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
(29, 'google_analytics_id', 'UA-76235649-1', 'analitycs', 'text', 0),
(30, 'google_webmaster', '', 'analitycs', 'text', 0),
(31, 'yandex_webmaster', '', 'analitycs', 'text', 0),
(32, 'yandex_metric', '', 'analitycs', 'text', 0),
(35, 'delimiter', '/', 'seo', 'text', 1),
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
(46, 'mail_smtp_secure', 'tls', 'mail', 'text', 0),
(47, 'company_name', 'Premium Shop', 'company', 'text', 1),
(48, 'company_phone', '111111', 'company', 'text', 1),
(49, 'seo', 'a:5:{s:5:"pages";a:1:{i:1;a:4:{s:5:"title";s:34:"{title} {delimiter} {company_name}";s:8:"keywords";s:37:"{keywords} {delimiter} {company_name}";s:11:"description";s:13:"{description}";s:2:"h1";s:4:"{h1}";}}s:4:"post";a:1:{i:1;a:4:{s:5:"title";s:67:"{title} {delimiter}  {category} {delimiter} блог {company_name}";s:8:"keywords";s:46:"{keywords} {delimiter} блог {company_name}";s:11:"description";s:49:"{description} {delimiter} блог {company_name}";s:2:"h1";s:4:"{h1}";}}s:9:"posts_cat";a:1:{i:1;a:4:{s:5:"title";s:44:"{title} {delimiter}  блог {company_name}";s:8:"keywords";s:37:"{keywords} {delimiter} {company_name}";s:11:"description";s:40:"{description} {delimiter} {company_name}";s:2:"h1";s:4:"{h1}";}}s:8:"products";a:1:{i:1;a:4:{s:5:"title";s:51:"{title} {delimiter} купити в  {company_name}";s:8:"keywords";s:37:"{keywords} {delimiter} {company_name}";s:11:"description";s:40:"{description} {delimiter} {company_name}";s:2:"h1";s:31:"{h1} {delimiter} {company_name}";}}s:18:"productsCategories";a:1:{i:1;a:4:{s:5:"title";s:51:"{title} {delimiter} купити в  {company_name}";s:8:"keywords";s:37:"{keywords} {delimiter} {company_name}";s:11:"description";s:40:"{description} {delimiter} {company_name}";s:2:"h1";s:31:"{h1} {delimiter} {company_name}";}}}', '', '', 0),
(50, 'home_id', '1', 'common', 'text', 1),
(51, 'widgets', 'a:1:{s:14:"callbacks.form";a:1:{i:0;a:2:{s:2:"id";s:11:"blog.sample";s:4:"data";a:1:{s:4:"name";s:18:"asdasdasdfdgdfgfdg";}}}}', 'common', 'text', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `e_tags`
--

CREATE TABLE IF NOT EXISTS `e_tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tag` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=31 ;

--
-- Дамп данных таблицы `e_tags`
--

INSERT INTO `e_tags` (`id`, `tag`) VALUES
(17, 'php'),
(18, 'mysql'),
(19, 'jquery'),
(20, 'sdfsdf'),
(21, 'sdf'),
(22, 'sd'),
(23, 'f'),
(24, 'dsf'),
(26, 'v'),
(27, 'b'),
(29, 'd'),
(30, 'cc');

-- --------------------------------------------------------

--
-- Структура таблицы `e_users`
--

CREATE TABLE IF NOT EXISTS `e_users` (
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
  `skey` varchar(64) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime NOT NULL,
  `lastlogin` timestamp NULL DEFAULT NULL,
  `status` enum('active','ban','deleted') NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`,`group_id`,`languages_id`),
  UNIQUE KEY `phone` (`phone`,`email`),
  KEY `fk_users_group1_idx` (`group_id`),
  KEY `status` (`status`),
  KEY `skey` (`skey`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=22 ;

--
-- Дамп данных таблицы `e_users`
--

INSERT INTO `e_users` (`id`, `group_id`, `languages_id`, `sessid`, `name`, `surname`, `phone`, `email`, `password`, `avatar`, `skey`, `created`, `updated`, `lastlogin`, `status`) VALUES
(2, 1, 0, 'kc7uphjmss68v9al9aels3pf42', 'Володимир', 'Годяк', '+38 (067) 6736242', 'wmgodyak@gmail.com', 'MTTuFPm3y4m2o', '/uploads/avatars/c81e728d9d4c2f636f067f89cc14862c.png', NULL, '2016-03-03 13:25:08', '2016-04-21 11:24:28', '2016-07-01 11:06:19', 'active'),
(19, 1, 0, NULL, 'Жорік', 'Васильович', '+77 (777) 7777777', 'otakoyi1@gmail.com', 'MTYFiZEAZZjt.', NULL, NULL, '2016-06-18 10:25:22', '0000-00-00 00:00:00', NULL, 'ban'),
(21, 20, 0, NULL, 'Жорік', 'Абрамович', '+99 (999) 9999999', 'sz@otakoyi.com', 'OT55OBip4.nJU', NULL, NULL, '2016-06-28 06:21:16', '0000-00-00 00:00:00', NULL, 'active');

-- --------------------------------------------------------

--
-- Структура таблицы `e_users_group`
--

CREATE TABLE IF NOT EXISTS `e_users_group` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` tinyint(3) unsigned NOT NULL,
  `isfolder` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `backend` tinyint(1) unsigned DEFAULT NULL,
  `permissions` text,
  `position` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`parent_id`),
  KEY `sort` (`position`),
  KEY `isfolder` (`isfolder`),
  KEY `backend` (`backend`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=23 ;

--
-- Дамп данных таблицы `e_users_group`
--

INSERT INTO `e_users_group` (`id`, `parent_id`, `isfolder`, `backend`, `permissions`, `position`) VALUES
(1, 0, 0, 1, 'a:1:{s:11:"full_access";s:1:"1";}', 1),
(2, 0, 0, 1, 'a:15:{s:11:"full_access";s:1:"0";s:9:"Dashboard";a:3:{i:0;s:5:"index";i:1;s:6:"create";i:2;s:4:"edit";}s:12:"content\\Post";a:6:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";i:4;s:3:"pub";i:5;s:4:"hide";}s:9:"Customers";a:7:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";i:4;s:6:"remove";i:5;s:3:"ban";i:6;s:7:"restore";}s:8:"Comments";a:9:{i:0;s:5:"index";i:1;s:3:"tab";i:2;s:5:"items";i:3;s:6:"create";i:4;s:4:"edit";i:5;s:5:"reply";i:6;s:7:"approve";i:7;s:4:"spam";i:8;s:7:"restore";}s:4:"Shop";a:3:{i:0;s:5:"index";i:1;s:6:"create";i:2;s:4:"edit";}s:16:"content\\Products";a:6:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";i:4;s:3:"pub";i:5;s:4:"hide";}s:26:"content\\ProductsCategories";a:6:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";i:4;s:3:"pub";i:5;s:4:"hide";}s:8:"Currency";a:4:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";}s:8:"Delivery";a:7:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";i:4;s:17:"getModuleSettings";i:5;s:3:"pub";i:6;s:4:"hide";}s:9:"Callbacks";a:8:{i:0;s:5:"index";i:1;s:3:"tab";i:2;s:5:"items";i:3;s:6:"create";i:4;s:4:"edit";i:5;s:5:"reply";i:6;s:4:"spam";i:7;s:7:"restore";}s:13:"content\\Pages";a:6:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";i:4;s:3:"pub";i:5;s:4:"hide";}s:32:"plugins\\ProductsCategoriesSelect";a:4:{i:0;s:5:"index";i:1;s:6:"create";i:2;s:4:"edit";i:3;s:7:"setMeta";}s:26:"plugins\\ProductsCategories";a:8:{i:0;s:5:"index";i:1;s:6:"create";i:2;s:4:"edit";i:3;s:4:"tree";i:4;s:4:"move";i:5;s:16:"createCategories";i:6;s:14:"editCategories";i:7;s:7:"setMeta";}s:17:"plugins\\PagesTree";a:6:{i:0;s:5:"index";i:1;s:6:"create";i:2;s:4:"edit";i:3;s:4:"tree";i:4;s:4:"move";i:5;s:7:"setMeta";}}', 0),
(4, 0, 0, 1, 'a:2:{s:11:"full_access";s:1:"0";s:5:"Admin";a:9:{i:0;s:4:"data";i:1;s:2:"id";i:2;s:5:"login";i:3;s:2:"fp";i:4;s:6:"logout";i:5;s:7:"profile";i:6;s:5:"index";i:7;s:6:"create";i:8;s:4:"edit";}}', 0),
(20, 0, 0, 0, 'N;', 0),
(21, 0, 0, 0, 'N;', 0),
(22, 0, 0, 0, 'N;', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `e_users_group_info`
--

CREATE TABLE IF NOT EXISTS `e_users_group_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` tinyint(3) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`languages_id`),
  KEY `fk_users_group_info_users_group1_idx` (`group_id`),
  KEY `fk_users_group_info_languages1_idx` (`languages_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=37 ;

--
-- Дамп данных таблицы `e_users_group_info`
--

INSERT INTO `e_users_group_info` (`id`, `group_id`, `languages_id`, `name`) VALUES
(15, 1, 1, 'Адміністратори'),
(16, 2, 1, 'Редактори'),
(18, 4, 1, 'Модератори'),
(34, 20, 1, 'Роздріб'),
(35, 21, 1, 'Гурт'),
(36, 22, 1, 'Дрібний гурт');

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `e_banners`
--
ALTER TABLE `e_banners`
  ADD CONSTRAINT `fk_banners_banners_places1` FOREIGN KEY (`places_id`) REFERENCES `e_banners_places` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_banners_languages1` FOREIGN KEY (`languages_id`) REFERENCES `e_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_comments`
--
ALTER TABLE `e_comments`
  ADD CONSTRAINT `fk_comments_content1` FOREIGN KEY (`content_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_users_id` FOREIGN KEY (`users_id`) REFERENCES `e_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_comments_subscribers`
--
ALTER TABLE `e_comments_subscribers`
  ADD CONSTRAINT `fk_comments_subscribers_content1` FOREIGN KEY (`content_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_comments_subscribers_users1` FOREIGN KEY (`users_id`) REFERENCES `e_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_content`
--
ALTER TABLE `e_content`
  ADD CONSTRAINT `fk_content_content_subtypes1` FOREIGN KEY (`subtypes_id`) REFERENCES `e_content_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_content_content_types1` FOREIGN KEY (`types_id`) REFERENCES `e_content_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_content_owner_id1` FOREIGN KEY (`owner_id`) REFERENCES `e_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_content_features`
--
ALTER TABLE `e_content_features`
  ADD CONSTRAINT `fk_content_features_values_content1` FOREIGN KEY (`content_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_content_features_values_features1` FOREIGN KEY (`features_id`) REFERENCES `e_features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_content_images`
--
ALTER TABLE `e_content_images`
  ADD CONSTRAINT `fk_content_images_content1` FOREIGN KEY (`content_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_content_info`
--
ALTER TABLE `e_content_info`
  ADD CONSTRAINT `fk_content_info_content1` FOREIGN KEY (`content_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_content_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `e_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_content_relationship`
--
ALTER TABLE `e_content_relationship`
  ADD CONSTRAINT `fk_content_relationship_content1` FOREIGN KEY (`content_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_content_relationship_content2` FOREIGN KEY (`categories_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_content_types_images_sizes`
--
ALTER TABLE `e_content_types_images_sizes`
  ADD CONSTRAINT `fk_content_types_images_sizes1` FOREIGN KEY (`types_id`) REFERENCES `e_content_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_content_types_images_sizes2` FOREIGN KEY (`images_sizes_id`) REFERENCES `e_content_images_sizes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_delivery_info`
--
ALTER TABLE `e_delivery_info`
  ADD CONSTRAINT `fk_delivery_info_delivery1` FOREIGN KEY (`delivery_id`) REFERENCES `e_delivery` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_delivery_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `e_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_delivery_payment`
--
ALTER TABLE `e_delivery_payment`
  ADD CONSTRAINT `fk_delivery_payment_delivery1` FOREIGN KEY (`delivery_id`) REFERENCES `e_delivery` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_delivery_payment_payment1` FOREIGN KEY (`payment_id`) REFERENCES `e_payment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_features`
--
ALTER TABLE `e_features`
  ADD CONSTRAINT `fk_features_users1` FOREIGN KEY (`owner_id`) REFERENCES `e_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_features_content`
--
ALTER TABLE `e_features_content`
  ADD CONSTRAINT `fk_content_features_idx` FOREIGN KEY (`features_id`) REFERENCES `e_features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_features_info`
--
ALTER TABLE `e_features_info`
  ADD CONSTRAINT `fk_features_info_features1` FOREIGN KEY (`features_id`) REFERENCES `e_features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_features_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `e_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_guides_info`
--
ALTER TABLE `e_guides_info`
  ADD CONSTRAINT `fk_guides_info_guides2` FOREIGN KEY (`guides_id`) REFERENCES `e_guides` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_guides_info_languages2` FOREIGN KEY (`languages_id`) REFERENCES `e_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_mail_templates_info`
--
ALTER TABLE `e_mail_templates_info`
  ADD CONSTRAINT `fk_mail_templates_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `e_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_mail_templates_info_mail_templates1` FOREIGN KEY (`templates_id`) REFERENCES `e_mail_templates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_nav_items`
--
ALTER TABLE `e_nav_items`
  ADD CONSTRAINT `fk_nav_items_content1` FOREIGN KEY (`content_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_nav_items_nav1` FOREIGN KEY (`nav_id`) REFERENCES `e_nav` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_orders_status_info`
--
ALTER TABLE `e_orders_status_info`
  ADD CONSTRAINT `fk_orders_status_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `e_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_orders_status_info_orders_status1` FOREIGN KEY (`status_id`) REFERENCES `e_orders_status` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_payment_info`
--
ALTER TABLE `e_payment_info`
  ADD CONSTRAINT `fk_payment_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `e_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_payment_info_payment1` FOREIGN KEY (`payment_id`) REFERENCES `e_payment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_plugins_components`
--
ALTER TABLE `e_plugins_components`
  ADD CONSTRAINT `fk_plugins_components_components1` FOREIGN KEY (`components_id`) REFERENCES `e_components` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_plugins_components_plugins1` FOREIGN KEY (`plugins_id`) REFERENCES `e_plugins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_posts_tags`
--
ALTER TABLE `e_posts_tags`
  ADD CONSTRAINT `fk_posts_tags_languages1` FOREIGN KEY (`languages_id`) REFERENCES `e_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tags_content1` FOREIGN KEY (`posts_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tags_posts_tags1` FOREIGN KEY (`tags_id`) REFERENCES `e_tags` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_products_accessories`
--
ALTER TABLE `e_products_accessories`
  ADD CONSTRAINT `fk_products_accessories_content1` FOREIGN KEY (`products_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_products_accessories_content2` FOREIGN KEY (`accessories_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_products_prices`
--
ALTER TABLE `e_products_prices`
  ADD CONSTRAINT `fk_products_prices_content1` FOREIGN KEY (`content_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_products_prices_users_group1` FOREIGN KEY (`group_id`) REFERENCES `e_users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_products_similar`
--
ALTER TABLE `e_products_similar`
  ADD CONSTRAINT `fk_products_similar_content1` FOREIGN KEY (`products_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_products_similar_features1` FOREIGN KEY (`features_id`) REFERENCES `e_features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_products_variants`
--
ALTER TABLE `e_products_variants`
  ADD CONSTRAINT `fk_products_variants_content1` FOREIGN KEY (`content_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_products_variants_features`
--
ALTER TABLE `e_products_variants_features`
  ADD CONSTRAINT `fk_products_variants_features_features1` FOREIGN KEY (`features_id`) REFERENCES `e_features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_products_variants_features_features2` FOREIGN KEY (`values_id`) REFERENCES `e_features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_products_variants_features_products_variants1` FOREIGN KEY (`variants_id`) REFERENCES `e_products_variants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_products_variants_prices`
--
ALTER TABLE `e_products_variants_prices`
  ADD CONSTRAINT `fk_products_variants_prices_products_variants1` FOREIGN KEY (`variants_id`, `content_id`) REFERENCES `e_products_variants` (`id`, `content_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_products_variants_prices_users_group1` FOREIGN KEY (`group_id`) REFERENCES `e_users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_users`
--
ALTER TABLE `e_users`
  ADD CONSTRAINT `fk_users_users_group1` FOREIGN KEY (`group_id`) REFERENCES `e_users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_users_group_info`
--
ALTER TABLE `e_users_group_info`
  ADD CONSTRAINT `fk_users_group_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `e_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_users_group_info_users_group1` FOREIGN KEY (`group_id`) REFERENCES `e_users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
