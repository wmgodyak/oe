-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Апр 11 2016 г., 16:48
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
-- Структура таблицы `banners`
--

CREATE TABLE IF NOT EXISTS `banners` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `banners_places_id` int(10) unsigned NOT NULL,
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
  PRIMARY KEY (`id`,`banners_places_id`,`languages_id`),
  UNIQUE KEY `skey_UNIQUE` (`skey`),
  KEY `fk_banners_banners_places1_idx` (`banners_places_id`),
  KEY `fk_banners_languages1_idx` (`languages_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Дамп данных таблицы `banners`
--

INSERT INTO `banners` (`id`, `banners_places_id`, `languages_id`, `skey`, `img`, `name`, `published`, `permanent`, `df`, `dt`, `url`, `target`) VALUES
(6, 1, 1, 'd32b004b6fe914a51847bf782648f6a2', '/uploads/content/2016/04/11/1679091c5a880faf6fb5e6087eb1b2dc.jpg', 'aa', 1, 1, '0000-00-00', '0000-00-00', 'a', '_self'),
(7, 1, 1, '556074529d9c821315235cba2718ef9b', '/uploads/content/2016/04/08/8f14e45fceea167a5a36dedd4bea2543.jpg', 'aa', 1, 0, '2016-04-18', '2016-04-21', 'aa', '_self'),
(8, 1, 1, '15e85489e56c9b3240c98b292bbc2df4', '/uploads/content/2016/04/08/c9f0f895fb98ab9159f51fd0297e236d.jpg', 'wrwerwe', 1, 1, '0000-00-00', '0000-00-00', 'wrwer', '_self'),
(9, 1, 1, 'b7568609e20f23e4ca9ee714a4eb0806', '/uploads/content/2016/04/08/45c48cce2e2d7fbdea1afc51c7c6ad26.jpg', 'aaa', 1, 1, '0000-00-00', '0000-00-00', 'aaaaa', '_self'),
(10, 1, 1, '8532ea7767499e0c9140d9ad3dff3e8b', '/uploads/content/2016/04/08/d3d9446802a44259755d38e6d163e820.jpg', 'aaa', 1, 1, '0000-00-00', '0000-00-00', 'aaaa', '_self'),
(11, 1, 1, '1571f4a9628a81c6a21d8acb13c17265', '/uploads/content/2016/04/08/6512bd43d9caa6e02c990b0a82652dca.jpg', 'wqewqeqwe', 1, 1, '0000-00-00', '0000-00-00', 'qweqweqwe', '_self');

-- --------------------------------------------------------

--
-- Структура таблицы `banners_places`
--

CREATE TABLE IF NOT EXISTS `banners_places` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(45) DEFAULT NULL,
  `name` varchar(60) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Дамп данных таблицы `banners_places`
--

INSERT INTO `banners_places` (`id`, `code`, `name`, `width`, `height`) VALUES
(1, 'aaa', 'першаaaa', 111, 150),
(3, 'bbb', 'другий', 1001, 100);

-- --------------------------------------------------------

--
-- Структура таблицы `banners_stat`
--

CREATE TABLE IF NOT EXISTS `banners_stat` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `banners_id` int(10) unsigned NOT NULL,
  `shows` int(10) unsigned DEFAULT NULL,
  `clicks` int(10) unsigned DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`,`banners_id`),
  KEY `fk_banners_stat_banners1_idx` (`banners_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `callbacks`
--

CREATE TABLE IF NOT EXISTS `callbacks` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Дамп данных таблицы `callbacks`
--

INSERT INTO `callbacks` (`id`, `users_id`, `phone`, `name`, `message`, `comment`, `created`, `ip`, `status`, `manager_id`, `updated`) VALUES
(4, 3, '+35 (555) 5555555', 'Жорік Ревазов', 'qwewqe', '', '2016-04-11 08:32:36', '127.0.0.1', 'processed', 2, '2016-04-11 09:01:19'),
(6, 3, '+38(055)555-55-55', 'Жорік Ревазов', 'jujjjjjj', NULL, '2016-04-11 09:02:11', '127.0.0.1', 'new', NULL, '0000-00-00 00:00:00');

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
-- Структура таблицы `comments`
--

CREATE TABLE IF NOT EXISTS `comments` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=27 ;

--
-- Дамп данных таблицы `comments`
--

INSERT INTO `comments` (`id`, `parent_id`, `isfolder`, `content_id`, `users_id`, `message`, `rate`, `status`, `created`, `ip`, `skey`) VALUES
(1, 0, 0, 16, 3, 'eertertert', 1.0, 'approved', '2016-03-30 13:27:52', '127.0.0.1', 'd41d8cd98f00b204e9800998ecf8427e'),
(2, 0, 0, 16, 3, 'eertertert', 1.0, 'approved', '2016-03-30 13:28:17', '127.0.0.1', 'b48e822fbda90eb3b3bc757517c3836e'),
(3, 0, 0, 16, 3, 'укекуеуке', 1.0, 'approved', '2016-03-30 13:31:55', '127.0.0.1', '9c25031acc2d3983ea7e726690db5f90'),
(4, 0, 1, 16, 3, ' я опублікувала статтю, в якій перерахувала 25 технік генерації ідей для логотипу. Якщо ви її не читали — обов''язково прочитайте :) А потім повертайтеся сюди :)\n', 1.0, 'approved', '2016-03-30 14:34:39', '127.0.0.1', 'c213bd663062279e03ba6adbf164f4c9'),
(5, 0, 1, 16, 3, 'Як придумати круте лого: продовжуємо говорити про техніки, які можна використати.\nНещодавно я опублікувала статтю, в якій перерахувала 25 технік генерації ідей для логотипу. Якщо ви її не читали — обов''язково прочитайте :) А потім повертайтеся сюди :)', 1.0, 'approved', '2016-03-30 14:36:08', '127.0.0.1', '340eefb5d284b21ba9fdfcf9cdc58c58'),
(6, 4, 1, 16, 3, 'Нещодавно я опублікувала статтю, в якій перерахувала 25 технік генерації ідей для логотипу. Якщо ви її не читали — обов''язково прочитайте :) А потім повертайтеся сюди :)', 1.0, 'approved', '2016-03-30 15:10:43', '127.0.0.1', 'a9a636cb5bab3cd034f6312e6387a828'),
(7, 5, 0, 16, 3, 'Нещодавно я опублікувала статтю, в якій перерахувала 25 технік генерації ідей для логотипу. Якщо ви її не читали — обов''язково прочитайте :) А потім повертайтеся сюди :)', 1.0, 'approved', '2016-03-30 15:10:48', '127.0.0.1', 'a460cca9058c56bdd8152e9f0842b530'),
(8, 7, 0, 16, 3, 'я опублікувала статтю, в якій перерахувала 25 технік генерації ідей для логотипу. Якщо ви її не читали — обов''язково прочитайте :) А потім по', 1.0, 'approved', '2016-03-30 15:19:05', '127.0.0.1', 'a2ad7b0b5608a88752fcd1d55b423df1'),
(9, 7, 0, 16, 3, 'ewrwer', 1.0, 'approved', '2016-03-30 15:19:43', '127.0.0.1', 'da28c000d5ca20ff3a01ef73e8890d01'),
(10, 0, 0, 16, 3, 'dsfdsf sdf sdf ', 1.0, 'approved', '2016-03-31 06:17:22', '127.0.0.1', '4c1abdd31bef2c7da87763d22a68de40'),
(11, 0, 1, 16, 15, 'я опублікувала статтю, в якій перерахувала 25 технік генерації ідей для логотипу. Якщо ви її не читали — обов''язково прочитайте :) А потім повертайтеся сюди :)', 1.0, 'approved', '2016-03-31 06:53:02', '127.0.0.1', '81a66e5c77d7549fd03fcf264c737afe'),
(12, 11, 1, 16, 3, '345435345 ggdfgdfg', 1.0, 'approved', '2016-03-31 06:54:37', '127.0.0.1', '17cd3a66cfc46e9def2aa961a9e49a58'),
(13, 0, 0, 16, 15, 'я опублікувала статтю, в якій перерахувала 25 технік генерації ідей для логотипу. Якщо ви її не читали — обов''язково прочитайте :) А потім повертайтеся сюди :)', 1.0, 'approved', '2016-03-31 06:56:08', '127.0.0.1', '81a66e5c77d7549fd03fcf264c737afe'),
(14, 6, 0, 16, 3, 'Жорік Ревазов\nя опублікувала статтю, в якій перерахувала 25 технік генерації ідей для логотипу. Якщо ви її не читали — обов''язково прочитайте :) А потім повертайтеся сюди :)', 1.0, 'approved', '2016-03-31 06:57:53', '127.0.0.1', 'de5a5df31ef353e979860181e96432fc'),
(15, 14, 0, 16, 2, 'в якій перерахувала 25 технік генерації ідей для логотипу. Якщо ви її не читали — обов''язково прочитайте :) А потім повертайтеся сюди :)', 1.0, 'approved', '2016-03-31 08:46:30', '127.0.0.1', NULL),
(16, 14, 0, 16, 2, 'обов''язково прочитайте :) А потім повертайтеся сюди :)', 1.0, 'approved', '2016-03-31 08:48:38', '127.0.0.1', NULL),
(17, 13, 0, 16, 2, 'ertertert', 1.0, 'approved', '2016-03-31 08:49:52', '127.0.0.1', NULL),
(18, 13, 0, 16, 2, 'werewrwer', 1.0, 'approved', '2016-03-31 08:49:58', '127.0.0.1', NULL),
(19, 13, 0, 16, 2, 'werwerwer', 1.0, 'approved', '2016-03-31 08:50:04', '127.0.0.1', NULL),
(21, 19, 0, 16, 2, 'dfdsfsd', 1.0, 'approved', '2016-03-31 09:11:27', '127.0.0.1', NULL),
(23, 21, 0, 16, 2, 'rtyr', 1.0, 'approved', '2016-03-31 09:15:54', '127.0.0.1', NULL),
(24, 12, 0, 16, 3, ' Ревазов\nя опублікувала статтю, в якій перерахувала 25 технік генерації ідей для логотипу. Якщо ви її не читали — обов''язково прочитайте :) А потім повертайтеся сюди :)', 1.0, 'approved', '2016-03-31 09:15:58', '127.0.0.1', '94ade8080aa05c1632fc0831d354c220'),
(25, 0, 0, 16, 3, 'xxzzxczsadf', 1.0, 'approved', '2016-03-31 13:33:43', '127.0.0.1', 'cbf59fc5c2a997a249d3c38fd52edeea'),
(26, 0, 0, 16, 3, 'xxzzxczsadf', 1.0, 'new', '2016-03-31 13:34:04', '127.0.0.1', 'cbf59fc5c2a997a249d3c38fd52edeea');

-- --------------------------------------------------------

--
-- Структура таблицы `comments_subscribers`
--

CREATE TABLE IF NOT EXISTS `comments_subscribers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` int(10) unsigned NOT NULL,
  `users_id` int(10) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`content_id`,`users_id`),
  UNIQUE KEY `content_id` (`content_id`,`users_id`),
  KEY `fk_comments_subscribe_content1_idx` (`content_id`),
  KEY `fk_comments_subscribe_users1_idx` (`users_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Дамп данных таблицы `comments_subscribers`
--

INSERT INTO `comments_subscribers` (`id`, `content_id`, `users_id`, `created`) VALUES
(2, 16, 15, '2016-03-31 06:52:55'),
(3, 16, 3, '2016-03-31 13:33:39');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=84 ;

--
-- Дамп данных таблицы `components`
--

INSERT INTO `components` (`id`, `parent_id`, `isfolder`, `icon`, `author`, `version`, `controller`, `position`, `published`, `rang`, `settings`, `created`) VALUES
(1, 0, 0, 'fa-home', 'Volodymyr Hodiak', '1.0.0', 'dashboard', 1, 1, 300, NULL, '2016-03-18 15:27:32'),
(43, 0, 0, 'fa-file-text', 'Volodymyr Hodiak', '1.0.0', 'content/Pages', 2, 1, 300, NULL, '2016-03-16 15:09:36'),
(45, 0, 1, 'fa-cogs', 'Volodymyr Hodiak', '1.0.0', 'tools', 9, 1, 300, NULL, '2016-03-16 15:10:15'),
(46, 45, 0, 'fa-bars', 'Volodymyr Hodiak', '1.0.0', 'nav', 46, 1, 300, NULL, '2016-03-16 15:18:30'),
(47, 60, 1, 'fa-puzzle-piece', 'Volodymyr Hodiak', '1.0.0', 'components', 47, 1, 300, NULL, '2016-03-16 15:18:54'),
(48, 60, 0, 'fa-puzzle-piece', 'Volodymyr Hodiak', '1.0.0', 'plugins', 48, 1, 300, NULL, '2016-03-16 15:19:05'),
(49, 45, 0, 'fa-television', 'Volodymyr Hodiak', '1.0.0', 'themes', 49, 1, 300, NULL, '2016-03-16 15:21:51'),
(50, 45, 0, 'fa-file-code-o', 'Volodymyr Hodiak', '1.0.0', 'chunks', 50, 1, 300, NULL, '2016-03-16 15:21:56'),
(51, 0, 0, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'admins', 8, 1, 300, NULL, '2016-03-16 15:22:03'),
(52, 45, 0, 'fa-file-code-o', 'Volodymyr Hodiak', '1.0.0', 'features', 52, 1, 300, NULL, '2016-03-16 15:24:22'),
(54, 45, 0, 'fa-book', 'Volodymyr Hodiak', '1.0.0', 'guides', 54, 1, 300, NULL, '2016-03-16 15:25:16'),
(55, 45, 0, 'fa-trash', 'Volodymyr Hodiak', '1.0.0', 'trash', 55, 1, 300, NULL, '2016-03-16 15:25:45'),
(56, 45, 0, 'fa-book', 'Volodymyr Hodiak', '1.0.0', 'contentImagesSizes', 56, 1, 300, NULL, '2016-03-16 15:25:52'),
(57, 45, 0, 'fa-cubes', 'Volodymyr Hodiak', '1.0.0', 'contentTypes', 57, 1, 300, NULL, '2016-03-16 15:26:02'),
(58, 65, 0, 'fa-flag', 'Volodymyr Hodiak', '1.0.0', 'languages', 58, 1, 300, NULL, '2016-03-16 15:26:13'),
(59, 45, 0, 'fa-file-code-o', 'Volodymyr Hodiak', '1.0.0', 'backup', 59, 1, 300, NULL, '2016-03-16 15:26:21'),
(60, 0, 1, 'fa-puzzle-piece', 'Volodymyr Hodiak', '1.0.0', 'componentsGroup', 11, 1, 300, NULL, '2016-03-17 07:52:27'),
(61, 65, 0, 'fa-cogs', 'Volodymyr Hodiak', '1.0.0', 'settings', 61, 1, 300, NULL, '2016-03-17 07:54:17'),
(64, 45, 0, 'fa-envelope-o', 'Volodymyr Hodiak', '1.0.0', 'mailTemplates', 64, 1, 300, NULL, '2016-03-18 10:14:32'),
(65, 0, 1, 'fa-cogs', 'Volodymyr Hodiak', '1.0.0', 'settingsGroup', 12, 1, 300, NULL, '2016-03-18 11:41:11'),
(66, 60, 0, 'fa-puzzle-piece', 'Volodymyr Hodiak', '1.0.0', 'modules', 0, 1, 300, NULL, '2016-03-23 13:50:46'),
(67, 0, 0, 'fa-pencil', 'Volodymyr Hodiak', '1.0.0', 'content/Post', 3, 1, 300, NULL, '2016-03-25 10:43:43'),
(68, 0, 0, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'customers', 5, 1, 300, NULL, '2016-03-28 07:56:25'),
(69, 0, 0, 'fa-comments', 'Volodymyr Hodiak', '1.0.0', 'comments', 5, 1, 300, NULL, '2016-03-31 07:17:06'),
(70, 0, 1, 'fa-shopping-cart', 'Volodymyr Hodiak', '1.0.0', 'shop', 3, 1, 300, NULL, '2016-04-01 06:30:35'),
(72, 70, 0, 'fa-mobile', 'Volodymyr Hodiak', '1.0.0', 'content/Products', 0, 1, 300, NULL, '2016-04-01 06:38:03'),
(76, 70, 0, 'fa-file-text', 'Volodymyr Hodiak', '1.0.0', 'content/ProductsCategories', 0, 1, 300, NULL, '2016-04-01 08:10:43'),
(77, 70, 0, 'fa-money', 'Volodymyr Hodiak', '1.0.0', 'currency', 0, 1, 300, NULL, '2016-04-01 10:28:14'),
(78, 70, 0, 'fa-bus', 'Volodymyr Hodiak', '1.0.0', 'delivery', 0, 1, 300, NULL, '2016-04-01 10:55:57'),
(79, 70, 0, 'fa-credit-card', 'Volodymyr Hodiak', '1.0.0', 'payment', 0, 1, 300, NULL, '2016-04-01 11:16:34'),
(81, 0, 0, 'fa-cogs', 'Volodymyr Hodiak', '1.0.0', 'banners', 6, 1, 300, NULL, '2016-04-07 12:06:56'),
(82, 0, 0, 'fa-phone-square', 'Volodymyr Hodiak', '1.0.0', 'callbacks', 5, 1, 300, NULL, '2016-04-11 07:55:03'),
(83, 65, 0, 'fa-bus', 'Volodymyr Hodiak', '1.0.0', 'ordersStatus', 3, 1, 300, NULL, '2016-04-11 11:53:42');

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
  `settings` text,
  `status` enum('blank','hidden','published','deleted') DEFAULT 'blank',
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
  KEY `published` (`published`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=75 ;

--
-- Дамп данных таблицы `content`
--

INSERT INTO `content` (`id`, `types_id`, `subtypes_id`, `owner_id`, `parent_id`, `isfolder`, `position`, `created`, `updated`, `published`, `settings`, `status`, `currency_id`, `unit_id`, `has_variants`, `in_stock`, `external_id`) VALUES
(1, 1, 6, 2, 0, 1, 0, '2016-03-21 07:55:55', '2016-03-28 12:16:23', '2016-03-21', 'a:1:{s:7:"modules";a:1:{i:0;s:12:"First::index";}}', 'published', NULL, NULL, NULL, NULL, NULL),
(2, 1, 1, 2, 1, 0, 0, '2016-03-21 07:56:43', '2016-03-30 12:50:47', '2016-03-21', 'a:1:{s:7:"modules";a:1:{i:0;s:12:"First::index";}}', 'published', NULL, NULL, NULL, NULL, NULL),
(3, 1, 7, 2, 1, 0, 0, '2016-03-21 07:56:57', '2016-03-24 14:04:03', '2016-03-21', 'a:1:{s:7:"modules";a:1:{i:0;s:11:"Blog::index";}}', 'published', NULL, NULL, NULL, NULL, NULL),
(4, 1, 1, 2, 1, 0, 0, '2016-03-21 07:57:10', NULL, '2016-03-21', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(5, 1, 1, 2, 1, 0, 0, '2016-03-21 07:57:23', NULL, '2016-03-21', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(6, 1, 1, 2, 1, 0, 0, '2016-03-21 07:57:34', NULL, '2016-03-21', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(7, 1, 1, 2, 1, 0, 0, '2016-03-21 07:58:13', NULL, '2016-03-21', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(8, 1, 9, 2, 1, 0, 0, '2016-03-21 07:58:21', '2016-03-31 14:00:44', '2016-03-21', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(9, 1, 4, 2, 1, 0, 0, '2016-03-21 12:44:48', NULL, '2016-03-21', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(13, 3, 3, 2, 0, 0, 0, '2016-03-24 13:23:43', '2016-03-25 09:56:19', '2016-03-25', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(14, 3, 3, 2, 0, 0, 0, '2016-03-24 13:24:00', '2016-03-25 09:56:29', '2016-03-25', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(15, 3, 3, 2, 0, 0, 0, '2016-03-24 13:24:10', '2016-03-24 13:24:10', '2016-03-24', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(16, 2, 2, 2, 0, 0, 0, '2016-03-24 13:24:14', '2016-04-05 07:55:07', '2016-03-24', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(17, 2, 2, 2, 0, 0, 0, '2016-03-24 13:30:28', '2016-03-24 13:31:01', '2016-03-24', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(18, 2, 2, 2, 0, 0, 0, '2016-03-24 13:31:04', '2016-03-25 15:53:18', '2016-03-24', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(19, 2, 2, 2, 0, 0, 0, '2016-03-24 13:31:33', '2016-03-24 13:32:11', '2016-03-24', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(20, 2, 2, 2, 0, 0, 0, '2016-03-24 13:32:19', '2016-03-25 13:02:57', '2016-03-24', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(21, 2, 2, 2, 0, 0, 0, '2016-03-24 13:32:39', '2016-03-24 13:33:06', '2016-03-24', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(22, 2, 2, 2, 0, 0, 0, '2016-03-24 13:33:07', '2016-03-24 13:33:34', '2016-03-24', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(23, 2, 2, 2, 0, 0, 0, '2016-03-24 13:33:41', '2016-03-24 13:34:21', '2016-03-24', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(24, 2, 2, 2, 0, 0, 0, '2016-03-24 13:34:28', '2016-03-24 13:34:46', '2016-03-24', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(25, 1, 1, 2, 1, 0, 0, '2016-03-25 09:45:43', '2016-03-25 09:46:08', '2016-03-25', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(27, 3, 3, 2, 0, 0, 0, '2016-03-25 11:52:31', '2016-03-25 11:52:31', '2016-03-25', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(28, 1, 1, 2, 1, 1, 0, '2016-03-28 07:15:17', '2016-03-28 12:41:20', '2016-03-28', 'a:1:{s:7:"modules";a:1:{i:0;s:12:"First::index";}}', 'published', NULL, NULL, NULL, NULL, NULL),
(29, 1, 8, 2, 28, 0, 0, '2016-03-28 07:19:02', '2016-03-30 07:23:17', '2016-03-28', 'a:1:{s:7:"modules";a:1:{i:0;s:14:"Account::login";}}', 'published', NULL, NULL, NULL, NULL, NULL),
(30, 1, 8, 2, 28, 0, 0, '2016-03-28 07:19:28', '2016-03-28 12:41:33', '2016-03-28', 'a:1:{s:7:"modules";a:1:{i:0;s:17:"Account::register";}}', 'published', NULL, NULL, NULL, NULL, NULL),
(31, 1, 8, 2, 28, 0, 0, '2016-03-28 12:50:28', '2016-03-28 12:50:49', '2016-03-28', 'a:1:{s:7:"modules";a:1:{i:0;s:16:"Account::profile";}}', 'published', NULL, NULL, NULL, NULL, NULL),
(34, 1, 8, 2, 28, 0, 0, '2016-03-30 07:40:52', '2016-03-30 07:41:43', '2016-03-30', 'a:1:{s:7:"modules";a:1:{i:0;s:11:"Account::fp";}}', 'published', NULL, NULL, NULL, NULL, NULL),
(39, 10, 10, 2, 0, 0, 0, '2016-04-01 06:43:59', '2016-04-07 08:02:03', '2016-04-06', NULL, 'published', 2, 2, 1, 0, NULL),
(40, 11, 11, 2, 0, 1, 0, '2016-04-01 07:08:53', '2016-04-01 07:56:46', '2016-04-01', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(41, 11, 11, 2, 40, 0, 0, '2016-04-01 07:09:00', '2016-04-04 14:39:02', '2016-04-01', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(42, 11, 11, 2, 0, 0, 0, '2016-04-01 07:10:09', '2016-04-01 07:10:08', '2016-04-01', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(43, 11, 11, 2, 0, 0, 0, '2016-04-01 07:10:40', '2016-04-01 08:26:37', '2016-04-01', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(44, 11, 11, 2, 0, 0, 0, '2016-04-01 07:10:45', '2016-04-01 07:10:45', '2016-04-01', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(45, 11, 11, 2, 0, 0, 0, '2016-04-01 07:10:50', '2016-04-01 07:10:50', '2016-04-01', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(46, 11, 11, 2, 0, 0, 0, '2016-04-01 07:11:00', '2016-04-01 07:11:00', '2016-04-01', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(47, 11, 11, 2, 0, 0, 0, '2016-04-01 07:11:07', '2016-04-01 07:11:07', '2016-04-01', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(48, 11, 11, 2, 0, 0, 0, '2016-04-01 07:11:12', '2016-04-01 07:11:12', '2016-04-01', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(49, 11, 11, 2, 40, 0, 0, '2016-04-01 08:26:25', '2016-04-01 08:26:25', '2016-04-01', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(52, 10, 10, 2, 0, 0, 0, '2016-04-04 14:41:04', '2016-04-04 16:24:17', '2016-04-04', NULL, 'hidden', NULL, NULL, NULL, NULL, NULL),
(54, 10, 10, 2, 0, 0, 0, '2016-04-04 16:21:23', '2016-04-04 16:21:27', '2016-04-04', NULL, 'hidden', NULL, NULL, NULL, NULL, NULL),
(55, 10, 10, 2, 0, 0, 0, '2016-04-04 16:22:23', '2016-04-04 16:22:41', '2016-04-04', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(57, 10, 10, 2, 0, 0, 0, '2016-04-05 06:12:57', '2016-04-05 06:13:34', '2016-04-05', NULL, 'published', NULL, NULL, NULL, NULL, NULL),
(59, 10, 10, 2, 0, 0, 0, '2016-04-05 06:27:37', '2016-04-05 06:28:00', '2016-04-05', NULL, 'hidden', NULL, NULL, NULL, NULL, NULL),
(74, 1, 1, 2, 1, 0, 0, '2016-04-11 07:04:37', NULL, NULL, NULL, 'blank', NULL, NULL, NULL, NULL, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

--
-- Дамп данных таблицы `content_features`
--

INSERT INTO `content_features` (`id`, `content_id`, `features_id`, `values_id`, `languages_id`, `value`) VALUES
(21, 39, 84, 86, 0, NULL),
(22, 39, 85, 89, 0, NULL),
(23, 39, 92, 94, 0, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=20 ;

--
-- Дамп данных таблицы `content_images`
--

INSERT INTO `content_images` (`id`, `content_id`, `path`, `image`, `position`, `created`) VALUES
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
(14, 1, 'uploads/content/2016/03/25/', 'testimonial2-1x13.jpg', 5, '2016-03-25 12:33:08'),
(15, 1, 'uploads/content/2016/03/25/', 'testimonial3-1x14.jpg', 6, '2016-03-25 12:33:08'),
(16, 39, 'uploads/content/2016/04/01/', 'big_93ebd896972498b439b4d378473b5a76-39x.jpg', 1, '2016-04-01 07:39:11'),
(17, 39, 'uploads/content/2016/04/07/', 'pictures-38191-39x16.jpg', 2, '2016-04-07 08:23:14'),
(18, 39, 'uploads/content/2016/04/07/', 'animals-smile_3379238k-39x17.jpg', 0, '2016-04-07 08:23:19'),
(19, 39, 'uploads/content/2016/04/07/', 'perfectly-timed-funny-cat-pictures-5-39x18.jpg', 3, '2016-04-07 08:23:19');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `content_images_sizes`
--

INSERT INTO `content_images_sizes` (`id`, `size`, `width`, `height`) VALUES
(1, 'post', 635, 310),
(2, 'slider', 935, 450);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=53 ;

--
-- Дамп данных таблицы `content_info`
--

INSERT INTO `content_info` (`id`, `content_id`, `languages_id`, `name`, `url`, `h1`, `title`, `keywords`, `description`, `content`) VALUES
(1, 1, 1, 'Головна', '', '', 'Головна', '', '', ''),
(3, 2, 1, 'Про нас', 'pro-nas', '', 'Про нас', '', 'Whether you want to fill this paragraph with some text like I''m doing right now, this place is perfect to describe some features or anything you want - React has a complete solution for you.', '<div class="row">\n<div class="col-md-12">\n<h1>We care about our work</h1>\n</div>\n</div>\n\n<div class="row">\n<div class="col-md-6">\n<p>Whether you want to fill this paragraph with some text like I&#39;m doing right now, this place is perfect to describe some features or anything you want - React has a complete solution for you.</p>\n\n<p>You have complete control over the look &amp; feel of your website, we offer the best quality so you take your site up and running in no time.</p>\n</div>\n\n<div class="col-md-6">\n<p>React is a simple, developer-friendly way to get your site. Full of features, cool documentation ease of use, lots of pages. We want to help bringing cool stuff to people so they can get their projects faster.</p>\n<a class="join-team button button-small" href="#">Join our team</a></div>\n</div>\n\n<div class="row stats">\n<div class="col-sm-3"><strong>13</strong> employees</div>\n\n<div class="col-sm-3"><strong>10k</strong> customers</div>\n\n<div class="col-sm-3"><strong>9</strong> template pages</div>\n\n<div class="col-sm-3"><strong>13k</strong> products sold</div>\n</div>\n'),
(4, 3, 1, 'Новини', 'novyny', '', 'Новини', '', '', ''),
(5, 4, 1, 'Оплата та доставка', 'oplata-ta-dostavka', '', 'Оплата та доставка', '', '', ''),
(6, 5, 1, 'Гарантія та сервіс', 'garantiya-ta-servis', '', 'Гарантія та сервіс', '', '', ''),
(7, 6, 1, 'Діючі акції', 'diyuchi-akciї', '', 'Діючі акції', '', '', ''),
(8, 7, 1, 'Ваканcії', 'vakanciї', '', 'Ваканcії', '', '', ''),
(9, 8, 1, 'Контакти', 'kontakty', '', 'Контакти', '', '', ''),
(10, 9, 1, '404', '404', '', '404', '', '', ''),
(13, 13, 1, 'Новини', 'blog/novyny', '', 'Новини', '', '', NULL),
(14, 14, 1, 'Акції', 'akcii', '', 'Акції', '', '', NULL),
(15, 15, 1, 'Різне', 'rizne', '', 'Різне', '', '', NULL),
(16, 16, 1, '50 відтінків логотипу. Частина 2', '50-vidtinkiv-logotypu-chastyna-2', '', '50 відтінків логотипу. Частина 2', '', 'Як придумати круте лого: продовжуємо говорити про техніки, які можна використати.\nНещодавно я опублікувала статтю, в якій перерахувала 25 технік генерації ідей для логотипу. Якщо ви її не читали — обов''язково прочитайте :) А потім повертайтеся сюди :)', '<p>Як придумати круте лого: продовжуємо говорити про техніки, які можна використати.<br />\nНещодавно я опублікувала статтю, в якій перерахувала 25 технік генерації ідей для логотипу. Якщо ви її не читали &mdash; обов&#39;язково прочитайте :) А потім повертайтеся сюди :)</p>\n'),
(17, 17, 1, 'РЕКУРСИВНЕ ВИДАЛЕННЯ СТАРИХ АРХІВІВ В LINUX', 'rekursyvne-vydalennya-staryh-arhiviv-v-linux', '', 'РЕКУРСИВНЕ ВИДАЛЕННЯ СТАРИХ АРХІВІВ В LINUX', '', '', '<p>Виникла проблема &mdash; на одному з серверів для збереження бекапів переповнилося місце. Через це на іншому сервері також переповнилося місце. Тому що спочатку робиться архів локально, а потім переміщується на один із серверів бекапів.</p>\n\n<p>Але ми адміни ліниві, і вручну перегладати директорії і видаляти архіви понад кількі місяців точно не будемо. Особливо, коли проектів понад 200. Виручить простенький скрипт, який треба повішати на cron.&nbsp;</p>\n'),
(18, 18, 1, '50 ВІДТІНКІВ ЛОГОТИПУ. ЧАСТИНА 1', '50-vidtinkiv-logotypu-chastyna-1', '', '50 ВІДТІНКІВ ЛОГОТИПУ. ЧАСТИНА 1', '', '', '<p>Немає єдиного підходу до створення логотипів. Проте існує великий вибір технік та стилів, якими може скористатися дизайнер, щоб згенерувати справді круте лого.</p>\n\n<p>В цій статті я покажу приклади логотипів, що належать до різних категорій: по стилю, формі, глибині, кольорах, техніці виконання, використаних елементах тощо.</p>\n\n<p>Зазвичай логотип водночас належить до кількох категорій. Наприклад, логотип може бути з унікальним шрифтовим накресленням і мати різні кольорові літери, це може бути тривимірна графіка з градієнтами або ж персонаж чи тваринка, намальовані як імітація дитячого малюнка.</p>\n\n<p>Кажуть, що творчість полягає в здатності несподіваним чином об&#39;єднати добре відомі, звичні речі. Цю думку, принаймні щодо створення логотипів, я вважаю цілком справедливою.</p>\n\n<p>Хороший дизайнер логотипів створює унікальні логотипи за допомогою декількох інструментів, старається поєднати різні форми і техніки. Хороший дизайнер втілює дух і стиль компанії в знаці, який нестиме потрібні асоціації з діяльністю компанії.</p>\n\n<p>Коли замовник захоче спробувати зовсім іншу, кардинально нову концепцію, перегляньте ці 50 категорій &mdash; у вас неодмінно з&rsquo;явиться нове дихання та ідеї для створення ідеального логотипу.</p>\n\n<p>Осягнути всі 50 ідей за раз буває складно (або ж неефективно), тому в цій частині я покажу перші 25 технік, а решту залишу для другої частини статті ;) До речі, вона вже&nbsp;<a href="http://otakoyi.com/uk/blog/layfkhak-yak-pereviryty-adaptyvnist-vykorystovuyuchy-brauzer" target="_blank">тут</a>.&nbsp;</p>\n'),
(19, 19, 1, 'БЕКАП САЙТУ С VPS НА ВІДДАЛЕНИЙ СЕРВЕР ПО FTP', 'bekap-sajtu-s-vps-na-viddalenyj-server-po-ftp', '', 'БЕКАП САЙТУ С VPS НА ВІДДАЛЕНИЙ СЕРВЕР ПО FTP', '', '', ''),
(20, 20, 1, 'АВТОМАТИЧНИЙ ПЕРЕКЛАД В OYI.ENGINE НЕ ПРАЦЮЄ', 'avtomatychnyj-pereklad-v-oyi-engine-ne-pracyuє', '', 'АВТОМАТИЧНИЙ ПЕРЕКЛАД В OYI.ENGINE НЕ ПРАЦЮЄ', '', '', '<p>Ця стаття призначена для наших клієнтів, в яких &quot;... не зберігаються сторінки. Я вношу назву, натискаю &quot;Перекласти&quot;. Натискаю &quot;Зберегти&quot; і отримую &quot;Помилка валідації&quot;.&quot;<br />\nПояснення читайте в статті.<br />\nБільшість наших проектів мають кілька мовних версій (від 2 до 25).<br />\nВідповідно для кожної мовної версії потрібно ввести мінімум 3 обов&#39;язкові поля: назву, урл (alias), title. Помилка виникає, якщо ви не заповнюєте ці поля на всіх мовних версіях.<br />\nШвидкість створення 1 сторінки (статті, товару, категорії, ітп) напряму залежить від кількості мовних версій проекту. Щоб зекономити час роботи менеджера, і, відповідно, гроші замовника у нас стандартно<br />\nінтегрована опція автоматичного перекладу контенту на основі Google Translate API || Yandex Translate API. Yandex Translate краще перекладає контент з української на російську і навпаки, Google Translate API інші.</p>\n'),
(21, 21, 1, '6 ПРАКТИЧНИХ ПОРАД ЯК ДИЗАЙНЕРАМ УНИКАТИ КОНФЛІКТІВ З КЛІЄНТАМИ', '6-praktychnyh-porad-yak-dyzajneram-unykaty-konfliktiv-z-kliєntamy', '', '6 ПРАКТИЧНИХ ПОРАД ЯК ДИЗАЙНЕРАМ УНИКАТИ КОНФЛІКТІВ З КЛІЄНТАМИ', '', '', '<p>Будь-який фрілансер або дизайнерська компанія, незалежно від свого напрямку (веб, графіка, архітектура, 3д-моделювання), рівня цін та професійності, рано чи пізно стикається з конфліктними клієнтами. Творчість взагалі дуже проблемна галузь, залежна від суб&#39;єктивної думки. Тому особливо важливо подбати про захист своїх тилів та уникати проблемних зон у стосунках з клієнтами.</p>\n\n<p>В цій статті ми підготували шість основних питань, про які треба подбати дизайнерській компанії (або фрілансеру) для того, щоб уникнути конфліктів з клієнтами або ж, якщо вони все-таки виникнуть, максимально захистити себе.&nbsp;</p>\n'),
(22, 22, 1, 'ALLOWOVERRIDE ALL HTTPD OPTIONS ALL -INDEXES — ЗАБОРОНА ПЕРЕГЛЯДУ ПАПОК В ISPMANAGER', 'allowoverride-all-httpd-options-all-indexes-—-zaborona-pereglyadu-papok-v-ispmanager', '', 'ALLOWOVERRIDE ALL HTTPD OPTIONS ALL -INDEXES — ЗАБОРОНА ПЕРЕГЛЯДУ ПАПОК В ISPMANAGER', '', '', ''),
(26, 23, 1, '20 ПРИКЛАДІВ ЦІКАВОГО ДИЗАЙНУ САЙТІВ (ЗА БЕРЕЗЕНЬ)', '20-prykladiv-cikavogo-dyzajnu-sajtiv-za-berezen', '', '20 ПРИКЛАДІВ ЦІКАВОГО ДИЗАЙНУ САЙТІВ (ЗА БЕРЕЗЕНЬ)', '', '', '<p>Впродовж місяця нам трапляється чимало сайтів, які варті уваги з точки зору дизайну, інформаційної архітектури, інтерактивності тощо. Ми вирішили зібрати їх докупи і поділитися з вами &mdash; тиждень добігає кінця, тож є час пошукати натхнення. Сюди потрапили і звичайні сайти, і портфоліо, і лендінги. Деякі з них здобули відзнаки від&nbsp;<a href="http://www.awwwards.com/" rel="nofollow" target="_blank">Awwwards</a>,&nbsp;<a href="http://www.cssdesignawards.com/" rel="nofollow" target="_blank">CSS Design Awards</a>&nbsp;тощо.</p>\n\n<p>До речі, на прикладі цих сайтів можна простежити за всіма&nbsp;<a href="http://otakoyi.com/blog/10-trendiv-veb-dyzaynu-v-2015-rotsi/">сучасними тенденціями</a>&nbsp;в сфері веб-дизайну.&nbsp;Доведеться трохи скролити, тож будьте терплячими! :)</p>\n'),
(27, 24, 1, 'ЯКОГО БІСА ТИ СКИГЛИШ?', 'yakogo-bisa-ty-skyglysh', '', 'ЯКОГО БІСА ТИ СКИГЛИШ?', '', '', '<p>Минулого вересня на IT Weekend мені пощастило побувати на доповіді Слави Панкратова зі Школи менеджерів Стратоплан. На тлі інших доповідачів він вирізнявся своєю харизмою та вмінням захопити увагу аудиторії. З того часу мені в очі періодично впадала реклама у фейсбуці, яку я успішно ігнорував. Проте нещодавно, перебуваючи у вимушеній лікарняній відпустці та вкотре гортаючи стрічку новин, вирішив все ж таки залишити свій імейл для завантаження &laquo;Чорної книги менеджера&raquo;.</p>\n\n<p>Не знаю, чи це у мене настрій був такий, чи температура подіяла на мозок, але, на мою думку, ці 18 сторінок брутального тексту &mdash; це найбільш чесні та відверті рядки з усього, що я читав про керування персоналом та роботу в команді. Це чистий концентрат правди для всіх і кожного: починаючи від власників бізнесу, закінчуючи менеджерами всіх рівнів та їхніми підлеглими. Кожен знайде в ній щось для себе.&nbsp;<strong>Цю книгу треба прочитати обов&#39;язково!</strong></p>\n'),
(28, 25, 1, 'Пошук', 'poshuk', '', 'Пошук', '', '', ''),
(30, 27, 1, 'Всяка всячина', 'vsyaka-vsyachyna', '', 'Всяка всячина', '', '', NULL),
(31, 28, 1, 'Аккаунт', 'account', '', 'Аккаунт', '', '', ''),
(32, 29, 1, 'Вхід ', 'account/login', '', 'Вхід', '', '', ''),
(33, 30, 1, 'Реєстрація ', 'account/register', '', 'Реєстрація', '', '', ''),
(34, 31, 1, 'Профіль', 'account/profile', '', 'Профіль', '', '', ''),
(35, 34, 1, 'Нагадати пароль', 'account/fp', '', 'Нагадати пароль', '', '', ''),
(36, 39, 1, 'SAMSUNG J120 DUOS Black', 'samsung-j120-duos-black', '', 'SAMSUNG J120 DUOS Black', 'ertert,re,ter,te,r,t,er', '', ''),
(37, 40, 1, 'Цифрове фото', 'cyfrove-foto', '', 'Цифрове фото, Планшетні ПК', '', '', '<p>retert</p>\n'),
(38, 41, 1, 'Цифрові фотоапарати', 'cyfrovi-fotoaparaty', '', 'Цифрові фотоапарати', '', '', '<p>dgfdg</p>\n'),
(39, 42, 1, 'Планшетні ПК', 'planshetni-pk', '', 'Планшетні ПК', '', '', NULL),
(40, 43, 1, 'Комп''ютерна периферія', 'komp-yuterna-peryferiya', '', 'Комп''ютерна периферія', '', '', NULL),
(41, 44, 1, 'Телефони ', 'telefony', '', 'Телефони ', '', '', NULL),
(42, 45, 1, 'Аудіо, портативна техніка', 'audio-portatyvna-tehnika', '', 'Аудіо, портативна техніка', '', '', NULL),
(43, 46, 1, 'Активний відпочинок, обігрівачі', 'aktyvnyj-vidpochynok-obigrivachi', '', 'Активний відпочинок, обігрівачі', '', '', NULL),
(44, 47, 1, 'Чохли та супутні товари', 'chohly-ta-suputni-tovary', '', 'Чохли та супутні товари', '', '', NULL),
(45, 48, 1, 'Годинники', 'godynnyky', '', 'Годинники', '', '', NULL),
(46, 49, 1, 'Штативи', 'shtatyvy', '', 'Штативи', '', '', NULL),
(47, 52, 1, 'ACER Iconia A1-840 FHD 8'''' 16 GB', 'acer-iconia-a1-840-fhd-8-16-gb', '', 'ACER Iconia A1-840 FHD 8'''' 16 GB', '', '', ''),
(48, 54, 1, 'Смартфон Samsung J500H Galaxy J5', 'smartfon-samsung-j500h-galaxy-j5', '', 'Смартфон Samsung J500H Galaxy J5', '', '', ''),
(49, 55, 1, 'Смартфон Keneksi Choice Dual Sim', 'smartfon-keneksi-choice-dual-sim', '', 'Смартфон Keneksi Choice Dual Sim', '', '', ''),
(51, 57, 1, 'Смартфон Keneksi Choice Dual Sim2', 'smartfon-keneksi-choice-dual-sim2', '', 'Смартфон Keneksi Choice Dual Sim2', '', '', ''),
(52, 59, 1, 'Смартфон Lenovo A1000 Dual Sim', 'smartfon-lenovo-a1000-dual-sim', '', 'Смартфон Lenovo A1000 Dual Sim', '', '', '');

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
  KEY `fk_content_relationship_content1_idx` (`content_id`),
  KEY `fk_content_relationship_content2_idx` (`categories_id`),
  KEY `is_main` (`is_main`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=75 ;

--
-- Дамп данных таблицы `content_relationship`
--

INSERT INTO `content_relationship` (`id`, `content_id`, `categories_id`, `is_main`) VALUES
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
(27, 52, 41, 1),
(29, 57, 41, 1),
(30, 59, 41, 1),
(74, 39, 41, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `content_tags`
--

CREATE TABLE IF NOT EXISTS `content_tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` int(11) unsigned NOT NULL,
  `tags_id` int(10) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`,`content_id`,`tags_id`,`languages_id`),
  UNIQUE KEY `content_id` (`content_id`,`tags_id`),
  KEY `fk_tags_content_content1_idx` (`content_id`),
  KEY `fk_tags_content_tags1_idx` (`tags_id`),
  KEY `fk_content_tags_languages1_idx` (`languages_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

--
-- Дамп данных таблицы `content_tags`
--

INSERT INTO `content_tags` (`id`, `content_id`, `tags_id`, `languages_id`) VALUES
(21, 16, 17, 1),
(22, 16, 18, 1),
(23, 16, 19, 1),
(24, 18, 20, 1),
(25, 18, 21, 1),
(26, 18, 22, 1),
(27, 18, 23, 1),
(28, 18, 24, 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Дамп данных таблицы `content_types`
--

INSERT INTO `content_types` (`id`, `parent_id`, `isfolder`, `type`, `name`, `is_main`, `settings`) VALUES
(1, 0, 1, 'pages', 'Сторінки', NULL, 'a:3:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:1:"0";s:7:"modules";a:1:{i:0;s:10:"Nav::index";}}'),
(2, 0, 0, 'post', 'Стаття', NULL, 'a:2:{s:9:"parent_id";s:0:"";s:7:"modules";a:3:{i:0;s:14:"Account::index";i:1;s:10:"Blog::post";i:2;s:8:"Nav::top";}}'),
(3, 0, 0, 'posts_cat', 'Категорії статтей', NULL, 'a:2:{s:9:"parent_id";s:0:"";s:7:"modules";a:2:{i:0;s:11:"Blog::index";i:1;s:10:"Nav::index";}}'),
(4, 1, 0, '404', '404', NULL, 'a:2:{s:9:"parent_id";s:0:"";s:11:"modules_ext";s:1:"1";}'),
(6, 1, 0, 'main', 'Головна', NULL, 'a:2:{s:9:"parent_id";s:0:"";s:7:"modules";a:1:{i:0;s:10:"Nav::index";}}'),
(7, 1, 0, 'blog', 'Блог', NULL, 'a:2:{s:9:"parent_id";s:0:"";s:11:"modules_ext";s:1:"1";}'),
(8, 1, 0, 'account', 'Аккаунт', NULL, 'a:1:{s:9:"parent_id";s:0:"";}'),
(9, 1, 0, 'contacts', 'Контакти', NULL, 'a:1:{s:9:"parent_id";s:0:"";}'),
(10, 0, 0, 'products', 'Товар', NULL, 'a:2:{s:9:"parent_id";s:0:"";s:8:"features";a:3:{s:13:"allowed_types";a:2:{i:0;s:6:"select";i:1;s:6:"folder";}s:14:"disable_values";s:1:"0";s:11:"ex_types_id";s:2:"11";}}'),
(11, 0, 0, 'productsCategories', 'Категорії товарів', NULL, 'a:2:{s:9:"parent_id";s:0:"";s:8:"features";a:3:{s:13:"allowed_types";a:2:{i:0;s:6:"select";i:1;s:6:"folder";}s:14:"disable_values";s:1:"1";s:11:"ex_types_id";s:0:"";}}');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=26 ;

--
-- Дамп данных таблицы `content_types_images_sizes`
--

INSERT INTO `content_types_images_sizes` (`id`, `types_id`, `images_sizes_id`) VALUES
(23, 1, 1),
(24, 1, 2),
(25, 2, 1),
(11, 6, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `currency`
--

CREATE TABLE IF NOT EXISTS `currency` (
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
-- Дамп данных таблицы `currency`
--

INSERT INTO `currency` (`id`, `name`, `code`, `symbol`, `rate`, `is_main`) VALUES
(1, 'Гривня', 'UAH', 'грн', 27.000, 0),
(2, 'Долар', 'USD', '$', 1.000, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `delivery`
--

CREATE TABLE IF NOT EXISTS `delivery` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `free_from` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `module` varchar(30) DEFAULT NULL,
  `settings` text,
  `published` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `delivery`
--

INSERT INTO `delivery` (`id`, `free_from`, `price`, `module`, `settings`, `published`) VALUES
(1, 500.00, 10.00, '', 'a:2:{s:3:"key";s:1:"1";s:8:"password";s:1:"2";}', 1),
(2, 500.00, 30.00, 'NovaPoshta', 'a:2:{s:3:"key";s:1:"1";s:8:"password";s:1:"2";}', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `delivery_info`
--

CREATE TABLE IF NOT EXISTS `delivery_info` (
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
-- Дамп данных таблицы `delivery_info`
--

INSERT INTO `delivery_info` (`id`, `delivery_id`, `languages_id`, `name`, `description`) VALUES
(1, 1, 1, 'Самовиз', '12121fds sadsadsa'),
(2, 2, 1, 'Нова пошта', 'Служба доставки нова пошта');

-- --------------------------------------------------------

--
-- Структура таблицы `delivery_payment`
--

CREATE TABLE IF NOT EXISTS `delivery_payment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `delivery_id` tinyint(3) unsigned NOT NULL,
  `payment_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`,`delivery_id`,`payment_id`),
  UNIQUE KEY `delivery_id` (`delivery_id`,`payment_id`),
  KEY `fk_delivery_payment_delivery1_idx` (`delivery_id`),
  KEY `fk_delivery_payment_payment1_idx` (`payment_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=18 ;

--
-- Дамп данных таблицы `delivery_payment`
--

INSERT INTO `delivery_payment` (`id`, `delivery_id`, `payment_id`) VALUES
(12, 1, 1),
(14, 1, 4),
(15, 1, 3),
(16, 1, 5),
(17, 2, 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=95 ;

--
-- Дамп данных таблицы `features`
--

INSERT INTO `features` (`id`, `parent_id`, `type`, `code`, `multiple`, `on_filter`, `required`, `owner_id`, `created`, `status`) VALUES
(84, 0, 'select', 'color', 0, 0, 0, 2, '2016-04-06 13:57:06', 'published'),
(85, 0, 'select', 'display', 0, 0, 0, 2, '2016-04-06 13:57:29', 'published'),
(86, 84, 'value', 'aba9acdf9cba0badd40268e929646147', NULL, NULL, 0, 2, '2016-04-06 13:57:42', 'published'),
(87, 84, 'value', 'ec49c725116679307ee05b409cc02d90', NULL, NULL, 0, 2, '2016-04-06 13:57:52', 'published'),
(88, 84, 'value', '6d6e0b0e6f01aa5a9140f8994df32b0c', NULL, NULL, 0, 2, '2016-04-06 13:57:56', 'published'),
(89, 85, 'value', 'db91b14683e24e9a405a0403dcbbd891', NULL, NULL, 0, 2, '2016-04-06 13:58:01', 'published'),
(90, 85, 'value', 'e651937988b34eb1539007f50ab7957d', NULL, NULL, 0, 2, '2016-04-06 13:58:04', 'published'),
(91, 85, 'value', '2f65302d5f544bade318e467576bf23c', NULL, NULL, 0, 2, '2016-04-06 13:58:08', 'published'),
(92, 0, 'select', 'weight', 1, 0, 0, 2, '2016-04-06 15:24:22', 'published'),
(93, 92, 'value', '24c12d85bd040e9ecfc6eeceba608338', NULL, NULL, 0, 2, '2016-04-06 15:24:27', 'published'),
(94, 92, 'value', '4424c73412c0e1f3db140971aabc015d', NULL, NULL, 0, 2, '2016-04-06 15:24:29', 'published');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=46 ;

--
-- Дамп данных таблицы `features_content`
--

INSERT INTO `features_content` (`id`, `features_id`, `content_types_id`, `content_subtypes_id`, `content_id`, `position`) VALUES
(43, 84, 11, 11, 41, NULL),
(44, 85, 11, 11, 41, NULL),
(45, 92, 11, 11, 41, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=90 ;

--
-- Дамп данных таблицы `features_info`
--

INSERT INTO `features_info` (`id`, `features_id`, `languages_id`, `name`) VALUES
(79, 84, 1, 'Color'),
(80, 85, 1, 'Display'),
(81, 86, 1, 'black'),
(82, 87, 1, 'red'),
(83, 88, 1, 'white'),
(84, 89, 1, '14'),
(85, 90, 1, '15'),
(86, 91, 1, '16'),
(87, 92, 1, 'Weight'),
(88, 93, 1, '1'),
(89, 94, 1, '3');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Дамп данных таблицы `guides`
--

INSERT INTO `guides` (`id`, `parent_id`, `position`, `code`) VALUES
(1, 0, 0, 'units'),
(2, 1, 0, ''),
(3, 1, 0, ''),
(4, 1, 0, ''),
(5, 1, 0, ''),
(6, 1, 0, '');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Дамп данных таблицы `guides_info`
--

INSERT INTO `guides_info` (`id`, `guides_id`, `languages_id`, `name`) VALUES
(1, 1, 1, 'Кількість'),
(2, 2, 1, 'шт.'),
(3, 3, 1, 'уп.'),
(4, 4, 1, 'г.'),
(5, 5, 1, 'кг.'),
(6, 6, 1, 'т.');

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
  `code` varchar(30) NOT NULL,
  `name` varchar(60) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Дамп данных таблицы `mail_templates`
--

INSERT INTO `mail_templates` (`id`, `code`, `name`) VALUES
(1, 'account_register', 'Реєстрація користувача'),
(2, 'account_fp', 'Відновлення паролю'),
(3, 'comment', 'Новий коментар'),
(4, 'comments_notify_subscribers', 'Сповіщення підписників про новий кеоментар'),
(5, 'feedback', 'feedback'),
(6, 'callback', 'callback');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Дамп данных таблицы `mail_templates_info`
--

INSERT INTO `mail_templates_info` (`id`, `templates_id`, `languages_id`, `subject`, `body`) VALUES
(1, 1, 1, 'Вітаємо з реєстрацією', '<p>Вітаємо {$data.name}&nbsp;{$data.surname}. Ви успішно зареєстувались на нашому сайті.&nbsp;</p>\n\n<p>Ваш логін:&nbsp;{$data.email}</p>\n\n<p>Ваш пароль:&nbsp;{$data.password}</p>\n\n<p>Бажаєм хороших покупок</p>\n'),
(2, 2, 1, 'Відновлення паролюцйуцйу', '<p>Вітаємо {$data.name}. Ви отримали це повідомлення, так як здійснили запит на відновлення паролю.</p>\n\n<p>Для цього вам необхідно перейти по <a href="{$data.fp_link}">цьому&nbsp;посиланню</a></p>\n'),
(3, 3, 1, 'Новий коментар', '<p>Вітаємо.<br />\nНовий коментар до статі {$data.post_name}.<br />\nІм&#39;я: {$data.user.name}<br />\nEmail: {$data.user.email}<br />\nКоментар: {$data.message}<br />\n<br />\n----------------------------------<br />\nВи можете <a href="{$data.approve_url}">опублікувати коменар</a> або <a href="{$data.delete_url}">видалити</a> його.</p>\n'),
(4, 4, 1, 'Вітаємо. Новий коментар. ', '<p>Вітаємо {$data.name}. Ви отримали це повідомлення, так як слідкуєте за коментарями до статті {$data.page_name}.</p>\n\n<p>Ви можете <a href="{$data.page_url}">переглянути його тут</a>.</p>\n'),
(5, 5, 1, 'Повідолення з форми контактів', '<p>Вітаємо. Нове повідомлення з форми контактів.</p>\n\n<p>Ім&#39;я: {$data.name}</p>\n\n<p>Телефон: {$data.phone}</p>\n\n<p>Email: {$data.email}</p>\n\n<p>Повідомлення</p>\n\n<p>{$data.message}</p>\n'),
(6, 6, 1, 'Новий зворотній дзвінок', '<p>Вітаємо. Замовлено зворотній дзвінок.</p>\n\n<p>Ім&#39;я: {$data.name}</p>\n\n<p>Телефон: {$data.phone}</p>\n\n<p>Повідомлення</p>\n\n<p>{$data.message}</p>\n');

-- --------------------------------------------------------

--
-- Структура таблицы `modules`
--

CREATE TABLE IF NOT EXISTS `modules` (
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
-- Дамп данных таблицы `modules`
--

INSERT INTO `modules` (`id`, `icon`, `author`, `version`, `controller`, `settings`, `created`) VALUES
(6, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'second', NULL, '2016-03-23 14:22:40'),
(7, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'first', NULL, '2016-03-23 14:22:41'),
(8, 'fa-nav', 'Volodymyr Hodiak', '1.0.0', 'nav', NULL, '2016-03-24 08:44:14'),
(9, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'blog', NULL, '2016-03-24 13:36:39'),
(10, 'fa-user', 'Volodymyr Hodiak', '1.0.0', 'account', NULL, '2016-03-28 07:13:08'),
(11, 'fa-mail', 'Volodymyr Hodiak', '1.0.0', 'feedback', NULL, '2016-03-31 13:55:23');

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
-- Структура таблицы `orders_status`
--

CREATE TABLE IF NOT EXISTS `orders_status` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `orders_status`
--

INSERT INTO `orders_status` (`id`, `bg_color`, `txt_color`, `on_site`, `external_id`, `is_main`) VALUES
(3, '#099bfe', '#eaff00', 1, 'ффффф', 0),
(4, '#fc0808', '#ffef00', 1, '111111', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `orders_status_info`
--

CREATE TABLE IF NOT EXISTS `orders_status_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status_id` int(10) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`,`status_id`,`languages_id`),
  KEY `fk_orders_status_info_languages1_idx` (`languages_id`),
  KEY `fk_orders_status_info_orders_status1_idx` (`status_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Дамп данных таблицы `orders_status_info`
--

INSERT INTO `orders_status_info` (`id`, `status_id`, `languages_id`, `status`) VALUES
(2, 3, 1, 'aaazzz'),
(3, 4, 1, 'ффффф');

-- --------------------------------------------------------

--
-- Структура таблицы `payment`
--

CREATE TABLE IF NOT EXISTS `payment` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `published` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `module` varchar(60) NOT NULL,
  `settings` text,
  `position` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `module` (`module`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Дамп данных таблицы `payment`
--

INSERT INTO `payment` (`id`, `published`, `module`, `settings`, `position`) VALUES
(1, 1, 'YandexMoney', 'a:2:{s:9:"yandex_id";s:1:"1";s:13:"yandex_secret";s:1:"2";}', 0),
(2, 1, '', NULL, 0),
(3, 1, 'LiqPay', 'a:5:{s:10:"public_key";s:1:"1";s:11:"private_key";s:1:"2";s:10:"result_url";s:1:"3";s:9:"error_url";s:1:"4";s:7:"sandbox";s:1:"5";}', 0),
(4, 1, 'YandexMoney', 'a:2:{s:9:"yandex_id";s:1:"1";s:13:"yandex_secret";s:1:"2";}', 0),
(5, 1, 'WebMoney', 'a:2:{s:5:"purse";s:1:"1";s:10:"secret_key";s:1:"2";}', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `payment_info`
--

CREATE TABLE IF NOT EXISTS `payment_info` (
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
-- Дамп данных таблицы `payment_info`
--

INSERT INTO `payment_info` (`id`, `payment_id`, `languages_id`, `name`, `description`) VALUES
(1, 1, 1, 'При отриманні', ''),
(2, 2, 1, 'Розрахунковий рахунок', ''),
(3, 3, 1, 'Онлайн LiqPay', ''),
(4, 4, 1, 'Онлайн YandexMoney', ''),
(5, 5, 1, 'WebMoney', '');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=34 ;

--
-- Дамп данных таблицы `plugins`
--

INSERT INTO `plugins` (`id`, `icon`, `author`, `version`, `controller`, `place`, `published`, `rang`, `settings`, `created`) VALUES
(14, 'fa-folder-o', 'Volodymyr Hodiak', '1.0.0', 'pagesTree', 'sidebar', 1, 300, NULL, '2016-03-03 14:58:57'),
(16, 'fa-picture-o', 'Volodymyr Hodiak', '1.0.0', 'contentImages', 'after_params', 1, 300, NULL, '2016-03-09 11:26:40'),
(17, 'fa-folder-o', 'Volodymyr Hodiak', '1.0.0', 'nav', 'sidebar', 1, 300, NULL, '2016-03-17 11:41:40'),
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
(33, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'productsVariants', 'after_main', 1, 300, NULL, '2016-04-05 12:29:51');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=24 ;

--
-- Дамп данных таблицы `plugins_components`
--

INSERT INTO `plugins_components` (`id`, `plugins_id`, `components_id`, `position`) VALUES
(1, 17, 43, 0),
(2, 18, 51, 0),
(5, 16, 43, 0),
(7, 21, 1, 0),
(8, 23, 43, 0),
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
(23, 33, 72, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `products_prices`
--

CREATE TABLE IF NOT EXISTS `products_prices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` int(10) unsigned NOT NULL,
  `group_id` tinyint(3) unsigned NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `price_old` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`,`content_id`,`group_id`),
  UNIQUE KEY `content_id` (`content_id`,`group_id`),
  KEY `fk_products_prices_content1_idx` (`content_id`),
  KEY `fk_products_prices_users_group1_idx` (`group_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Дамп данных таблицы `products_prices`
--

INSERT INTO `products_prices` (`id`, `content_id`, `group_id`, `price`, `price_old`) VALUES
(7, 39, 5, 7.00, NULL),
(13, 39, 12, 6.00, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `products_variants`
--

CREATE TABLE IF NOT EXISTS `products_variants` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content_id` int(10) unsigned NOT NULL,
  `in_stock` tinyint(1) DEFAULT '1',
  `img` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`content_id`),
  KEY `fk_products_variants_content1_idx` (`content_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=22 ;

--
-- Дамп данных таблицы `products_variants`
--

INSERT INTO `products_variants` (`id`, `content_id`, `in_stock`, `img`) VALUES
(17, 39, 2, '/uploads/content/2016/04/07/variants/70efdf2ec9b086079795c442636b55fb.png'),
(18, 39, 2, '/uploads/content/2016/04/07/variants/6f4922f45568161a8cdf4ad2299f6d23.png'),
(19, 39, 2, '/uploads/content/2016/04/07/variants/1f0e3dad99908345f7439f8ffabdffc4.png'),
(20, 39, 1, '/uploads/content/2016/04/07/variants/98f13708210194c475687be6106a3b84.png'),
(21, 39, 0, '/uploads/content/2016/04/07/variants/3c59dc048e8850243be8079a5c74d079.png');

-- --------------------------------------------------------

--
-- Структура таблицы `products_variants_features`
--

CREATE TABLE IF NOT EXISTS `products_variants_features` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `variants_id` int(10) unsigned NOT NULL,
  `features_id` int(10) unsigned NOT NULL,
  `values_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`,`variants_id`,`features_id`,`values_id`),
  UNIQUE KEY `variants_id` (`variants_id`,`features_id`,`values_id`),
  KEY `fk_products_variants_features_features1_idx` (`features_id`),
  KEY `fk_products_variants_features_products_variants1_idx` (`variants_id`),
  KEY `fk_products_variants_features_features2_idx` (`values_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=27 ;

--
-- Дамп данных таблицы `products_variants_features`
--

INSERT INTO `products_variants_features` (`id`, `variants_id`, `features_id`, `values_id`) VALUES
(21, 17, 84, 86),
(22, 18, 84, 87),
(23, 19, 84, 88),
(25, 21, 84, 86),
(24, 20, 85, 89),
(26, 21, 85, 89);

-- --------------------------------------------------------

--
-- Структура таблицы `products_variants_prices`
--

CREATE TABLE IF NOT EXISTS `products_variants_prices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `variants_id` int(10) unsigned NOT NULL,
  `content_id` int(10) unsigned NOT NULL,
  `group_id` tinyint(3) unsigned NOT NULL,
  `price` decimal(10,0) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`,`variants_id`,`content_id`,`group_id`),
  UNIQUE KEY `variants_id` (`variants_id`,`content_id`,`group_id`),
  KEY `fk_products_variants_prices_products_variants1_idx` (`variants_id`,`content_id`),
  KEY `fk_products_variants_prices_users_group1_idx` (`group_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=37 ;

--
-- Дамп данных таблицы `products_variants_prices`
--

INSERT INTO `products_variants_prices` (`id`, `variants_id`, `content_id`, `group_id`, `price`) VALUES
(27, 17, 39, 5, 7),
(28, 17, 39, 12, 6),
(29, 18, 39, 5, 7),
(30, 18, 39, 12, 6),
(31, 19, 39, 5, 7),
(32, 19, 39, 12, 6),
(33, 20, 39, 5, 7),
(34, 20, 39, 12, 6),
(35, 21, 39, 5, 7),
(36, 21, 39, 12, 6);

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
-- Структура таблицы `tags`
--

CREATE TABLE IF NOT EXISTS `tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tag` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

--
-- Дамп данных таблицы `tags`
--

INSERT INTO `tags` (`id`, `tag`) VALUES
(17, 'php'),
(18, 'mysql'),
(19, 'jquery'),
(20, 'sdfsdf'),
(21, 'sdf'),
(22, 'sd'),
(23, 'f'),
(24, 'dsf');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `group_id`, `languages_id`, `sessid`, `name`, `surname`, `phone`, `email`, `password`, `avatar`, `skey`, `created`, `updated`, `lastlogin`, `status`) VALUES
(2, 1, 0, 'cqib3aongupefr8grbuudirmm2', 'Володимир', 'Годяк', '380676736242', 'wmgodyak@gmail.com', 'MTTuFPm3y4m2o', '/uploads/avatars/c81e728d9d4c2f636f067f89cc14862c.png', NULL, '2016-03-03 13:25:08', '2016-03-24 16:42:51', '2016-04-11 13:26:56', 'active'),
(3, 5, 0, 'cqib3aongupefr8grbuudirmm2', 'Жорік', 'Ревазов', '+35 (555) 5555555', 'z@otakoyi.com', 'MToUTd7.hmK2o', NULL, NULL, '2016-03-28 09:01:38', '2016-03-30 13:47:30', '2016-04-11 07:35:30', 'active'),
(5, 2, 0, NULL, 'Жорік', '', '', 'otakoyi@gmail.com', 'MTGRXCzqBsZUI', NULL, NULL, '2016-03-29 12:21:29', '0000-00-00 00:00:00', NULL, 'active'),
(6, 2, 0, NULL, 'Микола', '', '', 'm@otakoyi.com', 'MTTuFPm3y4m2o', NULL, NULL, '2016-03-29 13:18:45', '0000-00-00 00:00:00', NULL, 'active'),
(7, 2, 0, NULL, 'Микола', '', '', 'ma@otakoyi.com', 'MTTuFPm3y4m2o', NULL, NULL, '2016-03-29 13:21:09', '0000-00-00 00:00:00', NULL, 'active'),
(8, 2, 0, NULL, 'Микола', '', '', 'maa@otakoyi.com', 'MTTuFPm3y4m2o', NULL, NULL, '2016-03-29 13:21:48', '0000-00-00 00:00:00', NULL, 'active'),
(9, 2, 0, NULL, 'Мирослав', '', '', 'a@otakoyi.com', 'MzqZbtJqwKKb2', NULL, NULL, '2016-03-29 13:23:14', '0000-00-00 00:00:00', NULL, 'active'),
(10, 2, 0, NULL, 'Мирослав', '', '', 'abn@otakoyi.com', 'ODM9/UvU5lRU2', NULL, NULL, '2016-03-29 13:25:31', '0000-00-00 00:00:00', NULL, 'active'),
(11, 2, 0, NULL, 'Мирослав', '', '', 'aaa1@otakoyi.com', 'OTIINr6XCS672', NULL, NULL, '2016-03-29 15:16:27', '0000-00-00 00:00:00', NULL, 'active'),
(12, 2, 0, NULL, 'Жорік', 'Ревахов', '380', 'az@otakoyi.com', 'Mj9RxlgpZTdp.', NULL, NULL, '2016-03-30 06:21:45', '2016-03-30 09:29:15', NULL, 'active'),
(13, 2, 0, NULL, 'Жорік', 'Пуців', '+380505988960', 'aaz@otakoyi.com', 'MTijnUdHaWG6A', NULL, NULL, '2016-03-30 06:50:17', '2016-03-30 09:50:35', NULL, 'active'),
(14, 2, 0, NULL, 'Мирослав', 'Столярчук', '0675533808', 'zzzza@otakoyi.com', 'Mz90k2TaTlAow', NULL, NULL, '2016-03-30 06:52:09', '2016-03-30 10:21:05', NULL, 'active'),
(15, 2, 0, NULL, 'Серго', '', '', 'sw@otakoyi.com', 'MTTuFPm3y4m2o', NULL, NULL, '2016-03-31 06:52:33', '0000-00-00 00:00:00', NULL, 'active');

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
(1, 0, 0, 500, 1),
(2, 0, 0, 300, 0),
(4, 0, 0, 300, 0),
(5, 0, 0, 20, 0),
(12, 0, 0, 10, 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=27 ;

--
-- Дамп данных таблицы `users_group_info`
--

INSERT INTO `users_group_info` (`id`, `group_id`, `languages_id`, `name`) VALUES
(15, 1, 1, 'Адміністратори'),
(16, 2, 1, 'Редактори'),
(18, 4, 1, 'Модератори'),
(19, 5, 1, 'Роздріб'),
(26, 12, 1, 'Дрібний гурт');

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `banners`
--
ALTER TABLE `banners`
  ADD CONSTRAINT `fk_banners_banners_places1` FOREIGN KEY (`banners_places_id`) REFERENCES `banners_places` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_banners_languages1` FOREIGN KEY (`languages_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `banners_stat`
--
ALTER TABLE `banners_stat`
  ADD CONSTRAINT `fk_banners_stat_banners1` FOREIGN KEY (`banners_id`) REFERENCES `banners` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `fk_comments_content1` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_users_id` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `comments_subscribers`
--
ALTER TABLE `comments_subscribers`
  ADD CONSTRAINT `fk_comments_subscribers_content1` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_comments_subscribers_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
-- Ограничения внешнего ключа таблицы `content_tags`
--
ALTER TABLE `content_tags`
  ADD CONSTRAINT `fk_content_tags_languages1` FOREIGN KEY (`languages_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tags_content1` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tags_content_tags1` FOREIGN KEY (`tags_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `content_types_images_sizes`
--
ALTER TABLE `content_types_images_sizes`
  ADD CONSTRAINT `fk_content_types_images_sizes1` FOREIGN KEY (`types_id`) REFERENCES `content_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_content_types_images_sizes2` FOREIGN KEY (`images_sizes_id`) REFERENCES `content_images_sizes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `delivery_info`
--
ALTER TABLE `delivery_info`
  ADD CONSTRAINT `fk_delivery_info_delivery1` FOREIGN KEY (`delivery_id`) REFERENCES `delivery` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_delivery_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `delivery_payment`
--
ALTER TABLE `delivery_payment`
  ADD CONSTRAINT `fk_delivery_payment_delivery1` FOREIGN KEY (`delivery_id`) REFERENCES `delivery` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_delivery_payment_payment1` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
-- Ограничения внешнего ключа таблицы `orders_status_info`
--
ALTER TABLE `orders_status_info`
  ADD CONSTRAINT `fk_orders_status_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_orders_status_info_orders_status1` FOREIGN KEY (`status_id`) REFERENCES `orders_status` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `payment_info`
--
ALTER TABLE `payment_info`
  ADD CONSTRAINT `fk_payment_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_payment_info_payment1` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `plugins_components`
--
ALTER TABLE `plugins_components`
  ADD CONSTRAINT `fk_plugins_components_components1` FOREIGN KEY (`components_id`) REFERENCES `components` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_plugins_components_plugins1` FOREIGN KEY (`plugins_id`) REFERENCES `plugins` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `products_prices`
--
ALTER TABLE `products_prices`
  ADD CONSTRAINT `fk_products_prices_content1` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_products_prices_users_group1` FOREIGN KEY (`group_id`) REFERENCES `users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `products_variants`
--
ALTER TABLE `products_variants`
  ADD CONSTRAINT `fk_products_variants_content1` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `products_variants_features`
--
ALTER TABLE `products_variants_features`
  ADD CONSTRAINT `fk_products_variants_features_features1` FOREIGN KEY (`features_id`) REFERENCES `features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_products_variants_features_features2` FOREIGN KEY (`values_id`) REFERENCES `features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_products_variants_features_products_variants1` FOREIGN KEY (`variants_id`) REFERENCES `products_variants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `products_variants_prices`
--
ALTER TABLE `products_variants_prices`
  ADD CONSTRAINT `fk_products_variants_prices_products_variants1` FOREIGN KEY (`variants_id`, `content_id`) REFERENCES `products_variants` (`id`, `content_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_products_variants_prices_users_group1` FOREIGN KEY (`group_id`) REFERENCES `users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
