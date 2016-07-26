-- phpMyAdmin SQL Dump
-- version 4.4.13.1deb1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Час створення: Лип 25 2016 р., 22:06
-- Версія сервера: 5.6.30-0ubuntu0.15.10.1
-- Версія PHP: 5.6.11-1ubuntu3.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База даних: `engine`
--

-- --------------------------------------------------------

--
-- Структура таблиці `e_banners`
--

CREATE TABLE IF NOT EXISTS `e_banners` (
  `id` int(10) unsigned NOT NULL,
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
  `target` enum('_blank','_self') DEFAULT '_self'
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_banners`
--

INSERT INTO `e_banners` (`id`, `places_id`, `languages_id`, `skey`, `img`, `name`, `published`, `permanent`, `df`, `dt`, `url`, `target`) VALUES
(1, 1, 1, 'bae2a8d88b2a6d61dd7b2151b2610119', '/uploads/content/2016/07/05/c4ca4238a0b923820dcc509a6f75849b.jpg', '1', 1, 1, '0000-00-00', '0000-00-00', '2', '_self'),
(2, 1, 1, '76275e21c718a611c60b7b8d5e8b7f57', '/uploads/content/2016/07/05/c81e728d9d4c2f636f067f89cc14862c.jpg', '2', 1, 1, '0000-00-00', '0000-00-00', '1', '_self'),
(3, 1, 1, '7faad2a001643a2dcb52914edfd8760b', '/uploads/content/2016/07/05/eccbc87e4b5ce2fe28308fd9f2a7baf3.jpg', '3', 1, 1, '0000-00-00', '0000-00-00', '1', '_blank'),
(4, 1, 1, '72a4a4e67dd7764427c188a330af6adb', '/uploads/content/2016/07/05/a87ff679a2f3e71d9181a67b7542122c.jpg', '4', 1, 1, '0000-00-00', '0000-00-00', '1', '_blank'),
(5, 2, 1, 'e3f465073bceb43cfe3c9de2e617cbff', '/uploads/content/2016/07/05/e4da3b7fbbce2345d7772b0674a318d5.jpg', 'm1', 1, 1, '0000-00-00', '0000-00-00', '1', '_self'),
(6, 2, 1, '135bc9bf624ab42262c9dac6b6f4f429', '/uploads/content/2016/07/05/1679091c5a880faf6fb5e6087eb1b2dc.jpg', 'm2', 1, 1, '0000-00-00', '0000-00-00', '1', '_self');

-- --------------------------------------------------------

--
-- Структура таблиці `e_banners_places`
--

CREATE TABLE IF NOT EXISTS `e_banners_places` (
  `id` int(10) unsigned NOT NULL,
  `code` varchar(45) DEFAULT NULL,
  `name` varchar(60) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_banners_places`
--

INSERT INTO `e_banners_places` (`id`, `code`, `name`, `width`, `height`) VALUES
(1, 'home-top', 'Голоана', 730, 330),
(2, 'home-bottom', 'Головна внизу', 350, 175);

-- --------------------------------------------------------

--
-- Структура таблиці `e_callbacks`
--

CREATE TABLE IF NOT EXISTS `e_callbacks` (
  `id` int(10) unsigned NOT NULL,
  `users_id` int(10) unsigned DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `name` varchar(45) NOT NULL,
  `comment` text,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` char(16) NOT NULL,
  `status` enum('processed','spam','new') NOT NULL DEFAULT 'new',
  `manager_id` int(11) DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_callbacks`
--

INSERT INTO `e_callbacks` (`id`, `users_id`, `phone`, `name`, `comment`, `created`, `ip`, `status`, `manager_id`, `updated`) VALUES
(1, NULL, '+38(222)22-22-222', 'asas', NULL, '2016-07-16 16:38:57', '127.0.0.1', 'spam', 2, '0000-00-00 00:00:00'),
(2, NULL, '+38(121)21-21-212', 'Ваа', NULL, '2016-07-16 16:39:49', '127.0.0.1', 'new', NULL, '0000-00-00 00:00:00'),
(3, NULL, '+38(067)67-36-669', 'Жорік', 'asdasd', '2016-07-16 16:43:02', '127.0.0.1', 'processed', 2, '2016-07-16 16:47:17');

-- --------------------------------------------------------

--
-- Структура таблиці `e_comments`
--

CREATE TABLE IF NOT EXISTS `e_comments` (
  `id` int(10) unsigned NOT NULL,
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0',
  `isfolder` tinyint(3) unsigned NOT NULL,
  `content_id` int(11) unsigned NOT NULL,
  `users_id` int(11) unsigned NOT NULL,
  `message` text NOT NULL,
  `rate` decimal(2,1) unsigned NOT NULL DEFAULT '1.0',
  `likes` int(10) unsigned NOT NULL,
  `dislikes` int(10) unsigned NOT NULL,
  `status` enum('approved','spam','new') NOT NULL DEFAULT 'new',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` char(15) DEFAULT NULL,
  `skey` varchar(64) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_comments`
--

INSERT INTO `e_comments` (`id`, `parent_id`, `isfolder`, `content_id`, `users_id`, `message`, `rate`, `likes`, `dislikes`, `status`, `created`, `ip`, `skey`) VALUES
(9, 0, 0, 19, 3, 'Волна повышения тарифов заставила потребителей перейти на коммунальную диету.', 1.0, 8, 10, 'approved', '2016-07-06 11:40:07', '127.0.0.1', '1c55904e6e433ae46ad0c942a9f02f3e'),
(10, 0, 0, 19, 3, ' Доступность топливной составляющей — весомое преимущество отопительного спецоборудования', 1.0, 4, 3, 'approved', '2016-07-06 11:40:13', '127.0.0.1', '466041b743cabe402dba2b2a6cc6fa7f'),
(11, 0, 1, 19, 3, 'Монтаж и проектирование котельных – удел специалистов. Вам предлагается  эффективные, простые в эксплуатации, отопительные системы на твердом топливе, которые неприхотливы в обслуживании и отличаются низкой себестоимостью.', 1.0, 16, 7, 'approved', '2016-07-06 11:40:18', '127.0.0.1', '0e92702238ed4cd94d7db302462452dd'),
(12, 11, 0, 19, 3, 'Доступность топливной составляющей — весомое преимущество отопительного спецоборудования', 1.0, 3, 0, 'approved', '2016-07-06 11:40:33', '127.0.0.1', '80f17e2ff7322e8467090531507423a6'),
(13, 0, 0, 20, 3, 'sadasd', 1.0, 1, 0, 'approved', '2016-07-06 12:08:40', '127.0.0.1', '190ba6f7e72750ef7187daf501518691'),
(14, 0, 1, 18, 3, 'asdsad', 1.0, 1, 0, 'approved', '2016-07-06 12:40:19', '127.0.0.1', '9ebfa575feb5dc2ea7c09600a62d87ce'),
(15, 14, 0, 18, 3, 'werewrwerwer', 1.0, 1, 0, 'approved', '2016-07-06 12:40:32', '127.0.0.1', '68658129c770be4000e26cc3571e47c0'),
(16, 0, 0, 18, 3, 'dsfsdfsd', 1.0, 0, 1, 'approved', '2016-07-06 14:33:57', '127.0.0.1', '49baa44be06b5a56f0d91bb94837ad4c');

-- --------------------------------------------------------

--
-- Структура таблиці `e_comments_likers`
--

CREATE TABLE IF NOT EXISTS `e_comments_likers` (
  `id` int(10) unsigned NOT NULL,
  `users_id` int(11) unsigned NOT NULL,
  `comments_id` int(10) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Дамп даних таблиці `e_comments_likers`
--

INSERT INTO `e_comments_likers` (`id`, `users_id`, `comments_id`, `created`) VALUES
(1, 3, 11, '2016-07-06 11:59:02'),
(2, 3, 12, '2016-07-06 11:59:33'),
(3, 3, 10, '2016-07-06 11:59:35'),
(4, 3, 9, '2016-07-06 11:59:37'),
(5, 3, 13, '2016-07-06 12:09:55'),
(6, 3, 14, '2016-07-06 12:40:26'),
(7, 3, 15, '2016-07-06 12:40:43'),
(8, 3, 16, '2016-07-06 14:34:15');

-- --------------------------------------------------------

--
-- Структура таблиці `e_comments_subscribers`
--

CREATE TABLE IF NOT EXISTS `e_comments_subscribers` (
  `id` int(10) unsigned NOT NULL,
  `content_id` int(10) unsigned NOT NULL,
  `users_id` int(10) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_comments_subscribers`
--

INSERT INTO `e_comments_subscribers` (`id`, `content_id`, `users_id`, `created`) VALUES
(7, 20, 3, '2016-07-06 12:08:38'),
(11, 18, 3, '2016-07-06 14:34:20');

-- --------------------------------------------------------

--
-- Структура таблиці `e_content`
--

CREATE TABLE IF NOT EXISTS `e_content` (
  `id` int(10) unsigned NOT NULL,
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
  `sku` varchar(60) DEFAULT NULL,
  `currency_id` tinyint(3) unsigned DEFAULT NULL,
  `unit_id` tinyint(3) unsigned DEFAULT NULL,
  `has_variants` tinyint(1) unsigned DEFAULT NULL,
  `in_stock` tinyint(1) unsigned DEFAULT NULL,
  `external_id` char(32) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11491 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_content`
--

INSERT INTO `e_content` (`id`, `types_id`, `subtypes_id`, `owner_id`, `parent_id`, `isfolder`, `position`, `created`, `updated`, `published`, `settings`, `status`, `sku`, `currency_id`, `unit_id`, `has_variants`, `in_stock`, `external_id`) VALUES
(1, 1, 16, 2, 0, 1, 0, '2016-07-04 19:39:41', '2016-07-04 20:00:21', '2016-07-04', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(4, 1, 1, 2, 1, 0, 0, '2016-07-04 20:09:38', '2016-07-17 10:26:46', '2016-07-04', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(5, 1, 17, 2, 1, 0, 0, '2016-07-04 20:09:55', '2016-07-11 14:53:51', '2016-07-04', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(6, 1, 1, 2, 1, 0, 0, '2016-07-04 20:10:10', '2016-07-11 14:53:56', '2016-07-04', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(7, 1, 21, 2, 1, 0, 0, '2016-07-04 20:10:43', '2016-07-16 16:52:45', '2016-07-04', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(8, 1, 24, 2, 1, 0, 0, '2016-07-11 14:54:48', '2016-07-11 15:03:11', '2016-07-11', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(9, 1, 25, 2, 1, 0, 0, '2016-07-13 15:16:14', '2016-07-14 09:29:20', '2016-07-13', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(10, 1, 26, 2, 1, 0, 0, '2016-07-13 15:38:14', '2016-07-14 06:33:21', '2016-07-13', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(11, 1, 1, 2, 1, 0, 0, '2016-07-14 09:30:26', '2016-07-14 09:30:34', '2016-07-14', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(12, 1, 27, 2, 26, 0, 0, '2016-07-15 12:58:29', '2016-07-15 14:31:15', '2016-07-15', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(16, 19, 19, 2, 0, 0, 0, '2016-07-05 07:03:56', '2016-07-05 07:03:56', '2016-07-05', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(17, 19, 19, 2, 0, 0, 0, '2016-07-05 07:04:05', '2016-07-05 07:04:05', '2016-07-05', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(18, 18, 18, 2, 0, 0, 0, '2016-07-05 07:04:07', '2016-07-16 17:44:56', '2016-07-05', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(19, 18, 18, 2, 0, 0, 0, '2016-07-05 07:22:12', '2016-07-05 09:28:34', '2016-07-05', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(20, 18, 18, 2, 0, 0, 0, '2016-07-05 07:25:51', '2016-07-05 09:29:28', '2016-07-05', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(21, 18, 18, 2, 0, 0, 0, '2016-07-05 07:26:32', '2016-07-05 07:26:59', '2016-07-05', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(22, 18, 18, 2, 0, 0, 0, '2016-07-05 07:27:13', '2016-07-05 07:27:36', '2016-07-05', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(23, 18, 18, 2, 0, 0, 0, '2016-07-05 07:27:41', '2016-07-05 07:28:44', '2016-07-05', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(25, 1, 1, 2, 1, 0, 0, '2016-07-06 13:05:47', '2016-07-11 14:54:04', '2016-07-06', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(26, 1, 20, 2, 1, 1, 0, '2016-07-07 07:34:56', '2016-07-11 14:54:09', '2016-07-07', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(28, 1, 20, 2, 26, 1, 0, '2016-07-07 07:35:12', '2016-07-15 12:39:13', '2016-07-07', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(29, 1, 20, 2, 28, 0, 0, '2016-07-07 08:08:57', '2016-07-07 08:09:05', '2016-07-07', NULL, 'deleted', NULL, NULL, NULL, NULL, NULL, NULL),
(30, 1, 20, 2, 26, 0, 0, '2016-07-07 08:09:06', '2016-07-15 12:17:59', '2016-07-07', NULL, 'hidden', NULL, NULL, NULL, NULL, NULL, NULL),
(31, 1, 20, 2, 26, 0, 0, '2016-07-07 08:14:53', '2016-07-15 10:45:52', '2016-07-07', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(32, 1, 20, 2, 26, 0, 0, '2016-07-07 08:15:17', '2016-07-07 08:15:43', '2016-07-07', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(34, 2, 2, 2, 0, 1, 0, '2016-07-07 11:11:18', '2016-07-07 11:12:46', '2016-07-07', NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'units'),
(35, 2, 2, 2, 34, 0, 0, '2016-07-07 11:11:31', '2016-07-07 11:11:31', '2016-07-07', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(36, 2, 2, 2, 34, 0, 0, '2016-07-07 11:11:48', '2016-07-07 11:11:48', '2016-07-07', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(37, 2, 2, 2, 34, 0, 0, '2016-07-07 11:11:55', '2016-07-07 11:11:55', '2016-07-07', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(38, 2, 2, 2, 34, 0, 0, '2016-07-07 11:12:06', '2016-07-07 11:12:06', '2016-07-07', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(39, 2, 2, 2, 34, 0, 0, '2016-07-07 11:12:12', '2016-07-07 11:12:12', '2016-07-07', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(10271, 2, 2, 2, 0, 1, 0, '2016-07-09 13:55:55', '2016-07-09 14:07:20', '2016-07-09', NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'shop.sorting'),
(10272, 2, 2, 2, 10271, 0, 0, '2016-07-09 13:56:38', '2016-07-09 14:16:05', '2016-07-09', NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'popular'),
(10273, 2, 2, 2, 10271, 0, 0, '2016-07-09 13:57:02', '2016-07-09 14:15:56', '2016-07-09', NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'cheap'),
(10274, 2, 2, 2, 10271, 0, 0, '2016-07-09 13:57:11', '2016-07-09 14:15:47', '2016-07-09', NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'expensive'),
(10275, 2, 2, 2, 10271, 0, 0, '2016-07-09 13:57:37', '2016-07-09 14:16:18', '2016-07-09', NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'in-stock'),
(10277, 1, 1, 2, 1, 0, 0, '2016-07-16 18:14:54', '2016-07-16 18:17:18', '2016-07-16', NULL, 'hidden', NULL, NULL, NULL, NULL, NULL, NULL),
(10288, 22, 22, 2, NULL, 0, 0, '2016-07-25 19:04:59', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'ІДКатегорії'),
(10289, 22, 22, 2, 0, 1, 0, '2016-07-25 19:04:59', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1'),
(10290, 22, 22, 2, 10289, 1, 0, '2016-07-25 19:04:59', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11'),
(10291, 22, 22, 2, 10290, 1, 0, '2016-07-25 19:04:59', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '111'),
(10292, 22, 22, 2, 10291, 0, 0, '2016-07-25 19:04:59', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1111'),
(10293, 22, 22, 2, 10291, 0, 0, '2016-07-25 19:04:59', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1112'),
(10294, 22, 22, 2, 10291, 0, 0, '2016-07-25 19:05:00', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1113'),
(10295, 22, 22, 2, 10291, 0, 0, '2016-07-25 19:05:00', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1114'),
(10296, 22, 22, 2, 10290, 1, 0, '2016-07-25 19:05:00', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '112'),
(10297, 22, 22, 2, 10296, 0, 0, '2016-07-25 19:05:00', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1121'),
(10298, 22, 22, 2, 10296, 0, 0, '2016-07-25 19:05:00', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1122'),
(10299, 22, 22, 2, 10296, 0, 0, '2016-07-25 19:05:00', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1123'),
(10300, 22, 22, 2, 10296, 0, 0, '2016-07-25 19:05:00', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1124'),
(10301, 22, 22, 2, 10290, 1, 0, '2016-07-25 19:05:00', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '113'),
(10302, 22, 22, 2, 10301, 0, 0, '2016-07-25 19:05:00', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1132'),
(10303, 22, 22, 2, 10301, 0, 0, '2016-07-25 19:05:00', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1133'),
(10304, 22, 22, 2, 10301, 0, 0, '2016-07-25 19:05:00', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1134'),
(10305, 22, 22, 2, 10290, 1, 0, '2016-07-25 19:05:00', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '114'),
(10306, 22, 22, 2, 10305, 0, 0, '2016-07-25 19:05:00', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1142'),
(10307, 22, 22, 2, 10305, 0, 0, '2016-07-25 19:05:00', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1143'),
(10308, 22, 22, 2, 10305, 0, 0, '2016-07-25 19:05:00', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1144'),
(10309, 22, 22, 2, 10290, 1, 0, '2016-07-25 19:05:00', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '115'),
(10310, 22, 22, 2, 10309, 0, 0, '2016-07-25 19:05:00', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1151'),
(10311, 22, 22, 2, 10309, 0, 0, '2016-07-25 19:05:00', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1152'),
(10312, 22, 22, 2, 10309, 0, 0, '2016-07-25 19:05:00', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1153'),
(10313, 22, 22, 2, 10309, 0, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1154'),
(10314, 22, 22, 2, 10290, 1, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '116'),
(10315, 22, 22, 2, 10314, 0, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1162'),
(10316, 22, 22, 2, 10314, 0, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1163'),
(10317, 22, 22, 2, 10290, 1, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '117'),
(10318, 22, 22, 2, 10317, 0, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1172'),
(10319, 22, 22, 2, 10317, 0, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1173'),
(10320, 22, 22, 2, 10290, 1, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '118'),
(10321, 22, 22, 2, 10320, 0, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1181'),
(10322, 22, 22, 2, 10320, 0, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1182'),
(10323, 22, 22, 2, 10290, 1, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '119'),
(10324, 22, 22, 2, 10323, 0, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1191'),
(10325, 22, 22, 2, 10323, 0, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1192'),
(10326, 22, 22, 2, 10323, 0, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1193'),
(10327, 22, 22, 2, 10290, 1, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11A'),
(10328, 22, 22, 2, 10327, 0, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11A1'),
(10329, 22, 22, 2, 10290, 1, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11B'),
(10330, 22, 22, 2, 10329, 0, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11B1'),
(10331, 22, 22, 2, 10329, 0, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11B2'),
(10332, 22, 22, 2, 10329, 0, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11B3'),
(10333, 22, 22, 2, 10329, 0, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11B4'),
(10334, 22, 22, 2, 10290, 1, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11C'),
(10335, 22, 22, 2, 10334, 0, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11C1'),
(10336, 22, 22, 2, 10290, 1, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11D'),
(10337, 22, 22, 2, 10336, 0, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11D1'),
(10338, 22, 22, 2, 10290, 0, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11E'),
(10339, 22, 22, 2, 10290, 0, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11F'),
(10340, 22, 22, 2, 10290, 0, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11G'),
(10341, 22, 22, 2, 10290, 1, 0, '2016-07-25 19:05:01', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11H'),
(10342, 22, 22, 2, 10341, 0, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11H1'),
(10343, 22, 22, 2, 10341, 0, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11H2'),
(10344, 22, 22, 2, 10290, 0, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11I'),
(10345, 22, 22, 2, 10290, 1, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11J'),
(10346, 22, 22, 2, 10345, 0, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11J1'),
(10347, 22, 22, 2, 10345, 0, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11J2'),
(10348, 22, 22, 2, 10290, 0, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11K'),
(10349, 22, 22, 2, 10290, 1, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11L'),
(10350, 22, 22, 2, 10349, 0, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11L1'),
(10351, 22, 22, 2, 10290, 1, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11M'),
(10352, 22, 22, 2, 10351, 0, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11M1'),
(10353, 22, 22, 2, 10290, 1, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11N'),
(10354, 22, 22, 2, 10353, 0, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11N1'),
(10355, 22, 22, 2, 10290, 0, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11O'),
(10356, 22, 22, 2, 10290, 0, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '11P'),
(10357, 22, 22, 2, 10289, 1, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '12'),
(10358, 22, 22, 2, 10357, 1, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '121'),
(10359, 22, 22, 2, 10358, 0, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1211'),
(10360, 22, 22, 2, 10358, 0, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1212'),
(10361, 22, 22, 2, 10358, 0, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1213'),
(10362, 22, 22, 2, 10358, 0, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1214'),
(10363, 22, 22, 2, 10357, 1, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '122'),
(10364, 22, 22, 2, 10363, 0, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1221'),
(10365, 22, 22, 2, 10363, 0, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1222'),
(10366, 22, 22, 2, 10363, 0, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1223'),
(10367, 22, 22, 2, 10363, 0, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1224'),
(10368, 22, 22, 2, 10357, 1, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '123'),
(10369, 22, 22, 2, 10368, 0, 0, '2016-07-25 19:05:02', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1231'),
(10370, 22, 22, 2, 10368, 0, 0, '2016-07-25 19:05:03', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1232'),
(10371, 22, 22, 2, 10357, 1, 0, '2016-07-25 19:05:03', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '124'),
(10372, 22, 22, 2, 10371, 0, 0, '2016-07-25 19:05:03', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1241'),
(10373, 22, 22, 2, 10371, 0, 0, '2016-07-25 19:05:03', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1242'),
(10374, 22, 22, 2, 10371, 0, 0, '2016-07-25 19:05:03', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1243'),
(10375, 22, 22, 2, 10357, 1, 0, '2016-07-25 19:05:03', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '125'),
(10376, 22, 22, 2, 10375, 0, 0, '2016-07-25 19:05:03', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1251'),
(10377, 22, 22, 2, 10375, 0, 0, '2016-07-25 19:05:03', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1252'),
(10378, 22, 22, 2, 10375, 0, 0, '2016-07-25 19:05:03', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1253'),
(10379, 22, 22, 2, 10357, 1, 0, '2016-07-25 19:05:03', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '126'),
(10380, 22, 22, 2, 10379, 0, 0, '2016-07-25 19:05:03', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1261'),
(10381, 22, 22, 2, 10357, 1, 0, '2016-07-25 19:05:03', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '127'),
(10382, 22, 22, 2, 10381, 0, 0, '2016-07-25 19:05:03', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1271'),
(10383, 22, 22, 2, 10381, 0, 0, '2016-07-25 19:05:03', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1272'),
(10384, 22, 22, 2, 10357, 1, 0, '2016-07-25 19:05:03', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '128'),
(10385, 22, 22, 2, 10384, 0, 0, '2016-07-25 19:05:03', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1281'),
(10386, 22, 22, 2, 10357, 1, 0, '2016-07-25 19:05:03', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '129'),
(10387, 22, 22, 2, 10386, 0, 0, '2016-07-25 19:05:03', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1291'),
(10388, 22, 22, 2, 10386, 0, 0, '2016-07-25 19:05:03', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1292'),
(10389, 22, 22, 2, 10357, 1, 0, '2016-07-25 19:05:03', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '12A'),
(10390, 22, 22, 2, 10389, 0, 0, '2016-07-25 19:05:03', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '12A1'),
(10391, 22, 22, 2, 10389, 0, 0, '2016-07-25 19:05:03', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '12A2'),
(10392, 22, 22, 2, 10357, 1, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '12B'),
(10393, 22, 22, 2, 10392, 0, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '12B1'),
(10394, 22, 22, 2, 10392, 0, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '12B2'),
(10395, 22, 22, 2, 10392, 0, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '12B3'),
(10396, 22, 22, 2, 10357, 1, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '12C'),
(10397, 22, 22, 2, 10396, 0, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '12C1'),
(10398, 22, 22, 2, 10396, 0, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '12C2'),
(10399, 22, 22, 2, 10357, 1, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '12D'),
(10400, 22, 22, 2, 10399, 0, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '12D1'),
(10401, 22, 22, 2, 10357, 1, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '12E'),
(10402, 22, 22, 2, 10401, 0, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '12E1'),
(10403, 22, 22, 2, 10401, 0, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '12E2'),
(10404, 22, 22, 2, 10357, 0, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '12J'),
(10405, 22, 22, 2, 10357, 1, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '12K'),
(10406, 22, 22, 2, 10405, 0, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '12K1'),
(10407, 22, 22, 2, 10357, 1, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '12L'),
(10408, 22, 22, 2, 10407, 0, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '12L1'),
(10409, 22, 22, 2, 10357, 1, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '12M'),
(10410, 22, 22, 2, 10409, 0, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '12M1'),
(10411, 22, 22, 2, 10357, 1, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '12N'),
(10412, 22, 22, 2, 10411, 0, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '12N1'),
(10413, 22, 22, 2, 10289, 1, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '13'),
(10414, 22, 22, 2, 10413, 1, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '131'),
(10415, 22, 22, 2, 10414, 0, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1311'),
(10416, 22, 22, 2, 10414, 0, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1312'),
(10417, 22, 22, 2, 10414, 0, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1313'),
(10418, 22, 22, 2, 10414, 0, 0, '2016-07-25 19:05:04', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1314'),
(10419, 22, 22, 2, 10413, 1, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '132'),
(10420, 22, 22, 2, 10419, 0, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1321'),
(10421, 22, 22, 2, 10419, 0, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1322'),
(10422, 22, 22, 2, 10419, 0, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1323'),
(10423, 22, 22, 2, 10419, 0, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1324'),
(10424, 22, 22, 2, 10413, 1, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '133'),
(10425, 22, 22, 2, 10424, 0, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1331'),
(10426, 22, 22, 2, 10424, 0, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1332'),
(10427, 22, 22, 2, 10424, 0, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1333'),
(10428, 22, 22, 2, 10413, 1, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '134'),
(10429, 22, 22, 2, 10428, 0, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1341'),
(10430, 22, 22, 2, 10428, 0, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1342'),
(10431, 22, 22, 2, 10413, 1, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '135'),
(10432, 22, 22, 2, 10431, 0, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1351'),
(10433, 22, 22, 2, 10431, 0, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1352'),
(10434, 22, 22, 2, 10431, 0, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1353'),
(10435, 22, 22, 2, 10413, 1, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '136'),
(10436, 22, 22, 2, 10435, 0, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1361'),
(10437, 22, 22, 2, 10413, 1, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '137'),
(10438, 22, 22, 2, 10437, 0, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1371'),
(10439, 22, 22, 2, 10413, 1, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '138'),
(10440, 22, 22, 2, 10439, 0, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1381'),
(10441, 22, 22, 2, 10439, 0, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1382'),
(10442, 22, 22, 2, 10439, 0, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1383'),
(10443, 22, 22, 2, 10413, 1, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '139'),
(10444, 22, 22, 2, 10443, 0, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1391'),
(10445, 22, 22, 2, 10413, 0, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '13A'),
(10446, 22, 22, 2, 10413, 1, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '13B'),
(10447, 22, 22, 2, 10446, 0, 0, '2016-07-25 19:05:05', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '13B1'),
(10448, 22, 22, 2, 10413, 1, 0, '2016-07-25 19:05:06', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '13C'),
(10449, 22, 22, 2, 10448, 0, 0, '2016-07-25 19:05:06', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '13C1'),
(10450, 22, 22, 2, 10289, 1, 0, '2016-07-25 19:05:06', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '14'),
(10451, 22, 22, 2, 10450, 1, 0, '2016-07-25 19:05:06', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '141'),
(10452, 22, 22, 2, 10451, 0, 0, '2016-07-25 19:05:06', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1411'),
(10453, 22, 22, 2, 10451, 0, 0, '2016-07-25 19:05:06', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1412'),
(10454, 22, 22, 2, 10451, 0, 0, '2016-07-25 19:05:06', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1413'),
(10455, 22, 22, 2, 10451, 0, 0, '2016-07-25 19:05:06', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1414'),
(10456, 22, 22, 2, 10450, 1, 0, '2016-07-25 19:05:06', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '142'),
(10457, 22, 22, 2, 10456, 0, 0, '2016-07-25 19:05:06', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1421'),
(10458, 22, 22, 2, 10456, 0, 0, '2016-07-25 19:05:06', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1422'),
(10459, 22, 22, 2, 10456, 0, 0, '2016-07-25 19:05:06', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1423'),
(10460, 22, 22, 2, 10456, 0, 0, '2016-07-25 19:05:06', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1424'),
(10461, 22, 22, 2, 10450, 1, 0, '2016-07-25 19:05:06', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '143'),
(10462, 22, 22, 2, 10461, 0, 0, '2016-07-25 19:05:06', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1431'),
(10463, 22, 22, 2, 10461, 0, 0, '2016-07-25 19:05:06', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1432'),
(10464, 22, 22, 2, 10450, 1, 0, '2016-07-25 19:05:06', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '144'),
(10465, 22, 22, 2, 10464, 0, 0, '2016-07-25 19:05:06', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1441'),
(10466, 22, 22, 2, 10450, 1, 0, '2016-07-25 19:05:06', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '145'),
(10467, 22, 22, 2, 10466, 0, 0, '2016-07-25 19:05:06', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1451'),
(10468, 22, 22, 2, 10450, 1, 0, '2016-07-25 19:05:06', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '146'),
(10469, 22, 22, 2, 10468, 0, 0, '2016-07-25 19:05:06', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1461'),
(10470, 22, 22, 2, 10450, 0, 0, '2016-07-25 19:05:06', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '147'),
(10471, 22, 22, 2, 10450, 0, 0, '2016-07-25 19:05:06', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '148'),
(10472, 22, 22, 2, 10289, 1, 0, '2016-07-25 19:05:07', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '15'),
(10473, 22, 22, 2, 10472, 1, 0, '2016-07-25 19:05:07', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '151'),
(10474, 22, 22, 2, 10473, 0, 0, '2016-07-25 19:05:07', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1511'),
(10475, 22, 22, 2, 10473, 0, 0, '2016-07-25 19:05:07', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1512'),
(10476, 22, 22, 2, 10472, 1, 0, '2016-07-25 19:05:07', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '152'),
(10477, 22, 22, 2, 10476, 0, 0, '2016-07-25 19:05:07', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1521'),
(10478, 22, 22, 2, 10476, 0, 0, '2016-07-25 19:05:07', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1522'),
(10479, 22, 22, 2, 10476, 0, 0, '2016-07-25 19:05:07', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1523'),
(10480, 22, 22, 2, 10472, 1, 0, '2016-07-25 19:05:07', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '153'),
(10481, 22, 22, 2, 10480, 0, 0, '2016-07-25 19:05:07', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1531'),
(10482, 22, 22, 2, 10480, 0, 0, '2016-07-25 19:05:07', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1532'),
(10483, 22, 22, 2, 10480, 0, 0, '2016-07-25 19:05:07', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1533'),
(10484, 22, 22, 2, 10472, 1, 0, '2016-07-25 19:05:07', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '154'),
(10485, 22, 22, 2, 10484, 0, 0, '2016-07-25 19:05:07', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1541'),
(10486, 22, 22, 2, 10484, 0, 0, '2016-07-25 19:05:07', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1542'),
(10487, 22, 22, 2, 10484, 0, 0, '2016-07-25 19:05:07', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1543'),
(10488, 22, 22, 2, 10472, 1, 0, '2016-07-25 19:05:07', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '155'),
(10489, 22, 22, 2, 10488, 0, 0, '2016-07-25 19:05:07', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1551'),
(10490, 22, 22, 2, 10472, 1, 0, '2016-07-25 19:05:07', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '156'),
(10491, 22, 22, 2, 10490, 0, 0, '2016-07-25 19:05:07', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1561'),
(10492, 22, 22, 2, 10490, 0, 0, '2016-07-25 19:05:07', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1562'),
(10493, 22, 22, 2, 10490, 0, 0, '2016-07-25 19:05:07', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1563'),
(10494, 22, 22, 2, 10472, 1, 0, '2016-07-25 19:05:07', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '157'),
(10495, 22, 22, 2, 10494, 0, 0, '2016-07-25 19:05:08', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1571'),
(10496, 22, 22, 2, 10494, 0, 0, '2016-07-25 19:05:08', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1572'),
(10497, 22, 22, 2, 10472, 1, 0, '2016-07-25 19:05:08', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '158'),
(10498, 22, 22, 2, 10497, 0, 0, '2016-07-25 19:05:08', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1581'),
(10499, 22, 22, 2, 10472, 1, 0, '2016-07-25 19:05:08', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '159'),
(10500, 22, 22, 2, 10499, 0, 0, '2016-07-25 19:05:08', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1591'),
(10501, 22, 22, 2, 10499, 0, 0, '2016-07-25 19:05:08', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1592'),
(10502, 22, 22, 2, 10472, 1, 0, '2016-07-25 19:05:08', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '15A'),
(10503, 22, 22, 2, 10502, 0, 0, '2016-07-25 19:05:08', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '15A1'),
(10504, 22, 22, 2, 10472, 0, 0, '2016-07-25 19:05:08', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '15B'),
(10505, 22, 22, 2, 10472, 0, 0, '2016-07-25 19:05:08', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '15C'),
(10506, 22, 22, 2, 10472, 0, 0, '2016-07-25 19:05:08', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '15D'),
(10507, 22, 22, 2, 10289, 1, 0, '2016-07-25 19:05:08', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '16'),
(10508, 22, 22, 2, 10507, 1, 0, '2016-07-25 19:05:08', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '161'),
(10509, 22, 22, 2, 10508, 0, 0, '2016-07-25 19:05:08', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1612'),
(10510, 22, 22, 2, 10508, 0, 0, '2016-07-25 19:05:08', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1613'),
(10511, 22, 22, 2, 10507, 1, 0, '2016-07-25 19:05:08', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '162'),
(10512, 22, 22, 2, 10511, 0, 0, '2016-07-25 19:05:08', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1621'),
(10513, 22, 22, 2, 10511, 0, 0, '2016-07-25 19:05:08', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1622'),
(10514, 22, 22, 2, 10511, 0, 0, '2016-07-25 19:05:08', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1623'),
(10515, 22, 22, 2, 10507, 1, 0, '2016-07-25 19:05:08', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '163'),
(10516, 22, 22, 2, 10515, 0, 0, '2016-07-25 19:05:08', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1631'),
(10517, 22, 22, 2, 10515, 0, 0, '2016-07-25 19:05:08', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1632'),
(10518, 22, 22, 2, 10515, 0, 0, '2016-07-25 19:05:08', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1633'),
(10519, 22, 22, 2, 10507, 0, 0, '2016-07-25 19:05:08', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '164'),
(10520, 22, 22, 2, 10507, 1, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '165'),
(10521, 22, 22, 2, 10520, 0, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1651'),
(10522, 22, 22, 2, 10507, 1, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '166'),
(10523, 22, 22, 2, 10522, 0, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1661'),
(10524, 22, 22, 2, 10507, 1, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '167'),
(10525, 22, 22, 2, 10524, 0, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1671'),
(10526, 22, 22, 2, 10524, 0, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1672'),
(10527, 22, 22, 2, 10507, 0, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '168'),
(10528, 22, 22, 2, 10289, 1, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '17'),
(10529, 22, 22, 2, 10528, 1, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '171'),
(10530, 22, 22, 2, 10529, 0, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1711'),
(10531, 22, 22, 2, 10529, 0, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1712'),
(10532, 22, 22, 2, 10529, 0, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1713'),
(10533, 22, 22, 2, 10528, 1, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '172'),
(10534, 22, 22, 2, 10533, 0, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1721'),
(10535, 22, 22, 2, 10533, 0, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1722'),
(10536, 22, 22, 2, 10533, 0, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1723'),
(10537, 22, 22, 2, 10528, 1, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '173'),
(10538, 22, 22, 2, 10537, 0, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1731'),
(10539, 22, 22, 2, 10528, 1, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '174'),
(10540, 22, 22, 2, 10539, 0, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1741'),
(10541, 22, 22, 2, 10528, 1, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '175'),
(10542, 22, 22, 2, 10541, 0, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1751'),
(10543, 22, 22, 2, 10541, 0, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1752'),
(10544, 22, 22, 2, 10528, 1, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '176'),
(10545, 22, 22, 2, 10544, 0, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1761'),
(10546, 22, 22, 2, 10528, 1, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '177'),
(10547, 22, 22, 2, 10546, 0, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1771'),
(10548, 22, 22, 2, 10528, 0, 0, '2016-07-25 19:05:09', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '178'),
(10549, 22, 22, 2, 10528, 0, 0, '2016-07-25 19:05:10', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '179'),
(10550, 22, 22, 2, 10528, 0, 0, '2016-07-25 19:05:10', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '17А'),
(10551, 22, 22, 2, 10289, 0, 0, '2016-07-25 19:05:10', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '18'),
(10552, 22, 22, 2, 10289, 0, 0, '2016-07-25 19:05:10', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '19'),
(10553, 22, 22, 2, 10289, 1, 0, '2016-07-25 19:05:10', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A'),
(10554, 22, 22, 2, 10553, 1, 0, '2016-07-25 19:05:10', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A1'),
(10555, 22, 22, 2, 10554, 0, 0, '2016-07-25 19:05:10', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A11'),
(10556, 22, 22, 2, 10554, 0, 0, '2016-07-25 19:05:10', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A12'),
(10557, 22, 22, 2, 10554, 0, 0, '2016-07-25 19:05:10', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A13'),
(10558, 22, 22, 2, 10554, 0, 0, '2016-07-25 19:05:10', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A14'),
(10559, 22, 22, 2, 10554, 0, 0, '2016-07-25 19:05:10', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A15'),
(10560, 22, 22, 2, 10554, 0, 0, '2016-07-25 19:05:10', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A16'),
(10561, 22, 22, 2, 10553, 0, 0, '2016-07-25 19:05:10', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A2'),
(10562, 22, 22, 2, 10553, 0, 0, '2016-07-25 19:05:10', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A3'),
(10563, 22, 22, 2, 10553, 0, 0, '2016-07-25 19:05:10', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A4'),
(10564, 22, 22, 2, 10553, 1, 0, '2016-07-25 19:05:10', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A5'),
(10565, 22, 22, 2, 10564, 0, 0, '2016-07-25 19:05:10', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A51'),
(10566, 22, 22, 2, 10564, 0, 0, '2016-07-25 19:05:10', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A52'),
(10567, 22, 22, 2, 10553, 1, 0, '2016-07-25 19:05:10', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A6'),
(10568, 22, 22, 2, 10567, 0, 0, '2016-07-25 19:05:10', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A61'),
(10569, 22, 22, 2, 10567, 0, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A62'),
(10570, 22, 22, 2, 10567, 0, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A63'),
(10571, 22, 22, 2, 10567, 0, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A64'),
(10572, 22, 22, 2, 10567, 0, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A65'),
(10573, 22, 22, 2, 10567, 0, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A66'),
(10574, 22, 22, 2, 10567, 0, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A67'),
(10575, 22, 22, 2, 10567, 0, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A68'),
(10576, 22, 22, 2, 10567, 0, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A69'),
(10577, 22, 22, 2, 10567, 0, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A6A'),
(10578, 22, 22, 2, 10567, 0, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A6B'),
(10579, 22, 22, 2, 10567, 0, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A6C'),
(10580, 22, 22, 2, 10567, 0, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A6D'),
(10581, 22, 22, 2, 10553, 0, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1A7'),
(10582, 22, 22, 2, 10289, 1, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1B'),
(10583, 22, 22, 2, 10582, 0, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1B1'),
(10584, 22, 22, 2, 10582, 0, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1B2'),
(10585, 22, 22, 2, 10582, 0, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1B3'),
(10586, 22, 22, 2, 10582, 0, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1B4'),
(10587, 22, 22, 2, 10582, 0, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1B5'),
(10588, 22, 22, 2, 10289, 1, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1C'),
(10589, 22, 22, 2, 10588, 0, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1C1'),
(10590, 22, 22, 2, 10588, 0, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1C2'),
(10591, 22, 22, 2, 10588, 0, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1C3'),
(10592, 22, 22, 2, 10588, 0, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1C4'),
(10593, 22, 22, 2, 10588, 0, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1C5'),
(10594, 22, 22, 2, 10588, 0, 0, '2016-07-25 19:05:11', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1C6'),
(10595, 22, 22, 2, 10588, 0, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1C7'),
(10596, 22, 22, 2, 10588, 0, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1C8'),
(10597, 22, 22, 2, 10588, 0, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1C9'),
(10598, 22, 22, 2, 10588, 0, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1CB'),
(10599, 22, 22, 2, 10588, 1, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1CC'),
(10600, 22, 22, 2, 10599, 0, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1CC1'),
(10601, 22, 22, 2, 10588, 0, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1CА'),
(10602, 22, 22, 2, 10289, 0, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1D'),
(10603, 22, 22, 2, 10289, 1, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1E'),
(10604, 22, 22, 2, 10603, 0, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1E1'),
(10605, 22, 22, 2, 10603, 0, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1E2'),
(10606, 22, 22, 2, 10603, 0, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1E3'),
(10607, 22, 22, 2, 10603, 0, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1E4'),
(10608, 22, 22, 2, 10603, 0, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1E5'),
(10609, 22, 22, 2, 10603, 0, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1E6'),
(10610, 22, 22, 2, 10603, 0, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1E7'),
(10611, 22, 22, 2, 10289, 0, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1F'),
(10612, 22, 22, 2, 10289, 1, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1G'),
(10613, 22, 22, 2, 10612, 1, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1G1'),
(10614, 22, 22, 2, 10613, 0, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '1G11'),
(10615, 22, 22, 2, 0, 1, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '2'),
(10616, 22, 22, 2, 10615, 1, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '21'),
(10617, 22, 22, 2, 10616, 0, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '211'),
(10618, 22, 22, 2, 10616, 0, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '212'),
(10619, 22, 22, 2, 10616, 0, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '213'),
(10620, 22, 22, 2, 10616, 0, 0, '2016-07-25 19:05:12', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '214'),
(10621, 22, 22, 2, 10616, 0, 0, '2016-07-25 19:05:13', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '215'),
(10622, 22, 22, 2, 10615, 1, 0, '2016-07-25 19:05:13', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '22'),
(10623, 22, 22, 2, 10622, 0, 0, '2016-07-25 19:05:13', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '221'),
(10624, 22, 22, 2, 10622, 0, 0, '2016-07-25 19:05:13', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '222'),
(10625, 22, 22, 2, 10622, 0, 0, '2016-07-25 19:05:13', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '223'),
(10626, 22, 22, 2, 10622, 0, 0, '2016-07-25 19:05:13', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '224'),
(10627, 22, 22, 2, 10615, 1, 0, '2016-07-25 19:05:13', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '23'),
(10628, 22, 22, 2, 10627, 0, 0, '2016-07-25 19:05:13', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '231'),
(10629, 22, 22, 2, 10627, 0, 0, '2016-07-25 19:05:13', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '232'),
(10630, 22, 22, 2, 10615, 1, 0, '2016-07-25 19:05:13', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '24'),
(10631, 22, 22, 2, 10630, 0, 0, '2016-07-25 19:05:13', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '241'),
(10632, 22, 22, 2, 10630, 0, 0, '2016-07-25 19:05:13', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '242'),
(10633, 22, 22, 2, 10630, 0, 0, '2016-07-25 19:05:13', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '243'),
(10634, 22, 22, 2, 10615, 1, 0, '2016-07-25 19:05:13', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '25'),
(10635, 22, 22, 2, 10634, 0, 0, '2016-07-25 19:05:13', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '251'),
(10636, 22, 22, 2, 10634, 0, 0, '2016-07-25 19:05:13', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '252'),
(10637, 22, 22, 2, 10634, 0, 0, '2016-07-25 19:05:13', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '253'),
(10638, 22, 22, 2, 10634, 0, 0, '2016-07-25 19:05:14', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '254'),
(10639, 22, 22, 2, 10615, 1, 0, '2016-07-25 19:05:14', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '26'),
(10640, 22, 22, 2, 10639, 0, 0, '2016-07-25 19:05:14', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '261'),
(10641, 22, 22, 2, 10639, 0, 0, '2016-07-25 19:05:14', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '262'),
(10642, 22, 22, 2, 10639, 0, 0, '2016-07-25 19:05:14', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '263'),
(10643, 22, 22, 2, 10615, 1, 0, '2016-07-25 19:05:14', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '27'),
(10644, 22, 22, 2, 10643, 0, 0, '2016-07-25 19:05:14', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '271'),
(10645, 22, 22, 2, 10643, 0, 0, '2016-07-25 19:05:14', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '272'),
(10646, 22, 22, 2, 10643, 0, 0, '2016-07-25 19:05:14', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '273'),
(10647, 22, 22, 2, 10615, 0, 0, '2016-07-25 19:05:14', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '28'),
(10648, 22, 22, 2, 10615, 0, 0, '2016-07-25 19:05:14', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '29'),
(10649, 22, 22, 2, 10615, 0, 0, '2016-07-25 19:05:14', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '2A'),
(10650, 22, 22, 2, 10615, 0, 0, '2016-07-25 19:05:14', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '2B'),
(10651, 22, 22, 2, 10615, 0, 0, '2016-07-25 19:05:14', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '2C');
INSERT INTO `e_content` (`id`, `types_id`, `subtypes_id`, `owner_id`, `parent_id`, `isfolder`, `position`, `created`, `updated`, `published`, `settings`, `status`, `sku`, `currency_id`, `unit_id`, `has_variants`, `in_stock`, `external_id`) VALUES
(10652, 22, 22, 2, 10615, 0, 0, '2016-07-25 19:05:14', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '2D'),
(10653, 22, 22, 2, 10615, 0, 0, '2016-07-25 19:05:14', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '2E'),
(10654, 22, 22, 2, 10615, 0, 0, '2016-07-25 19:05:14', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '2F'),
(10655, 22, 22, 2, 10615, 1, 0, '2016-07-25 19:05:14', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '2I'),
(10656, 22, 22, 2, 10655, 0, 0, '2016-07-25 19:05:14', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '2I1'),
(10657, 22, 22, 2, 10655, 0, 0, '2016-07-25 19:05:14', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '2I2'),
(10658, 22, 22, 2, 10655, 0, 0, '2016-07-25 19:05:14', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '2I3'),
(10659, 22, 22, 2, 0, 1, 0, '2016-07-25 19:05:14', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '3'),
(10660, 22, 22, 2, 10659, 1, 0, '2016-07-25 19:05:15', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '31'),
(10661, 22, 22, 2, 10660, 0, 0, '2016-07-25 19:05:15', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '311'),
(10662, 22, 22, 2, 10660, 0, 0, '2016-07-25 19:05:15', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '312'),
(10663, 22, 22, 2, 10660, 0, 0, '2016-07-25 19:05:15', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '313'),
(10664, 22, 22, 2, 10659, 1, 0, '2016-07-25 19:05:15', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '32'),
(10665, 22, 22, 2, 10664, 0, 0, '2016-07-25 19:05:15', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '321'),
(10666, 22, 22, 2, 10664, 0, 0, '2016-07-25 19:05:15', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '322'),
(10667, 22, 22, 2, 10664, 0, 0, '2016-07-25 19:05:15', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '323'),
(10668, 22, 22, 2, 10659, 1, 0, '2016-07-25 19:05:15', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '33'),
(10669, 22, 22, 2, 10668, 0, 0, '2016-07-25 19:05:15', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '331'),
(10670, 22, 22, 2, 10659, 1, 0, '2016-07-25 19:05:15', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '34'),
(10671, 22, 22, 2, 10670, 0, 0, '2016-07-25 19:05:15', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '341'),
(10672, 22, 22, 2, 10670, 0, 0, '2016-07-25 19:05:15', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '342'),
(10673, 22, 22, 2, 10659, 1, 0, '2016-07-25 19:05:15', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '35'),
(10674, 22, 22, 2, 10673, 0, 0, '2016-07-25 19:05:15', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '351'),
(10675, 22, 22, 2, 10673, 0, 0, '2016-07-25 19:05:15', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '352'),
(10676, 22, 22, 2, 10659, 0, 0, '2016-07-25 19:05:15', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '36'),
(10677, 22, 22, 2, 10659, 1, 0, '2016-07-25 19:05:15', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '37'),
(10678, 22, 22, 2, 10677, 0, 0, '2016-07-25 19:05:15', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '371'),
(10679, 22, 22, 2, 10659, 0, 0, '2016-07-25 19:05:15', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '3A'),
(10680, 22, 22, 2, 10659, 0, 0, '2016-07-25 19:05:15', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '3B'),
(10681, 22, 22, 2, 0, 1, 0, '2016-07-25 19:05:15', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4'),
(10682, 22, 22, 2, 10681, 1, 0, '2016-07-25 19:05:15', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41'),
(10683, 22, 22, 2, 10682, 1, 0, '2016-07-25 19:05:15', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '411'),
(10684, 22, 22, 2, 10683, 0, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4111'),
(10685, 22, 22, 2, 10683, 0, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4112'),
(10686, 22, 22, 2, 10682, 1, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '412'),
(10687, 22, 22, 2, 10686, 0, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4121'),
(10688, 22, 22, 2, 10686, 0, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4122'),
(10689, 22, 22, 2, 10686, 0, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4123'),
(10690, 22, 22, 2, 10686, 0, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4124'),
(10691, 22, 22, 2, 10686, 0, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4125'),
(10692, 22, 22, 2, 10686, 0, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4126'),
(10693, 22, 22, 2, 10686, 1, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4127'),
(10694, 22, 22, 2, 10693, 0, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41271'),
(10695, 22, 22, 2, 10693, 0, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41272'),
(10696, 22, 22, 2, 10693, 0, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41273'),
(10697, 22, 22, 2, 10693, 0, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41274'),
(10698, 22, 22, 2, 10682, 1, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '413'),
(10699, 22, 22, 2, 10698, 0, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4131'),
(10700, 22, 22, 2, 10698, 0, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4132'),
(10701, 22, 22, 2, 10698, 0, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4133'),
(10702, 22, 22, 2, 10698, 0, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4134'),
(10703, 22, 22, 2, 10698, 0, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4135'),
(10704, 22, 22, 2, 10698, 1, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4136'),
(10705, 22, 22, 2, 10704, 0, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41361'),
(10706, 22, 22, 2, 10704, 0, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41362'),
(10707, 22, 22, 2, 10704, 0, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41363'),
(10708, 22, 22, 2, 10682, 1, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '414'),
(10709, 22, 22, 2, 10708, 0, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4141'),
(10710, 22, 22, 2, 10708, 0, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4142'),
(10711, 22, 22, 2, 10708, 0, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4143'),
(10712, 22, 22, 2, 10708, 0, 0, '2016-07-25 19:05:16', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4144'),
(10713, 22, 22, 2, 10708, 0, 0, '2016-07-25 19:05:17', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4145'),
(10714, 22, 22, 2, 10708, 1, 0, '2016-07-25 19:05:17', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4146'),
(10715, 22, 22, 2, 10714, 0, 0, '2016-07-25 19:05:17', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41461'),
(10716, 22, 22, 2, 10682, 1, 0, '2016-07-25 19:05:17', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '415'),
(10717, 22, 22, 2, 10716, 0, 0, '2016-07-25 19:05:17', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4151'),
(10718, 22, 22, 2, 10716, 0, 0, '2016-07-25 19:05:17', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4152'),
(10719, 22, 22, 2, 10716, 0, 0, '2016-07-25 19:05:17', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4153'),
(10720, 22, 22, 2, 10716, 0, 0, '2016-07-25 19:05:17', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4154'),
(10721, 22, 22, 2, 10716, 0, 0, '2016-07-25 19:05:17', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4155'),
(10722, 22, 22, 2, 10716, 1, 0, '2016-07-25 19:05:17', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4156'),
(10723, 22, 22, 2, 10722, 0, 0, '2016-07-25 19:05:17', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41561'),
(10724, 22, 22, 2, 10722, 0, 0, '2016-07-25 19:05:17', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41562'),
(10725, 22, 22, 2, 10722, 0, 0, '2016-07-25 19:05:17', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41563'),
(10726, 22, 22, 2, 10722, 0, 0, '2016-07-25 19:05:17', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41564'),
(10727, 22, 22, 2, 10682, 1, 0, '2016-07-25 19:05:17', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '416'),
(10728, 22, 22, 2, 10727, 0, 0, '2016-07-25 19:05:17', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4161'),
(10729, 22, 22, 2, 10727, 0, 0, '2016-07-25 19:05:17', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4162'),
(10730, 22, 22, 2, 10682, 1, 0, '2016-07-25 19:05:17', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '417'),
(10731, 22, 22, 2, 10730, 0, 0, '2016-07-25 19:05:17', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4171'),
(10732, 22, 22, 2, 10730, 0, 0, '2016-07-25 19:05:17', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4172'),
(10733, 22, 22, 2, 10730, 0, 0, '2016-07-25 19:05:17', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4173'),
(10734, 22, 22, 2, 10682, 0, 0, '2016-07-25 19:05:17', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '418'),
(10735, 22, 22, 2, 10682, 0, 0, '2016-07-25 19:05:17', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '419'),
(10736, 22, 22, 2, 10682, 1, 0, '2016-07-25 19:05:17', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41A'),
(10737, 22, 22, 2, 10736, 0, 0, '2016-07-25 19:05:17', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41A1'),
(10738, 22, 22, 2, 10736, 0, 0, '2016-07-25 19:05:18', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41A2'),
(10739, 22, 22, 2, 10736, 1, 0, '2016-07-25 19:05:18', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41A3'),
(10740, 22, 22, 2, 10739, 0, 0, '2016-07-25 19:05:18', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41A31'),
(10741, 22, 22, 2, 10739, 0, 0, '2016-07-25 19:05:18', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41A32'),
(10742, 22, 22, 2, 10682, 1, 0, '2016-07-25 19:05:18', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41B'),
(10743, 22, 22, 2, 10742, 0, 0, '2016-07-25 19:05:18', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41B1'),
(10744, 22, 22, 2, 10682, 1, 0, '2016-07-25 19:05:18', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41C'),
(10745, 22, 22, 2, 10744, 0, 0, '2016-07-25 19:05:18', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41C1'),
(10746, 22, 22, 2, 10682, 0, 0, '2016-07-25 19:05:18', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41D'),
(10747, 22, 22, 2, 10682, 0, 0, '2016-07-25 19:05:18', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41E'),
(10748, 22, 22, 2, 10682, 1, 0, '2016-07-25 19:05:18', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41F'),
(10749, 22, 22, 2, 10748, 0, 0, '2016-07-25 19:05:18', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41F1'),
(10750, 22, 22, 2, 10748, 0, 0, '2016-07-25 19:05:18', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41F2'),
(10751, 22, 22, 2, 10748, 0, 0, '2016-07-25 19:05:18', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41F3'),
(10752, 22, 22, 2, 10748, 0, 0, '2016-07-25 19:05:18', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41F4'),
(10753, 22, 22, 2, 10748, 0, 0, '2016-07-25 19:05:19', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41F5'),
(10754, 22, 22, 2, 10682, 1, 0, '2016-07-25 19:05:19', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41G'),
(10755, 22, 22, 2, 10754, 0, 0, '2016-07-25 19:05:19', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41G1'),
(10756, 22, 22, 2, 10754, 0, 0, '2016-07-25 19:05:19', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41G2'),
(10757, 22, 22, 2, 10754, 0, 0, '2016-07-25 19:05:19', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41G3'),
(10758, 22, 22, 2, 10754, 1, 0, '2016-07-25 19:05:19', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41G4'),
(10759, 22, 22, 2, 10758, 0, 0, '2016-07-25 19:05:19', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41G41'),
(10760, 22, 22, 2, 10682, 1, 0, '2016-07-25 19:05:19', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41H'),
(10761, 22, 22, 2, 10760, 0, 0, '2016-07-25 19:05:19', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41H1'),
(10762, 22, 22, 2, 10682, 1, 0, '2016-07-25 19:05:19', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41I'),
(10763, 22, 22, 2, 10762, 0, 0, '2016-07-25 19:05:19', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41I1'),
(10764, 22, 22, 2, 10682, 1, 0, '2016-07-25 19:05:19', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41J'),
(10765, 22, 22, 2, 10764, 0, 0, '2016-07-25 19:05:19', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41J1'),
(10766, 22, 22, 2, 10764, 0, 0, '2016-07-25 19:05:19', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41J2'),
(10767, 22, 22, 2, 10764, 1, 0, '2016-07-25 19:05:19', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41J3'),
(10768, 22, 22, 2, 10767, 0, 0, '2016-07-25 19:05:19', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41J31'),
(10769, 22, 22, 2, 10682, 1, 0, '2016-07-25 19:05:19', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41K'),
(10770, 22, 22, 2, 10769, 0, 0, '2016-07-25 19:05:19', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41K1'),
(10771, 22, 22, 2, 10769, 0, 0, '2016-07-25 19:05:19', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41K2'),
(10772, 22, 22, 2, 10769, 0, 0, '2016-07-25 19:05:19', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41K3'),
(10773, 22, 22, 2, 10769, 0, 0, '2016-07-25 19:05:19', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41K4'),
(10774, 22, 22, 2, 10769, 0, 0, '2016-07-25 19:05:19', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '41K5'),
(10775, 22, 22, 2, 10681, 1, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '42'),
(10776, 22, 22, 2, 10775, 0, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '421'),
(10777, 22, 22, 2, 10775, 0, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '422'),
(10778, 22, 22, 2, 10775, 0, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '423'),
(10779, 22, 22, 2, 10775, 0, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '424'),
(10780, 22, 22, 2, 10775, 0, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '425'),
(10781, 22, 22, 2, 10681, 1, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '43'),
(10782, 22, 22, 2, 10781, 0, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '431'),
(10783, 22, 22, 2, 10781, 0, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '432'),
(10784, 22, 22, 2, 10781, 0, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '433'),
(10785, 22, 22, 2, 10781, 0, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '434'),
(10786, 22, 22, 2, 10781, 0, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '435'),
(10787, 22, 22, 2, 10781, 0, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '436'),
(10788, 22, 22, 2, 10781, 0, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '437'),
(10789, 22, 22, 2, 10781, 0, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '438'),
(10790, 22, 22, 2, 10781, 0, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '439'),
(10791, 22, 22, 2, 10781, 0, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '43B'),
(10792, 22, 22, 2, 10781, 0, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '43C'),
(10793, 22, 22, 2, 10781, 0, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '43А'),
(10794, 22, 22, 2, 10681, 1, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44'),
(10795, 22, 22, 2, 10794, 1, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '441'),
(10796, 22, 22, 2, 10795, 1, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4411'),
(10797, 22, 22, 2, 10796, 0, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44111'),
(10798, 22, 22, 2, 10796, 0, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44112'),
(10799, 22, 22, 2, 10796, 0, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44113'),
(10800, 22, 22, 2, 10796, 0, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44114'),
(10801, 22, 22, 2, 10796, 0, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44115'),
(10802, 22, 22, 2, 10796, 0, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44116'),
(10803, 22, 22, 2, 10795, 1, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4412'),
(10804, 22, 22, 2, 10803, 0, 0, '2016-07-25 19:05:20', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44121'),
(10805, 22, 22, 2, 10803, 0, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44122'),
(10806, 22, 22, 2, 10794, 1, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '442'),
(10807, 22, 22, 2, 10806, 1, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4421'),
(10808, 22, 22, 2, 10807, 0, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44211'),
(10809, 22, 22, 2, 10807, 0, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44212'),
(10810, 22, 22, 2, 10794, 1, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '443'),
(10811, 22, 22, 2, 10810, 1, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4431'),
(10812, 22, 22, 2, 10811, 0, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44311'),
(10813, 22, 22, 2, 10794, 1, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '444'),
(10814, 22, 22, 2, 10813, 1, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4441'),
(10815, 22, 22, 2, 10814, 0, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44411'),
(10816, 22, 22, 2, 10794, 1, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '445'),
(10817, 22, 22, 2, 10816, 1, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4451'),
(10818, 22, 22, 2, 10817, 0, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44511'),
(10819, 22, 22, 2, 10794, 1, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '446'),
(10820, 22, 22, 2, 10819, 1, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4461'),
(10821, 22, 22, 2, 10820, 0, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44612'),
(10822, 22, 22, 2, 10819, 1, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4462'),
(10823, 22, 22, 2, 10822, 0, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44621'),
(10824, 22, 22, 2, 10794, 1, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '447'),
(10825, 22, 22, 2, 10824, 1, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4471'),
(10826, 22, 22, 2, 10825, 0, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44711'),
(10827, 22, 22, 2, 10825, 0, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44712'),
(10828, 22, 22, 2, 10794, 1, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '448'),
(10829, 22, 22, 2, 10828, 1, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4481'),
(10830, 22, 22, 2, 10829, 0, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44811'),
(10831, 22, 22, 2, 10828, 1, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4482'),
(10832, 22, 22, 2, 10831, 0, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44821'),
(10833, 22, 22, 2, 10794, 1, 0, '2016-07-25 19:05:21', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '449'),
(10834, 22, 22, 2, 10833, 1, 0, '2016-07-25 19:05:22', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '4491'),
(10835, 22, 22, 2, 10834, 0, 0, '2016-07-25 19:05:22', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44911'),
(10836, 22, 22, 2, 10834, 0, 0, '2016-07-25 19:05:22', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44912'),
(10837, 22, 22, 2, 10794, 1, 0, '2016-07-25 19:05:22', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44A'),
(10838, 22, 22, 2, 10837, 1, 0, '2016-07-25 19:05:22', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44A1'),
(10839, 22, 22, 2, 10838, 0, 0, '2016-07-25 19:05:22', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44A11'),
(10840, 22, 22, 2, 10838, 0, 0, '2016-07-25 19:05:22', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44A12'),
(10841, 22, 22, 2, 10794, 1, 0, '2016-07-25 19:05:22', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44B'),
(10842, 22, 22, 2, 10841, 1, 0, '2016-07-25 19:05:22', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44B1'),
(10843, 22, 22, 2, 10842, 0, 0, '2016-07-25 19:05:22', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44B11'),
(10844, 22, 22, 2, 10794, 1, 0, '2016-07-25 19:05:22', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44C'),
(10845, 22, 22, 2, 10844, 1, 0, '2016-07-25 19:05:22', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44C1'),
(10846, 22, 22, 2, 10845, 0, 0, '2016-07-25 19:05:22', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44C11'),
(10847, 22, 22, 2, 10794, 1, 0, '2016-07-25 19:05:22', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44D'),
(10848, 22, 22, 2, 10847, 0, 0, '2016-07-25 19:05:22', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44D1'),
(10849, 22, 22, 2, 10847, 0, 0, '2016-07-25 19:05:22', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '44D2'),
(10850, 22, 22, 2, 0, 1, 0, '2016-07-25 19:05:22', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5'),
(10851, 22, 22, 2, 10850, 1, 0, '2016-07-25 19:05:22', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51'),
(10852, 22, 22, 2, 10851, 1, 0, '2016-07-25 19:05:22', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '511'),
(10853, 22, 22, 2, 10852, 1, 0, '2016-07-25 19:05:22', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5111'),
(10854, 22, 22, 2, 10853, 0, 0, '2016-07-25 19:05:22', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51111'),
(10855, 22, 22, 2, 10853, 0, 0, '2016-07-25 19:05:22', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51112'),
(10856, 22, 22, 2, 10853, 0, 0, '2016-07-25 19:05:22', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51113'),
(10857, 22, 22, 2, 10852, 0, 0, '2016-07-25 19:05:22', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5112'),
(10858, 22, 22, 2, 10852, 0, 0, '2016-07-25 19:05:22', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5113'),
(10859, 22, 22, 2, 10852, 0, 0, '2016-07-25 19:05:23', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5114'),
(10860, 22, 22, 2, 10851, 1, 0, '2016-07-25 19:05:23', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '512'),
(10861, 22, 22, 2, 10860, 1, 0, '2016-07-25 19:05:23', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5121'),
(10862, 22, 22, 2, 10861, 0, 0, '2016-07-25 19:05:23', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51211'),
(10863, 22, 22, 2, 10861, 0, 0, '2016-07-25 19:05:23', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51212'),
(10864, 22, 22, 2, 10861, 0, 0, '2016-07-25 19:05:23', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51213'),
(10865, 22, 22, 2, 10860, 0, 0, '2016-07-25 19:05:23', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5122'),
(10866, 22, 22, 2, 10860, 0, 0, '2016-07-25 19:05:23', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5123'),
(10867, 22, 22, 2, 10860, 0, 0, '2016-07-25 19:05:23', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5124'),
(10868, 22, 22, 2, 10851, 0, 0, '2016-07-25 19:05:23', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '513'),
(10869, 22, 22, 2, 10851, 1, 0, '2016-07-25 19:05:23', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '514'),
(10870, 22, 22, 2, 10869, 0, 0, '2016-07-25 19:05:23', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5141'),
(10871, 22, 22, 2, 10869, 0, 0, '2016-07-25 19:05:23', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5142'),
(10872, 22, 22, 2, 10851, 1, 0, '2016-07-25 19:05:23', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '515'),
(10873, 22, 22, 2, 10872, 1, 0, '2016-07-25 19:05:23', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5151'),
(10874, 22, 22, 2, 10873, 0, 0, '2016-07-25 19:05:23', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51511'),
(10875, 22, 22, 2, 10873, 0, 0, '2016-07-25 19:05:23', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51512'),
(10876, 22, 22, 2, 10873, 0, 0, '2016-07-25 19:05:23', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51513'),
(10877, 22, 22, 2, 10872, 0, 0, '2016-07-25 19:05:23', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5152'),
(10878, 22, 22, 2, 10872, 0, 0, '2016-07-25 19:05:23', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5153'),
(10879, 22, 22, 2, 10851, 1, 0, '2016-07-25 19:05:23', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '516'),
(10880, 22, 22, 2, 10879, 1, 0, '2016-07-25 19:05:23', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5161'),
(10881, 22, 22, 2, 10880, 0, 0, '2016-07-25 19:05:23', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51611'),
(10882, 22, 22, 2, 10880, 0, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51612'),
(10883, 22, 22, 2, 10880, 0, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51613'),
(10884, 22, 22, 2, 10879, 0, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5162'),
(10885, 22, 22, 2, 10879, 0, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5163'),
(10886, 22, 22, 2, 10879, 0, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5164'),
(10887, 22, 22, 2, 10851, 1, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '517'),
(10888, 22, 22, 2, 10887, 1, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5171'),
(10889, 22, 22, 2, 10888, 0, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51711'),
(10890, 22, 22, 2, 10888, 0, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51712'),
(10891, 22, 22, 2, 10888, 0, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51713'),
(10892, 22, 22, 2, 10887, 0, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5172'),
(10893, 22, 22, 2, 10887, 0, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5173'),
(10894, 22, 22, 2, 10851, 1, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '518'),
(10895, 22, 22, 2, 10894, 1, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5181'),
(10896, 22, 22, 2, 10895, 0, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51811'),
(10897, 22, 22, 2, 10895, 0, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51812'),
(10898, 22, 22, 2, 10895, 0, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51813'),
(10899, 22, 22, 2, 10894, 0, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5182'),
(10900, 22, 22, 2, 10894, 0, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5183'),
(10901, 22, 22, 2, 10894, 0, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5184'),
(10902, 22, 22, 2, 10851, 1, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51A'),
(10903, 22, 22, 2, 10902, 0, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51A1'),
(10904, 22, 22, 2, 10902, 0, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51A2'),
(10905, 22, 22, 2, 10851, 1, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51B'),
(10906, 22, 22, 2, 10905, 0, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51B1'),
(10907, 22, 22, 2, 10905, 0, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51B2'),
(10908, 22, 22, 2, 10851, 1, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51C'),
(10909, 22, 22, 2, 10908, 0, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51C1'),
(10910, 22, 22, 2, 10908, 0, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51C2'),
(10911, 22, 22, 2, 10908, 0, 0, '2016-07-25 19:05:24', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51C3'),
(10912, 22, 22, 2, 10851, 0, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51E'),
(10913, 22, 22, 2, 10851, 0, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51F'),
(10914, 22, 22, 2, 10851, 0, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51G'),
(10915, 22, 22, 2, 10851, 0, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51H'),
(10916, 22, 22, 2, 10851, 0, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51I'),
(10917, 22, 22, 2, 10851, 0, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51J'),
(10918, 22, 22, 2, 10851, 0, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51K'),
(10919, 22, 22, 2, 10851, 1, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51N'),
(10920, 22, 22, 2, 10919, 0, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51N1'),
(10921, 22, 22, 2, 10851, 0, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51O'),
(10922, 22, 22, 2, 10851, 1, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51P'),
(10923, 22, 22, 2, 10922, 0, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51P1'),
(10924, 22, 22, 2, 10851, 0, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '51R'),
(10925, 22, 22, 2, 10850, 1, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '52'),
(10926, 22, 22, 2, 10925, 1, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '521'),
(10927, 22, 22, 2, 10926, 0, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5211'),
(10928, 22, 22, 2, 10926, 0, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5212'),
(10929, 22, 22, 2, 10926, 0, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5213'),
(10930, 22, 22, 2, 10925, 1, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '522'),
(10931, 22, 22, 2, 10930, 0, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5221'),
(10932, 22, 22, 2, 10930, 0, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5222'),
(10933, 22, 22, 2, 10930, 0, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5223'),
(10934, 22, 22, 2, 10925, 0, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '523'),
(10935, 22, 22, 2, 10925, 1, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '524'),
(10936, 22, 22, 2, 10935, 0, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5242'),
(10937, 22, 22, 2, 10925, 1, 0, '2016-07-25 19:05:25', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '525'),
(10938, 22, 22, 2, 10937, 0, 0, '2016-07-25 19:05:26', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5251'),
(10939, 22, 22, 2, 10937, 0, 0, '2016-07-25 19:05:26', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5252'),
(10940, 22, 22, 2, 10925, 1, 0, '2016-07-25 19:05:26', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '526'),
(10941, 22, 22, 2, 10940, 0, 0, '2016-07-25 19:05:26', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5261'),
(10942, 22, 22, 2, 10940, 0, 0, '2016-07-25 19:05:26', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5262'),
(10943, 22, 22, 2, 10925, 1, 0, '2016-07-25 19:05:26', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '527'),
(10944, 22, 22, 2, 10943, 0, 0, '2016-07-25 19:05:26', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5271'),
(10945, 22, 22, 2, 10943, 0, 0, '2016-07-25 19:05:26', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5272'),
(10946, 22, 22, 2, 10925, 1, 0, '2016-07-25 19:05:26', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '528'),
(10947, 22, 22, 2, 10946, 0, 0, '2016-07-25 19:05:26', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5281'),
(10948, 22, 22, 2, 10946, 0, 0, '2016-07-25 19:05:26', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '5282'),
(10949, 22, 22, 2, 10925, 0, 0, '2016-07-25 19:05:26', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '529'),
(10950, 22, 22, 2, 10925, 0, 0, '2016-07-25 19:05:26', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '52A'),
(10951, 22, 22, 2, 10925, 0, 0, '2016-07-25 19:05:26', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '52B'),
(10952, 22, 22, 2, 10925, 0, 0, '2016-07-25 19:05:26', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '52C'),
(10953, 22, 22, 2, 10925, 0, 0, '2016-07-25 19:05:26', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '52D'),
(10954, 22, 22, 2, 10925, 1, 0, '2016-07-25 19:05:26', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '52E'),
(10955, 22, 22, 2, 10954, 0, 0, '2016-07-25 19:05:26', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '52E1'),
(10956, 22, 22, 2, 10925, 1, 0, '2016-07-25 19:05:26', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '52F'),
(10957, 22, 22, 2, 10956, 0, 0, '2016-07-25 19:05:26', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '52F1'),
(10958, 22, 22, 2, 10850, 0, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '53'),
(10959, 22, 22, 2, 10850, 0, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '54'),
(10960, 22, 22, 2, 10850, 1, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '55'),
(10961, 22, 22, 2, 10960, 0, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '551'),
(10962, 22, 22, 2, 10960, 0, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '552'),
(10963, 22, 22, 2, 10960, 0, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '553'),
(10964, 22, 22, 2, 10960, 0, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '554'),
(10965, 22, 22, 2, 10960, 0, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '555'),
(10966, 22, 22, 2, 10960, 0, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '556'),
(10967, 22, 22, 2, 10960, 0, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '557'),
(10968, 22, 22, 2, 10960, 0, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '558'),
(10969, 22, 22, 2, 10960, 0, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '559'),
(10970, 22, 22, 2, 10960, 0, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '55A'),
(10971, 22, 22, 2, 10850, 1, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '56'),
(10972, 22, 22, 2, 10971, 0, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '561'),
(10973, 22, 22, 2, 10971, 0, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '562'),
(10974, 22, 22, 2, 10971, 0, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '563'),
(10975, 22, 22, 2, 10971, 0, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '564'),
(10976, 22, 22, 2, 10850, 0, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '57'),
(10977, 22, 22, 2, 0, 1, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6'),
(10978, 22, 22, 2, 10977, 1, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '61'),
(10979, 22, 22, 2, 10978, 1, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '611'),
(10980, 22, 22, 2, 10979, 0, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6111'),
(10981, 22, 22, 2, 10979, 0, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6112'),
(10982, 22, 22, 2, 10979, 0, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6113'),
(10983, 22, 22, 2, 10979, 0, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6114'),
(10984, 22, 22, 2, 10979, 0, 0, '2016-07-25 19:05:27', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6115'),
(10985, 22, 22, 2, 10979, 0, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6116'),
(10986, 22, 22, 2, 10979, 0, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6117'),
(10987, 22, 22, 2, 10979, 0, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6118'),
(10988, 22, 22, 2, 10979, 0, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6119'),
(10989, 22, 22, 2, 10979, 0, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '611A'),
(10990, 22, 22, 2, 10979, 0, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '611B'),
(10991, 22, 22, 2, 10979, 0, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '611C'),
(10992, 22, 22, 2, 10979, 0, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '611D'),
(10993, 22, 22, 2, 10979, 0, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '611E'),
(10994, 22, 22, 2, 10979, 0, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '611F'),
(10995, 22, 22, 2, 10979, 0, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '611G'),
(10996, 22, 22, 2, 10979, 0, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '611H'),
(10997, 22, 22, 2, 10979, 0, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '611I'),
(10998, 22, 22, 2, 10979, 0, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '611S'),
(10999, 22, 22, 2, 10978, 1, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '612'),
(11000, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6121'),
(11001, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6122'),
(11002, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6123'),
(11003, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6124'),
(11004, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6125'),
(11005, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6126'),
(11006, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6127'),
(11007, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6128'),
(11008, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6129'),
(11009, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '612A'),
(11010, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:28', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '612B'),
(11011, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:29', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '612C'),
(11012, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:29', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '612D'),
(11013, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:29', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '612E'),
(11014, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:29', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '612F'),
(11015, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:29', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '612G'),
(11016, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:29', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '612I'),
(11017, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:29', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '612J'),
(11018, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:29', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '612K'),
(11019, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:29', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '612L'),
(11020, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:29', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '612M'),
(11021, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:29', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '612N'),
(11022, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:29', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '612O'),
(11023, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:29', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '612P'),
(11024, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:29', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '612Q'),
(11025, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:29', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '612R'),
(11026, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:29', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '612S'),
(11027, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:29', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '612T'),
(11028, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:29', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '612V'),
(11029, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:29', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '612W'),
(11030, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:29', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '612X'),
(11031, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:29', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '612Y'),
(11032, 22, 22, 2, 10999, 0, 0, '2016-07-25 19:05:29', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '612Z'),
(11033, 22, 22, 2, 10978, 0, 0, '2016-07-25 19:05:29', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '613'),
(11034, 22, 22, 2, 10978, 0, 0, '2016-07-25 19:05:30', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '614'),
(11035, 22, 22, 2, 10978, 0, 0, '2016-07-25 19:05:30', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '615'),
(11036, 22, 22, 2, 10978, 0, 0, '2016-07-25 19:05:30', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '616'),
(11037, 22, 22, 2, 10978, 1, 0, '2016-07-25 19:05:30', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '617'),
(11038, 22, 22, 2, 11037, 0, 0, '2016-07-25 19:05:30', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6171'),
(11039, 22, 22, 2, 11037, 0, 0, '2016-07-25 19:05:30', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6172'),
(11040, 22, 22, 2, 11037, 0, 0, '2016-07-25 19:05:30', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6173'),
(11041, 22, 22, 2, 11037, 0, 0, '2016-07-25 19:05:30', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6174'),
(11042, 22, 22, 2, 11037, 0, 0, '2016-07-25 19:05:30', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6175'),
(11043, 22, 22, 2, 11037, 0, 0, '2016-07-25 19:05:30', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6176'),
(11044, 22, 22, 2, 11037, 0, 0, '2016-07-25 19:05:30', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6177'),
(11045, 22, 22, 2, 11037, 0, 0, '2016-07-25 19:05:30', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6178'),
(11046, 22, 22, 2, 11037, 0, 0, '2016-07-25 19:05:30', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6179'),
(11047, 22, 22, 2, 10977, 1, 0, '2016-07-25 19:05:30', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '62'),
(11048, 22, 22, 2, 11047, 1, 0, '2016-07-25 19:05:30', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '621'),
(11049, 22, 22, 2, 11048, 0, 0, '2016-07-25 19:05:30', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6211'),
(11050, 22, 22, 2, 11048, 0, 0, '2016-07-25 19:05:30', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6212'),
(11051, 22, 22, 2, 11048, 0, 0, '2016-07-25 19:05:30', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6213'),
(11052, 22, 22, 2, 11048, 0, 0, '2016-07-25 19:05:30', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6214'),
(11053, 22, 22, 2, 11048, 0, 0, '2016-07-25 19:05:30', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6215'),
(11054, 22, 22, 2, 11048, 0, 0, '2016-07-25 19:05:30', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6216'),
(11055, 22, 22, 2, 11048, 0, 0, '2016-07-25 19:05:30', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6217'),
(11056, 22, 22, 2, 11048, 0, 0, '2016-07-25 19:05:30', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6218');
INSERT INTO `e_content` (`id`, `types_id`, `subtypes_id`, `owner_id`, `parent_id`, `isfolder`, `position`, `created`, `updated`, `published`, `settings`, `status`, `sku`, `currency_id`, `unit_id`, `has_variants`, `in_stock`, `external_id`) VALUES
(11057, 22, 22, 2, 11048, 0, 0, '2016-07-25 19:05:30', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6219'),
(11058, 22, 22, 2, 11048, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '621A'),
(11059, 22, 22, 2, 11048, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '621B'),
(11060, 22, 22, 2, 11048, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '621C'),
(11061, 22, 22, 2, 11048, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '621D'),
(11062, 22, 22, 2, 11047, 1, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '622'),
(11063, 22, 22, 2, 11062, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6221'),
(11064, 22, 22, 2, 11062, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6222'),
(11065, 22, 22, 2, 11062, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6223'),
(11066, 22, 22, 2, 11062, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6224'),
(11067, 22, 22, 2, 11062, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6225'),
(11068, 22, 22, 2, 11062, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6226'),
(11069, 22, 22, 2, 11062, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6227'),
(11070, 22, 22, 2, 11062, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6228'),
(11071, 22, 22, 2, 11062, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6229'),
(11072, 22, 22, 2, 11062, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '622A'),
(11073, 22, 22, 2, 11062, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '622B'),
(11074, 22, 22, 2, 11062, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '622C'),
(11075, 22, 22, 2, 11062, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '622D'),
(11076, 22, 22, 2, 11062, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '622E'),
(11077, 22, 22, 2, 11062, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '622F'),
(11078, 22, 22, 2, 11062, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '622I'),
(11079, 22, 22, 2, 11062, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '622J'),
(11080, 22, 22, 2, 11062, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '622K'),
(11081, 22, 22, 2, 11062, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '622L'),
(11082, 22, 22, 2, 11062, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '622M'),
(11083, 22, 22, 2, 11062, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '622N'),
(11084, 22, 22, 2, 11062, 0, 0, '2016-07-25 19:05:31', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '622O'),
(11085, 22, 22, 2, 11047, 0, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '623'),
(11086, 22, 22, 2, 11047, 0, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '624'),
(11087, 22, 22, 2, 11047, 0, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '625'),
(11088, 22, 22, 2, 11047, 0, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '626'),
(11089, 22, 22, 2, 10977, 1, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '63'),
(11090, 22, 22, 2, 11089, 1, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '631'),
(11091, 22, 22, 2, 11090, 0, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6311'),
(11092, 22, 22, 2, 11090, 0, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6312'),
(11093, 22, 22, 2, 11090, 0, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6313'),
(11094, 22, 22, 2, 11090, 0, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6314'),
(11095, 22, 22, 2, 11090, 0, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6315'),
(11096, 22, 22, 2, 11090, 0, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6316'),
(11097, 22, 22, 2, 11090, 0, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6317'),
(11098, 22, 22, 2, 11089, 1, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '632'),
(11099, 22, 22, 2, 11098, 0, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6321'),
(11100, 22, 22, 2, 11098, 0, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6322'),
(11101, 22, 22, 2, 11098, 0, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6323'),
(11102, 22, 22, 2, 11098, 0, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6324'),
(11103, 22, 22, 2, 11098, 0, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6325'),
(11104, 22, 22, 2, 11098, 0, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6326'),
(11105, 22, 22, 2, 11098, 0, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6327'),
(11106, 22, 22, 2, 11098, 0, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6328'),
(11107, 22, 22, 2, 11098, 0, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6329'),
(11108, 22, 22, 2, 11098, 0, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '632A'),
(11109, 22, 22, 2, 11089, 0, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '633'),
(11110, 22, 22, 2, 11089, 0, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '634'),
(11111, 22, 22, 2, 11089, 0, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '635'),
(11112, 22, 22, 2, 11089, 0, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '636'),
(11113, 22, 22, 2, 10977, 1, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '64'),
(11114, 22, 22, 2, 11113, 1, 0, '2016-07-25 19:05:32', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '641'),
(11115, 22, 22, 2, 11114, 0, 0, '2016-07-25 19:05:33', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6411'),
(11116, 22, 22, 2, 11114, 0, 0, '2016-07-25 19:05:33', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6412'),
(11117, 22, 22, 2, 11114, 0, 0, '2016-07-25 19:05:33', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6413'),
(11118, 22, 22, 2, 11114, 0, 0, '2016-07-25 19:05:33', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6414'),
(11119, 22, 22, 2, 11114, 0, 0, '2016-07-25 19:05:33', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6415'),
(11120, 22, 22, 2, 11114, 0, 0, '2016-07-25 19:05:33', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6416'),
(11121, 22, 22, 2, 11114, 0, 0, '2016-07-25 19:05:33', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6417'),
(11122, 22, 22, 2, 11114, 0, 0, '2016-07-25 19:05:33', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6418'),
(11123, 22, 22, 2, 11114, 0, 0, '2016-07-25 19:05:33', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6419'),
(11124, 22, 22, 2, 11114, 0, 0, '2016-07-25 19:05:33', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '641A'),
(11125, 22, 22, 2, 11113, 1, 0, '2016-07-25 19:05:33', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '642'),
(11126, 22, 22, 2, 11125, 0, 0, '2016-07-25 19:05:33', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6421'),
(11127, 22, 22, 2, 11125, 0, 0, '2016-07-25 19:05:33', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6422'),
(11128, 22, 22, 2, 11125, 0, 0, '2016-07-25 19:05:33', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6423'),
(11129, 22, 22, 2, 11125, 0, 0, '2016-07-25 19:05:33', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6424'),
(11130, 22, 22, 2, 11125, 0, 0, '2016-07-25 19:05:33', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6425'),
(11131, 22, 22, 2, 11125, 0, 0, '2016-07-25 19:05:33', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6426'),
(11132, 22, 22, 2, 11125, 0, 0, '2016-07-25 19:05:33', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6427'),
(11133, 22, 22, 2, 11125, 0, 0, '2016-07-25 19:05:33', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6428'),
(11134, 22, 22, 2, 11125, 0, 0, '2016-07-25 19:05:33', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6429'),
(11135, 22, 22, 2, 11125, 0, 0, '2016-07-25 19:05:33', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '642A'),
(11136, 22, 22, 2, 11125, 0, 0, '2016-07-25 19:05:33', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '642B'),
(11137, 22, 22, 2, 11125, 0, 0, '2016-07-25 19:05:33', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '642C'),
(11138, 22, 22, 2, 11125, 0, 0, '2016-07-25 19:05:34', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '642S'),
(11139, 22, 22, 2, 11125, 0, 0, '2016-07-25 19:05:34', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '642T'),
(11140, 22, 22, 2, 11125, 0, 0, '2016-07-25 19:05:34', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '642U'),
(11141, 22, 22, 2, 11125, 0, 0, '2016-07-25 19:05:34', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '642V'),
(11142, 22, 22, 2, 11113, 0, 0, '2016-07-25 19:05:34', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '643'),
(11143, 22, 22, 2, 11113, 0, 0, '2016-07-25 19:05:34', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '644'),
(11144, 22, 22, 2, 11113, 0, 0, '2016-07-25 19:05:34', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '645'),
(11145, 22, 22, 2, 11113, 0, 0, '2016-07-25 19:05:34', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '646'),
(11146, 22, 22, 2, 10977, 1, 0, '2016-07-25 19:05:34', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '65'),
(11147, 22, 22, 2, 11146, 1, 0, '2016-07-25 19:05:34', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '651'),
(11148, 22, 22, 2, 11147, 0, 0, '2016-07-25 19:05:34', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6511'),
(11149, 22, 22, 2, 11147, 0, 0, '2016-07-25 19:05:34', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6512'),
(11150, 22, 22, 2, 11147, 0, 0, '2016-07-25 19:05:34', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6513'),
(11151, 22, 22, 2, 11147, 0, 0, '2016-07-25 19:05:34', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6514'),
(11152, 22, 22, 2, 11147, 0, 0, '2016-07-25 19:05:34', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6515'),
(11153, 22, 22, 2, 11147, 0, 0, '2016-07-25 19:05:34', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6516'),
(11154, 22, 22, 2, 11146, 1, 0, '2016-07-25 19:05:34', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '652'),
(11155, 22, 22, 2, 11154, 0, 0, '2016-07-25 19:05:34', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6521'),
(11156, 22, 22, 2, 11154, 0, 0, '2016-07-25 19:05:34', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6522'),
(11157, 22, 22, 2, 11154, 0, 0, '2016-07-25 19:05:34', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6523'),
(11158, 22, 22, 2, 11154, 0, 0, '2016-07-25 19:05:34', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6524'),
(11159, 22, 22, 2, 11154, 0, 0, '2016-07-25 19:05:34', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6525'),
(11160, 22, 22, 2, 11154, 0, 0, '2016-07-25 19:05:34', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6526'),
(11161, 22, 22, 2, 11154, 0, 0, '2016-07-25 19:05:35', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6527'),
(11162, 22, 22, 2, 11154, 0, 0, '2016-07-25 19:05:35', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6528'),
(11163, 22, 22, 2, 11154, 0, 0, '2016-07-25 19:05:35', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6529'),
(11164, 22, 22, 2, 11146, 0, 0, '2016-07-25 19:05:35', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '653'),
(11165, 22, 22, 2, 11146, 0, 0, '2016-07-25 19:05:35', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '654'),
(11166, 22, 22, 2, 11146, 0, 0, '2016-07-25 19:05:35', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '655'),
(11167, 22, 22, 2, 10977, 1, 0, '2016-07-25 19:05:35', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '66'),
(11168, 22, 22, 2, 11167, 1, 0, '2016-07-25 19:05:35', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '661'),
(11169, 22, 22, 2, 11168, 0, 0, '2016-07-25 19:05:35', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6611'),
(11170, 22, 22, 2, 11168, 0, 0, '2016-07-25 19:05:35', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6612'),
(11171, 22, 22, 2, 11168, 0, 0, '2016-07-25 19:05:35', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6613'),
(11172, 22, 22, 2, 11168, 0, 0, '2016-07-25 19:05:35', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6614'),
(11173, 22, 22, 2, 11168, 0, 0, '2016-07-25 19:05:35', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6615'),
(11174, 22, 22, 2, 11168, 0, 0, '2016-07-25 19:05:35', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6616'),
(11175, 22, 22, 2, 11168, 0, 0, '2016-07-25 19:05:35', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6617'),
(11176, 22, 22, 2, 11168, 0, 0, '2016-07-25 19:05:35', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6618'),
(11177, 22, 22, 2, 11168, 0, 0, '2016-07-25 19:05:35', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6619'),
(11178, 22, 22, 2, 11167, 1, 0, '2016-07-25 19:05:35', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '662'),
(11179, 22, 22, 2, 11178, 0, 0, '2016-07-25 19:05:35', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6621'),
(11180, 22, 22, 2, 11178, 0, 0, '2016-07-25 19:05:35', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6622'),
(11181, 22, 22, 2, 11178, 0, 0, '2016-07-25 19:05:35', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6623'),
(11182, 22, 22, 2, 11178, 0, 0, '2016-07-25 19:05:35', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6624'),
(11183, 22, 22, 2, 11178, 0, 0, '2016-07-25 19:05:35', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6625'),
(11184, 22, 22, 2, 11178, 0, 0, '2016-07-25 19:05:35', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6626'),
(11185, 22, 22, 2, 11178, 0, 0, '2016-07-25 19:05:35', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6627'),
(11186, 22, 22, 2, 11167, 0, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '663'),
(11187, 22, 22, 2, 11167, 0, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '664'),
(11188, 22, 22, 2, 11167, 0, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '665'),
(11189, 22, 22, 2, 10977, 1, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '67'),
(11190, 22, 22, 2, 11189, 1, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '671'),
(11191, 22, 22, 2, 11190, 0, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6711'),
(11192, 22, 22, 2, 11190, 0, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6712'),
(11193, 22, 22, 2, 11190, 0, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6713'),
(11194, 22, 22, 2, 11190, 0, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6714'),
(11195, 22, 22, 2, 11189, 1, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '672'),
(11196, 22, 22, 2, 11195, 1, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6721'),
(11197, 22, 22, 2, 11196, 0, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '67211'),
(11198, 22, 22, 2, 11196, 0, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '67212'),
(11199, 22, 22, 2, 11196, 0, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '67213'),
(11200, 22, 22, 2, 11196, 0, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '67214'),
(11201, 22, 22, 2, 11196, 0, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '67215'),
(11202, 22, 22, 2, 11196, 0, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '67216'),
(11203, 22, 22, 2, 11195, 0, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6722'),
(11204, 22, 22, 2, 11195, 0, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6723'),
(11205, 22, 22, 2, 11195, 0, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6724'),
(11206, 22, 22, 2, 11189, 1, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '673'),
(11207, 22, 22, 2, 11206, 0, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6731'),
(11208, 22, 22, 2, 11206, 0, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6732'),
(11209, 22, 22, 2, 11206, 0, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6733'),
(11210, 22, 22, 2, 11206, 0, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6734'),
(11211, 22, 22, 2, 11189, 0, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '674'),
(11212, 22, 22, 2, 11189, 0, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '675'),
(11213, 22, 22, 2, 11189, 0, 0, '2016-07-25 19:05:36', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '676'),
(11214, 22, 22, 2, 11189, 1, 0, '2016-07-25 19:05:37', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '677'),
(11215, 22, 22, 2, 11214, 0, 0, '2016-07-25 19:05:37', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6771'),
(11216, 22, 22, 2, 11214, 0, 0, '2016-07-25 19:05:37', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6772'),
(11217, 22, 22, 2, 10977, 1, 0, '2016-07-25 19:05:37', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '68'),
(11218, 22, 22, 2, 11217, 0, 0, '2016-07-25 19:05:37', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '681'),
(11219, 22, 22, 2, 11217, 1, 0, '2016-07-25 19:05:37', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '682'),
(11220, 22, 22, 2, 11219, 0, 0, '2016-07-25 19:05:37', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6821'),
(11221, 22, 22, 2, 11219, 0, 0, '2016-07-25 19:05:37', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6822'),
(11222, 22, 22, 2, 11219, 0, 0, '2016-07-25 19:05:37', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6823'),
(11223, 22, 22, 2, 11219, 0, 0, '2016-07-25 19:05:37', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6824'),
(11224, 22, 22, 2, 11217, 1, 0, '2016-07-25 19:05:37', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '683'),
(11225, 22, 22, 2, 11224, 0, 0, '2016-07-25 19:05:37', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6831'),
(11226, 22, 22, 2, 11224, 0, 0, '2016-07-25 19:05:37', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6832'),
(11227, 22, 22, 2, 11224, 0, 0, '2016-07-25 19:05:37', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6833'),
(11228, 22, 22, 2, 11224, 0, 0, '2016-07-25 19:05:37', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6834'),
(11229, 22, 22, 2, 11224, 0, 0, '2016-07-25 19:05:37', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6835'),
(11230, 22, 22, 2, 11224, 0, 0, '2016-07-25 19:05:37', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6836'),
(11231, 22, 22, 2, 11224, 0, 0, '2016-07-25 19:05:37', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6837'),
(11232, 22, 22, 2, 11224, 0, 0, '2016-07-25 19:05:37', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6838'),
(11233, 22, 22, 2, 11217, 0, 0, '2016-07-25 19:05:37', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '684'),
(11234, 22, 22, 2, 10977, 1, 0, '2016-07-25 19:05:37', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '69'),
(11235, 22, 22, 2, 11234, 1, 0, '2016-07-25 19:05:38', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '691'),
(11236, 22, 22, 2, 11235, 0, 0, '2016-07-25 19:05:38', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6911'),
(11237, 22, 22, 2, 11235, 0, 0, '2016-07-25 19:05:38', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6912'),
(11238, 22, 22, 2, 11235, 0, 0, '2016-07-25 19:05:38', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6913'),
(11239, 22, 22, 2, 11235, 0, 0, '2016-07-25 19:05:38', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6914'),
(11240, 22, 22, 2, 11235, 0, 0, '2016-07-25 19:05:38', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6915'),
(11241, 22, 22, 2, 11234, 1, 0, '2016-07-25 19:05:38', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '692'),
(11242, 22, 22, 2, 11241, 0, 0, '2016-07-25 19:05:38', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6921'),
(11243, 22, 22, 2, 11241, 0, 0, '2016-07-25 19:05:38', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6922'),
(11244, 22, 22, 2, 11241, 0, 0, '2016-07-25 19:05:38', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6923'),
(11245, 22, 22, 2, 10977, 1, 0, '2016-07-25 19:05:38', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6A'),
(11246, 22, 22, 2, 11245, 1, 0, '2016-07-25 19:05:38', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6A1'),
(11247, 22, 22, 2, 11246, 0, 0, '2016-07-25 19:05:38', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6A11'),
(11248, 22, 22, 2, 11245, 1, 0, '2016-07-25 19:05:38', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6A2'),
(11249, 22, 22, 2, 11248, 0, 0, '2016-07-25 19:05:38', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6A21'),
(11250, 22, 22, 2, 10977, 0, 0, '2016-07-25 19:05:38', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6B'),
(11251, 22, 22, 2, 10977, 0, 0, '2016-07-25 19:05:38', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6C'),
(11252, 22, 22, 2, 10977, 1, 0, '2016-07-25 19:05:38', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6D'),
(11253, 22, 22, 2, 11252, 1, 0, '2016-07-25 19:05:39', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6D1'),
(11254, 22, 22, 2, 11253, 0, 0, '2016-07-25 19:05:39', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6D11'),
(11255, 22, 22, 2, 11253, 0, 0, '2016-07-25 19:05:39', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6D12'),
(11256, 22, 22, 2, 11253, 0, 0, '2016-07-25 19:05:39', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6D13'),
(11257, 22, 22, 2, 11252, 1, 0, '2016-07-25 19:05:39', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6D2'),
(11258, 22, 22, 2, 11257, 0, 0, '2016-07-25 19:05:39', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6D21'),
(11259, 22, 22, 2, 11257, 0, 0, '2016-07-25 19:05:39', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6D22'),
(11260, 22, 22, 2, 11257, 0, 0, '2016-07-25 19:05:39', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6D23'),
(11261, 22, 22, 2, 10977, 1, 0, '2016-07-25 19:05:39', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6E'),
(11262, 22, 22, 2, 11261, 1, 0, '2016-07-25 19:05:39', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6E1'),
(11263, 22, 22, 2, 11262, 0, 0, '2016-07-25 19:05:39', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6E11'),
(11264, 22, 22, 2, 11261, 1, 0, '2016-07-25 19:05:39', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6E2'),
(11265, 22, 22, 2, 11264, 0, 0, '2016-07-25 19:05:39', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6E21'),
(11266, 22, 22, 2, 10977, 1, 0, '2016-07-25 19:05:39', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6F'),
(11267, 22, 22, 2, 11266, 0, 0, '2016-07-25 19:05:39', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6F1'),
(11268, 22, 22, 2, 10977, 1, 0, '2016-07-25 19:05:39', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6G'),
(11269, 22, 22, 2, 11268, 1, 0, '2016-07-25 19:05:39', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6G1'),
(11270, 22, 22, 2, 11269, 0, 0, '2016-07-25 19:05:39', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6G11'),
(11271, 22, 22, 2, 11268, 1, 0, '2016-07-25 19:05:39', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6G2'),
(11272, 22, 22, 2, 11271, 0, 0, '2016-07-25 19:05:39', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6G21'),
(11273, 22, 22, 2, 10977, 1, 0, '2016-07-25 19:05:39', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6H'),
(11274, 22, 22, 2, 11273, 1, 0, '2016-07-25 19:05:39', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6H1'),
(11275, 22, 22, 2, 11274, 0, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6H11'),
(11276, 22, 22, 2, 11274, 0, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6H12'),
(11277, 22, 22, 2, 10977, 1, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6I'),
(11278, 22, 22, 2, 11277, 1, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6I1'),
(11279, 22, 22, 2, 11278, 0, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '6I11'),
(11280, 22, 22, 2, 0, 1, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '7'),
(11281, 22, 22, 2, 11280, 1, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '71'),
(11282, 22, 22, 2, 11281, 0, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '711'),
(11283, 22, 22, 2, 11281, 0, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '712'),
(11284, 22, 22, 2, 11281, 0, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '713'),
(11285, 22, 22, 2, 11281, 0, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '714'),
(11286, 22, 22, 2, 11281, 0, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '715'),
(11287, 22, 22, 2, 11281, 0, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '716'),
(11288, 22, 22, 2, 11281, 0, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '717'),
(11289, 22, 22, 2, 11281, 0, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '718'),
(11290, 22, 22, 2, 11281, 0, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '719'),
(11291, 22, 22, 2, 11281, 0, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '71A'),
(11292, 22, 22, 2, 11280, 1, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '72'),
(11293, 22, 22, 2, 11292, 0, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '721'),
(11294, 22, 22, 2, 11292, 0, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '722'),
(11295, 22, 22, 2, 11292, 0, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '723'),
(11296, 22, 22, 2, 11292, 0, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '724'),
(11297, 22, 22, 2, 11292, 0, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '725'),
(11298, 22, 22, 2, 11292, 0, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '726'),
(11299, 22, 22, 2, 11292, 0, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '727'),
(11300, 22, 22, 2, 11292, 0, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '728'),
(11301, 22, 22, 2, 11292, 0, 0, '2016-07-25 19:05:40', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '729'),
(11302, 22, 22, 2, 11292, 0, 0, '2016-07-25 19:05:41', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '72A'),
(11303, 22, 22, 2, 11292, 0, 0, '2016-07-25 19:05:41', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '72B'),
(11304, 22, 22, 2, 11292, 0, 0, '2016-07-25 19:05:41', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '72C'),
(11305, 22, 22, 2, 11292, 0, 0, '2016-07-25 19:05:41', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '72D'),
(11306, 22, 22, 2, 11280, 1, 0, '2016-07-25 19:05:41', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '73'),
(11307, 22, 22, 2, 11306, 0, 0, '2016-07-25 19:05:41', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '731'),
(11308, 22, 22, 2, 11306, 0, 0, '2016-07-25 19:05:41', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '732'),
(11309, 22, 22, 2, 11306, 0, 0, '2016-07-25 19:05:41', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '733'),
(11310, 22, 22, 2, 11306, 0, 0, '2016-07-25 19:05:41', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '734'),
(11311, 22, 22, 2, 11306, 0, 0, '2016-07-25 19:05:41', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '735'),
(11312, 22, 22, 2, 11306, 0, 0, '2016-07-25 19:05:41', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '736'),
(11313, 22, 22, 2, 11306, 0, 0, '2016-07-25 19:05:41', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '737'),
(11314, 22, 22, 2, 11306, 0, 0, '2016-07-25 19:05:41', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '738'),
(11315, 22, 22, 2, 11306, 0, 0, '2016-07-25 19:05:41', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '739'),
(11316, 22, 22, 2, 11280, 1, 0, '2016-07-25 19:05:41', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '74'),
(11317, 22, 22, 2, 11316, 0, 0, '2016-07-25 19:05:41', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '741'),
(11318, 22, 22, 2, 11316, 0, 0, '2016-07-25 19:05:41', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '742'),
(11319, 22, 22, 2, 11316, 0, 0, '2016-07-25 19:05:41', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '743'),
(11320, 22, 22, 2, 11316, 0, 0, '2016-07-25 19:05:41', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '744'),
(11321, 22, 22, 2, 11316, 0, 0, '2016-07-25 19:05:41', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '747'),
(11322, 22, 22, 2, 11316, 0, 0, '2016-07-25 19:05:42', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '748'),
(11323, 22, 22, 2, 11280, 1, 0, '2016-07-25 19:05:42', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '75'),
(11324, 22, 22, 2, 11323, 0, 0, '2016-07-25 19:05:42', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '751'),
(11325, 22, 22, 2, 11323, 0, 0, '2016-07-25 19:05:42', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '752'),
(11326, 22, 22, 2, 11323, 0, 0, '2016-07-25 19:05:42', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '753'),
(11327, 22, 22, 2, 11323, 0, 0, '2016-07-25 19:05:42', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '754'),
(11328, 22, 22, 2, 11323, 0, 0, '2016-07-25 19:05:42', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '755'),
(11329, 22, 22, 2, 11323, 0, 0, '2016-07-25 19:05:42', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '756'),
(11330, 22, 22, 2, 11323, 0, 0, '2016-07-25 19:05:42', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '757'),
(11331, 22, 22, 2, 11323, 0, 0, '2016-07-25 19:05:42', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '758'),
(11332, 22, 22, 2, 11280, 1, 0, '2016-07-25 19:05:42', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '76'),
(11333, 22, 22, 2, 11332, 0, 0, '2016-07-25 19:05:42', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '761'),
(11334, 22, 22, 2, 11332, 0, 0, '2016-07-25 19:05:42', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '762'),
(11335, 22, 22, 2, 11280, 1, 0, '2016-07-25 19:05:42', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '77'),
(11336, 22, 22, 2, 11335, 0, 0, '2016-07-25 19:05:42', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '771'),
(11337, 22, 22, 2, 11335, 0, 0, '2016-07-25 19:05:42', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '772'),
(11338, 22, 22, 2, 11335, 0, 0, '2016-07-25 19:05:42', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '773'),
(11339, 22, 22, 2, 11335, 0, 0, '2016-07-25 19:05:42', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '774'),
(11340, 22, 22, 2, 11335, 0, 0, '2016-07-25 19:05:42', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '775'),
(11341, 22, 22, 2, 11335, 0, 0, '2016-07-25 19:05:42', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '776'),
(11342, 22, 22, 2, 11335, 0, 0, '2016-07-25 19:05:42', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '777'),
(11343, 22, 22, 2, 11335, 0, 0, '2016-07-25 19:05:42', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '778'),
(11344, 22, 22, 2, 11335, 0, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '779'),
(11345, 22, 22, 2, 11335, 0, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '77A'),
(11346, 22, 22, 2, 11335, 0, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '77B'),
(11347, 22, 22, 2, 11335, 0, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '77C'),
(11348, 22, 22, 2, 11335, 0, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '77D'),
(11349, 22, 22, 2, 11335, 0, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '77I'),
(11350, 22, 22, 2, 11280, 1, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '78'),
(11351, 22, 22, 2, 11350, 0, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '781'),
(11352, 22, 22, 2, 11350, 0, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '782'),
(11353, 22, 22, 2, 11350, 0, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '783'),
(11354, 22, 22, 2, 0, 1, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '8'),
(11355, 22, 22, 2, 11354, 0, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '81'),
(11356, 22, 22, 2, 11354, 0, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '82'),
(11357, 22, 22, 2, 11354, 0, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '83'),
(11358, 22, 22, 2, 11354, 0, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '84'),
(11359, 22, 22, 2, 11354, 0, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '85'),
(11360, 22, 22, 2, 11354, 0, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '86'),
(11361, 22, 22, 2, 11354, 0, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '87'),
(11362, 22, 22, 2, 0, 1, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '9'),
(11363, 22, 22, 2, 11362, 1, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '91'),
(11364, 22, 22, 2, 11363, 1, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '911'),
(11365, 22, 22, 2, 11364, 0, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '9111'),
(11366, 22, 22, 2, 11364, 0, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '9112'),
(11367, 22, 22, 2, 11364, 0, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '9113'),
(11368, 22, 22, 2, 11363, 1, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '912'),
(11369, 22, 22, 2, 11368, 0, 0, '2016-07-25 19:05:43', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '9121'),
(11370, 22, 22, 2, 11368, 0, 0, '2016-07-25 19:05:44', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '9122'),
(11371, 22, 22, 2, 11368, 0, 0, '2016-07-25 19:05:44', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '9123'),
(11372, 22, 22, 2, 11363, 1, 0, '2016-07-25 19:05:44', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '913'),
(11373, 22, 22, 2, 11372, 0, 0, '2016-07-25 19:05:44', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '9131'),
(11374, 22, 22, 2, 11372, 0, 0, '2016-07-25 19:05:44', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '9132'),
(11375, 22, 22, 2, 11372, 0, 0, '2016-07-25 19:05:44', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '9133'),
(11376, 22, 22, 2, 11363, 1, 0, '2016-07-25 19:05:44', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '914'),
(11377, 22, 22, 2, 11376, 0, 0, '2016-07-25 19:05:44', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '9141'),
(11378, 22, 22, 2, 11376, 0, 0, '2016-07-25 19:05:44', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '9142'),
(11379, 22, 22, 2, 11376, 0, 0, '2016-07-25 19:05:44', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '9143'),
(11380, 22, 22, 2, 11363, 1, 0, '2016-07-25 19:05:44', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '915'),
(11381, 22, 22, 2, 11380, 0, 0, '2016-07-25 19:05:44', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '9151'),
(11382, 22, 22, 2, 11380, 0, 0, '2016-07-25 19:05:44', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '9152'),
(11383, 22, 22, 2, 11380, 0, 0, '2016-07-25 19:05:44', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '9153'),
(11384, 22, 22, 2, 11363, 1, 0, '2016-07-25 19:05:44', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '916'),
(11385, 22, 22, 2, 11384, 0, 0, '2016-07-25 19:05:44', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '9161'),
(11386, 22, 22, 2, 11384, 0, 0, '2016-07-25 19:05:44', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '9162'),
(11387, 22, 22, 2, 11363, 1, 0, '2016-07-25 19:05:44', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '917'),
(11388, 22, 22, 2, 11387, 0, 0, '2016-07-25 19:05:44', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '9171'),
(11389, 22, 22, 2, 11387, 0, 0, '2016-07-25 19:05:44', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '9172'),
(11390, 22, 22, 2, 11363, 0, 0, '2016-07-25 19:05:44', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '919'),
(11391, 22, 22, 2, 11363, 0, 0, '2016-07-25 19:05:44', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '91A'),
(11392, 22, 22, 2, 11363, 1, 0, '2016-07-25 19:05:44', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '91B'),
(11393, 22, 22, 2, 11392, 0, 0, '2016-07-25 19:05:44', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '91B1'),
(11394, 22, 22, 2, 11363, 0, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '91C'),
(11395, 22, 22, 2, 11363, 0, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '91D'),
(11396, 22, 22, 2, 11363, 0, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '91E'),
(11397, 22, 22, 2, 11363, 0, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '91F'),
(11398, 22, 22, 2, 11362, 1, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '92'),
(11399, 22, 22, 2, 11398, 0, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '921'),
(11400, 22, 22, 2, 11398, 0, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '922'),
(11401, 22, 22, 2, 11398, 0, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '923'),
(11402, 22, 22, 2, 11398, 0, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '924'),
(11403, 22, 22, 2, 11398, 0, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '925'),
(11404, 22, 22, 2, 11398, 0, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '926'),
(11405, 22, 22, 2, 11398, 0, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '927'),
(11406, 22, 22, 2, 11398, 0, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '928'),
(11407, 22, 22, 2, 11362, 1, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '93'),
(11408, 22, 22, 2, 11407, 0, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '931'),
(11409, 22, 22, 2, 11407, 0, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '932'),
(11410, 22, 22, 2, 11407, 0, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '933'),
(11411, 22, 22, 2, 11407, 0, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '934'),
(11412, 22, 22, 2, 11407, 0, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '935'),
(11413, 22, 22, 2, 11407, 0, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '936'),
(11414, 22, 22, 2, 11407, 0, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '937'),
(11415, 22, 22, 2, 11407, 0, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '938'),
(11416, 22, 22, 2, 11407, 0, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '939'),
(11417, 22, 22, 2, 11407, 0, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '93A'),
(11418, 22, 22, 2, 11407, 0, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '93B'),
(11419, 22, 22, 2, 11407, 0, 0, '2016-07-25 19:05:45', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '93C'),
(11420, 22, 22, 2, 11407, 0, 0, '2016-07-25 19:05:46', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '93D'),
(11421, 22, 22, 2, 11407, 0, 0, '2016-07-25 19:05:46', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '93E'),
(11422, 22, 22, 2, 11407, 0, 0, '2016-07-25 19:05:46', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, '93F'),
(11423, 22, 22, 2, 0, 1, 0, '2016-07-25 19:05:46', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'A'),
(11424, 22, 22, 2, 11423, 1, 0, '2016-07-25 19:05:46', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'A1'),
(11425, 22, 22, 2, 11424, 0, 0, '2016-07-25 19:05:46', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'A11'),
(11426, 22, 22, 2, 11424, 0, 0, '2016-07-25 19:05:46', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'A12'),
(11427, 22, 22, 2, 11424, 0, 0, '2016-07-25 19:05:46', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'A13'),
(11428, 22, 22, 2, 11424, 0, 0, '2016-07-25 19:05:46', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'A14'),
(11429, 22, 22, 2, 11424, 0, 0, '2016-07-25 19:05:46', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'A15'),
(11430, 22, 22, 2, 11424, 0, 0, '2016-07-25 19:05:46', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'A16'),
(11431, 22, 22, 2, 11424, 0, 0, '2016-07-25 19:05:46', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'A17'),
(11432, 22, 22, 2, 11424, 0, 0, '2016-07-25 19:05:46', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'A18'),
(11433, 22, 22, 2, 11424, 0, 0, '2016-07-25 19:05:46', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'A19'),
(11434, 22, 22, 2, 11424, 0, 0, '2016-07-25 19:05:46', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'A1A'),
(11435, 22, 22, 2, 11424, 0, 0, '2016-07-25 19:05:46', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'A1B'),
(11436, 22, 22, 2, 11424, 0, 0, '2016-07-25 19:05:46', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'A1C'),
(11437, 22, 22, 2, 11424, 0, 0, '2016-07-25 19:05:46', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'A1D'),
(11438, 22, 22, 2, 11424, 0, 0, '2016-07-25 19:05:46', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'A1E'),
(11439, 22, 22, 2, 11423, 0, 0, '2016-07-25 19:05:46', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'A2'),
(11440, 22, 22, 2, 0, 1, 0, '2016-07-25 19:05:46', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'B'),
(11441, 22, 22, 2, 11440, 0, 0, '2016-07-25 19:05:47', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'B1'),
(11442, 22, 22, 2, 11440, 0, 0, '2016-07-25 19:05:47', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'B2'),
(11443, 22, 22, 2, 11440, 0, 0, '2016-07-25 19:05:47', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'B3'),
(11444, 22, 22, 2, 11440, 0, 0, '2016-07-25 19:05:47', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'B4'),
(11445, 22, 22, 2, 11440, 0, 0, '2016-07-25 19:05:47', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'B5'),
(11446, 22, 22, 2, 11440, 0, 0, '2016-07-25 19:05:47', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'B6'),
(11447, 22, 22, 2, 11440, 0, 0, '2016-07-25 19:05:47', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'B7'),
(11448, 22, 22, 2, 11440, 0, 0, '2016-07-25 19:05:47', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'B8'),
(11449, 22, 22, 2, 11440, 0, 0, '2016-07-25 19:05:47', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'B9'),
(11450, 22, 22, 2, 11440, 0, 0, '2016-07-25 19:05:47', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'BA'),
(11451, 22, 22, 2, 11440, 0, 0, '2016-07-25 19:05:47', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'BB'),
(11452, 22, 22, 2, 11440, 0, 0, '2016-07-25 19:05:47', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'BC'),
(11453, 22, 22, 2, 0, 1, 0, '2016-07-25 19:05:47', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'C'),
(11454, 22, 22, 2, 11453, 0, 0, '2016-07-25 19:05:47', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'C1'),
(11455, 22, 22, 2, 11453, 0, 0, '2016-07-25 19:05:47', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'C2'),
(11456, 22, 22, 2, 11453, 0, 0, '2016-07-25 19:05:47', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'C3'),
(11457, 22, 22, 2, 0, 1, 0, '2016-07-25 19:05:47', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'D'),
(11458, 22, 22, 2, 11457, 0, 0, '2016-07-25 19:05:47', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'D1'),
(11459, 22, 22, 2, 11457, 0, 0, '2016-07-25 19:05:47', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'D2'),
(11460, 22, 22, 2, 0, 1, 0, '2016-07-25 19:05:47', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'E'),
(11461, 22, 22, 2, 11460, 0, 0, '2016-07-25 19:05:47', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'E1'),
(11462, 22, 22, 2, 11460, 0, 0, '2016-07-25 19:05:47', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'E2'),
(11463, 22, 22, 2, 11460, 0, 0, '2016-07-25 19:05:48', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'E3');
INSERT INTO `e_content` (`id`, `types_id`, `subtypes_id`, `owner_id`, `parent_id`, `isfolder`, `position`, `created`, `updated`, `published`, `settings`, `status`, `sku`, `currency_id`, `unit_id`, `has_variants`, `in_stock`, `external_id`) VALUES
(11464, 22, 22, 2, 11460, 0, 0, '2016-07-25 19:05:48', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'E4'),
(11465, 22, 22, 2, 11460, 0, 0, '2016-07-25 19:05:48', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'E5'),
(11466, 22, 22, 2, 0, 1, 0, '2016-07-25 19:05:48', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'F'),
(11467, 22, 22, 2, 11466, 0, 0, '2016-07-25 19:05:48', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'F1'),
(11468, 22, 22, 2, 11466, 0, 0, '2016-07-25 19:05:48', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'F2'),
(11469, 22, 22, 2, 11466, 0, 0, '2016-07-25 19:05:48', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'F3'),
(11470, 22, 22, 2, 11466, 0, 0, '2016-07-25 19:05:48', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'F4'),
(11471, 22, 22, 2, 11466, 0, 0, '2016-07-25 19:05:48', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'F5'),
(11472, 22, 22, 2, 11466, 0, 0, '2016-07-25 19:05:48', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'F6'),
(11473, 22, 22, 2, 11466, 0, 0, '2016-07-25 19:05:48', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'F7'),
(11474, 22, 22, 2, 11466, 0, 0, '2016-07-25 19:05:48', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'F8'),
(11475, 22, 22, 2, 11466, 0, 0, '2016-07-25 19:05:48', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'F9'),
(11476, 22, 22, 2, 11466, 0, 0, '2016-07-25 19:05:48', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'FA'),
(11477, 22, 22, 2, 11466, 0, 0, '2016-07-25 19:05:48', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'FB'),
(11478, 22, 22, 2, 11466, 0, 0, '2016-07-25 19:05:48', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'FC'),
(11479, 22, 22, 2, 11466, 0, 0, '2016-07-25 19:05:48', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'FD'),
(11480, 22, 22, 2, 11466, 0, 0, '2016-07-25 19:05:48', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'FE'),
(11481, 22, 22, 2, 11466, 0, 0, '2016-07-25 19:05:48', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'FF'),
(11482, 22, 22, 2, 11466, 0, 0, '2016-07-25 19:05:48', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'FG'),
(11483, 22, 22, 2, 11466, 0, 0, '2016-07-25 19:05:48', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'FH'),
(11484, 22, 22, 2, 11466, 0, 0, '2016-07-25 19:05:48', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'FI'),
(11485, 22, 22, 2, 11466, 0, 0, '2016-07-25 19:05:48', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'FK'),
(11486, 22, 22, 2, 11466, 0, 0, '2016-07-25 19:05:48', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'FL'),
(11487, 22, 22, 2, 11466, 0, 0, '2016-07-25 19:05:48', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'FM'),
(11488, 22, 22, 2, 11466, 0, 0, '2016-07-25 19:05:49', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'FN'),
(11489, 22, 22, 2, 11466, 0, 0, '2016-07-25 19:05:49', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'FO'),
(11490, 22, 22, 2, 11466, 0, 0, '2016-07-25 19:05:49', NULL, NULL, NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'FP');

-- --------------------------------------------------------

--
-- Структура таблиці `e_content_features`
--

CREATE TABLE IF NOT EXISTS `e_content_features` (
  `id` int(10) unsigned NOT NULL,
  `content_id` int(10) unsigned NOT NULL,
  `features_id` int(10) unsigned NOT NULL,
  `values_id` int(10) unsigned DEFAULT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `value` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблиці `e_content_images`
--

CREATE TABLE IF NOT EXISTS `e_content_images` (
  `id` int(11) unsigned NOT NULL,
  `content_id` int(11) unsigned NOT NULL,
  `path` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `position` tinyint(5) unsigned NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=10208 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_content_images`
--

INSERT INTO `e_content_images` (`id`, `content_id`, `path`, `image`, `position`, `created`) VALUES
(1, 18, 'uploads/content/2016/07/05/', 'new1-18x.png', 1, '2016-07-05 07:11:35'),
(2, 20, 'uploads/content/2016/07/05/', 'new2-20x.png', 1, '2016-07-05 07:26:22'),
(3, 22, 'uploads/content/2016/07/05/', 'new4-22x.png', 1, '2016-07-05 07:27:33'),
(4, 23, 'uploads/content/2016/07/05/', 'new_one-23x.png', 1, '2016-07-05 07:28:20');

-- --------------------------------------------------------

--
-- Структура таблиці `e_content_images_sizes`
--

CREATE TABLE IF NOT EXISTS `e_content_images_sizes` (
  `id` tinyint(3) unsigned NOT NULL,
  `size` varchar(16) NOT NULL,
  `width` int(5) unsigned NOT NULL,
  `height` int(5) unsigned NOT NULL,
  `quality` tinyint(3) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_content_images_sizes`
--

INSERT INTO `e_content_images_sizes` (`id`, `size`, `width`, `height`, `quality`) VALUES
(3, 'post', 240, 220, 70),
(4, 'psm', 260, 180, 70),
(5, 'thumbs', 160, 120, 60);

-- --------------------------------------------------------

--
-- Структура таблиці `e_content_info`
--

CREATE TABLE IF NOT EXISTS `e_content_info` (
  `id` int(10) unsigned NOT NULL,
  `content_id` int(10) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `url` varchar(160) DEFAULT NULL,
  `h1` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `intro` text,
  `content` text
) ENGINE=InnoDB AUTO_INCREMENT=11480 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_content_info`
--

INSERT INTO `e_content_info` (`id`, `content_id`, `languages_id`, `name`, `url`, `h1`, `title`, `keywords`, `description`, `intro`, `content`) VALUES
(1, 1, 1, 'Головна', '', '', 'Головна', '', '', '', ''),
(2, 4, 1, 'Про нас', 'pro-nas', '', 'Про нас', '', '', '', '<p><em>Компанія Світ Мобільних Аксесуарів розпочала свою діяльність понад десять років тому, із мережі роздрібних магазинів - сервісів &quot; Світ Мобільних Аксесуарів&quot;, котрі займались як роздрібною торгівлею комплектуючих та аксесуарів для мобільних телефонів, так і спеціалісти СМА проводили ремонтні роботи техніки. За всю історію свою історію &nbsp;компанія світ Мобільних Аксесуарів здобула хорошу репутацію та безліч задоволених відгуків як від споживачів так і від партнерів та постачальників.</em></p>\n\n<p><em>&nbsp; &nbsp; &nbsp; &nbsp; На сьогодні СМА робить наступний крок у свому розвитку та розпочинає свою інтернет-діяльність відкриваючи інтернет - магазин Світ Мобільних Аксесуарів. Ми не тільки пропонуємо роздрібну торгівлю комплектуючими та аксесуарами для смартфонів, планшетів та фото - і відео- техніки, а й надаємо вигідні пропозиції гуртовикам, а також споживачам котрі бажають не тільки купити запчастини а й одразу потребують їхньої заміни.</em></p>\n\n<p><em>&nbsp; &nbsp; &nbsp; &nbsp; Кожному відвідувачу нашого інтернет-магазина ми пропонуємо не тільки широкий асортимент комплектуючих та аксесуарів за доступними цінами для мобільних телефонів, смартфонів, планшетів, фотоапаратів та відеокамер, а й &nbsp;гнучку цінову політику та якісну систему знижок. А висококваліфіковані спеціалісти інтернет-магазина Світ Мобільних Аксесуарів швидко та якісно нададуть вам необхідну консультацію та допоможуть обрати необхідний Вам товар.</em></p>\n'),
(3, 5, 1, 'Новини та Акції', 'novyny-ta-akcii', '', 'Новини та Акції', '', '', '', ''),
(4, 6, 1, 'Доставка і оплата', 'dostavka-i-oplata', '', 'Доставка і оплата', '', '', '', ''),
(5, 7, 1, 'Контакти', 'kontakty', '', 'Контакти', '', '', '', '<div class="goods-list__row">\n\n                                <div class="item item7">\n                                    <h3>Головний офіс, вул. Наукова 7а <br><span>(Офісний центр “Оптіма Плаза”)</span></h3>\n\n                                    <p>1 поверх, офіс №124</p>\n                                    <p>Працюємо з 09:00 до 19:00</p>\n                                    <p>Сб: 09:00 - 15:00, Нд: вихідний</p>\n                                </div>\n\n                                <div class="item item5">\n                                    <img src="{$theme_url}/assets/img/contacts.jpg" alt="">\n                                </div>\n\n                            </div>\n                            <div class="goods-list__row">\n                                <div class="head">Телефонні номери, інтернет зв’язок:</div>\n                                <div class="item item6">\n                                    <div class="footer__contacts">\n\n                                        <a class="ks" href="#">\n                                            +38 (097) 59 88 666\n                                        </a>\n\n                                        <a class="vf" href="#">\n                                            +38 (099) 25 88 666\n                                        </a>\n\n                                        <a class="lc" href="#">\n                                            +38 (063) 59 88 666\n                                        </a>\n\n                                    </div>\n                                </div>\n                                <div class="item item6">\n                                    <div class="footer__contacts">\n\n                                        <a class="gm" href="#">\n                                            sma.lviv@gmail.com\n                                        </a>\n\n                                        <a class="sk" href="#">\n                                            sma_lviv\n                                        </a>\n\n                                    </div>\n                                </div>\n\n                            </div>'),
(7, 16, 1, 'Новини', 'eeeeesees', '', 'Новини', '', '', NULL, NULL),
(8, 17, 1, 'Акції', 'ebeitsi', '', 'Акції', '', '', NULL, NULL),
(9, 18, 1, 'Samsung Galaxy S7 дві SIM і microSD', 'samsunggalaxys7eyeeisimimicrosd', '', 'Samsung Galaxy S7: як змусити працювати дві SIM і microSD разом', '', '', '<p>Samsung услышала просьбы фанатов и оснастила флагманы Galaxy S7 и Galaxy S7&nbsp;</p>\n', '<p>Samsung услышала просьбы фанатов и оснастила флагманы Galaxy S7 и Galaxy S7 edge слотом для карт microSD. Правда, сделала это, как сейчас модно, с помощью гибридного лотка, то есть пользователь должен выбрать, будет ли он использовать две SIM-карты или одну SIM и microSD. &laquo;Очумелые ручки&raquo; желающих получить все и сразу привели к появлению инструкции, как добиться одновременной работы двух SIM-карт и microSD. Для этого вам необходимо осторожно отделить чип SIM-карты от корпуса (по словам автора, это занимает не больше минуты времени), обрезать по 1-2 мм с каждой стороны, чтобы она не выходила за пределы карты памяти, приклеить симку к обратной стороне microSD строго, как показано на картинке</p>\n'),
(10, 19, 1, 'Фоновий малюнок HTC 10 на Sense UI', 'eeeeeeseueebeyueeeihtc10eebsenseui', '', 'Фоновий малюнок HTC 10 на Sense UI у повномурозмірі доступний для Вас', '', '', '<p>Волна повышения тарифов заставила потребителей перейти на коммунальную диету.</p>\n', '<p>Волна повышения тарифов заставила потребителей перейти на коммунальную диету. Активный самостоятельный поиск альтернативных источников тепла обращает внимание &nbsp;на твердотопливные котельные. Доступность топливной составляющей &mdash; весомое преимущество отопительного спецоборудования. Желающим получить максимальный экономический эффект, необходимо смотреть на систему как на единое целое<strong>. &nbsp;</strong>Монтаж и&nbsp;<strong><a target="_blank">проектирование котельных</a></strong>&nbsp;&ndash; удел специалистов. Вам предлагается &nbsp;эффективные, простые в эксплуатации, отопительные системы на твердом топливе, которые неприхотливы в обслуживании и отличаются низкой себестоимостью.</p>\n'),
(11, 20, 1, 'Экономный источник тепловой энергии', 'eieeeeeeuesecheeseieleeeeeeeueelezeses', '', 'Экономный источник тепловой энергии', '', '', '<p>Устанавливаются &nbsp;на любую&nbsp;площадку.</p>\n', '<p><strong><a href="http://e-service.biz.ua/produktsiya/modulnye-kotelnye-na-tverdom-toplive" target="_blank">Модульные котельные</a></strong>&nbsp;установки, собраны и настроены на заводе, предназначены для отопления и горячего водоснабжения объектов промышленного или жилого назначения. Устанавливаются в непосредственной близости к отапливаемому сооружению на любую ровную площадку. Высокие показатели эффективности работы твердотопливной котельной установки позволяют значительно экономить на энергоресурсах.</p>\n\n<p>На этапе проектирования, расчет тепловых нагрузок выполняется под конкретное техническое задание. Блочно-модульный принцип комплектации котельной&nbsp; предусматривает возможность&nbsp; подбора технологического оборудования в широком диапазоне мощностей под каждого потребителя. Максимально сжатые сроки от начала проектирования и до момента запуска в эксплуатацию &mdash; весомый аргумент в пользу блочно-модульных котельных, работающих на твердом топливе.</p>\n'),
(12, 21, 1, 'Мифы, которые развенчает любой магазин стиральных машин.', 'eeseieeelebepeeelechebeleyuegeeueebezebepeseesebeeheebshese', '', 'Мифы, которые развенчает любой магазин стиральных машин.', '', '', '<p>Ежедневно на рынке совершается несколько тысяч сделок по покупке бытовой техники. Однако любой магазин стиральных машин подтвердит, что при выборе данного оборудования многие покупатели руководствуются очень нелепыми заблуждениями, навязанными общественным мнением. Существует целый ряд мифов о стиральных машинах. И именно эти заблуждения порой препятствуют правильному выбору или эксплуатации техники.</p>\n', '<p>Ежедневно на рынке совершается несколько тысяч сделок по покупке бытовой техники. Однако любой магазин стиральных машин подтвердит, что при выборе данного оборудования многие покупатели руководствуются очень нелепыми заблуждениями, навязанными общественным мнением. Существует целый ряд мифов о стиральных машинах. И именно эти заблуждения порой препятствуют правильному выбору или эксплуатации техники.</p>\n\n<p>Итак, крупный интернет&nbsp;<strong>магазин стиральных машин</strong>&nbsp;предлагает ТОП 5 заблуждений:</p>\n\n<p><img alt="магазин стиральных машин" height="384" src="http://freecentre.com.ua/wp-content/uploads/2015/04/4f4e766ab5a3e.jpg" width="640" /></p>\n\n<p>1. Калгон &ndash; это панацея. Зачастую современные стиральные порошки уже содержат в составе средства, смягчающие воду. Однако их содержание в порошке минимально, поэтому накипь все равно образовывается. И Калгон по мнению специалистов не препятствует этому процессу, не удаляет уже образовавшуюся накипь. Лучше использовать обычную лимонную кислоту, которая добавляется в отсек стиральной машины. При этом барабан не загружается бельем, машинка работает в холостую на режиме стирки при максимально высокой температуре. Результат будет заметен даже невооруженным глазом.</p>\n\n<p>2. Вертикальная загрузка более предпочтительна. Люди, которые приходят в&nbsp;<strong>магазин стиральных машин</strong>, часто выбирают более дорогие вертикальные машины лишь потому, что, по их мнению, в такой технике баки крепятся лучше. И именно качественное крепление обеспечивает длительный срок эксплуатации машины, а также меньшую вибрацию при отжиме. На самом деле это лишь заблуждение. И вертикальные машины ломаются. Важно правильно загружать барабан бельем, не перегружать и не стирать по одной вещи. Тогда вы сможете избежать перекосов барабана и как следствие &ndash; поломок или усиленной вибрации.</p>\n\n<p><img alt="как выбрать стиральную машину" height="398" src="http://freecentre.com.ua/wp-content/uploads/2015/04/2dc373d18b880d0a4d7864324fc9ad5c_h.jpg" width="550" /></p>\n\n<p>3. Нужно набивать барабан плотно, тогда машинка не будет &laquo;прыгать&raquo;. В данном случае дело не в степени загрузки барабана, а в других особенностях. Каждый вид ткани обладает своими свойствами. При намокании хлопок лишь немного увеличивает вес, а вот махровые полотенца становятся гораздо тяжелее. Отсюда и &laquo;прыжки&raquo; техники во время отжима, затянутое время стирки по причине того, что машина не может раскрутить барабан. Нужно обязательно застегивать все пуговицы, молнии, иные застежки перед тем, как класть вещь в барабан. Используйте мешки для стирки деликатных тканей.</p>\n\n<p>4. Фильтр для машины продлит ее срок службы. Но его установка производит обратный эффект. Фильтры не справляются с очисткой воды, поэтому осадок и накипь никуда не исчезают. Однако возрастает риск образования засоров. Так называемые солевые фильтры могут засорить входной клапан солью, поэтому техника будет постепенно набирать воду даже в режиме покоя. И рано или поздно эта вода станет литься на пол. В отдельных случаях вы можете даже затопить соседей снизу. Лучше устанавливать фильтр на всю поступающую в дом воду. Конечно, такой способ дороже, но гораздо эффективнее.</p>\n\n<p>5. Ультразвуковая стиральная машина. Любой&nbsp;<strong>магазин стиральных машин</strong>&nbsp;подтвердит, что такие устройства не несут в себе никакой пользы. Эффективность от их применения соизмерима с простым замачиванием белья. Без усилий и механического воздействия избавиться от пятен у вас не получится.</p>\n'),
(13, 22, 1, 'Доставка техники из Китая', 'eyeebeeeiebelheeseiesesepeiesebya', '', 'Доставка техники из Китая', '', '', '<p>Поставка груза из Китая в Украину реализуется по сформированной схеме.Товар направляется к месту назначения, в это время работники логистического предприятия занимаются оформлением документов для его таможенного оформления. Доставленный в Украину груз, подвергается особой проверке. Когда груз прошел всю процедуру проверки успешно, тогда он готов для отправки в разные города Украины.</p>\n', '<p>Важнейшим функциональным предметом владения доносящего постоянный доход бизнеса, есть как иное маркетинговые исследования во множество разных грузоперевозок промышленных товаров из-за рубежа.На данный момент торговые структуры обращают пристально внимание на&nbsp;<a href="http://proficargo.com.ua/geografiya-perevozok/aziya/kitaj.html">доставку сборных грузов из Китая</a>, которые возрастают на особые результаты каждый год. Проанализировано грузопотоки на основе данных из таможни, образовавшими структурами госслужб, которые позволяют определить не только сферы развития международной торговли, но и возрастание спроса по разным предприятиям.<br />\n<img alt="доставка сборных грузов из китая" height="690" src="http://freecentre.com.ua/wp-content/uploads/2015/03/dostavka-sbornyh-gruzov-iz-kitaya-1030x826.jpg" width="861" /><br />\nКомпании которые конкуренты имеют доступ к изучению по разным ступеням руководства собственного производства: закупку различной продукции, каким видом грузоперевозок поставляется и период между поставок груза. Такой доступ открыт только для крупных предприятий.<br />\nЧаще всего бизнесмены, закупающие товар в Китае, ошибаются в выборе грузоперевозки определенным транспортом, который позаботится о хорошей и своевременной доставки. Большинство торговых предприятий выбирают способ грузоперевозки ориентируясь на экономию в тарифах или быстроту доставки. Грузоперевозки из Китая не так просты, ведь тут задействуют все основные факторы, с помощью которых уменьшают основные растраты при ведении особых условий.</p>\n\n<p>Поставка груза из Китая в Украину реализуется по сформированной схеме.Товар направляется к месту назначения, в это время работники логистического предприятия занимаются оформлением документов для его таможенного оформления. Доставленный в Украину груз, подвергается особой проверке. Когда груз прошел всю процедуру проверки успешно, тогда он готов для отправки в разные города Украины.</p>\n'),
(15, 23, 1, 'Экономный источник тепловой энергии 2', 'eieeeeeeuesecheeseieleeeeeeeueelezeses2', '', 'Экономный источник тепловой энергии 2', '', '', '<p>Модульные твердотопливные котельные &ndash; надежные, безопасные решения &mdash; не требуют согласования с различными инстанциями, прошли испытания, что подтверждается сертификатом соответствия.</p>\n', '<p>Волна повышения тарифов заставила потребителей перейти на коммунальную диету. Активный самостоятельный поиск альтернативных источников тепла обращает внимание &nbsp;на твердотопливные котельные. Доступность топливной составляющей &mdash; весомое преимущество отопительного спецоборудования. Желающим получить максимальный экономический эффект, необходимо смотреть на систему как на единое целое<strong>. &nbsp;</strong>Монтаж и&nbsp;<strong><a href="http://e-service.biz.ua/usluhy/proektnye-resheniya" target="_blank">проектирование котельных</a></strong>&nbsp;&ndash; удел специалистов. Вам предлагается &nbsp;эффективные, простые в эксплуатации, отопительные системы на твердом топливе, которые неприхотливы в обслуживании и отличаются низкой себестоимостью.</p>\n\n<p><img alt="Экономный источник тепловой энергии" height="437" src="http://freecentre.com.ua/wp-content/uploads/2015/04/2015-04-20-11-51-15-Rezultat-poiska-Google-dlya-http-www.porjati.ru-uploads-posts-2014-05-thumbs-1401181088_blst-14.jpg-.png" width="675" /></p>\n\n<p><strong><a href="http://e-service.biz.ua/produktsiya/modulnye-kotelnye-na-tverdom-toplive" target="_blank">Модульные котельные</a></strong>&nbsp;установки, собраны и настроены на заводе, предназначены для отопления и горячего водоснабжения объектов промышленного или жилого назначения. Устанавливаются в непосредственной близости к отапливаемому сооружению на любую ровную площадку. Высокие показатели эффективности работы твердотопливной котельной установки позволяют значительно экономить на энергоресурсах.</p>\n\n<p>На этапе проектирования, расчет тепловых нагрузок выполняется под конкретное техническое задание. Блочно-модульный принцип комплектации котельной&nbsp; предусматривает возможность&nbsp; подбора технологического оборудования в широком диапазоне мощностей под каждого потребителя. Максимально сжатые сроки от начала проектирования и до момента запуска в эксплуатацию &mdash; весомый аргумент в пользу блочно-модульных котельных, работающих на твердом топливе.</p>\n\n<p><img alt="модульные котельные на твердом топливе" height="789" src="http://freecentre.com.ua/wp-content/uploads/2015/04/2015-04-20-11-54-31-KlimatAkvaTEks-2014-.-Krasnoyarsk.-Rezultaty-vystavki.-Waterfox.png" width="793" /></p>\n\n<p>Корпус модульной котельной &ndash; цельнометаллический каркас, с высококачественной теплоизоляцией, пожаробезопасный, имеет высокую степень защиты от физических повреждений и влияния климатических условий. Простой монтаж исключает&nbsp; затраты на капитальное строительство. Показатели выбросов продуктов горения соответствуют европейским экологическим нормам. Автоматизированная система котельной управляет количеством выработанной тепловой энергии, распределяет её и передает по трубопроводам. Температура теплоносителя регулируется автоматически, учет вырабатываемого тепла осуществляется теплосчетчиком. Регулярность обслуживания зависит от объема бункера и не требует постоянного присутствия персонала.</p>\n\n<p>Модульные твердотопливные котельные &ndash; надежные, безопасные решения &mdash; не требуют согласования с различными инстанциями, прошли испытания, что подтверждается сертификатом соответствия.</p>\n'),
(16, 25, 1, 'Сервіс', 'servis', '', 'Сервіс', '', '', '', ''),
(17, 26, 1, 'Аккаунт', 'akkaunt', '', 'Аккаунт', '', '', '', ''),
(18, 28, 1, 'Профіль ', 'akkaunt/profil', '', 'Профіль', '', '', '', ''),
(19, 29, 1, 'Загальна інформація', 'epebezebeeebieeeebtsiya', '', 'Загальна інформація', '', '', '', ''),
(20, 30, 1, 'Мій кошик', 'eieueieshesei', '', 'Мій кошик', '', '', '', ''),
(21, 31, 1, 'Мої замовлення', 'akkaunt/moi-zamovlennya', '', 'Мої замовлення', '', '', '', ''),
(22, 32, 1, 'Моя бонусна картка', 'eeyaegeeeebeiebeieb', '', 'Моя бонусна картка', '', '', '', ''),
(23, 34, 1, 'Кількісні одиниці', 'eiieeiieieeyeseestsi', '', 'Кількісні одиниці', '', '', NULL, NULL),
(24, 35, 1, 'шт.', 'sh', '', 'шт.', '', '', NULL, NULL),
(25, 36, 1, 'уп.', 'e', '', 'уп.', '', '', NULL, NULL),
(26, 37, 1, 'г.', 'ez', '', 'г.', '', '', NULL, NULL),
(27, 38, 1, 'кг.', 'eiez', '', 'кг.', '', '', NULL, NULL),
(28, 39, 1, 'т.', 't', '', 'т.', '', '', NULL, NULL),
(10256, 10271, 1, 'Сортування', 'sortuvannya', '', 'Сортування в каталозі', '', '', NULL, NULL),
(10257, 10272, 1, 'Популярні', 'populyarni', '', 'Популярні', '', '', NULL, NULL),
(10258, 10273, 1, 'Спочатку дешеві', 'spochatku-deshevi', '', 'Спочатку дешеві', '', '', NULL, NULL),
(10259, 10274, 1, 'Спочатку дорогі', 'spochatku-dorogi', '', 'Спочатку дорогі', '', '', NULL, NULL),
(10260, 10275, 1, 'Тільки наявні', 'til-ky-nayavni', '', 'Тільки наявні', '', '', NULL, NULL),
(10261, 8, 1, 'Пошук по магазину', 'poshuk-po-magazynu', '', 'Пошук по магазину', '', '', '', ''),
(10262, 9, 1, 'Оформити замовлення ', 'oformyty-zamovlennya', '', 'Оформити замовлення', '', '', '', ''),
(10263, 10, 1, 'Кошик', 'cart', '', 'Кошик', '', '', '', ''),
(10264, 11, 1, '404', '404', '', '404', '', '', '', ''),
(10265, 12, 1, 'Список бажань', 'akkaunt/spysok-bazhan', '', 'Список бажань', '', '', '', ''),
(10266, 10277, 1, 'Успішне замовлення', 'uspishne-zamovlennya', '', 'Успішне замовлення', '', '', '', '<p>Ваше замовлення прийнято. Ви можете переглянути його в особистому кабінеті. Також на вашу скриньку надіслоно повідмолення з інформаціїю про замовлення.&nbsp;</p>\n'),
(10277, 10288, 1, 'Назва', 'nazva', NULL, NULL, NULL, NULL, NULL, NULL),
(10278, 10289, 1, 'Запчастини для мобільних телефонів', 'zapchastyny-dlya-mobilnykh-telefoniv', NULL, NULL, NULL, NULL, NULL, NULL),
(10279, 10290, 1, 'LCD', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd', NULL, NULL, NULL, NULL, NULL, NULL),
(10280, 10291, 1, 'Nokia, Microsoft', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/nokia-microsoft', NULL, NULL, NULL, NULL, NULL, NULL),
(10281, 10292, 1, 'Копія AАA клас', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/nokia-microsoft/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10282, 10293, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/nokia-microsoft/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10283, 10294, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/nokia-microsoft/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10284, 10295, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/nokia-microsoft/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10285, 10296, 1, 'Samsung', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(10286, 10297, 1, 'Копія AАA клас', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/samsung/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10287, 10298, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/samsung/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10288, 10299, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/samsung/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10289, 10300, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/samsung/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10290, 10301, 1, 'Sony', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/sony', NULL, NULL, NULL, NULL, NULL, NULL),
(10291, 10302, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/sony/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10292, 10303, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/sony/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10293, 10304, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/sony/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10294, 10305, 1, 'Sony Ericsson', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/sony-ericsson', NULL, NULL, NULL, NULL, NULL, NULL),
(10295, 10306, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/sony-ericsson/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10296, 10307, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/sony-ericsson/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10297, 10308, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/sony-ericsson/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10298, 10309, 1, 'LG', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/lg', NULL, NULL, NULL, NULL, NULL, NULL),
(10299, 10310, 1, 'Копія AАA клас', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/lg/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10300, 10311, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/lg/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10301, 10312, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/lg/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10302, 10313, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/lg/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10303, 10314, 1, 'Motorola', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/motorola', NULL, NULL, NULL, NULL, NULL, NULL),
(10304, 10315, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/motorola/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10305, 10316, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/motorola/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10306, 10317, 1, 'Siemens', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/siemens', NULL, NULL, NULL, NULL, NULL, NULL),
(10307, 10318, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/siemens/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10308, 10319, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/siemens/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10309, 10320, 1, 'Benq Siemens', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/benq-siemens', NULL, NULL, NULL, NULL, NULL, NULL),
(10310, 10321, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/benq-siemens/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10311, 10322, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/benq-siemens/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10312, 10323, 1, 'HTC', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/htc', NULL, NULL, NULL, NULL, NULL, NULL),
(10313, 10324, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/htc/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10314, 10325, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/htc/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10315, 10326, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/htc/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10316, 10327, 1, 'Asus', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/asus', NULL, NULL, NULL, NULL, NULL, NULL),
(10317, 10328, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/asus/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10318, 10329, 1, 'Apple', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/apple', NULL, NULL, NULL, NULL, NULL, NULL),
(10319, 10330, 1, 'Копія AАA клас', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/apple/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10320, 10331, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/apple/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10321, 10332, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/apple/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10322, 10333, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/apple/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10323, 10334, 1, 'Philips', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/philips', NULL, NULL, NULL, NULL, NULL, NULL),
(10324, 10335, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/philips/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10325, 10336, 1, 'Panasonic', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/panasonic', NULL, NULL, NULL, NULL, NULL, NULL),
(10326, 10337, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/panasonic/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10327, 10338, 1, 'Fly', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/fly', NULL, NULL, NULL, NULL, NULL, NULL),
(10328, 10339, 1, 'Alcatel', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/alcatel', NULL, NULL, NULL, NULL, NULL, NULL),
(10329, 10340, 1, 'Blackberry', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/blackberry', NULL, NULL, NULL, NULL, NULL, NULL),
(10330, 10341, 1, 'Lenovo', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/lenovo', NULL, NULL, NULL, NULL, NULL, NULL),
(10331, 10342, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/lenovo/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10332, 10343, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/lenovo/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10333, 10344, 1, 'ZOPO', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/zopo', NULL, NULL, NULL, NULL, NULL, NULL),
(10334, 10345, 1, 'Huawei', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/huawei', NULL, NULL, NULL, NULL, NULL, NULL),
(10335, 10346, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/huawei/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10336, 10347, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/huawei/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10337, 10348, 1, 'Sagem', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/sagem', NULL, NULL, NULL, NULL, NULL, NULL),
(10338, 10349, 1, 'Acer', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/acer', NULL, NULL, NULL, NULL, NULL, NULL),
(10339, 10350, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/acer/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10340, 10351, 1, 'Prestigio', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/prestigio', NULL, NULL, NULL, NULL, NULL, NULL),
(10341, 10352, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/prestigio/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10342, 10353, 1, 'China', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/china', NULL, NULL, NULL, NULL, NULL, NULL),
(10343, 10354, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/china/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10344, 10355, 1, 'Xiaomi', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/xiaomi', NULL, NULL, NULL, NULL, NULL, NULL),
(10345, 10356, 1, 'Meizu', 'zapchastyny-dlya-mobilnykh-telefoniv/lcd/meizu', NULL, NULL, NULL, NULL, NULL, NULL),
(10346, 10357, 1, 'Touchscreen', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen', NULL, NULL, NULL, NULL, NULL, NULL),
(10347, 10358, 1, 'Nokia', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/nokia', NULL, NULL, NULL, NULL, NULL, NULL),
(10348, 10359, 1, 'Копія AАA клас', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/nokia/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10349, 10360, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/nokia/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10350, 10361, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/nokia/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10351, 10362, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/nokia/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10352, 10363, 1, 'Samsung', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(10353, 10364, 1, 'Копія AАA клас', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/samsung/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10354, 10365, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/samsung/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10355, 10366, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/samsung/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10356, 10367, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/samsung/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10357, 10368, 1, 'Sony', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/sony', NULL, NULL, NULL, NULL, NULL, NULL),
(10358, 10369, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/sony/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10359, 10370, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/sony/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10360, 10371, 1, 'Sony Ericsson', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/sony-ericsson', NULL, NULL, NULL, NULL, NULL, NULL),
(10361, 10372, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/sony-ericsson/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10362, 10373, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/sony-ericsson/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10363, 10374, 1, 'Копія ААА клас', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/sony-ericsson/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10364, 10375, 1, 'LG', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/lg', NULL, NULL, NULL, NULL, NULL, NULL),
(10365, 10376, 1, 'Копія AАA клас', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/lg/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10366, 10377, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/lg/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10367, 10378, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/lg/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10368, 10379, 1, 'Acer', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/acer', NULL, NULL, NULL, NULL, NULL, NULL),
(10369, 10380, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/acer/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10370, 10381, 1, 'HTC', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/htc', NULL, NULL, NULL, NULL, NULL, NULL),
(10371, 10382, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/htc/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10372, 10383, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/htc/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10373, 10384, 1, 'Qtek', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/qtek', NULL, NULL, NULL, NULL, NULL, NULL),
(10374, 10385, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/qtek/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10375, 10386, 1, 'Motorola', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/motorola', NULL, NULL, NULL, NULL, NULL, NULL),
(10376, 10387, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/motorola/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10377, 10388, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/motorola/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10378, 10389, 1, 'Asus', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/asus', NULL, NULL, NULL, NULL, NULL, NULL),
(10379, 10390, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/asus/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10380, 10391, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/asus/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10381, 10392, 1, 'Apple', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/apple', NULL, NULL, NULL, NULL, NULL, NULL),
(10382, 10393, 1, 'Копія AАA клас', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/apple/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10383, 10394, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/apple/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10384, 10395, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/apple/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10385, 10396, 1, 'Fly', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/fly', NULL, NULL, NULL, NULL, NULL, NULL),
(10386, 10397, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/fly/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10387, 10398, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/fly/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10388, 10399, 1, 'Huawei', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/huawei', NULL, NULL, NULL, NULL, NULL, NULL),
(10389, 10400, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/huawei/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10390, 10401, 1, 'Lenovo', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/lenovo', NULL, NULL, NULL, NULL, NULL, NULL),
(10391, 10402, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/lenovo/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10392, 10403, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/lenovo/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10393, 10404, 1, 'Chinese', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/chinese', NULL, NULL, NULL, NULL, NULL, NULL),
(10394, 10405, 1, 'ZTE', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/zte', NULL, NULL, NULL, NULL, NULL, NULL),
(10395, 10406, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/zte/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10396, 10407, 1, 'Prestigio', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/prestigio', NULL, NULL, NULL, NULL, NULL, NULL),
(10397, 10408, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/prestigio/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10398, 10409, 1, 'Alcatel', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/alcatel', NULL, NULL, NULL, NULL, NULL, NULL),
(10399, 10410, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/alcatel/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10400, 10411, 1, 'Philips', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/philips', NULL, NULL, NULL, NULL, NULL, NULL),
(10401, 10412, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/touchscreen/philips/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10402, 10413, 1, 'Шлейфи', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy', NULL, NULL, NULL, NULL, NULL, NULL),
(10403, 10414, 1, 'Nokia', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/nokia', NULL, NULL, NULL, NULL, NULL, NULL),
(10404, 10415, 1, 'Копія AАA клас', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/nokia/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10405, 10416, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/nokia/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10406, 10417, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/nokia/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10407, 10418, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/nokia/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10408, 10419, 1, 'Samsung', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(10409, 10420, 1, 'Копія AАA клас', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/samsung/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10410, 10421, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/samsung/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10411, 10422, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/samsung/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10412, 10423, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/samsung/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10413, 10424, 1, 'Sony Ericsson', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/sony-ericsson', NULL, NULL, NULL, NULL, NULL, NULL),
(10414, 10425, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/sony-ericsson/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10415, 10426, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/sony-ericsson/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10416, 10427, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/sony-ericsson/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10417, 10428, 1, 'LG', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/lg', NULL, NULL, NULL, NULL, NULL, NULL),
(10418, 10429, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/lg/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10419, 10430, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/lg/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10420, 10431, 1, 'Motorola', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/motorola', NULL, NULL, NULL, NULL, NULL, NULL),
(10421, 10432, 1, 'Копія AАA клас', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/motorola/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10422, 10433, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/motorola/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10423, 10434, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/motorola/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10424, 10435, 1, 'Siemens', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/siemens', NULL, NULL, NULL, NULL, NULL, NULL),
(10425, 10436, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/siemens/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10426, 10437, 1, 'Fly', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/fly', NULL, NULL, NULL, NULL, NULL, NULL),
(10427, 10438, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/fly/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10428, 10439, 1, 'Apple', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/apple', NULL, NULL, NULL, NULL, NULL, NULL),
(10429, 10440, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/apple/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10430, 10441, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/apple/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10431, 10442, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/apple/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10432, 10443, 1, 'Philips', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/philips', NULL, NULL, NULL, NULL, NULL, NULL),
(10433, 10444, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/philips/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10434, 10445, 1, 'ASUS', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/asus', NULL, NULL, NULL, NULL, NULL, NULL),
(10435, 10446, 1, 'HTC', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/htc', NULL, NULL, NULL, NULL, NULL, NULL),
(10436, 10447, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/htc/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10437, 10448, 1, 'Lenovo', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/lenovo', NULL, NULL, NULL, NULL, NULL, NULL),
(10438, 10449, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/shleyfy/lenovo/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10439, 10450, 1, 'Клавіатурні модулі', 'zapchastyny-dlya-mobilnykh-telefoniv/klaviaturni-moduli', NULL, NULL, NULL, NULL, NULL, NULL),
(10440, 10451, 1, 'Nokia', 'zapchastyny-dlya-mobilnykh-telefoniv/klaviaturni-moduli/nokia', NULL, NULL, NULL, NULL, NULL, NULL),
(10441, 10452, 1, 'Копія AАA клас', 'zapchastyny-dlya-mobilnykh-telefoniv/klaviaturni-moduli/nokia/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10442, 10453, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/klaviaturni-moduli/nokia/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10443, 10454, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/klaviaturni-moduli/nokia/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10444, 10455, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/klaviaturni-moduli/nokia/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10445, 10456, 1, 'Samsung', 'zapchastyny-dlya-mobilnykh-telefoniv/klaviaturni-moduli/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(10446, 10457, 1, 'Копія AАA клас', 'zapchastyny-dlya-mobilnykh-telefoniv/klaviaturni-moduli/samsung/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10447, 10458, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/klaviaturni-moduli/samsung/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10448, 10459, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/klaviaturni-moduli/samsung/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10449, 10460, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/klaviaturni-moduli/samsung/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10450, 10461, 1, 'Sony Ericsson', 'zapchastyny-dlya-mobilnykh-telefoniv/klaviaturni-moduli/sony-ericsson', NULL, NULL, NULL, NULL, NULL, NULL),
(10451, 10462, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/klaviaturni-moduli/sony-ericsson/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10452, 10463, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/klaviaturni-moduli/sony-ericsson/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10453, 10464, 1, 'Motorola', 'zapchastyny-dlya-mobilnykh-telefoniv/klaviaturni-moduli/motorola', NULL, NULL, NULL, NULL, NULL, NULL),
(10454, 10465, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/klaviaturni-moduli/motorola/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10455, 10466, 1, 'LG', 'zapchastyny-dlya-mobilnykh-telefoniv/klaviaturni-moduli/lg', NULL, NULL, NULL, NULL, NULL, NULL),
(10456, 10467, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/klaviaturni-moduli/lg/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10457, 10468, 1, 'Siemens', 'zapchastyny-dlya-mobilnykh-telefoniv/klaviaturni-moduli/siemens', NULL, NULL, NULL, NULL, NULL, NULL),
(10458, 10469, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/klaviaturni-moduli/siemens/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10459, 10470, 1, 'Sagem', 'zapchastyny-dlya-mobilnykh-telefoniv/klaviaturni-moduli/sagem', NULL, NULL, NULL, NULL, NULL, NULL),
(10460, 10471, 1, 'HTC', 'zapchastyny-dlya-mobilnykh-telefoniv/klaviaturni-moduli/htc', NULL, NULL, NULL, NULL, NULL, NULL),
(10461, 10472, 1, 'Динаміки бузера', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera', NULL, NULL, NULL, NULL, NULL, NULL),
(10462, 10473, 1, 'Apple', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/apple', NULL, NULL, NULL, NULL, NULL, NULL),
(10463, 10474, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/apple/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10464, 10475, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/apple/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10465, 10476, 1, 'Nokia', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/nokia', NULL, NULL, NULL, NULL, NULL, NULL),
(10466, 10477, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/nokia/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10467, 10478, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/nokia/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10468, 10479, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/nokia/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10469, 10480, 1, 'Samsung', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(10470, 10481, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/samsung/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10471, 10482, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/samsung/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10472, 10483, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/samsung/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10473, 10484, 1, 'Sony Ericsson', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/sony-ericsson', NULL, NULL, NULL, NULL, NULL, NULL),
(10474, 10485, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/sony-ericsson/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10475, 10486, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/sony-ericsson/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10476, 10487, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/sony-ericsson/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10477, 10488, 1, 'LG', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/lg', NULL, NULL, NULL, NULL, NULL, NULL),
(10478, 10489, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/lg/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10479, 10490, 1, 'Siemens', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/siemens', NULL, NULL, NULL, NULL, NULL, NULL),
(10480, 10491, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/siemens/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10481, 10492, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/siemens/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10482, 10493, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/siemens/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10483, 10494, 1, 'Motorola', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/motorola', NULL, NULL, NULL, NULL, NULL, NULL),
(10484, 10495, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/motorola/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10485, 10496, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/motorola/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10486, 10497, 1, 'Panasonic', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/panasonic', NULL, NULL, NULL, NULL, NULL, NULL),
(10487, 10498, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/panasonic/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10488, 10499, 1, 'HTC', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/htc', NULL, NULL, NULL, NULL, NULL, NULL),
(10489, 10500, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/htc/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10490, 10501, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/htc/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10491, 10502, 1, 'Alcatel', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/alcatel', NULL, NULL, NULL, NULL, NULL, NULL),
(10492, 10503, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/alcatel/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10493, 10504, 1, 'Sagem', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/sagem', NULL, NULL, NULL, NULL, NULL, NULL),
(10494, 10505, 1, 'FLY', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/fly', NULL, NULL, NULL, NULL, NULL, NULL),
(10495, 10506, 1, 'Asus', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-buzera/asus', NULL, NULL, NULL, NULL, NULL, NULL),
(10496, 10507, 1, 'Динаміки спікера', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-spikera', NULL, NULL, NULL, NULL, NULL, NULL),
(10497, 10508, 1, 'Apple', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-spikera/apple', NULL, NULL, NULL, NULL, NULL, NULL),
(10498, 10509, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-spikera/apple/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10499, 10510, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-spikera/apple/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10500, 10511, 1, 'Nokia', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-spikera/nokia', NULL, NULL, NULL, NULL, NULL, NULL),
(10501, 10512, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-spikera/nokia/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10502, 10513, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-spikera/nokia/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10503, 10514, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-spikera/nokia/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10504, 10515, 1, 'Samsung', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-spikera/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(10505, 10516, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-spikera/samsung/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10506, 10517, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-spikera/samsung/original-tw', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `e_content_info` (`id`, `content_id`, `languages_id`, `name`, `url`, `h1`, `title`, `keywords`, `description`, `intro`, `content`) VALUES
(10507, 10518, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-spikera/samsung/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10508, 10519, 1, 'Sony Ericsson', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-spikera/sony-ericsson', NULL, NULL, NULL, NULL, NULL, NULL),
(10509, 10520, 1, 'LG', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-spikera/lg', NULL, NULL, NULL, NULL, NULL, NULL),
(10510, 10521, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-spikera/lg/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10511, 10522, 1, 'Siemens', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-spikera/siemens', NULL, NULL, NULL, NULL, NULL, NULL),
(10512, 10523, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-spikera/siemens/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10513, 10524, 1, 'Motorola', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-spikera/motorola', NULL, NULL, NULL, NULL, NULL, NULL),
(10514, 10525, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-spikera/motorola/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10515, 10526, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-spikera/motorola/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10516, 10527, 1, 'Універсальні', 'zapchastyny-dlya-mobilnykh-telefoniv/dynamiky-spikera/universalni', NULL, NULL, NULL, NULL, NULL, NULL),
(10517, 10528, 1, 'Мікрофони', 'zapchastyny-dlya-mobilnykh-telefoniv/mikrofony', NULL, NULL, NULL, NULL, NULL, NULL),
(10518, 10529, 1, 'Nokia', 'zapchastyny-dlya-mobilnykh-telefoniv/mikrofony/nokia', NULL, NULL, NULL, NULL, NULL, NULL),
(10519, 10530, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/mikrofony/nokia/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10520, 10531, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/mikrofony/nokia/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10521, 10532, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/mikrofony/nokia/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10522, 10533, 1, 'Samsung', 'zapchastyny-dlya-mobilnykh-telefoniv/mikrofony/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(10523, 10534, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/mikrofony/samsung/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10524, 10535, 1, 'High Copy', 'zapchastyny-dlya-mobilnykh-telefoniv/mikrofony/samsung/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10525, 10536, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/mikrofony/samsung/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10526, 10537, 1, 'Sony Ericsson', 'zapchastyny-dlya-mobilnykh-telefoniv/mikrofony/sony-ericsson', NULL, NULL, NULL, NULL, NULL, NULL),
(10527, 10538, 1, 'Original TW, Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/mikrofony/sony-ericsson/original-tw-original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10528, 10539, 1, 'Motorola', 'zapchastyny-dlya-mobilnykh-telefoniv/mikrofony/motorola', NULL, NULL, NULL, NULL, NULL, NULL),
(10529, 10540, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/mikrofony/motorola/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10530, 10541, 1, 'Siemens', 'zapchastyny-dlya-mobilnykh-telefoniv/mikrofony/siemens', NULL, NULL, NULL, NULL, NULL, NULL),
(10531, 10542, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/mikrofony/siemens/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10532, 10543, 1, 'Original 100%', 'zapchastyny-dlya-mobilnykh-telefoniv/mikrofony/siemens/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10533, 10544, 1, 'LG', 'zapchastyny-dlya-mobilnykh-telefoniv/mikrofony/lg', NULL, NULL, NULL, NULL, NULL, NULL),
(10534, 10545, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/mikrofony/lg/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10535, 10546, 1, 'Apple', 'zapchastyny-dlya-mobilnykh-telefoniv/mikrofony/apple', NULL, NULL, NULL, NULL, NULL, NULL),
(10536, 10547, 1, 'Original TW', 'zapchastyny-dlya-mobilnykh-telefoniv/mikrofony/apple/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10537, 10548, 1, 'Універсальні', 'zapchastyny-dlya-mobilnykh-telefoniv/mikrofony/universalni', NULL, NULL, NULL, NULL, NULL, NULL),
(10538, 10549, 1, 'Panasonic', 'zapchastyny-dlya-mobilnykh-telefoniv/mikrofony/panasonic', NULL, NULL, NULL, NULL, NULL, NULL),
(10539, 10550, 1, 'Xiaomi', 'zapchastyny-dlya-mobilnykh-telefoniv/mikrofony/xiaomi', NULL, NULL, NULL, NULL, NULL, NULL),
(10540, 10551, 1, 'Джойстики', 'zapchastyny-dlya-mobilnykh-telefoniv/dzhoystyky', NULL, NULL, NULL, NULL, NULL, NULL),
(10541, 10552, 1, 'Вимикачі', 'zapchastyny-dlya-mobilnykh-telefoniv/vymykachi', NULL, NULL, NULL, NULL, NULL, NULL),
(10542, 10553, 1, 'Розєми та контакти', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty', NULL, NULL, NULL, NULL, NULL, NULL),
(10543, 10554, 1, 'Конектори SIM та Memory Card', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/konektory-sim-ta-memory-card', NULL, NULL, NULL, NULL, NULL, NULL),
(10544, 10555, 1, 'Nokia', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/konektory-sim-ta-memory-card/nokia', NULL, NULL, NULL, NULL, NULL, NULL),
(10545, 10556, 1, 'Samsung', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/konektory-sim-ta-memory-card/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(10546, 10557, 1, 'Siemens', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/konektory-sim-ta-memory-card/siemens', NULL, NULL, NULL, NULL, NULL, NULL),
(10547, 10558, 1, 'Lenovo', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/konektory-sim-ta-memory-card/lenovo', NULL, NULL, NULL, NULL, NULL, NULL),
(10548, 10559, 1, 'Huawei', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/konektory-sim-ta-memory-card/huawei', NULL, NULL, NULL, NULL, NULL, NULL),
(10549, 10560, 1, 'Asus', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/konektory-sim-ta-memory-card/asus', NULL, NULL, NULL, NULL, NULL, NULL),
(10550, 10561, 1, 'Конектор LCD', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/konektor-lcd', NULL, NULL, NULL, NULL, NULL, NULL),
(10551, 10562, 1, 'Конектор шлейфа', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/konektor-shleyfa', NULL, NULL, NULL, NULL, NULL, NULL),
(10552, 10563, 1, 'Контакти під батарею', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/kontakty-pid-batareyu', NULL, NULL, NULL, NULL, NULL, NULL),
(10553, 10564, 1, 'Роз`єм HF', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/rozem-hf', NULL, NULL, NULL, NULL, NULL, NULL),
(10554, 10565, 1, 'Samsung', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/rozem-hf/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(10555, 10566, 1, 'Nokia', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/rozem-hf/nokia', NULL, NULL, NULL, NULL, NULL, NULL),
(10556, 10567, 1, 'Роз`єм зарядки', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/rozem-zaryadky', NULL, NULL, NULL, NULL, NULL, NULL),
(10557, 10568, 1, 'Nokia', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/rozem-zaryadky/nokia', NULL, NULL, NULL, NULL, NULL, NULL),
(10558, 10569, 1, 'Samsung', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/rozem-zaryadky/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(10559, 10570, 1, 'Sony, Sony Ericsson', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/rozem-zaryadky/sony-sony-ericsson', NULL, NULL, NULL, NULL, NULL, NULL),
(10560, 10571, 1, 'Motorola', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/rozem-zaryadky/motorola', NULL, NULL, NULL, NULL, NULL, NULL),
(10561, 10572, 1, 'Siemens', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/rozem-zaryadky/siemens', NULL, NULL, NULL, NULL, NULL, NULL),
(10562, 10573, 1, 'LG', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/rozem-zaryadky/lg', NULL, NULL, NULL, NULL, NULL, NULL),
(10563, 10574, 1, 'Lenovo', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/rozem-zaryadky/lenovo', NULL, NULL, NULL, NULL, NULL, NULL),
(10564, 10575, 1, 'HTC', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/rozem-zaryadky/htc', NULL, NULL, NULL, NULL, NULL, NULL),
(10565, 10576, 1, 'Fly', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/rozem-zaryadky/fly', NULL, NULL, NULL, NULL, NULL, NULL),
(10566, 10577, 1, 'Різне', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/rozem-zaryadky/rizne', NULL, NULL, NULL, NULL, NULL, NULL),
(10567, 10578, 1, 'Huawei', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/rozem-zaryadky/huawei', NULL, NULL, NULL, NULL, NULL, NULL),
(10568, 10579, 1, 'Asus', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/rozem-zaryadky/asus', NULL, NULL, NULL, NULL, NULL, NULL),
(10569, 10580, 1, 'Універсальні', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/rozem-zaryadky/universalni', NULL, NULL, NULL, NULL, NULL, NULL),
(10570, 10581, 1, 'Слот карти памяті', 'zapchastyny-dlya-mobilnykh-telefoniv/rozemy-ta-kontakty/slot-karty-pamyati', NULL, NULL, NULL, NULL, NULL, NULL),
(10571, 10582, 1, 'Мікросхеми, плати', 'zapchastyny-dlya-mobilnykh-telefoniv/mikroskhemy-platy', NULL, NULL, NULL, NULL, NULL, NULL),
(10572, 10583, 1, 'Контроллер живлення', 'zapchastyny-dlya-mobilnykh-telefoniv/mikroskhemy-platy/kontroller-zhyvlennya', NULL, NULL, NULL, NULL, NULL, NULL),
(10573, 10584, 1, 'Драйвер підсвітки', 'zapchastyny-dlya-mobilnykh-telefoniv/mikroskhemy-platy/drayver-pidsvitky', NULL, NULL, NULL, NULL, NULL, NULL),
(10574, 10585, 1, 'Процесор', 'zapchastyny-dlya-mobilnykh-telefoniv/mikroskhemy-platy/protsesor', NULL, NULL, NULL, NULL, NULL, NULL),
(10575, 10586, 1, 'Підсилювач потужності', 'zapchastyny-dlya-mobilnykh-telefoniv/mikroskhemy-platy/pidsylyuvach-potuzhnosti', NULL, NULL, NULL, NULL, NULL, NULL),
(10576, 10587, 1, 'Плати', 'zapchastyny-dlya-mobilnykh-telefoniv/mikroskhemy-platy/platy', NULL, NULL, NULL, NULL, NULL, NULL),
(10577, 10588, 1, 'Корпусні частини', 'zapchastyny-dlya-mobilnykh-telefoniv/korpusni-chastyny', NULL, NULL, NULL, NULL, NULL, NULL),
(10578, 10589, 1, 'Вібромотори', 'zapchastyny-dlya-mobilnykh-telefoniv/korpusni-chastyny/vibromotory', NULL, NULL, NULL, NULL, NULL, NULL),
(10579, 10590, 1, 'Гвинти, саморізи', 'zapchastyny-dlya-mobilnykh-telefoniv/korpusni-chastyny/gvynty-samorizy', NULL, NULL, NULL, NULL, NULL, NULL),
(10580, 10591, 1, 'Тримачі для SIM карти', 'zapchastyny-dlya-mobilnykh-telefoniv/korpusni-chastyny/trymachi-dlya-sim-karty', NULL, NULL, NULL, NULL, NULL, NULL),
(10581, 10592, 1, 'Задні кришки', 'zapchastyny-dlya-mobilnykh-telefoniv/korpusni-chastyny/zadni-kryshky', NULL, NULL, NULL, NULL, NULL, NULL),
(10582, 10593, 1, 'Бокові кнопки', 'zapchastyny-dlya-mobilnykh-telefoniv/korpusni-chastyny/bokovi-knopky', NULL, NULL, NULL, NULL, NULL, NULL),
(10583, 10594, 1, 'Ковпачок на джойстик', 'zapchastyny-dlya-mobilnykh-telefoniv/korpusni-chastyny/kovpachok-na-dzhoystyk', NULL, NULL, NULL, NULL, NULL, NULL),
(10584, 10595, 1, 'Зовнішні кнопки різні', 'zapchastyny-dlya-mobilnykh-telefoniv/korpusni-chastyny/zovnishni-knopky-rizni', NULL, NULL, NULL, NULL, NULL, NULL),
(10585, 10596, 1, 'Поворотно-розсувні механізми', 'zapchastyny-dlya-mobilnykh-telefoniv/korpusni-chastyny/povorotno-rozsuvni-mekhanizmy', NULL, NULL, NULL, NULL, NULL, NULL),
(10586, 10597, 1, 'Середня частина корпуса', 'zapchastyny-dlya-mobilnykh-telefoniv/korpusni-chastyny/serednya-chastyna-korpusa', NULL, NULL, NULL, NULL, NULL, NULL),
(10587, 10598, 1, 'Різне', 'zapchastyny-dlya-mobilnykh-telefoniv/korpusni-chastyny/rizne', NULL, NULL, NULL, NULL, NULL, NULL),
(10588, 10599, 1, 'Рамки для LCD', 'zapchastyny-dlya-mobilnykh-telefoniv/korpusni-chastyny/ramky-dlya-lcd', NULL, NULL, NULL, NULL, NULL, NULL),
(10589, 10600, 1, 'iPhone', 'zapchastyny-dlya-mobilnykh-telefoniv/korpusni-chastyny/ramky-dlya-lcd/iphone', NULL, NULL, NULL, NULL, NULL, NULL),
(10590, 10601, 1, 'Скло', 'zapchastyny-dlya-mobilnykh-telefoniv/korpusni-chastyny/sklo', NULL, NULL, NULL, NULL, NULL, NULL),
(10591, 10602, 1, 'Антени', 'zapchastyny-dlya-mobilnykh-telefoniv/anteny', NULL, NULL, NULL, NULL, NULL, NULL),
(10592, 10603, 1, 'Камери', 'zapchastyny-dlya-mobilnykh-telefoniv/kamery', NULL, NULL, NULL, NULL, NULL, NULL),
(10593, 10604, 1, 'Nokia', 'zapchastyny-dlya-mobilnykh-telefoniv/kamery/nokia', NULL, NULL, NULL, NULL, NULL, NULL),
(10594, 10605, 1, 'Samsung', 'zapchastyny-dlya-mobilnykh-telefoniv/kamery/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(10595, 10606, 1, 'Sony Ericsson', 'zapchastyny-dlya-mobilnykh-telefoniv/kamery/sony-ericsson', NULL, NULL, NULL, NULL, NULL, NULL),
(10596, 10607, 1, 'Apple', 'zapchastyny-dlya-mobilnykh-telefoniv/kamery/apple', NULL, NULL, NULL, NULL, NULL, NULL),
(10597, 10608, 1, 'Siemens', 'zapchastyny-dlya-mobilnykh-telefoniv/kamery/siemens', NULL, NULL, NULL, NULL, NULL, NULL),
(10598, 10609, 1, 'Sagem', 'zapchastyny-dlya-mobilnykh-telefoniv/kamery/sagem', NULL, NULL, NULL, NULL, NULL, NULL),
(10599, 10610, 1, 'Motorola', 'zapchastyny-dlya-mobilnykh-telefoniv/kamery/motorola', NULL, NULL, NULL, NULL, NULL, NULL),
(10600, 10611, 1, 'Запчастини Apple Used', 'zapchastyny-dlya-mobilnykh-telefoniv/zapchastyny-apple-used', NULL, NULL, NULL, NULL, NULL, NULL),
(10601, 10612, 1, 'Запчастини для фото-, відео- камер', 'zapchastyny-dlya-mobilnykh-telefoniv/zapchastyny-dlya-foto--video--kamer', NULL, NULL, NULL, NULL, NULL, NULL),
(10602, 10613, 1, 'LCD', 'zapchastyny-dlya-mobilnykh-telefoniv/zapchastyny-dlya-foto--video--kamer/lcd', NULL, NULL, NULL, NULL, NULL, NULL),
(10603, 10614, 1, 'Samsung', 'zapchastyny-dlya-mobilnykh-telefoniv/zapchastyny-dlya-foto--video--kamer/lcd/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(10604, 10615, 1, 'Корпуса', 'korpusa', NULL, NULL, NULL, NULL, NULL, NULL),
(10605, 10616, 1, 'Nokia', 'korpusa/nokia', NULL, NULL, NULL, NULL, NULL, NULL),
(10606, 10617, 1, 'Копія АА клас', 'korpusa/nokia/kopiya-aa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10607, 10618, 1, 'Копія ААА клас', 'korpusa/nokia/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10608, 10619, 1, 'High Copy', 'korpusa/nokia/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10609, 10620, 1, 'Original TW', 'korpusa/nokia/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10610, 10621, 1, '100% original', 'korpusa/nokia/100-original', NULL, NULL, NULL, NULL, NULL, NULL),
(10611, 10622, 1, 'Samsung', 'korpusa/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(10612, 10623, 1, 'Копія АА клас', 'korpusa/samsung/kopiya-aa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10613, 10624, 1, 'Копія ААА клас', 'korpusa/samsung/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10614, 10625, 1, 'High Copy', 'korpusa/samsung/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10615, 10626, 1, '100% original', 'korpusa/samsung/100-original', NULL, NULL, NULL, NULL, NULL, NULL),
(10616, 10627, 1, 'Apple', 'korpusa/apple', NULL, NULL, NULL, NULL, NULL, NULL),
(10617, 10628, 1, 'High Copy', 'korpusa/apple/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10618, 10629, 1, 'Original TW', 'korpusa/apple/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10619, 10630, 1, 'Siemens', 'korpusa/siemens', NULL, NULL, NULL, NULL, NULL, NULL),
(10620, 10631, 1, 'Копія АА клас', 'korpusa/siemens/kopiya-aa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10621, 10632, 1, 'Копія ААА клас', 'korpusa/siemens/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10622, 10633, 1, 'High Copy', 'korpusa/siemens/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10623, 10634, 1, 'Sony Ericsson', 'korpusa/sony-ericsson', NULL, NULL, NULL, NULL, NULL, NULL),
(10624, 10635, 1, 'Копія АА клас', 'korpusa/sony-ericsson/kopiya-aa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10625, 10636, 1, 'Копія ААА клас', 'korpusa/sony-ericsson/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10626, 10637, 1, 'High Copy', 'korpusa/sony-ericsson/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10627, 10638, 1, 'Original TW', 'korpusa/sony-ericsson/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10628, 10639, 1, 'Motorola', 'korpusa/motorola', NULL, NULL, NULL, NULL, NULL, NULL),
(10629, 10640, 1, 'Копія АА клас', 'korpusa/motorola/kopiya-aa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10630, 10641, 1, 'Копія ААА клас', 'korpusa/motorola/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10631, 10642, 1, 'High Copy', 'korpusa/motorola/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10632, 10643, 1, 'LG', 'korpusa/lg', NULL, NULL, NULL, NULL, NULL, NULL),
(10633, 10644, 1, 'Копія АА клас', 'korpusa/lg/kopiya-aa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10634, 10645, 1, 'Копія ААА клас', 'korpusa/lg/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10635, 10646, 1, 'High Copy', 'korpusa/lg/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10636, 10647, 1, 'Alcatel', 'korpusa/alcatel', NULL, NULL, NULL, NULL, NULL, NULL),
(10637, 10648, 1, 'Philips', 'korpusa/philips', NULL, NULL, NULL, NULL, NULL, NULL),
(10638, 10649, 1, 'Panasonic', 'korpusa/panasonic', NULL, NULL, NULL, NULL, NULL, NULL),
(10639, 10650, 1, 'Mitsubishi', 'korpusa/mitsubishi', NULL, NULL, NULL, NULL, NULL, NULL),
(10640, 10651, 1, 'Sagem', 'korpusa/sagem', NULL, NULL, NULL, NULL, NULL, NULL),
(10641, 10652, 1, 'Sony', 'korpusa/sony', NULL, NULL, NULL, NULL, NULL, NULL),
(10642, 10653, 1, 'Ericsson', 'korpusa/ericsson', NULL, NULL, NULL, NULL, NULL, NULL),
(10643, 10654, 1, 'Fly', 'korpusa/fly', NULL, NULL, NULL, NULL, NULL, NULL),
(10644, 10655, 1, 'HTC', 'korpusa/htc', NULL, NULL, NULL, NULL, NULL, NULL),
(10645, 10656, 1, 'Копія АА клас', 'korpusa/htc/kopiya-aa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10646, 10657, 1, 'Копія ААА клас', 'korpusa/htc/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10647, 10658, 1, 'High Copy', 'korpusa/htc/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10648, 10659, 1, 'Клавіатура', 'klaviatura', NULL, NULL, NULL, NULL, NULL, NULL),
(10649, 10660, 1, 'Nokia', 'klaviatura/nokia', NULL, NULL, NULL, NULL, NULL, NULL),
(10650, 10661, 1, 'High Copy', 'klaviatura/nokia/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10651, 10662, 1, 'Original TW', 'klaviatura/nokia/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10652, 10663, 1, 'Original 100%', 'klaviatura/nokia/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10653, 10664, 1, 'Samsung', 'klaviatura/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(10654, 10665, 1, 'High Copy', 'klaviatura/samsung/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10655, 10666, 1, 'Original TW', 'klaviatura/samsung/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10656, 10667, 1, 'Original 100%', 'klaviatura/samsung/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10657, 10668, 1, 'Siemens', 'klaviatura/siemens', NULL, NULL, NULL, NULL, NULL, NULL),
(10658, 10669, 1, 'High Copy', 'klaviatura/siemens/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10659, 10670, 1, 'Sony Ericsson', 'klaviatura/sony-ericsson', NULL, NULL, NULL, NULL, NULL, NULL),
(10660, 10671, 1, 'High Copy', 'klaviatura/sony-ericsson/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10661, 10672, 1, 'Original TW', 'klaviatura/sony-ericsson/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10662, 10673, 1, 'Motorola', 'klaviatura/motorola', NULL, NULL, NULL, NULL, NULL, NULL),
(10663, 10674, 1, 'High Copy', 'klaviatura/motorola/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10664, 10675, 1, 'Original TW', 'klaviatura/motorola/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10665, 10676, 1, 'Alcatel', 'klaviatura/alcatel', NULL, NULL, NULL, NULL, NULL, NULL),
(10666, 10677, 1, 'LG', 'klaviatura/lg', NULL, NULL, NULL, NULL, NULL, NULL),
(10667, 10678, 1, 'Original TW', 'klaviatura/lg/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10668, 10679, 1, 'Різне', 'klaviatura/rizne', NULL, NULL, NULL, NULL, NULL, NULL),
(10669, 10680, 1, 'HTC', 'klaviatura/htc', NULL, NULL, NULL, NULL, NULL, NULL),
(10670, 10681, 1, 'Елементи живлення, акумулятори', 'elementy-zhyvlennya-akumulyatory', NULL, NULL, NULL, NULL, NULL, NULL),
(10671, 10682, 1, 'Акумулятори для мобільних телефонів', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv', NULL, NULL, NULL, NULL, NULL, NULL),
(10672, 10683, 1, 'Apple', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/apple', NULL, NULL, NULL, NULL, NULL, NULL),
(10673, 10684, 1, 'Оригінал Euro2.2', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/apple/oryginal-euro22', NULL, NULL, NULL, NULL, NULL, NULL),
(10674, 10685, 1, 'Original TW', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/apple/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10675, 10686, 1, 'Samsung', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(10676, 10687, 1, 'Копія ААА клас Econom', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/samsung/kopiya-aaa-klas-econom', NULL, NULL, NULL, NULL, NULL, NULL),
(10677, 10688, 1, 'Копія ААА клас', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/samsung/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10678, 10689, 1, 'Оригінал Euro2.2', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/samsung/oryginal-euro22', NULL, NULL, NULL, NULL, NULL, NULL),
(10679, 10690, 1, 'Оригінал Euro2.2 Econom', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/samsung/oryginal-euro22-econom', NULL, NULL, NULL, NULL, NULL, NULL),
(10680, 10691, 1, 'Original TW', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/samsung/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10681, 10692, 1, 'Оригінал 100%', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/samsung/oryginal-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10682, 10693, 1, 'Підвищеної ємності', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/samsung/pidvyschenoyi-emnosti', NULL, NULL, NULL, NULL, NULL, NULL),
(10683, 10694, 1, 'Kvanta', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/samsung/pidvyschenoyi-emnosti/kvanta', NULL, NULL, NULL, NULL, NULL, NULL),
(10684, 10695, 1, 'VipPower', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/samsung/pidvyschenoyi-emnosti/vippower', NULL, NULL, NULL, NULL, NULL, NULL),
(10685, 10696, 1, 'Gelius', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/samsung/pidvyschenoyi-emnosti/gelius', NULL, NULL, NULL, NULL, NULL, NULL),
(10686, 10697, 1, '100% Power', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/samsung/pidvyschenoyi-emnosti/100-power', NULL, NULL, NULL, NULL, NULL, NULL),
(10687, 10698, 1, 'Nokia', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/nokia', NULL, NULL, NULL, NULL, NULL, NULL),
(10688, 10699, 1, 'Копія ААА клас', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/nokia/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10689, 10700, 1, 'Копія ААА клас Econom', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/nokia/kopiya-aaa-klas-econom', NULL, NULL, NULL, NULL, NULL, NULL),
(10690, 10701, 1, 'Оригінал Euro2.2', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/nokia/oryginal-euro22', NULL, NULL, NULL, NULL, NULL, NULL),
(10691, 10702, 1, 'Оригінал Euro 2.2 Econom', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/nokia/oryginal-euro-22-econom', NULL, NULL, NULL, NULL, NULL, NULL),
(10692, 10703, 1, 'Оригінал 100%', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/nokia/oryginal-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10693, 10704, 1, 'Підвищеної ємності', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/nokia/pidvyschenoyi-emnosti', NULL, NULL, NULL, NULL, NULL, NULL),
(10694, 10705, 1, 'Kvanta', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/nokia/pidvyschenoyi-emnosti/kvanta', NULL, NULL, NULL, NULL, NULL, NULL),
(10695, 10706, 1, '100% Power', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/nokia/pidvyschenoyi-emnosti/100-power', NULL, NULL, NULL, NULL, NULL, NULL),
(10696, 10707, 1, 'Yoobao', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/nokia/pidvyschenoyi-emnosti/yoobao', NULL, NULL, NULL, NULL, NULL, NULL),
(10697, 10708, 1, 'LG', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/lg', NULL, NULL, NULL, NULL, NULL, NULL),
(10698, 10709, 1, 'Копія ААА клас', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/lg/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10699, 10710, 1, 'Копія ААА клас Econom', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/lg/kopiya-aaa-klas-econom', NULL, NULL, NULL, NULL, NULL, NULL),
(10700, 10711, 1, 'Оригінал Euro2,2', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/lg/oryginal-euro22', NULL, NULL, NULL, NULL, NULL, NULL),
(10701, 10712, 1, 'Оригінал Euro2.2 Econom', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/lg/oryginal-euro22-econom', NULL, NULL, NULL, NULL, NULL, NULL),
(10702, 10713, 1, 'Original TW', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/lg/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10703, 10714, 1, 'Підвищеної ємності', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/lg/pidvyschenoyi-emnosti', NULL, NULL, NULL, NULL, NULL, NULL),
(10704, 10715, 1, 'Kvanta', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/lg/pidvyschenoyi-emnosti/kvanta', NULL, NULL, NULL, NULL, NULL, NULL),
(10705, 10716, 1, 'Sony/Sony Ericsson', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/sony-sony-ericsson', NULL, NULL, NULL, NULL, NULL, NULL),
(10706, 10717, 1, 'Копія ААА клас', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/sony-sony-ericsson/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10707, 10718, 1, 'Копія ААА клас Econom', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/sony-sony-ericsson/kopiya-aaa-klas-econom', NULL, NULL, NULL, NULL, NULL, NULL),
(10708, 10719, 1, 'Оригінал Euro2.2', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/sony-sony-ericsson/oryginal-euro22', NULL, NULL, NULL, NULL, NULL, NULL),
(10709, 10720, 1, 'Оригінал Euro2.2 Econom', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/sony-sony-ericsson/oryginal-euro22-econom', NULL, NULL, NULL, NULL, NULL, NULL),
(10710, 10721, 1, 'Original TW', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/sony-sony-ericsson/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10711, 10722, 1, 'Підвищеної ємності', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/sony-sony-ericsson/pidvyschenoyi-emnosti', NULL, NULL, NULL, NULL, NULL, NULL),
(10712, 10723, 1, 'Kvanta', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/sony-sony-ericsson/pidvyschenoyi-emnosti/kvanta', NULL, NULL, NULL, NULL, NULL, NULL),
(10713, 10724, 1, 'Vip Power (Graftman)', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/sony-sony-ericsson/pidvyschenoyi-emnosti/vip-power-graftman', NULL, NULL, NULL, NULL, NULL, NULL),
(10714, 10725, 1, 'Prowin', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/sony-sony-ericsson/pidvyschenoyi-emnosti/prowin', NULL, NULL, NULL, NULL, NULL, NULL),
(10715, 10726, 1, 'Yoobao', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/sony-sony-ericsson/pidvyschenoyi-emnosti/yoobao', NULL, NULL, NULL, NULL, NULL, NULL),
(10716, 10727, 1, 'Fly', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/fly', NULL, NULL, NULL, NULL, NULL, NULL),
(10717, 10728, 1, 'Original TW', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/fly/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10718, 10729, 1, 'Original', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/fly/original', NULL, NULL, NULL, NULL, NULL, NULL),
(10719, 10730, 1, 'Lenovo', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/lenovo', NULL, NULL, NULL, NULL, NULL, NULL),
(10720, 10731, 1, 'Оригінал Euro2.2', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/lenovo/oryginal-euro22', NULL, NULL, NULL, NULL, NULL, NULL),
(10721, 10732, 1, 'Підвищеної ємності', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/lenovo/pidvyschenoyi-emnosti', NULL, NULL, NULL, NULL, NULL, NULL),
(10722, 10733, 1, 'Original TW', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/lenovo/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10723, 10734, 1, 'PowerBank', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/powerbank', NULL, NULL, NULL, NULL, NULL, NULL),
(10724, 10735, 1, 'Універсальні', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/universalni', NULL, NULL, NULL, NULL, NULL, NULL),
(10725, 10736, 1, 'HTC', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/htc', NULL, NULL, NULL, NULL, NULL, NULL),
(10726, 10737, 1, 'Оригінал Euro 2.2', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/htc/oryginal-euro-22', NULL, NULL, NULL, NULL, NULL, NULL),
(10727, 10738, 1, 'Original TW', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/htc/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10728, 10739, 1, 'Підвищеної ємності', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/htc/pidvyschenoyi-emnosti', NULL, NULL, NULL, NULL, NULL, NULL),
(10729, 10740, 1, 'Kvanta', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/htc/pidvyschenoyi-emnosti/kvanta', NULL, NULL, NULL, NULL, NULL, NULL),
(10730, 10741, 1, 'Yoobao', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/htc/pidvyschenoyi-emnosti/yoobao', NULL, NULL, NULL, NULL, NULL, NULL),
(10731, 10742, 1, 'Prestigio', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/prestigio', NULL, NULL, NULL, NULL, NULL, NULL),
(10732, 10743, 1, 'Original TW', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/prestigio/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10733, 10744, 1, 'Huawei', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/huawei', NULL, NULL, NULL, NULL, NULL, NULL),
(10734, 10745, 1, 'Original TW', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/huawei/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10735, 10746, 1, 'Xiaomi', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/xiaomi', NULL, NULL, NULL, NULL, NULL, NULL),
(10736, 10747, 1, 'Meizu', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/meizu', NULL, NULL, NULL, NULL, NULL, NULL),
(10737, 10748, 1, 'Motorola', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/motorola', NULL, NULL, NULL, NULL, NULL, NULL),
(10738, 10749, 1, 'Копія AAA клас', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/motorola/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10739, 10750, 1, 'Копія AAA Econom', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/motorola/kopiya-aaa-econom', NULL, NULL, NULL, NULL, NULL, NULL),
(10740, 10751, 1, 'Оригінал Euro 2.2', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/motorola/oryginal-euro-22', NULL, NULL, NULL, NULL, NULL, NULL),
(10741, 10752, 1, 'Оригінал Euro 2.2 Econom', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/motorola/oryginal-euro-22-econom', NULL, NULL, NULL, NULL, NULL, NULL),
(10742, 10753, 1, 'Original TW', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/motorola/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10743, 10754, 1, 'BlackBerry', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/blackberry', NULL, NULL, NULL, NULL, NULL, NULL),
(10744, 10755, 1, 'Копія ААА клас', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/blackberry/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10745, 10756, 1, 'Оригінал Euro 2.2', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/blackberry/oryginal-euro-22', NULL, NULL, NULL, NULL, NULL, NULL),
(10746, 10757, 1, 'Original TW', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/blackberry/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10747, 10758, 1, 'Підвищеної ємності', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/blackberry/pidvyschenoyi-emnosti', NULL, NULL, NULL, NULL, NULL, NULL),
(10748, 10759, 1, 'Yoobao', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/blackberry/pidvyschenoyi-emnosti/yoobao', NULL, NULL, NULL, NULL, NULL, NULL),
(10749, 10760, 1, 'Alcatel', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/alcatel', NULL, NULL, NULL, NULL, NULL, NULL),
(10750, 10761, 1, 'Копія ААА клас', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/alcatel/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10751, 10762, 1, 'Philips', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/philips', NULL, NULL, NULL, NULL, NULL, NULL),
(10752, 10763, 1, 'Копія ААА клас', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/philips/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10753, 10764, 1, 'Siemens', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/siemens', NULL, NULL, NULL, NULL, NULL, NULL),
(10754, 10765, 1, 'Копія ААА клас', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/siemens/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10755, 10766, 1, 'Копія ААА клас Econom', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/siemens/kopiya-aaa-klas-econom', NULL, NULL, NULL, NULL, NULL, NULL),
(10756, 10767, 1, 'Підвищеної ємності', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/siemens/pidvyschenoyi-emnosti', NULL, NULL, NULL, NULL, NULL, NULL),
(10757, 10768, 1, 'Kvanta', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/siemens/pidvyschenoyi-emnosti/kvanta', NULL, NULL, NULL, NULL, NULL, NULL),
(10758, 10769, 1, 'Різні', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/rizni', NULL, NULL, NULL, NULL, NULL, NULL),
(10759, 10770, 1, 'ZTE', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/rizni/zte', NULL, NULL, NULL, NULL, NULL, NULL),
(10760, 10771, 1, 'Panasonic', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/rizni/panasonic', NULL, NULL, NULL, NULL, NULL, NULL),
(10761, 10772, 1, 'Sendo', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/rizni/sendo', NULL, NULL, NULL, NULL, NULL, NULL),
(10762, 10773, 1, 'Sagem', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/rizni/sagem', NULL, NULL, NULL, NULL, NULL, NULL),
(10763, 10774, 1, 'Mitsubishi', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-mobilnykh-telefoniv/rizni/mitsubishi', NULL, NULL, NULL, NULL, NULL, NULL),
(10764, 10775, 1, 'Акумулятори для відеотехніки', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-videotekhniky', NULL, NULL, NULL, NULL, NULL, NULL),
(10765, 10776, 1, 'Canon', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-videotekhniky/canon', NULL, NULL, NULL, NULL, NULL, NULL),
(10766, 10777, 1, 'JVC', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-videotekhniky/jvc', NULL, NULL, NULL, NULL, NULL, NULL),
(10767, 10778, 1, 'Panasonic', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-videotekhniky/panasonic', NULL, NULL, NULL, NULL, NULL, NULL),
(10768, 10779, 1, 'Samsung', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-videotekhniky/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(10769, 10780, 1, 'Sony', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-videotekhniky/sony', NULL, NULL, NULL, NULL, NULL, NULL),
(10770, 10781, 1, 'Акумулятори для фототехніки', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-fototekhniky', NULL, NULL, NULL, NULL, NULL, NULL),
(10771, 10782, 1, 'Canon', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-fototekhniky/canon', NULL, NULL, NULL, NULL, NULL, NULL),
(10772, 10783, 1, 'Casio', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-fototekhniky/casio', NULL, NULL, NULL, NULL, NULL, NULL),
(10773, 10784, 1, 'Fuji', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-fototekhniky/fuji', NULL, NULL, NULL, NULL, NULL, NULL),
(10774, 10785, 1, 'Kodak', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-fototekhniky/kodak', NULL, NULL, NULL, NULL, NULL, NULL),
(10775, 10786, 1, 'Konica', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-fototekhniky/konica', NULL, NULL, NULL, NULL, NULL, NULL),
(10776, 10787, 1, 'Nikon', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-fototekhniky/nikon', NULL, NULL, NULL, NULL, NULL, NULL),
(10777, 10788, 1, 'Olympus', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-fototekhniky/olympus', NULL, NULL, NULL, NULL, NULL, NULL),
(10778, 10789, 1, 'Panasonic', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-fototekhniky/panasonic', NULL, NULL, NULL, NULL, NULL, NULL),
(10779, 10790, 1, 'Pentax', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-fototekhniky/pentax', NULL, NULL, NULL, NULL, NULL, NULL),
(10780, 10791, 1, 'Sony', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-fototekhniky/sony', NULL, NULL, NULL, NULL, NULL, NULL),
(10781, 10792, 1, 'UFO', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-fototekhniky/ufo', NULL, NULL, NULL, NULL, NULL, NULL),
(10782, 10793, 1, 'Samsung', 'elementy-zhyvlennya-akumulyatory/akumulyatory-dlya-fototekhniky/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(10783, 10794, 1, 'Елементи живлення, батарейки', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky', NULL, NULL, NULL, NULL, NULL, NULL),
(10784, 10795, 1, 'GP', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/gp', NULL, NULL, NULL, NULL, NULL, NULL),
(10785, 10796, 1, 'Батарейки', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/gp/batareyky', NULL, NULL, NULL, NULL, NULL, NULL),
(10786, 10797, 1, 'Батарейки стандартні', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/gp/batareyky/batareyky-standartni', NULL, NULL, NULL, NULL, NULL, NULL),
(10787, 10798, 1, 'Батарейки високої напруги', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/gp/batareyky/batareyky-vysokoyi-naprugy', NULL, NULL, NULL, NULL, NULL, NULL),
(10788, 10799, 1, 'Батарейки "Крона"', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/gp/batareyky/batareyky-krona', NULL, NULL, NULL, NULL, NULL, NULL),
(10789, 10800, 1, 'Батарейки дискові', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/gp/batareyky/batareyky-dyskovi', NULL, NULL, NULL, NULL, NULL, NULL),
(10790, 10801, 1, 'Батарейки для годинників та фотообладнання', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/gp/batareyky/batareyky-dlya-godynnykiv-ta-fotoobladnannya', NULL, NULL, NULL, NULL, NULL, NULL),
(10791, 10802, 1, 'Батарейки для слухових апаратів', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/gp/batareyky/batareyky-dlya-slukhovykh-aparativ', NULL, NULL, NULL, NULL, NULL, NULL),
(10792, 10803, 1, 'Акумулятори', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/gp/akumulyatory', NULL, NULL, NULL, NULL, NULL, NULL),
(10793, 10804, 1, 'Акумулятори стандартні', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/gp/akumulyatory/akumulyatory-standartni', NULL, NULL, NULL, NULL, NULL, NULL),
(10794, 10805, 1, 'Акумулятори для бездротових телефонів', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/gp/akumulyatory/akumulyatory-dlya-bezdrotovykh-telefoniv', NULL, NULL, NULL, NULL, NULL, NULL),
(10795, 10806, 1, 'Duracell', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/duracell', NULL, NULL, NULL, NULL, NULL, NULL),
(10796, 10807, 1, 'Батарейки', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/duracell/batareyky', NULL, NULL, NULL, NULL, NULL, NULL),
(10797, 10808, 1, 'Батарейки стандартні', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/duracell/batareyky/batareyky-standartni', NULL, NULL, NULL, NULL, NULL, NULL),
(10798, 10809, 1, 'Батарейки "Крона"', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/duracell/batareyky/batareyky-krona', NULL, NULL, NULL, NULL, NULL, NULL),
(10799, 10810, 1, 'Energizer', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/energizer', NULL, NULL, NULL, NULL, NULL, NULL),
(10800, 10811, 1, 'Батарейки', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/energizer/batareyky', NULL, NULL, NULL, NULL, NULL, NULL),
(10801, 10812, 1, 'Батарейки стандартні', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/energizer/batareyky/batareyky-standartni', NULL, NULL, NULL, NULL, NULL, NULL),
(10802, 10813, 1, 'Kodak', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/kodak', NULL, NULL, NULL, NULL, NULL, NULL),
(10803, 10814, 1, 'Батарейки', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/kodak/batareyky', NULL, NULL, NULL, NULL, NULL, NULL),
(10804, 10815, 1, 'Батрейки стандартні', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/kodak/batareyky/batreyky-standartni', NULL, NULL, NULL, NULL, NULL, NULL),
(10805, 10816, 1, 'Renata', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/renata', NULL, NULL, NULL, NULL, NULL, NULL),
(10806, 10817, 1, 'Батарейки', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/renata/batareyky', NULL, NULL, NULL, NULL, NULL, NULL),
(10807, 10818, 1, 'Батарейки дискові', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/renata/batareyky/batareyky-dyskovi', NULL, NULL, NULL, NULL, NULL, NULL),
(10808, 10819, 1, 'Panasonic', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/panasonic', NULL, NULL, NULL, NULL, NULL, NULL),
(10809, 10820, 1, 'Акумулятори', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/panasonic/akumulyatory', NULL, NULL, NULL, NULL, NULL, NULL),
(10810, 10821, 1, 'Акумулятори для бездротових телефонів', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/panasonic/akumulyatory/akumulyatory-dlya-bezdrotovykh-telefoniv', NULL, NULL, NULL, NULL, NULL, NULL),
(10811, 10822, 1, 'Батарейки', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/panasonic/batareyky', NULL, NULL, NULL, NULL, NULL, NULL),
(10812, 10823, 1, 'Батарейки дискові', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/panasonic/batareyky/batareyky-dyskovi', NULL, NULL, NULL, NULL, NULL, NULL),
(10813, 10824, 1, 'Hyundai', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/hyundai', NULL, NULL, NULL, NULL, NULL, NULL),
(10814, 10825, 1, 'Батарейки', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/hyundai/batareyky', NULL, NULL, NULL, NULL, NULL, NULL),
(10815, 10826, 1, 'Батарейки стандартні', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/hyundai/batareyky/batareyky-standartni', NULL, NULL, NULL, NULL, NULL, NULL),
(10816, 10827, 1, 'Батарейки дискові', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/hyundai/batareyky/batareyky-dyskovi', NULL, NULL, NULL, NULL, NULL, NULL),
(10817, 10828, 1, 'Енергія', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/energiya', NULL, NULL, NULL, NULL, NULL, NULL),
(10818, 10829, 1, 'Акумулятори', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/energiya/akumulyatory', NULL, NULL, NULL, NULL, NULL, NULL),
(10819, 10830, 1, 'Акумулятори для бездротових телефонів', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/energiya/akumulyatory/akumulyatory-dlya-bezdrotovykh-telefoniv', NULL, NULL, NULL, NULL, NULL, NULL),
(10820, 10831, 1, 'Батарейки', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/energiya/batareyky', NULL, NULL, NULL, NULL, NULL, NULL),
(10821, 10832, 1, 'Батарейки дискові', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/energiya/batareyky/batareyky-dyskovi', NULL, NULL, NULL, NULL, NULL, NULL),
(10822, 10833, 1, 'Varta', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/varta', NULL, NULL, NULL, NULL, NULL, NULL),
(10823, 10834, 1, 'Батарейки', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/varta/batareyky', NULL, NULL, NULL, NULL, NULL, NULL),
(10824, 10835, 1, 'Батарейки дискові', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/varta/batareyky/batareyky-dyskovi', NULL, NULL, NULL, NULL, NULL, NULL),
(10825, 10836, 1, 'Батарейки стандартні', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/varta/batareyky/batareyky-standartni', NULL, NULL, NULL, NULL, NULL, NULL),
(10826, 10837, 1, 'Sony', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/sony', NULL, NULL, NULL, NULL, NULL, NULL),
(10827, 10838, 1, 'Батарейки', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/sony/batareyky', NULL, NULL, NULL, NULL, NULL, NULL),
(10828, 10839, 1, 'Батарейки для годинників та фотообладнання', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/sony/batareyky/batareyky-dlya-godynnykiv-ta-fotoobladnannya', NULL, NULL, NULL, NULL, NULL, NULL),
(10829, 10840, 1, 'Батарейки стандартні', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/sony/batareyky/batareyky-standartni', NULL, NULL, NULL, NULL, NULL, NULL),
(10830, 10841, 1, 'Master', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/master', NULL, NULL, NULL, NULL, NULL, NULL),
(10831, 10842, 1, 'Акумулятори', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/master/akumulyatory', NULL, NULL, NULL, NULL, NULL, NULL),
(10832, 10843, 1, 'Акумулятори для бездротових телефонів', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/master/akumulyatory/akumulyatory-dlya-bezdrotovykh-telefoniv', NULL, NULL, NULL, NULL, NULL, NULL),
(10833, 10844, 1, 'Maxell', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/maxell', NULL, NULL, NULL, NULL, NULL, NULL),
(10834, 10845, 1, 'Батарейки', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/maxell/batareyky', NULL, NULL, NULL, NULL, NULL, NULL),
(10835, 10846, 1, 'Батарейки для годинників', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/maxell/batareyky/batareyky-dlya-godynnykiv', NULL, NULL, NULL, NULL, NULL, NULL),
(10836, 10847, 1, 'Різні', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/rizni', NULL, NULL, NULL, NULL, NULL, NULL),
(10837, 10848, 1, 'Батарейки', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/rizni/batareyky', NULL, NULL, NULL, NULL, NULL, NULL),
(10838, 10849, 1, 'Акумулятори', 'elementy-zhyvlennya-akumulyatory/elementy-zhyvlennya-batareyky/rizni/akumulyatory', NULL, NULL, NULL, NULL, NULL, NULL),
(10839, 10850, 1, 'Зарядні пристрої', 'zaryadni-prystroyi', NULL, NULL, NULL, NULL, NULL, NULL),
(10840, 10851, 1, 'Мережеві зарядні пристрої для моб. телефонів', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv', NULL, NULL, NULL, NULL, NULL, NULL),
(10841, 10852, 1, 'Nokia', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/nokia', NULL, NULL, NULL, NULL, NULL, NULL),
(10842, 10853, 1, 'Копія ААА клас', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/nokia/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10843, 10854, 1, 'TCT Euro', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/nokia/kopiya-aaa-klas/tct-euro', NULL, NULL, NULL, NULL, NULL, NULL),
(10844, 10855, 1, 'Celebrity', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/nokia/kopiya-aaa-klas/celebrity', NULL, NULL, NULL, NULL, NULL, NULL),
(10845, 10856, 1, 'Premium', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/nokia/kopiya-aaa-klas/premium', NULL, NULL, NULL, NULL, NULL, NULL),
(10846, 10857, 1, 'High Copy', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/nokia/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10847, 10858, 1, 'Original TW', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/nokia/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10848, 10859, 1, 'Original 100%', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/nokia/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10849, 10860, 1, 'Samsung', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(10850, 10861, 1, 'Копія ААА клас', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/samsung/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10851, 10862, 1, 'TCT Euro', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/samsung/kopiya-aaa-klas/tct-euro', NULL, NULL, NULL, NULL, NULL, NULL),
(10852, 10863, 1, 'Celebrity', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/samsung/kopiya-aaa-klas/celebrity', NULL, NULL, NULL, NULL, NULL, NULL),
(10853, 10864, 1, 'Premium', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/samsung/kopiya-aaa-klas/premium', NULL, NULL, NULL, NULL, NULL, NULL),
(10854, 10865, 1, 'High Copy', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/samsung/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10855, 10866, 1, 'Original TW', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/samsung/original-tw', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `e_content_info` (`id`, `content_id`, `languages_id`, `name`, `url`, `h1`, `title`, `keywords`, `description`, `intro`, `content`) VALUES
(10856, 10867, 1, 'Original 100%', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/samsung/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10857, 10868, 1, 'Apple', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/apple', NULL, NULL, NULL, NULL, NULL, NULL),
(10858, 10869, 1, 'HTC', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/htc', NULL, NULL, NULL, NULL, NULL, NULL),
(10859, 10870, 1, 'High Copy', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/htc/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10860, 10871, 1, 'Original TW', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/htc/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10861, 10872, 1, 'Sony Ericsson', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/sony-ericsson', NULL, NULL, NULL, NULL, NULL, NULL),
(10862, 10873, 1, 'Копія ААА клас', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/sony-ericsson/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10863, 10874, 1, 'TCT Euro', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/sony-ericsson/kopiya-aaa-klas/tct-euro', NULL, NULL, NULL, NULL, NULL, NULL),
(10864, 10875, 1, 'Celebrity', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/sony-ericsson/kopiya-aaa-klas/celebrity', NULL, NULL, NULL, NULL, NULL, NULL),
(10865, 10876, 1, 'Premium', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/sony-ericsson/kopiya-aaa-klas/premium', NULL, NULL, NULL, NULL, NULL, NULL),
(10866, 10877, 1, 'High Copy', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/sony-ericsson/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10867, 10878, 1, 'Original TW', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/sony-ericsson/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10868, 10879, 1, 'LG', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/lg', NULL, NULL, NULL, NULL, NULL, NULL),
(10869, 10880, 1, 'Копія ААА клас', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/lg/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10870, 10881, 1, 'TCT Euro', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/lg/kopiya-aaa-klas/tct-euro', NULL, NULL, NULL, NULL, NULL, NULL),
(10871, 10882, 1, 'Celebrity', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/lg/kopiya-aaa-klas/celebrity', NULL, NULL, NULL, NULL, NULL, NULL),
(10872, 10883, 1, 'Premium', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/lg/kopiya-aaa-klas/premium', NULL, NULL, NULL, NULL, NULL, NULL),
(10873, 10884, 1, 'High Copy', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/lg/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10874, 10885, 1, 'Original TW', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/lg/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10875, 10886, 1, 'Original 100%', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/lg/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10876, 10887, 1, 'Siemens', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/siemens', NULL, NULL, NULL, NULL, NULL, NULL),
(10877, 10888, 1, 'Копія ААА клас', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/siemens/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10878, 10889, 1, 'TCT Euro', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/siemens/kopiya-aaa-klas/tct-euro', NULL, NULL, NULL, NULL, NULL, NULL),
(10879, 10890, 1, 'Celebrity', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/siemens/kopiya-aaa-klas/celebrity', NULL, NULL, NULL, NULL, NULL, NULL),
(10880, 10891, 1, 'Premium', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/siemens/kopiya-aaa-klas/premium', NULL, NULL, NULL, NULL, NULL, NULL),
(10881, 10892, 1, 'High Copy', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/siemens/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10882, 10893, 1, 'Original TW', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/siemens/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10883, 10894, 1, 'Motorola', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/motorola', NULL, NULL, NULL, NULL, NULL, NULL),
(10884, 10895, 1, 'Копія ААА клас', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/motorola/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10885, 10896, 1, 'TCT Euro', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/motorola/kopiya-aaa-klas/tct-euro', NULL, NULL, NULL, NULL, NULL, NULL),
(10886, 10897, 1, 'Celebrity', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/motorola/kopiya-aaa-klas/celebrity', NULL, NULL, NULL, NULL, NULL, NULL),
(10887, 10898, 1, 'Premium', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/motorola/kopiya-aaa-klas/premium', NULL, NULL, NULL, NULL, NULL, NULL),
(10888, 10899, 1, 'High Copy', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/motorola/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10889, 10900, 1, 'Original TW', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/motorola/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10890, 10901, 1, 'Original 100%', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/motorola/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10891, 10902, 1, 'Huawei', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/huawei', NULL, NULL, NULL, NULL, NULL, NULL),
(10892, 10903, 1, 'High Copy', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/huawei/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10893, 10904, 1, 'Original TW', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/huawei/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10894, 10905, 1, 'Mitsubishi', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/mitsubishi', NULL, NULL, NULL, NULL, NULL, NULL),
(10895, 10906, 1, 'Копія ААА клас', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/mitsubishi/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10896, 10907, 1, 'High Copy', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/mitsubishi/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10897, 10908, 1, 'Panasonic', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/panasonic', NULL, NULL, NULL, NULL, NULL, NULL),
(10898, 10909, 1, 'Копія ААА клас', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/panasonic/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10899, 10910, 1, 'Original 100%', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/panasonic/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(10900, 10911, 1, 'High Copy', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/panasonic/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10901, 10912, 1, 'Sagem', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/sagem', NULL, NULL, NULL, NULL, NULL, NULL),
(10902, 10913, 1, 'Sony', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/sony', NULL, NULL, NULL, NULL, NULL, NULL),
(10903, 10914, 1, 'Philips', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/philips', NULL, NULL, NULL, NULL, NULL, NULL),
(10904, 10915, 1, 'Alcatel', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/alcatel', NULL, NULL, NULL, NULL, NULL, NULL),
(10905, 10916, 1, 'BlackBerry', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/blackberry', NULL, NULL, NULL, NULL, NULL, NULL),
(10906, 10917, 1, 'FLY', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/fly', NULL, NULL, NULL, NULL, NULL, NULL),
(10907, 10918, 1, 'China', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/china', NULL, NULL, NULL, NULL, NULL, NULL),
(10908, 10919, 1, 'Lenovo', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/lenovo', NULL, NULL, NULL, NULL, NULL, NULL),
(10909, 10920, 1, 'High Copy', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/lenovo/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10910, 10921, 1, 'Sendo', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/sendo', NULL, NULL, NULL, NULL, NULL, NULL),
(10911, 10922, 1, 'Asus', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/asus', NULL, NULL, NULL, NULL, NULL, NULL),
(10912, 10923, 1, 'High Copy', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/asus/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10913, 10924, 1, 'Різні', 'zaryadni-prystroyi/merezhevi-zaryadni-prystroyi-dlya-mob-telefoniv/rizni', NULL, NULL, NULL, NULL, NULL, NULL),
(10914, 10925, 1, 'Автомобільні зарядні пристрої для моб. телефонів', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv', NULL, NULL, NULL, NULL, NULL, NULL),
(10915, 10926, 1, 'Nokia', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/nokia', NULL, NULL, NULL, NULL, NULL, NULL),
(10916, 10927, 1, 'Копія ААА клас', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/nokia/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10917, 10928, 1, 'High Copy', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/nokia/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10918, 10929, 1, 'Original TW', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/nokia/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10919, 10930, 1, 'Samsung', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(10920, 10931, 1, 'Копія ААА клас', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/samsung/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10921, 10932, 1, 'High Copy', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/samsung/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10922, 10933, 1, 'Original TW', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/samsung/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(10923, 10934, 1, 'Apple', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/apple', NULL, NULL, NULL, NULL, NULL, NULL),
(10924, 10935, 1, 'HTC', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/htc', NULL, NULL, NULL, NULL, NULL, NULL),
(10925, 10936, 1, 'High Copy', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/htc/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10926, 10937, 1, 'Sony Ericsson', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/sony-ericsson', NULL, NULL, NULL, NULL, NULL, NULL),
(10927, 10938, 1, 'Копія ААА клас', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/sony-ericsson/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10928, 10939, 1, 'High Copy', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/sony-ericsson/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10929, 10940, 1, 'LG', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/lg', NULL, NULL, NULL, NULL, NULL, NULL),
(10930, 10941, 1, 'Копія ААА клас', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/lg/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10931, 10942, 1, 'High Copy', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/lg/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10932, 10943, 1, 'Siemens', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/siemens', NULL, NULL, NULL, NULL, NULL, NULL),
(10933, 10944, 1, 'Копія ААА клас', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/siemens/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10934, 10945, 1, 'High Copy', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/siemens/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10935, 10946, 1, 'Motorola', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/motorola', NULL, NULL, NULL, NULL, NULL, NULL),
(10936, 10947, 1, 'Копія ААА клас', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/motorola/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(10937, 10948, 1, 'High Copy', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/motorola/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10938, 10949, 1, 'Panasonic', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/panasonic', NULL, NULL, NULL, NULL, NULL, NULL),
(10939, 10950, 1, 'Blackberry', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/blackberry', NULL, NULL, NULL, NULL, NULL, NULL),
(10940, 10951, 1, 'Alcatel', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/alcatel', NULL, NULL, NULL, NULL, NULL, NULL),
(10941, 10952, 1, 'Philips', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/philips', NULL, NULL, NULL, NULL, NULL, NULL),
(10942, 10953, 1, 'Mitsubishi', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/mitsubishi', NULL, NULL, NULL, NULL, NULL, NULL),
(10943, 10954, 1, 'Lenovo', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/lenovo', NULL, NULL, NULL, NULL, NULL, NULL),
(10944, 10955, 1, 'High Copy', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/lenovo/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10945, 10956, 1, 'Huawei', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/huawei', NULL, NULL, NULL, NULL, NULL, NULL),
(10946, 10957, 1, 'High Copy', 'zaryadni-prystroyi/avtomobilni-zaryadni-prystroyi-dlya-mob-telefoniv/huawei/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(10947, 10958, 1, 'Мережеві універсальні зарядні пристрої', 'zaryadni-prystroyi/merezhevi-universalni-zaryadni-prystroyi', NULL, NULL, NULL, NULL, NULL, NULL),
(10948, 10959, 1, 'Автомобільні універсальні зарядні пристрої', 'zaryadni-prystroyi/avtomobilni-universalni-zaryadni-prystroyi', NULL, NULL, NULL, NULL, NULL, NULL),
(10949, 10960, 1, 'Зарядні пристрої для фото-, відео- акумуляторів', 'zaryadni-prystroyi/zaryadni-prystroyi-dlya-foto--video--akumulyatoriv', NULL, NULL, NULL, NULL, NULL, NULL),
(10950, 10961, 1, 'Canon', 'zaryadni-prystroyi/zaryadni-prystroyi-dlya-foto--video--akumulyatoriv/canon', NULL, NULL, NULL, NULL, NULL, NULL),
(10951, 10962, 1, 'Olympus', 'zaryadni-prystroyi/zaryadni-prystroyi-dlya-foto--video--akumulyatoriv/olympus', NULL, NULL, NULL, NULL, NULL, NULL),
(10952, 10963, 1, 'Sony', 'zaryadni-prystroyi/zaryadni-prystroyi-dlya-foto--video--akumulyatoriv/sony', NULL, NULL, NULL, NULL, NULL, NULL),
(10953, 10964, 1, 'Nikon', 'zaryadni-prystroyi/zaryadni-prystroyi-dlya-foto--video--akumulyatoriv/nikon', NULL, NULL, NULL, NULL, NULL, NULL),
(10954, 10965, 1, 'Kodak', 'zaryadni-prystroyi/zaryadni-prystroyi-dlya-foto--video--akumulyatoriv/kodak', NULL, NULL, NULL, NULL, NULL, NULL),
(10955, 10966, 1, 'Samsung', 'zaryadni-prystroyi/zaryadni-prystroyi-dlya-foto--video--akumulyatoriv/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(10956, 10967, 1, 'Panasonic', 'zaryadni-prystroyi/zaryadni-prystroyi-dlya-foto--video--akumulyatoriv/panasonic', NULL, NULL, NULL, NULL, NULL, NULL),
(10957, 10968, 1, 'Casio', 'zaryadni-prystroyi/zaryadni-prystroyi-dlya-foto--video--akumulyatoriv/casio', NULL, NULL, NULL, NULL, NULL, NULL),
(10958, 10969, 1, 'JVC', 'zaryadni-prystroyi/zaryadni-prystroyi-dlya-foto--video--akumulyatoriv/jvc', NULL, NULL, NULL, NULL, NULL, NULL),
(10959, 10970, 1, 'Sanyo', 'zaryadni-prystroyi/zaryadni-prystroyi-dlya-foto--video--akumulyatoriv/sanyo', NULL, NULL, NULL, NULL, NULL, NULL),
(10960, 10971, 1, 'Зарядні пристрої для акумуляторних батарейок', 'zaryadni-prystroyi/zaryadni-prystroyi-dlya-akumulyatornykh-batareyok', NULL, NULL, NULL, NULL, NULL, NULL),
(10961, 10972, 1, 'Енергія', 'zaryadni-prystroyi/zaryadni-prystroyi-dlya-akumulyatornykh-batareyok/energiya', NULL, NULL, NULL, NULL, NULL, NULL),
(10962, 10973, 1, 'GP', 'zaryadni-prystroyi/zaryadni-prystroyi-dlya-akumulyatornykh-batareyok/gp', NULL, NULL, NULL, NULL, NULL, NULL),
(10963, 10974, 1, 'Sony', 'zaryadni-prystroyi/zaryadni-prystroyi-dlya-akumulyatornykh-batareyok/sony', NULL, NULL, NULL, NULL, NULL, NULL),
(10964, 10975, 1, 'Різні', 'zaryadni-prystroyi/zaryadni-prystroyi-dlya-akumulyatornykh-batareyok/rizni', NULL, NULL, NULL, NULL, NULL, NULL),
(10965, 10976, 1, 'Зарядні пристрої для ноутбуків та блоки живлення', 'zaryadni-prystroyi/zaryadni-prystroyi-dlya-noutbukiv-ta-bloky-zhyvlennya', NULL, NULL, NULL, NULL, NULL, NULL),
(10966, 10977, 1, 'Чохли', 'chokhly', NULL, NULL, NULL, NULL, NULL, NULL),
(10967, 10978, 1, 'Apple', 'chokhly/apple', NULL, NULL, NULL, NULL, NULL, NULL),
(10968, 10979, 1, 'Книжки', 'chokhly/apple/knyzhky', NULL, NULL, NULL, NULL, NULL, NULL),
(10969, 10980, 1, 'Brum', 'chokhly/apple/knyzhky/brum', NULL, NULL, NULL, NULL, NULL, NULL),
(10970, 10981, 1, 'Original Flip Case', 'chokhly/apple/knyzhky/original-flip-case', NULL, NULL, NULL, NULL, NULL, NULL),
(10971, 10982, 1, 'BMW', 'chokhly/apple/knyzhky/bmw', NULL, NULL, NULL, NULL, NULL, NULL),
(10972, 10983, 1, 'Melkco', 'chokhly/apple/knyzhky/melkco', NULL, NULL, NULL, NULL, NULL, NULL),
(10973, 10984, 1, 'СМА', 'chokhly/apple/knyzhky/sma', NULL, NULL, NULL, NULL, NULL, NULL),
(10974, 10985, 1, 'Atlanta', 'chokhly/apple/knyzhky/atlanta', NULL, NULL, NULL, NULL, NULL, NULL),
(10975, 10986, 1, 'HOCO', 'chokhly/apple/knyzhky/hoco', NULL, NULL, NULL, NULL, NULL, NULL),
(10976, 10987, 1, 'BELK', 'chokhly/apple/knyzhky/belk', NULL, NULL, NULL, NULL, NULL, NULL),
(10977, 10988, 1, 'Griffin', 'chokhly/apple/knyzhky/griffin', NULL, NULL, NULL, NULL, NULL, NULL),
(10978, 10989, 1, 'Beats', 'chokhly/apple/knyzhky/beats', NULL, NULL, NULL, NULL, NULL, NULL),
(10979, 10990, 1, 'Yoobao', 'chokhly/apple/knyzhky/yoobao', NULL, NULL, NULL, NULL, NULL, NULL),
(10980, 10991, 1, 'Chic Case', 'chokhly/apple/knyzhky/chic-case', NULL, NULL, NULL, NULL, NULL, NULL),
(10981, 10992, 1, 'VIVA', 'chokhly/apple/knyzhky/viva', NULL, NULL, NULL, NULL, NULL, NULL),
(10982, 10993, 1, 'Різні', 'chokhly/apple/knyzhky/rizni', NULL, NULL, NULL, NULL, NULL, NULL),
(10983, 10994, 1, 'Borofone', 'chokhly/apple/knyzhky/borofone', NULL, NULL, NULL, NULL, NULL, NULL),
(10984, 10995, 1, 'Ferrari', 'chokhly/apple/knyzhky/ferrari', NULL, NULL, NULL, NULL, NULL, NULL),
(10985, 10996, 1, 'NavJack', 'chokhly/apple/knyzhky/navjack', NULL, NULL, NULL, NULL, NULL, NULL),
(10986, 10997, 1, 'Lamborghini', 'chokhly/apple/knyzhky/lamborghini', NULL, NULL, NULL, NULL, NULL, NULL),
(10987, 10998, 1, 'Nillkin', 'chokhly/apple/knyzhky/nillkin', NULL, NULL, NULL, NULL, NULL, NULL),
(10988, 10999, 1, 'Накладки', 'chokhly/apple/nakladky', NULL, NULL, NULL, NULL, NULL, NULL),
(10989, 11000, 1, 'Moshi', 'chokhly/apple/nakladky/moshi', NULL, NULL, NULL, NULL, NULL, NULL),
(10990, 11001, 1, 'Younicou', 'chokhly/apple/nakladky/younicou', NULL, NULL, NULL, NULL, NULL, NULL),
(10991, 11002, 1, 'Red Angel', 'chokhly/apple/nakladky/red-angel', NULL, NULL, NULL, NULL, NULL, NULL),
(10992, 11003, 1, 'Original Silicon Case', 'chokhly/apple/nakladky/original-silicon-case', NULL, NULL, NULL, NULL, NULL, NULL),
(10993, 11004, 1, 'Ultra Thin', 'chokhly/apple/nakladky/ultra-thin', NULL, NULL, NULL, NULL, NULL, NULL),
(10994, 11005, 1, 'BMW', 'chokhly/apple/nakladky/bmw', NULL, NULL, NULL, NULL, NULL, NULL),
(10995, 11006, 1, 'iCover', 'chokhly/apple/nakladky/icover', NULL, NULL, NULL, NULL, NULL, NULL),
(10996, 11007, 1, 'FaceCase', 'chokhly/apple/nakladky/facecase', NULL, NULL, NULL, NULL, NULL, NULL),
(10997, 11008, 1, 'Lamborghini', 'chokhly/apple/nakladky/lamborghini', NULL, NULL, NULL, NULL, NULL, NULL),
(10998, 11009, 1, 'Rabbit Case', 'chokhly/apple/nakladky/rabbit-case', NULL, NULL, NULL, NULL, NULL, NULL),
(10999, 11010, 1, 'Original Case', 'chokhly/apple/nakladky/original-case', NULL, NULL, NULL, NULL, NULL, NULL),
(11000, 11011, 1, 'Motomo', 'chokhly/apple/nakladky/motomo', NULL, NULL, NULL, NULL, NULL, NULL),
(11001, 11012, 1, 'HOCO', 'chokhly/apple/nakladky/hoco', NULL, NULL, NULL, NULL, NULL, NULL),
(11002, 11013, 1, 'Fashion', 'chokhly/apple/nakladky/fashion', NULL, NULL, NULL, NULL, NULL, NULL),
(11003, 11014, 1, 'Senior case', 'chokhly/apple/nakladky/senior-case', NULL, NULL, NULL, NULL, NULL, NULL),
(11004, 11015, 1, 'Різні', 'chokhly/apple/nakladky/rizni', NULL, NULL, NULL, NULL, NULL, NULL),
(11005, 11016, 1, 'Disney', 'chokhly/apple/nakladky/disney', NULL, NULL, NULL, NULL, NULL, NULL),
(11006, 11017, 1, 'Melkco', 'chokhly/apple/nakladky/melkco', NULL, NULL, NULL, NULL, NULL, NULL),
(11007, 11018, 1, 'Ferrari', 'chokhly/apple/nakladky/ferrari', NULL, NULL, NULL, NULL, NULL, NULL),
(11008, 11019, 1, 'Yoobao', 'chokhly/apple/nakladky/yoobao', NULL, NULL, NULL, NULL, NULL, NULL),
(11009, 11020, 1, 'Protective Case', 'chokhly/apple/nakladky/protective-case', NULL, NULL, NULL, NULL, NULL, NULL),
(11010, 11021, 1, 'Borofone', 'chokhly/apple/nakladky/borofone', NULL, NULL, NULL, NULL, NULL, NULL),
(11011, 11022, 1, 'ARU', 'chokhly/apple/nakladky/aru', NULL, NULL, NULL, NULL, NULL, NULL),
(11012, 11023, 1, 'Griffin', 'chokhly/apple/nakladky/griffin', NULL, NULL, NULL, NULL, NULL, NULL),
(11013, 11024, 1, 'Spigen', 'chokhly/apple/nakladky/spigen', NULL, NULL, NULL, NULL, NULL, NULL),
(11014, 11025, 1, 'Eimo', 'chokhly/apple/nakladky/eimo', NULL, NULL, NULL, NULL, NULL, NULL),
(11015, 11026, 1, 'UkrCase', 'chokhly/apple/nakladky/ukrcase', NULL, NULL, NULL, NULL, NULL, NULL),
(11016, 11027, 1, 'SGP', 'chokhly/apple/nakladky/sgp', NULL, NULL, NULL, NULL, NULL, NULL),
(11017, 11028, 1, 'Honor Armor Series', 'chokhly/apple/nakladky/honor-armor-series', NULL, NULL, NULL, NULL, NULL, NULL),
(11018, 11029, 1, 'Perfectum', 'chokhly/apple/nakladky/perfectum', NULL, NULL, NULL, NULL, NULL, NULL),
(11019, 11030, 1, 'Cherry', 'chokhly/apple/nakladky/cherry', NULL, NULL, NULL, NULL, NULL, NULL),
(11020, 11031, 1, 'CMA', 'chokhly/apple/nakladky/cma', NULL, NULL, NULL, NULL, NULL, NULL),
(11021, 11032, 1, 'Remax', 'chokhly/apple/nakladky/remax', NULL, NULL, NULL, NULL, NULL, NULL),
(11022, 11033, 1, 'Накладки силіконові Capdase', 'chokhly/apple/nakladky-sylikonovi-capdase', NULL, NULL, NULL, NULL, NULL, NULL),
(11023, 11034, 1, 'Бампера', 'chokhly/apple/bampera', NULL, NULL, NULL, NULL, NULL, NULL),
(11024, 11035, 1, 'Чохол на пояс', 'chokhly/apple/chokhol-na-poyas', NULL, NULL, NULL, NULL, NULL, NULL),
(11025, 11036, 1, 'Різні', 'chokhly/apple/rizni', NULL, NULL, NULL, NULL, NULL, NULL),
(11026, 11037, 1, 'Накладки modern', 'chokhly/apple/nakladky-modern', NULL, NULL, NULL, NULL, NULL, NULL),
(11027, 11038, 1, 'Slicoo', 'chokhly/apple/nakladky-modern/slicoo', NULL, NULL, NULL, NULL, NULL, NULL),
(11028, 11039, 1, 'Різні', 'chokhly/apple/nakladky-modern/rizni', NULL, NULL, NULL, NULL, NULL, NULL),
(11029, 11040, 1, 'Animals/Afro', 'chokhly/apple/nakladky-modern/animals-afro', NULL, NULL, NULL, NULL, NULL, NULL),
(11030, 11041, 1, 'Diesel', 'chokhly/apple/nakladky-modern/diesel', NULL, NULL, NULL, NULL, NULL, NULL),
(11031, 11042, 1, 'Doll', 'chokhly/apple/nakladky-modern/doll', NULL, NULL, NULL, NULL, NULL, NULL),
(11032, 11043, 1, 'Original', 'chokhly/apple/nakladky-modern/original', NULL, NULL, NULL, NULL, NULL, NULL),
(11033, 11044, 1, 'TPU', 'chokhly/apple/nakladky-modern/tpu', NULL, NULL, NULL, NULL, NULL, NULL),
(11034, 11045, 1, 'QU', 'chokhly/apple/nakladky-modern/qu', NULL, NULL, NULL, NULL, NULL, NULL),
(11035, 11046, 1, 'Wear it', 'chokhly/apple/nakladky-modern/wear-it', NULL, NULL, NULL, NULL, NULL, NULL),
(11036, 11047, 1, 'Samsung', 'chokhly/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(11037, 11048, 1, 'Книжки', 'chokhly/samsung/knyzhky', NULL, NULL, NULL, NULL, NULL, NULL),
(11038, 11049, 1, 'Brum', 'chokhly/samsung/knyzhky/brum', NULL, NULL, NULL, NULL, NULL, NULL),
(11039, 11050, 1, 'HOCO', 'chokhly/samsung/knyzhky/hoco', NULL, NULL, NULL, NULL, NULL, NULL),
(11040, 11051, 1, 'Original Flip Case', 'chokhly/samsung/knyzhky/original-flip-case', NULL, NULL, NULL, NULL, NULL, NULL),
(11041, 11052, 1, 'Melkco', 'chokhly/samsung/knyzhky/melkco', NULL, NULL, NULL, NULL, NULL, NULL),
(11042, 11053, 1, 'СМА', 'chokhly/samsung/knyzhky/sma', NULL, NULL, NULL, NULL, NULL, NULL),
(11043, 11054, 1, 'Atlanta', 'chokhly/samsung/knyzhky/atlanta', NULL, NULL, NULL, NULL, NULL, NULL),
(11044, 11055, 1, 'Yoobao', 'chokhly/samsung/knyzhky/yoobao', NULL, NULL, NULL, NULL, NULL, NULL),
(11045, 11056, 1, 'Chic Case', 'chokhly/samsung/knyzhky/chic-case', NULL, NULL, NULL, NULL, NULL, NULL),
(11046, 11057, 1, 'BELK', 'chokhly/samsung/knyzhky/belk', NULL, NULL, NULL, NULL, NULL, NULL),
(11047, 11058, 1, 'Різні', 'chokhly/samsung/knyzhky/rizni', NULL, NULL, NULL, NULL, NULL, NULL),
(11048, 11059, 1, 'NavJack', 'chokhly/samsung/knyzhky/navjack', NULL, NULL, NULL, NULL, NULL, NULL),
(11049, 11060, 1, 'Nillkin', 'chokhly/samsung/knyzhky/nillkin', NULL, NULL, NULL, NULL, NULL, NULL),
(11050, 11061, 1, 'Goospery', 'chokhly/samsung/knyzhky/goospery', NULL, NULL, NULL, NULL, NULL, NULL),
(11051, 11062, 1, 'Накладки', 'chokhly/samsung/nakladky', NULL, NULL, NULL, NULL, NULL, NULL),
(11052, 11063, 1, 'Moshi', 'chokhly/samsung/nakladky/moshi', NULL, NULL, NULL, NULL, NULL, NULL),
(11053, 11064, 1, 'Younicou', 'chokhly/samsung/nakladky/younicou', NULL, NULL, NULL, NULL, NULL, NULL),
(11054, 11065, 1, 'Red Angel', 'chokhly/samsung/nakladky/red-angel', NULL, NULL, NULL, NULL, NULL, NULL),
(11055, 11066, 1, 'Original Silicon Case', 'chokhly/samsung/nakladky/original-silicon-case', NULL, NULL, NULL, NULL, NULL, NULL),
(11056, 11067, 1, 'Ultra Thin', 'chokhly/samsung/nakladky/ultra-thin', NULL, NULL, NULL, NULL, NULL, NULL),
(11057, 11068, 1, 'Yoobao', 'chokhly/samsung/nakladky/yoobao', NULL, NULL, NULL, NULL, NULL, NULL),
(11058, 11069, 1, 'Kashi', 'chokhly/samsung/nakladky/kashi', NULL, NULL, NULL, NULL, NULL, NULL),
(11059, 11070, 1, 'Modeall', 'chokhly/samsung/nakladky/modeall', NULL, NULL, NULL, NULL, NULL, NULL),
(11060, 11071, 1, 'TPU', 'chokhly/samsung/nakladky/tpu', NULL, NULL, NULL, NULL, NULL, NULL),
(11061, 11072, 1, 'iCover', 'chokhly/samsung/nakladky/icover', NULL, NULL, NULL, NULL, NULL, NULL),
(11062, 11073, 1, 'Hoco', 'chokhly/samsung/nakladky/hoco', NULL, NULL, NULL, NULL, NULL, NULL),
(11063, 11074, 1, 'Cherry', 'chokhly/samsung/nakladky/cherry', NULL, NULL, NULL, NULL, NULL, NULL),
(11064, 11075, 1, 'HOCO', 'chokhly/samsung/nakladky/hoco_dubl_0.67120900 1469473531', NULL, NULL, NULL, NULL, NULL, NULL),
(11065, 11076, 1, 'Різні', 'chokhly/samsung/nakladky/rizni', NULL, NULL, NULL, NULL, NULL, NULL),
(11066, 11077, 1, 'Griffin', 'chokhly/samsung/nakladky/griffin', NULL, NULL, NULL, NULL, NULL, NULL),
(11067, 11078, 1, 'SMTT', 'chokhly/samsung/nakladky/smtt', NULL, NULL, NULL, NULL, NULL, NULL),
(11068, 11079, 1, 'SGP', 'chokhly/samsung/nakladky/sgp', NULL, NULL, NULL, NULL, NULL, NULL),
(11069, 11080, 1, 'Speck', 'chokhly/samsung/nakladky/speck', NULL, NULL, NULL, NULL, NULL, NULL),
(11070, 11081, 1, 'Remax', 'chokhly/samsung/nakladky/remax', NULL, NULL, NULL, NULL, NULL, NULL),
(11071, 11082, 1, 'Slicoo', 'chokhly/samsung/nakladky/slicoo', NULL, NULL, NULL, NULL, NULL, NULL),
(11072, 11083, 1, 'Diesel', 'chokhly/samsung/nakladky/diesel', NULL, NULL, NULL, NULL, NULL, NULL),
(11073, 11084, 1, 'QU', 'chokhly/samsung/nakladky/qu', NULL, NULL, NULL, NULL, NULL, NULL),
(11074, 11085, 1, 'Накладки силіконові Capdase', 'chokhly/samsung/nakladky-sylikonovi-capdase', NULL, NULL, NULL, NULL, NULL, NULL),
(11075, 11086, 1, 'Бампера', 'chokhly/samsung/bampera', NULL, NULL, NULL, NULL, NULL, NULL),
(11076, 11087, 1, 'Чохли на пояс', 'chokhly/samsung/chokhly-na-poyas', NULL, NULL, NULL, NULL, NULL, NULL),
(11077, 11088, 1, 'Original 100%', 'chokhly/samsung/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(11078, 11089, 1, 'Nokia', 'chokhly/nokia', NULL, NULL, NULL, NULL, NULL, NULL),
(11079, 11090, 1, 'Книжки', 'chokhly/nokia/knyzhky', NULL, NULL, NULL, NULL, NULL, NULL),
(11080, 11091, 1, 'Brum', 'chokhly/nokia/knyzhky/brum', NULL, NULL, NULL, NULL, NULL, NULL),
(11081, 11092, 1, 'СМА', 'chokhly/nokia/knyzhky/sma', NULL, NULL, NULL, NULL, NULL, NULL),
(11082, 11093, 1, 'Atlanta', 'chokhly/nokia/knyzhky/atlanta', NULL, NULL, NULL, NULL, NULL, NULL),
(11083, 11094, 1, 'Chic Case', 'chokhly/nokia/knyzhky/chic-case', NULL, NULL, NULL, NULL, NULL, NULL),
(11084, 11095, 1, 'Capdase', 'chokhly/nokia/knyzhky/capdase', NULL, NULL, NULL, NULL, NULL, NULL),
(11085, 11096, 1, 'Melkco', 'chokhly/nokia/knyzhky/melkco', NULL, NULL, NULL, NULL, NULL, NULL),
(11086, 11097, 1, 'Nillkin', 'chokhly/nokia/knyzhky/nillkin', NULL, NULL, NULL, NULL, NULL, NULL),
(11087, 11098, 1, 'Накладки', 'chokhly/nokia/nakladky', NULL, NULL, NULL, NULL, NULL, NULL),
(11088, 11099, 1, 'Moshi', 'chokhly/nokia/nakladky/moshi', NULL, NULL, NULL, NULL, NULL, NULL),
(11089, 11100, 1, 'Original Silicon Case', 'chokhly/nokia/nakladky/original-silicon-case', NULL, NULL, NULL, NULL, NULL, NULL),
(11090, 11101, 1, 'Ultra Thin', 'chokhly/nokia/nakladky/ultra-thin', NULL, NULL, NULL, NULL, NULL, NULL),
(11091, 11102, 1, 'Modeall', 'chokhly/nokia/nakladky/modeall', NULL, NULL, NULL, NULL, NULL, NULL),
(11092, 11103, 1, 'TPU', 'chokhly/nokia/nakladky/tpu', NULL, NULL, NULL, NULL, NULL, NULL),
(11093, 11104, 1, 'Speck', 'chokhly/nokia/nakladky/speck', NULL, NULL, NULL, NULL, NULL, NULL),
(11094, 11105, 1, 'Nillkin', 'chokhly/nokia/nakladky/nillkin', NULL, NULL, NULL, NULL, NULL, NULL),
(11095, 11106, 1, 'SGP', 'chokhly/nokia/nakladky/sgp', NULL, NULL, NULL, NULL, NULL, NULL),
(11096, 11107, 1, 'Cherry', 'chokhly/nokia/nakladky/cherry', NULL, NULL, NULL, NULL, NULL, NULL),
(11097, 11108, 1, 'Remax', 'chokhly/nokia/nakladky/remax', NULL, NULL, NULL, NULL, NULL, NULL),
(11098, 11109, 1, 'Накладки силіконові Capdase', 'chokhly/nokia/nakladky-sylikonovi-capdase', NULL, NULL, NULL, NULL, NULL, NULL),
(11099, 11110, 1, 'Бампера', 'chokhly/nokia/bampera', NULL, NULL, NULL, NULL, NULL, NULL),
(11100, 11111, 1, 'Чохли на пояс', 'chokhly/nokia/chokhly-na-poyas', NULL, NULL, NULL, NULL, NULL, NULL),
(11101, 11112, 1, 'Original 100%', 'chokhly/nokia/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(11102, 11113, 1, 'HTC', 'chokhly/htc', NULL, NULL, NULL, NULL, NULL, NULL),
(11103, 11114, 1, 'Чохли книжки', 'chokhly/htc/chokhly-knyzhky', NULL, NULL, NULL, NULL, NULL, NULL),
(11104, 11115, 1, 'Brum', 'chokhly/htc/chokhly-knyzhky/brum', NULL, NULL, NULL, NULL, NULL, NULL),
(11105, 11116, 1, 'Atlanta', 'chokhly/htc/chokhly-knyzhky/atlanta', NULL, NULL, NULL, NULL, NULL, NULL),
(11106, 11117, 1, 'Original Flip Case', 'chokhly/htc/chokhly-knyzhky/original-flip-case', NULL, NULL, NULL, NULL, NULL, NULL),
(11107, 11118, 1, 'Melkco', 'chokhly/htc/chokhly-knyzhky/melkco', NULL, NULL, NULL, NULL, NULL, NULL),
(11108, 11119, 1, 'СМА', 'chokhly/htc/chokhly-knyzhky/sma', NULL, NULL, NULL, NULL, NULL, NULL),
(11109, 11120, 1, 'Yoobao', 'chokhly/htc/chokhly-knyzhky/yoobao', NULL, NULL, NULL, NULL, NULL, NULL),
(11110, 11121, 1, 'Hoco', 'chokhly/htc/chokhly-knyzhky/hoco', NULL, NULL, NULL, NULL, NULL, NULL),
(11111, 11122, 1, 'Chic Case', 'chokhly/htc/chokhly-knyzhky/chic-case', NULL, NULL, NULL, NULL, NULL, NULL),
(11112, 11123, 1, 'Різні', 'chokhly/htc/chokhly-knyzhky/rizni', NULL, NULL, NULL, NULL, NULL, NULL),
(11113, 11124, 1, 'Nillkin', 'chokhly/htc/chokhly-knyzhky/nillkin', NULL, NULL, NULL, NULL, NULL, NULL),
(11114, 11125, 1, 'Накладки', 'chokhly/htc/nakladky', NULL, NULL, NULL, NULL, NULL, NULL),
(11115, 11126, 1, 'Red Angel', 'chokhly/htc/nakladky/red-angel', NULL, NULL, NULL, NULL, NULL, NULL),
(11116, 11127, 1, 'Original Silicon Case', 'chokhly/htc/nakladky/original-silicon-case', NULL, NULL, NULL, NULL, NULL, NULL),
(11117, 11128, 1, 'Ultra Thin', 'chokhly/htc/nakladky/ultra-thin', NULL, NULL, NULL, NULL, NULL, NULL),
(11118, 11129, 1, 'Yoobao', 'chokhly/htc/nakladky/yoobao', NULL, NULL, NULL, NULL, NULL, NULL),
(11119, 11130, 1, 'Kashi', 'chokhly/htc/nakladky/kashi', NULL, NULL, NULL, NULL, NULL, NULL),
(11120, 11131, 1, 'JZZS', 'chokhly/htc/nakladky/jzzs', NULL, NULL, NULL, NULL, NULL, NULL),
(11121, 11132, 1, 'Modeall', 'chokhly/htc/nakladky/modeall', NULL, NULL, NULL, NULL, NULL, NULL),
(11122, 11133, 1, 'TPU', 'chokhly/htc/nakladky/tpu', NULL, NULL, NULL, NULL, NULL, NULL),
(11123, 11134, 1, 'Nillkin', 'chokhly/htc/nakladky/nillkin', NULL, NULL, NULL, NULL, NULL, NULL),
(11124, 11135, 1, 'Cherry', 'chokhly/htc/nakladky/cherry', NULL, NULL, NULL, NULL, NULL, NULL),
(11125, 11136, 1, 'iCover', 'chokhly/htc/nakladky/icover', NULL, NULL, NULL, NULL, NULL, NULL),
(11126, 11137, 1, 'Різні', 'chokhly/htc/nakladky/rizni', NULL, NULL, NULL, NULL, NULL, NULL),
(11127, 11138, 1, 'SGP', 'chokhly/htc/nakladky/sgp', NULL, NULL, NULL, NULL, NULL, NULL),
(11128, 11139, 1, 'Momax', 'chokhly/htc/nakladky/momax', NULL, NULL, NULL, NULL, NULL, NULL),
(11129, 11140, 1, 'Speck', 'chokhly/htc/nakladky/speck', NULL, NULL, NULL, NULL, NULL, NULL),
(11130, 11141, 1, 'Remax', 'chokhly/htc/nakladky/remax', NULL, NULL, NULL, NULL, NULL, NULL),
(11131, 11142, 1, 'Накладки силіконові Capdase', 'chokhly/htc/nakladky-sylikonovi-capdase', NULL, NULL, NULL, NULL, NULL, NULL),
(11132, 11143, 1, 'Бампера', 'chokhly/htc/bampera', NULL, NULL, NULL, NULL, NULL, NULL),
(11133, 11144, 1, 'Чохол на пояс', 'chokhly/htc/chokhol-na-poyas', NULL, NULL, NULL, NULL, NULL, NULL),
(11134, 11145, 1, 'Original 100%', 'chokhly/htc/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(11135, 11146, 1, 'Sony Ericsson, Sony', 'chokhly/sony-ericsson-sony', NULL, NULL, NULL, NULL, NULL, NULL),
(11136, 11147, 1, 'Книжки', 'chokhly/sony-ericsson-sony/knyzhky', NULL, NULL, NULL, NULL, NULL, NULL),
(11137, 11148, 1, 'Brum', 'chokhly/sony-ericsson-sony/knyzhky/brum', NULL, NULL, NULL, NULL, NULL, NULL),
(11138, 11149, 1, 'СМА', 'chokhly/sony-ericsson-sony/knyzhky/sma', NULL, NULL, NULL, NULL, NULL, NULL),
(11139, 11150, 1, 'Atlanta', 'chokhly/sony-ericsson-sony/knyzhky/atlanta', NULL, NULL, NULL, NULL, NULL, NULL),
(11140, 11151, 1, 'Melkco', 'chokhly/sony-ericsson-sony/knyzhky/melkco', NULL, NULL, NULL, NULL, NULL, NULL),
(11141, 11152, 1, 'Chic Case', 'chokhly/sony-ericsson-sony/knyzhky/chic-case', NULL, NULL, NULL, NULL, NULL, NULL),
(11142, 11153, 1, 'Nillkin', 'chokhly/sony-ericsson-sony/knyzhky/nillkin', NULL, NULL, NULL, NULL, NULL, NULL),
(11143, 11154, 1, 'Накладки', 'chokhly/sony-ericsson-sony/nakladky', NULL, NULL, NULL, NULL, NULL, NULL),
(11144, 11155, 1, 'Red Angel', 'chokhly/sony-ericsson-sony/nakladky/red-angel', NULL, NULL, NULL, NULL, NULL, NULL),
(11145, 11156, 1, 'Original Silicon Case', 'chokhly/sony-ericsson-sony/nakladky/original-silicon-case', NULL, NULL, NULL, NULL, NULL, NULL),
(11146, 11157, 1, 'Modeall', 'chokhly/sony-ericsson-sony/nakladky/modeall', NULL, NULL, NULL, NULL, NULL, NULL),
(11147, 11158, 1, 'TPU', 'chokhly/sony-ericsson-sony/nakladky/tpu', NULL, NULL, NULL, NULL, NULL, NULL),
(11148, 11159, 1, 'Ultra Thin', 'chokhly/sony-ericsson-sony/nakladky/ultra-thin', NULL, NULL, NULL, NULL, NULL, NULL),
(11149, 11160, 1, 'Melkco', 'chokhly/sony-ericsson-sony/nakladky/melkco', NULL, NULL, NULL, NULL, NULL, NULL),
(11150, 11161, 1, 'SGP', 'chokhly/sony-ericsson-sony/nakladky/sgp', NULL, NULL, NULL, NULL, NULL, NULL),
(11151, 11162, 1, 'Cherry', 'chokhly/sony-ericsson-sony/nakladky/cherry', NULL, NULL, NULL, NULL, NULL, NULL),
(11152, 11163, 1, 'Remax', 'chokhly/sony-ericsson-sony/nakladky/remax', NULL, NULL, NULL, NULL, NULL, NULL),
(11153, 11164, 1, 'Накладки силіконові Capdase', 'chokhly/sony-ericsson-sony/nakladky-sylikonovi-capdase', NULL, NULL, NULL, NULL, NULL, NULL),
(11154, 11165, 1, 'Бампера', 'chokhly/sony-ericsson-sony/bampera', NULL, NULL, NULL, NULL, NULL, NULL),
(11155, 11166, 1, 'Original 100%', 'chokhly/sony-ericsson-sony/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(11156, 11167, 1, 'LG', 'chokhly/lg', NULL, NULL, NULL, NULL, NULL, NULL),
(11157, 11168, 1, 'Книжки', 'chokhly/lg/knyzhky', NULL, NULL, NULL, NULL, NULL, NULL),
(11158, 11169, 1, 'Brum', 'chokhly/lg/knyzhky/brum', NULL, NULL, NULL, NULL, NULL, NULL),
(11159, 11170, 1, 'Original Flip Case', 'chokhly/lg/knyzhky/original-flip-case', NULL, NULL, NULL, NULL, NULL, NULL),
(11160, 11171, 1, 'Melkco', 'chokhly/lg/knyzhky/melkco', NULL, NULL, NULL, NULL, NULL, NULL),
(11161, 11172, 1, 'Atlanta', 'chokhly/lg/knyzhky/atlanta', NULL, NULL, NULL, NULL, NULL, NULL),
(11162, 11173, 1, 'CMA', 'chokhly/lg/knyzhky/cma', NULL, NULL, NULL, NULL, NULL, NULL),
(11163, 11174, 1, 'Chic Case', 'chokhly/lg/knyzhky/chic-case', NULL, NULL, NULL, NULL, NULL, NULL),
(11164, 11175, 1, 'Nillkin', 'chokhly/lg/knyzhky/nillkin', NULL, NULL, NULL, NULL, NULL, NULL),
(11165, 11176, 1, 'VOIA', 'chokhly/lg/knyzhky/voia', NULL, NULL, NULL, NULL, NULL, NULL),
(11166, 11177, 1, 'Goospery', 'chokhly/lg/knyzhky/goospery', NULL, NULL, NULL, NULL, NULL, NULL),
(11167, 11178, 1, 'Накладки', 'chokhly/lg/nakladky', NULL, NULL, NULL, NULL, NULL, NULL),
(11168, 11179, 1, 'Original Silicon Case', 'chokhly/lg/nakladky/original-silicon-case', NULL, NULL, NULL, NULL, NULL, NULL),
(11169, 11180, 1, 'Kashi', 'chokhly/lg/nakladky/kashi', NULL, NULL, NULL, NULL, NULL, NULL),
(11170, 11181, 1, 'TPU', 'chokhly/lg/nakladky/tpu', NULL, NULL, NULL, NULL, NULL, NULL),
(11171, 11182, 1, 'SGP', 'chokhly/lg/nakladky/sgp', NULL, NULL, NULL, NULL, NULL, NULL),
(11172, 11183, 1, 'Cherry', 'chokhly/lg/nakladky/cherry', NULL, NULL, NULL, NULL, NULL, NULL),
(11173, 11184, 1, 'Nillkin', 'chokhly/lg/nakladky/nillkin', NULL, NULL, NULL, NULL, NULL, NULL),
(11174, 11185, 1, 'Remax', 'chokhly/lg/nakladky/remax', NULL, NULL, NULL, NULL, NULL, NULL),
(11175, 11186, 1, 'Накладки силіконові Capdase', 'chokhly/lg/nakladky-sylikonovi-capdase', NULL, NULL, NULL, NULL, NULL, NULL),
(11176, 11187, 1, 'Бампера', 'chokhly/lg/bampera', NULL, NULL, NULL, NULL, NULL, NULL),
(11177, 11188, 1, 'Original 100%', 'chokhly/lg/original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(11178, 11189, 1, 'Універсальні, різні', 'chokhly/universalni-rizni', NULL, NULL, NULL, NULL, NULL, NULL),
(11179, 11190, 1, 'Книжки', 'chokhly/universalni-rizni/knyzhky', NULL, NULL, NULL, NULL, NULL, NULL),
(11180, 11191, 1, 'Brum', 'chokhly/universalni-rizni/knyzhky/brum', NULL, NULL, NULL, NULL, NULL, NULL),
(11181, 11192, 1, 'Різні', 'chokhly/universalni-rizni/knyzhky/rizni', NULL, NULL, NULL, NULL, NULL, NULL),
(11182, 11193, 1, 'L/C', 'chokhly/universalni-rizni/knyzhky/l-c', NULL, NULL, NULL, NULL, NULL, NULL),
(11183, 11194, 1, 'CMA', 'chokhly/universalni-rizni/knyzhky/cma', NULL, NULL, NULL, NULL, NULL, NULL),
(11184, 11195, 1, 'Колби', 'chokhly/universalni-rizni/kolby', NULL, NULL, NULL, NULL, NULL, NULL),
(11185, 11196, 1, 'CMA', 'chokhly/universalni-rizni/kolby/cma', NULL, NULL, NULL, NULL, NULL, NULL),
(11186, 11197, 1, 'Nokia', 'chokhly/universalni-rizni/kolby/cma/nokia', NULL, NULL, NULL, NULL, NULL, NULL),
(11187, 11198, 1, 'HTC', 'chokhly/universalni-rizni/kolby/cma/htc', NULL, NULL, NULL, NULL, NULL, NULL),
(11188, 11199, 1, 'Samsung', 'chokhly/universalni-rizni/kolby/cma/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(11189, 11200, 1, 'Apple iphone', 'chokhly/universalni-rizni/kolby/cma/apple-iphone', NULL, NULL, NULL, NULL, NULL, NULL),
(11190, 11201, 1, 'Fly', 'chokhly/universalni-rizni/kolby/cma/fly', NULL, NULL, NULL, NULL, NULL, NULL),
(11191, 11202, 1, 'Lenovo', 'chokhly/universalni-rizni/kolby/cma/lenovo', NULL, NULL, NULL, NULL, NULL, NULL),
(11192, 11203, 1, 'Sport', 'chokhly/universalni-rizni/kolby/sport', NULL, NULL, NULL, NULL, NULL, NULL),
(11193, 11204, 1, 'Різні', 'chokhly/universalni-rizni/kolby/rizni', NULL, NULL, NULL, NULL, NULL, NULL),
(11194, 11205, 1, 'Sale', 'chokhly/universalni-rizni/kolby/sale', NULL, NULL, NULL, NULL, NULL, NULL),
(11195, 11206, 1, 'Кисети', 'chokhly/universalni-rizni/kysety', NULL, NULL, NULL, NULL, NULL, NULL),
(11196, 11207, 1, 'Brum', 'chokhly/universalni-rizni/kysety/brum', NULL, NULL, NULL, NULL, NULL, NULL),
(11197, 11208, 1, 'CMA', 'chokhly/universalni-rizni/kysety/cma', NULL, NULL, NULL, NULL, NULL, NULL),
(11198, 11209, 1, 'Brand', 'chokhly/universalni-rizni/kysety/brand', NULL, NULL, NULL, NULL, NULL, NULL),
(11199, 11210, 1, 'Sale', 'chokhly/universalni-rizni/kysety/sale', NULL, NULL, NULL, NULL, NULL, NULL),
(11200, 11211, 1, 'Sport', 'chokhly/universalni-rizni/sport', NULL, NULL, NULL, NULL, NULL, NULL),
(11201, 11212, 1, 'На пояс', 'chokhly/universalni-rizni/na-poyas', NULL, NULL, NULL, NULL, NULL, NULL),
(11202, 11213, 1, 'Накладки', 'chokhly/universalni-rizni/nakladky', NULL, NULL, NULL, NULL, NULL, NULL),
(11203, 11214, 1, 'Мішечок', 'chokhly/universalni-rizni/mishechok', NULL, NULL, NULL, NULL, NULL, NULL),
(11204, 11215, 1, 'Brand', 'chokhly/universalni-rizni/mishechok/brand', NULL, NULL, NULL, NULL, NULL, NULL),
(11205, 11216, 1, 'Різне', 'chokhly/universalni-rizni/mishechok/rizne', NULL, NULL, NULL, NULL, NULL, NULL),
(11206, 11217, 1, 'Lenovo', 'chokhly/lenovo', NULL, NULL, NULL, NULL, NULL, NULL),
(11207, 11218, 1, 'Original Silicon Case', 'chokhly/lenovo/original-silicon-case', NULL, NULL, NULL, NULL, NULL, NULL),
(11208, 11219, 1, 'Накладки', 'chokhly/lenovo/nakladky', NULL, NULL, NULL, NULL, NULL, NULL),
(11209, 11220, 1, 'Nillkin', 'chokhly/lenovo/nakladky/nillkin', NULL, NULL, NULL, NULL, NULL, NULL),
(11210, 11221, 1, 'SGP', 'chokhly/lenovo/nakladky/sgp', NULL, NULL, NULL, NULL, NULL, NULL),
(11211, 11222, 1, 'Cherry', 'chokhly/lenovo/nakladky/cherry', NULL, NULL, NULL, NULL, NULL, NULL),
(11212, 11223, 1, 'Remax', 'chokhly/lenovo/nakladky/remax', NULL, NULL, NULL, NULL, NULL, NULL),
(11213, 11224, 1, 'Книжки', 'chokhly/lenovo/knyzhky', NULL, NULL, NULL, NULL, NULL, NULL),
(11214, 11225, 1, 'Brum', 'chokhly/lenovo/knyzhky/brum', NULL, NULL, NULL, NULL, NULL, NULL),
(11215, 11226, 1, 'Original Flip Cover', 'chokhly/lenovo/knyzhky/original-flip-cover', NULL, NULL, NULL, NULL, NULL, NULL),
(11216, 11227, 1, 'Melkco', 'chokhly/lenovo/knyzhky/melkco', NULL, NULL, NULL, NULL, NULL, NULL),
(11217, 11228, 1, 'Atlanta', 'chokhly/lenovo/knyzhky/atlanta', NULL, NULL, NULL, NULL, NULL, NULL),
(11218, 11229, 1, 'Nillkin', 'chokhly/lenovo/knyzhky/nillkin', NULL, NULL, NULL, NULL, NULL, NULL),
(11219, 11230, 1, 'CMA', 'chokhly/lenovo/knyzhky/cma', NULL, NULL, NULL, NULL, NULL, NULL),
(11220, 11231, 1, 'Folio', 'chokhly/lenovo/knyzhky/folio', NULL, NULL, NULL, NULL, NULL, NULL),
(11221, 11232, 1, 'Goospery', 'chokhly/lenovo/knyzhky/goospery', NULL, NULL, NULL, NULL, NULL, NULL),
(11222, 11233, 1, 'Накладки силікон Capdase', 'chokhly/lenovo/nakladky-sylikon-capdase', NULL, NULL, NULL, NULL, NULL, NULL),
(11223, 11234, 1, 'Huawei', 'chokhly/huawei', NULL, NULL, NULL, NULL, NULL, NULL),
(11224, 11235, 1, 'Книжки', 'chokhly/huawei/knyzhky', NULL, NULL, NULL, NULL, NULL, NULL),
(11225, 11236, 1, 'Original Flip Cover', 'chokhly/huawei/knyzhky/original-flip-cover', NULL, NULL, NULL, NULL, NULL, NULL),
(11226, 11237, 1, 'Hoco', 'chokhly/huawei/knyzhky/hoco', NULL, NULL, NULL, NULL, NULL, NULL),
(11227, 11238, 1, 'Atlanta', 'chokhly/huawei/knyzhky/atlanta', NULL, NULL, NULL, NULL, NULL, NULL),
(11228, 11239, 1, 'Brum', 'chokhly/huawei/knyzhky/brum', NULL, NULL, NULL, NULL, NULL, NULL),
(11229, 11240, 1, 'Nillkin', 'chokhly/huawei/knyzhky/nillkin', NULL, NULL, NULL, NULL, NULL, NULL),
(11230, 11241, 1, 'Чохол накладка', 'chokhly/huawei/chokhol-nakladka', NULL, NULL, NULL, NULL, NULL, NULL),
(11231, 11242, 1, 'Original Silicon Case', 'chokhly/huawei/chokhol-nakladka/original-silicon-case', NULL, NULL, NULL, NULL, NULL, NULL),
(11232, 11243, 1, 'Nillkin', 'chokhly/huawei/chokhol-nakladka/nillkin', NULL, NULL, NULL, NULL, NULL, NULL),
(11233, 11244, 1, 'SGP', 'chokhly/huawei/chokhol-nakladka/sgp', NULL, NULL, NULL, NULL, NULL, NULL),
(11234, 11245, 1, 'Acer', 'chokhly/acer', NULL, NULL, NULL, NULL, NULL, NULL),
(11235, 11246, 1, 'Книжка', 'chokhly/acer/knyzhka', NULL, NULL, NULL, NULL, NULL, NULL),
(11236, 11247, 1, 'Forsa', 'chokhly/acer/knyzhka/forsa', NULL, NULL, NULL, NULL, NULL, NULL),
(11237, 11248, 1, 'Накладки', 'chokhly/acer/nakladky', NULL, NULL, NULL, NULL, NULL, NULL),
(11238, 11249, 1, 'Original Silicon Case', 'chokhly/acer/nakladky/original-silicon-case', NULL, NULL, NULL, NULL, NULL, NULL),
(11239, 11250, 1, 'HP', 'chokhly/hp', NULL, NULL, NULL, NULL, NULL, NULL),
(11240, 11251, 1, 'BlackBerry', 'chokhly/blackberry', NULL, NULL, NULL, NULL, NULL, NULL),
(11241, 11252, 1, 'Asus', 'chokhly/asus', NULL, NULL, NULL, NULL, NULL, NULL),
(11242, 11253, 1, 'Накладки', 'chokhly/asus/nakladky', NULL, NULL, NULL, NULL, NULL, NULL),
(11243, 11254, 1, 'Cherry', 'chokhly/asus/nakladky/cherry', NULL, NULL, NULL, NULL, NULL, NULL),
(11244, 11255, 1, 'Remax', 'chokhly/asus/nakladky/remax', NULL, NULL, NULL, NULL, NULL, NULL),
(11245, 11256, 1, 'SGP', 'chokhly/asus/nakladky/sgp', NULL, NULL, NULL, NULL, NULL, NULL),
(11246, 11257, 1, 'Книжки', 'chokhly/asus/knyzhky', NULL, NULL, NULL, NULL, NULL, NULL),
(11247, 11258, 1, 'Nillkin', 'chokhly/asus/knyzhky/nillkin', NULL, NULL, NULL, NULL, NULL, NULL),
(11248, 11259, 1, 'Folio', 'chokhly/asus/knyzhky/folio', NULL, NULL, NULL, NULL, NULL, NULL),
(11249, 11260, 1, 'СМА', 'chokhly/asus/knyzhky/sma', NULL, NULL, NULL, NULL, NULL, NULL),
(11250, 11261, 1, 'Fly', 'chokhly/fly', NULL, NULL, NULL, NULL, NULL, NULL),
(11251, 11262, 1, 'Чохол книжка', 'chokhly/fly/chokhol-knyzhka', NULL, NULL, NULL, NULL, NULL, NULL),
(11252, 11263, 1, 'Brum', 'chokhly/fly/chokhol-knyzhka/brum', NULL, NULL, NULL, NULL, NULL, NULL),
(11253, 11264, 1, 'Накладки', 'chokhly/fly/nakladky', NULL, NULL, NULL, NULL, NULL, NULL),
(11254, 11265, 1, 'Line X-series', 'chokhly/fly/nakladky/line-x-series', NULL, NULL, NULL, NULL, NULL, NULL),
(11255, 11266, 1, 'Alcatel', 'chokhly/alcatel', NULL, NULL, NULL, NULL, NULL, NULL),
(11256, 11267, 1, 'Original Silicon Case', 'chokhly/alcatel/original-silicon-case', NULL, NULL, NULL, NULL, NULL, NULL),
(11257, 11268, 1, 'Xiaomi', 'chokhly/xiaomi', NULL, NULL, NULL, NULL, NULL, NULL),
(11258, 11269, 1, 'Накладки', 'chokhly/xiaomi/nakladky', NULL, NULL, NULL, NULL, NULL, NULL),
(11259, 11270, 1, 'Remax', 'chokhly/xiaomi/nakladky/remax', NULL, NULL, NULL, NULL, NULL, NULL),
(11260, 11271, 1, 'Чохол книжка', 'chokhly/xiaomi/chokhol-knyzhka', NULL, NULL, NULL, NULL, NULL, NULL),
(11261, 11272, 1, 'СМА', 'chokhly/xiaomi/chokhol-knyzhka/sma', NULL, NULL, NULL, NULL, NULL, NULL),
(11262, 11273, 1, 'Motorola', 'chokhly/motorola', NULL, NULL, NULL, NULL, NULL, NULL),
(11263, 11274, 1, 'Книжки', 'chokhly/motorola/knyzhky', NULL, NULL, NULL, NULL, NULL, NULL),
(11264, 11275, 1, 'Nillkin', 'chokhly/motorola/knyzhky/nillkin', NULL, NULL, NULL, NULL, NULL, NULL),
(11265, 11276, 1, 'СМА', 'chokhly/motorola/knyzhky/sma', NULL, NULL, NULL, NULL, NULL, NULL),
(11266, 11277, 1, 'Meizu', 'chokhly/meizu', NULL, NULL, NULL, NULL, NULL, NULL),
(11267, 11278, 1, 'Чохол книжка', 'chokhly/meizu/chokhol-knyzhka', NULL, NULL, NULL, NULL, NULL, NULL),
(11268, 11279, 1, 'СМА', 'chokhly/meizu/chokhol-knyzhka/sma', NULL, NULL, NULL, NULL, NULL, NULL),
(11269, 11280, 1, 'Захисні плівки та скло', 'zakhysni-plivky-ta-sklo', NULL, NULL, NULL, NULL, NULL, NULL),
(11270, 11281, 1, 'Звичайні', 'zakhysni-plivky-ta-sklo/zvychayni', NULL, NULL, NULL, NULL, NULL, NULL),
(11271, 11282, 1, 'Apple', 'zakhysni-plivky-ta-sklo/zvychayni/apple', NULL, NULL, NULL, NULL, NULL, NULL),
(11272, 11283, 1, 'Samsung', 'zakhysni-plivky-ta-sklo/zvychayni/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(11273, 11284, 1, 'Nokia', 'zakhysni-plivky-ta-sklo/zvychayni/nokia', NULL, NULL, NULL, NULL, NULL, NULL),
(11274, 11285, 1, 'HTC', 'zakhysni-plivky-ta-sklo/zvychayni/htc', NULL, NULL, NULL, NULL, NULL, NULL),
(11275, 11286, 1, 'LG', 'zakhysni-plivky-ta-sklo/zvychayni/lg', NULL, NULL, NULL, NULL, NULL, NULL),
(11276, 11287, 1, 'Sony Ericsson, Sony', 'zakhysni-plivky-ta-sklo/zvychayni/sony-ericsson-sony', NULL, NULL, NULL, NULL, NULL, NULL),
(11277, 11288, 1, 'Універсальні', 'zakhysni-plivky-ta-sklo/zvychayni/universalni', NULL, NULL, NULL, NULL, NULL, NULL),
(11278, 11289, 1, 'Acer', 'zakhysni-plivky-ta-sklo/zvychayni/acer', NULL, NULL, NULL, NULL, NULL, NULL),
(11279, 11290, 1, 'Asus', 'zakhysni-plivky-ta-sklo/zvychayni/asus', NULL, NULL, NULL, NULL, NULL, NULL),
(11280, 11291, 1, 'Lenovo', 'zakhysni-plivky-ta-sklo/zvychayni/lenovo', NULL, NULL, NULL, NULL, NULL, NULL),
(11281, 11292, 1, 'Люкс', 'zakhysni-plivky-ta-sklo/lyuks', NULL, NULL, NULL, NULL, NULL, NULL),
(11282, 11293, 1, 'Apple', 'zakhysni-plivky-ta-sklo/lyuks/apple', NULL, NULL, NULL, NULL, NULL, NULL),
(11283, 11294, 1, 'Samsung', 'zakhysni-plivky-ta-sklo/lyuks/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(11284, 11295, 1, 'Nokia/Microsoft', 'zakhysni-plivky-ta-sklo/lyuks/nokia-microsoft', NULL, NULL, NULL, NULL, NULL, NULL),
(11285, 11296, 1, 'HTC', 'zakhysni-plivky-ta-sklo/lyuks/htc', NULL, NULL, NULL, NULL, NULL, NULL),
(11286, 11297, 1, 'LG', 'zakhysni-plivky-ta-sklo/lyuks/lg', NULL, NULL, NULL, NULL, NULL, NULL),
(11287, 11298, 1, 'Sony Ericsson, Sony', 'zakhysni-plivky-ta-sklo/lyuks/sony-ericsson-sony', NULL, NULL, NULL, NULL, NULL, NULL),
(11288, 11299, 1, 'Універсальні', 'zakhysni-plivky-ta-sklo/lyuks/universalni', NULL, NULL, NULL, NULL, NULL, NULL),
(11289, 11300, 1, 'Lenovo', 'zakhysni-plivky-ta-sklo/lyuks/lenovo', NULL, NULL, NULL, NULL, NULL, NULL),
(11290, 11301, 1, 'Huawei', 'zakhysni-plivky-ta-sklo/lyuks/huawei', NULL, NULL, NULL, NULL, NULL, NULL),
(11291, 11302, 1, 'Fly', 'zakhysni-plivky-ta-sklo/lyuks/fly', NULL, NULL, NULL, NULL, NULL, NULL),
(11292, 11303, 1, 'XIAOMI', 'zakhysni-plivky-ta-sklo/lyuks/xiaomi', NULL, NULL, NULL, NULL, NULL, NULL),
(11293, 11304, 1, 'Asus', 'zakhysni-plivky-ta-sklo/lyuks/asus', NULL, NULL, NULL, NULL, NULL, NULL),
(11294, 11305, 1, 'Meizu', 'zakhysni-plivky-ta-sklo/lyuks/meizu', NULL, NULL, NULL, NULL, NULL, NULL),
(11295, 11306, 1, 'Premium', 'zakhysni-plivky-ta-sklo/premium', NULL, NULL, NULL, NULL, NULL, NULL),
(11296, 11307, 1, 'Apple', 'zakhysni-plivky-ta-sklo/premium/apple', NULL, NULL, NULL, NULL, NULL, NULL),
(11297, 11308, 1, 'Samsung', 'zakhysni-plivky-ta-sklo/premium/samsung', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `e_content_info` (`id`, `content_id`, `languages_id`, `name`, `url`, `h1`, `title`, `keywords`, `description`, `intro`, `content`) VALUES
(11298, 11309, 1, 'Nokia', 'zakhysni-plivky-ta-sklo/premium/nokia', NULL, NULL, NULL, NULL, NULL, NULL),
(11299, 11310, 1, 'HTC', 'zakhysni-plivky-ta-sklo/premium/htc', NULL, NULL, NULL, NULL, NULL, NULL),
(11300, 11311, 1, 'LG', 'zakhysni-plivky-ta-sklo/premium/lg', NULL, NULL, NULL, NULL, NULL, NULL),
(11301, 11312, 1, 'Sony Ericsson, Sony', 'zakhysni-plivky-ta-sklo/premium/sony-ericsson-sony', NULL, NULL, NULL, NULL, NULL, NULL),
(11302, 11313, 1, 'Універсальні', 'zakhysni-plivky-ta-sklo/premium/universalni', NULL, NULL, NULL, NULL, NULL, NULL),
(11303, 11314, 1, 'Lenovo', 'zakhysni-plivky-ta-sklo/premium/lenovo', NULL, NULL, NULL, NULL, NULL, NULL),
(11304, 11315, 1, 'FLY', 'zakhysni-plivky-ta-sklo/premium/fly', NULL, NULL, NULL, NULL, NULL, NULL),
(11305, 11316, 1, 'Протиударні', 'zakhysni-plivky-ta-sklo/protyudarni', NULL, NULL, NULL, NULL, NULL, NULL),
(11306, 11317, 1, 'Apple', 'zakhysni-plivky-ta-sklo/protyudarni/apple', NULL, NULL, NULL, NULL, NULL, NULL),
(11307, 11318, 1, 'Samsung', 'zakhysni-plivky-ta-sklo/protyudarni/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(11308, 11319, 1, 'Nokia', 'zakhysni-plivky-ta-sklo/protyudarni/nokia', NULL, NULL, NULL, NULL, NULL, NULL),
(11309, 11320, 1, 'HTC', 'zakhysni-plivky-ta-sklo/protyudarni/htc', NULL, NULL, NULL, NULL, NULL, NULL),
(11310, 11321, 1, 'Універсальні', 'zakhysni-plivky-ta-sklo/protyudarni/universalni', NULL, NULL, NULL, NULL, NULL, NULL),
(11311, 11322, 1, 'Lenovo', 'zakhysni-plivky-ta-sklo/protyudarni/lenovo', NULL, NULL, NULL, NULL, NULL, NULL),
(11312, 11323, 1, 'Yoobao', 'zakhysni-plivky-ta-sklo/yoobao', NULL, NULL, NULL, NULL, NULL, NULL),
(11313, 11324, 1, 'Apple', 'zakhysni-plivky-ta-sklo/yoobao/apple', NULL, NULL, NULL, NULL, NULL, NULL),
(11314, 11325, 1, 'Samsung', 'zakhysni-plivky-ta-sklo/yoobao/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(11315, 11326, 1, 'Nokia', 'zakhysni-plivky-ta-sklo/yoobao/nokia', NULL, NULL, NULL, NULL, NULL, NULL),
(11316, 11327, 1, 'HTC', 'zakhysni-plivky-ta-sklo/yoobao/htc', NULL, NULL, NULL, NULL, NULL, NULL),
(11317, 11328, 1, 'Blackberry', 'zakhysni-plivky-ta-sklo/yoobao/blackberry', NULL, NULL, NULL, NULL, NULL, NULL),
(11318, 11329, 1, 'Sony, Sony Ericsson', 'zakhysni-plivky-ta-sklo/yoobao/sony-sony-ericsson', NULL, NULL, NULL, NULL, NULL, NULL),
(11319, 11330, 1, 'Motorola', 'zakhysni-plivky-ta-sklo/yoobao/motorola', NULL, NULL, NULL, NULL, NULL, NULL),
(11320, 11331, 1, 'Різні', 'zakhysni-plivky-ta-sklo/yoobao/rizni', NULL, NULL, NULL, NULL, NULL, NULL),
(11321, 11332, 1, 'Red Angel', 'zakhysni-plivky-ta-sklo/red-angel', NULL, NULL, NULL, NULL, NULL, NULL),
(11322, 11333, 1, 'Apple', 'zakhysni-plivky-ta-sklo/red-angel/apple', NULL, NULL, NULL, NULL, NULL, NULL),
(11323, 11334, 1, 'HTC', 'zakhysni-plivky-ta-sklo/red-angel/htc', NULL, NULL, NULL, NULL, NULL, NULL),
(11324, 11335, 1, 'Захисне скло', 'zakhysni-plivky-ta-sklo/zakhysne-sklo', NULL, NULL, NULL, NULL, NULL, NULL),
(11325, 11336, 1, 'Apple', 'zakhysni-plivky-ta-sklo/zakhysne-sklo/apple', NULL, NULL, NULL, NULL, NULL, NULL),
(11326, 11337, 1, 'Nokia', 'zakhysni-plivky-ta-sklo/zakhysne-sklo/nokia', NULL, NULL, NULL, NULL, NULL, NULL),
(11327, 11338, 1, 'Samsung', 'zakhysni-plivky-ta-sklo/zakhysne-sklo/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(11328, 11339, 1, 'Lenovo', 'zakhysni-plivky-ta-sklo/zakhysne-sklo/lenovo', NULL, NULL, NULL, NULL, NULL, NULL),
(11329, 11340, 1, 'HTC', 'zakhysni-plivky-ta-sklo/zakhysne-sklo/htc', NULL, NULL, NULL, NULL, NULL, NULL),
(11330, 11341, 1, 'LG', 'zakhysni-plivky-ta-sklo/zakhysne-sklo/lg', NULL, NULL, NULL, NULL, NULL, NULL),
(11331, 11342, 1, 'Sony', 'zakhysni-plivky-ta-sklo/zakhysne-sklo/sony', NULL, NULL, NULL, NULL, NULL, NULL),
(11332, 11343, 1, 'Huawei', 'zakhysni-plivky-ta-sklo/zakhysne-sklo/huawei', NULL, NULL, NULL, NULL, NULL, NULL),
(11333, 11344, 1, 'Meizu', 'zakhysni-plivky-ta-sklo/zakhysne-sklo/meizu', NULL, NULL, NULL, NULL, NULL, NULL),
(11334, 11345, 1, 'Xiaomi', 'zakhysni-plivky-ta-sklo/zakhysne-sklo/xiaomi', NULL, NULL, NULL, NULL, NULL, NULL),
(11335, 11346, 1, 'Asus', 'zakhysni-plivky-ta-sklo/zakhysne-sklo/asus', NULL, NULL, NULL, NULL, NULL, NULL),
(11336, 11347, 1, 'Motorola', 'zakhysni-plivky-ta-sklo/zakhysne-sklo/motorola', NULL, NULL, NULL, NULL, NULL, NULL),
(11337, 11348, 1, 'Універсальні', 'zakhysni-plivky-ta-sklo/zakhysne-sklo/universalni', NULL, NULL, NULL, NULL, NULL, NULL),
(11338, 11349, 1, 'Різні', 'zakhysni-plivky-ta-sklo/zakhysne-sklo/rizni', NULL, NULL, NULL, NULL, NULL, NULL),
(11339, 11350, 1, 'Різне', 'zakhysni-plivky-ta-sklo/rizne', NULL, NULL, NULL, NULL, NULL, NULL),
(11340, 11351, 1, 'Apple', 'zakhysni-plivky-ta-sklo/rizne/apple', NULL, NULL, NULL, NULL, NULL, NULL),
(11341, 11352, 1, 'Alcatel', 'zakhysni-plivky-ta-sklo/rizne/alcatel', NULL, NULL, NULL, NULL, NULL, NULL),
(11342, 11353, 1, 'Asus', 'zakhysni-plivky-ta-sklo/rizne/asus', NULL, NULL, NULL, NULL, NULL, NULL),
(11343, 11354, 1, 'Аксесуари різні', 'aksesuary-rizni', NULL, NULL, NULL, NULL, NULL, NULL),
(11344, 11355, 1, 'Стилуси', 'aksesuary-rizni/stylusy', NULL, NULL, NULL, NULL, NULL, NULL),
(11345, 11356, 1, 'Брелки', 'aksesuary-rizni/brelky', NULL, NULL, NULL, NULL, NULL, NULL),
(11346, 11357, 1, 'Шнурок', 'aksesuary-rizni/shnurok', NULL, NULL, NULL, NULL, NULL, NULL),
(11347, 11358, 1, 'Докстанція', 'aksesuary-rizni/dokstantsiya', NULL, NULL, NULL, NULL, NULL, NULL),
(11348, 11359, 1, 'Підставка', 'aksesuary-rizni/pidstavka', NULL, NULL, NULL, NULL, NULL, NULL),
(11349, 11360, 1, 'Monopod', 'aksesuary-rizni/monopod', NULL, NULL, NULL, NULL, NULL, NULL),
(11350, 11361, 1, 'Різні', 'aksesuary-rizni/rizni', NULL, NULL, NULL, NULL, NULL, NULL),
(11351, 11362, 1, 'Гарнитури, навушники, AUX-перехідники та кабеля', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya', NULL, NULL, NULL, NULL, NULL, NULL),
(11352, 11363, 1, 'Гарнітури', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury', NULL, NULL, NULL, NULL, NULL, NULL),
(11353, 11364, 1, 'Nokia', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/nokia', NULL, NULL, NULL, NULL, NULL, NULL),
(11354, 11365, 1, 'High Copy', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/nokia/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(11355, 11366, 1, 'Original TW, original 100%', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/nokia/original-tw-original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(11356, 11367, 1, 'S-Music', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/nokia/s-music', NULL, NULL, NULL, NULL, NULL, NULL),
(11357, 11368, 1, 'Samsung', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(11358, 11369, 1, 'High Copy', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/samsung/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(11359, 11370, 1, 'Original TW, original 100%', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/samsung/original-tw-original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(11360, 11371, 1, 'S-Music', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/samsung/s-music', NULL, NULL, NULL, NULL, NULL, NULL),
(11361, 11372, 1, 'Sony Ericsson, Sony', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/sony-ericsson-sony', NULL, NULL, NULL, NULL, NULL, NULL),
(11362, 11373, 1, 'Original TW, original 100%', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/sony-ericsson-sony/original-tw-original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(11363, 11374, 1, 'High Copy', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/sony-ericsson-sony/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(11364, 11375, 1, 'S-Music', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/sony-ericsson-sony/s-music', NULL, NULL, NULL, NULL, NULL, NULL),
(11365, 11376, 1, 'LG', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/lg', NULL, NULL, NULL, NULL, NULL, NULL),
(11366, 11377, 1, 'High Copy', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/lg/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(11367, 11378, 1, 'Original TW. Original 100%', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/lg/original-tw-original-100', NULL, NULL, NULL, NULL, NULL, NULL),
(11368, 11379, 1, 'S-Music', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/lg/s-music', NULL, NULL, NULL, NULL, NULL, NULL),
(11369, 11380, 1, 'HTC', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/htc', NULL, NULL, NULL, NULL, NULL, NULL),
(11370, 11381, 1, 'Копія ААА клас', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/htc/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(11371, 11382, 1, 'Original TW', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/htc/original-tw', NULL, NULL, NULL, NULL, NULL, NULL),
(11372, 11383, 1, 'High Copy', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/htc/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(11373, 11384, 1, 'Siemens', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/siemens', NULL, NULL, NULL, NULL, NULL, NULL),
(11374, 11385, 1, 'Копія ААА клас', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/siemens/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(11375, 11386, 1, 'Best Quality, original', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/siemens/best-quality-original', NULL, NULL, NULL, NULL, NULL, NULL),
(11376, 11387, 1, 'Motorola', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/motorola', NULL, NULL, NULL, NULL, NULL, NULL),
(11377, 11388, 1, 'Копія ААА клас', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/motorola/kopiya-aaa-klas', NULL, NULL, NULL, NULL, NULL, NULL),
(11378, 11389, 1, 'High Copy', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/motorola/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(11379, 11390, 1, 'Перехідники та кабеля', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/perekhidnyky-ta-kabelya', NULL, NULL, NULL, NULL, NULL, NULL),
(11380, 11391, 1, 'Apple', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/apple', NULL, NULL, NULL, NULL, NULL, NULL),
(11381, 11392, 1, 'Lenovo', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/lenovo', NULL, NULL, NULL, NULL, NULL, NULL),
(11382, 11393, 1, 'High Copy', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/lenovo/high-copy', NULL, NULL, NULL, NULL, NULL, NULL),
(11383, 11394, 1, 'Huawei', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/huawei', NULL, NULL, NULL, NULL, NULL, NULL),
(11384, 11395, 1, 'Mi', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/mi', NULL, NULL, NULL, NULL, NULL, NULL),
(11385, 11396, 1, 'Meizu', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/meizu', NULL, NULL, NULL, NULL, NULL, NULL),
(11386, 11397, 1, 'Різні', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/garnitury/rizni', NULL, NULL, NULL, NULL, NULL, NULL),
(11387, 11398, 1, 'Bluetooth гарнітури', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/bluetooth-garnitury', NULL, NULL, NULL, NULL, NULL, NULL),
(11388, 11399, 1, 'Nokia', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/bluetooth-garnitury/nokia', NULL, NULL, NULL, NULL, NULL, NULL),
(11389, 11400, 1, 'Samsung', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/bluetooth-garnitury/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(11390, 11401, 1, 'Jabra', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/bluetooth-garnitury/jabra', NULL, NULL, NULL, NULL, NULL, NULL),
(11391, 11402, 1, 'Plantronics', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/bluetooth-garnitury/plantronics', NULL, NULL, NULL, NULL, NULL, NULL),
(11392, 11403, 1, 'Sony', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/bluetooth-garnitury/sony', NULL, NULL, NULL, NULL, NULL, NULL),
(11393, 11404, 1, 'Різні', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/bluetooth-garnitury/rizni', NULL, NULL, NULL, NULL, NULL, NULL),
(11394, 11405, 1, 'Аксесуари', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/bluetooth-garnitury/aksesuary', NULL, NULL, NULL, NULL, NULL, NULL),
(11395, 11406, 1, 'Remax', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/bluetooth-garnitury/remax', NULL, NULL, NULL, NULL, NULL, NULL),
(11396, 11407, 1, 'Навушники', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/navushnyky', NULL, NULL, NULL, NULL, NULL, NULL),
(11397, 11408, 1, 'Monster Beats by Dr. Dre', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/navushnyky/monster-beats-by-dr-dre', NULL, NULL, NULL, NULL, NULL, NULL),
(11398, 11409, 1, 'TDK', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/navushnyky/tdk', NULL, NULL, NULL, NULL, NULL, NULL),
(11399, 11410, 1, 'KOSS', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/navushnyky/koss', NULL, NULL, NULL, NULL, NULL, NULL),
(11400, 11411, 1, 'Sennheiser', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/navushnyky/sennheiser', NULL, NULL, NULL, NULL, NULL, NULL),
(11401, 11412, 1, 'Sony', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/navushnyky/sony', NULL, NULL, NULL, NULL, NULL, NULL),
(11402, 11413, 1, 'Weile', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/navushnyky/weile', NULL, NULL, NULL, NULL, NULL, NULL),
(11403, 11414, 1, 'Philips', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/navushnyky/philips', NULL, NULL, NULL, NULL, NULL, NULL),
(11404, 11415, 1, 'Різні', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/navushnyky/rizni', NULL, NULL, NULL, NULL, NULL, NULL),
(11405, 11416, 1, 'Soul', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/navushnyky/soul', NULL, NULL, NULL, NULL, NULL, NULL),
(11406, 11417, 1, 'Smusic', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/navushnyky/smusic', NULL, NULL, NULL, NULL, NULL, NULL),
(11407, 11418, 1, 'Diesel', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/navushnyky/diesel', NULL, NULL, NULL, NULL, NULL, NULL),
(11408, 11419, 1, 'Iriver', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/navushnyky/iriver', NULL, NULL, NULL, NULL, NULL, NULL),
(11409, 11420, 1, 'Nia', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/navushnyky/nia', NULL, NULL, NULL, NULL, NULL, NULL),
(11410, 11421, 1, 'Nike', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/navushnyky/nike', NULL, NULL, NULL, NULL, NULL, NULL),
(11411, 11422, 1, 'Panasonic', 'garnytury-navushnyky-aux-perekhidnyky-ta-kabelya/navushnyky/panasonic', NULL, NULL, NULL, NULL, NULL, NULL),
(11412, 11423, 1, 'USB кабеля, перехідники, адаптери', 'usb-kabelya-perekhidnyky-adaptery', NULL, NULL, NULL, NULL, NULL, NULL),
(11413, 11424, 1, 'Кабеля', 'usb-kabelya-perekhidnyky-adaptery/kabelya', NULL, NULL, NULL, NULL, NULL, NULL),
(11414, 11425, 1, 'Nokia', 'usb-kabelya-perekhidnyky-adaptery/kabelya/nokia', NULL, NULL, NULL, NULL, NULL, NULL),
(11415, 11426, 1, 'Samsung', 'usb-kabelya-perekhidnyky-adaptery/kabelya/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(11416, 11427, 1, 'Apple', 'usb-kabelya-perekhidnyky-adaptery/kabelya/apple', NULL, NULL, NULL, NULL, NULL, NULL),
(11417, 11428, 1, 'LG', 'usb-kabelya-perekhidnyky-adaptery/kabelya/lg', NULL, NULL, NULL, NULL, NULL, NULL),
(11418, 11429, 1, 'Sony Ericsson', 'usb-kabelya-perekhidnyky-adaptery/kabelya/sony-ericsson', NULL, NULL, NULL, NULL, NULL, NULL),
(11419, 11430, 1, 'Siemens', 'usb-kabelya-perekhidnyky-adaptery/kabelya/siemens', NULL, NULL, NULL, NULL, NULL, NULL),
(11420, 11431, 1, 'Motorola', 'usb-kabelya-perekhidnyky-adaptery/kabelya/motorola', NULL, NULL, NULL, NULL, NULL, NULL),
(11421, 11432, 1, 'HTC', 'usb-kabelya-perekhidnyky-adaptery/kabelya/htc', NULL, NULL, NULL, NULL, NULL, NULL),
(11422, 11433, 1, 'Універсальні', 'usb-kabelya-perekhidnyky-adaptery/kabelya/universalni', NULL, NULL, NULL, NULL, NULL, NULL),
(11423, 11434, 1, 'Asus', 'usb-kabelya-perekhidnyky-adaptery/kabelya/asus', NULL, NULL, NULL, NULL, NULL, NULL),
(11424, 11435, 1, 'BlackBerry', 'usb-kabelya-perekhidnyky-adaptery/kabelya/blackberry', NULL, NULL, NULL, NULL, NULL, NULL),
(11425, 11436, 1, 'FLY', 'usb-kabelya-perekhidnyky-adaptery/kabelya/fly', NULL, NULL, NULL, NULL, NULL, NULL),
(11426, 11437, 1, 'Lenovo', 'usb-kabelya-perekhidnyky-adaptery/kabelya/lenovo', NULL, NULL, NULL, NULL, NULL, NULL),
(11427, 11438, 1, 'Різні', 'usb-kabelya-perekhidnyky-adaptery/kabelya/rizni', NULL, NULL, NULL, NULL, NULL, NULL),
(11428, 11439, 1, 'Перехідники, адаптери', 'usb-kabelya-perekhidnyky-adaptery/perekhidnyky-adaptery', NULL, NULL, NULL, NULL, NULL, NULL),
(11429, 11440, 1, 'Комп. аксесуари, пам''ять, різне', 'komp-aksesuary-pamyat-rizne', NULL, NULL, NULL, NULL, NULL, NULL),
(11430, 11441, 1, 'Карти памяті, флеш-драйв', 'komp-aksesuary-pamyat-rizne/karty-pamyati-flesh-drayv', NULL, NULL, NULL, NULL, NULL, NULL),
(11431, 11442, 1, 'Мережеве обладнання', 'komp-aksesuary-pamyat-rizne/merezheve-obladnannya', NULL, NULL, NULL, NULL, NULL, NULL),
(11432, 11443, 1, 'Web камери', 'komp-aksesuary-pamyat-rizne/web-kamery', NULL, NULL, NULL, NULL, NULL, NULL),
(11433, 11444, 1, 'Клавіатури, деколі', 'komp-aksesuary-pamyat-rizne/klaviatury-dekoli', NULL, NULL, NULL, NULL, NULL, NULL),
(11434, 11445, 1, 'Мишки, коврики для мишок', 'komp-aksesuary-pamyat-rizne/myshky-kovryky-dlya-myshok', NULL, NULL, NULL, NULL, NULL, NULL),
(11435, 11446, 1, 'USB лампи', 'komp-aksesuary-pamyat-rizne/usb-lampy', NULL, NULL, NULL, NULL, NULL, NULL),
(11436, 11447, 1, 'Картрідери', 'komp-aksesuary-pamyat-rizne/kartridery', NULL, NULL, NULL, NULL, NULL, NULL),
(11437, 11448, 1, 'USB HUB', 'komp-aksesuary-pamyat-rizne/usb-hub', NULL, NULL, NULL, NULL, NULL, NULL),
(11438, 11449, 1, 'Адаптери', 'komp-aksesuary-pamyat-rizne/adaptery', NULL, NULL, NULL, NULL, NULL, NULL),
(11439, 11450, 1, 'Ліхтарики', 'komp-aksesuary-pamyat-rizne/likhtaryky', NULL, NULL, NULL, NULL, NULL, NULL),
(11440, 11451, 1, 'Диски', 'komp-aksesuary-pamyat-rizne/dysky', NULL, NULL, NULL, NULL, NULL, NULL),
(11441, 11452, 1, 'Колонки', 'komp-aksesuary-pamyat-rizne/kolonky', NULL, NULL, NULL, NULL, NULL, NULL),
(11442, 11453, 1, 'Автомобільні аксесуари', 'avtomobilni-aksesuary', NULL, NULL, NULL, NULL, NULL, NULL),
(11443, 11454, 1, 'Автотримачі', 'avtomobilni-aksesuary/avtotrymachi', NULL, NULL, NULL, NULL, NULL, NULL),
(11444, 11455, 1, 'FM модулятори', 'avtomobilni-aksesuary/fm-modulyatory', NULL, NULL, NULL, NULL, NULL, NULL),
(11445, 11456, 1, 'Автоковрик', 'avtomobilni-aksesuary/avtokovryk', NULL, NULL, NULL, NULL, NULL, NULL),
(11446, 11457, 1, 'Портативні колонки, Mp3/Mp4 плеєри', 'portatyvni-kolonky-mp3-mp4-pleery', NULL, NULL, NULL, NULL, NULL, NULL),
(11447, 11458, 1, 'Колонки', 'portatyvni-kolonky-mp3-mp4-pleery/kolonky', NULL, NULL, NULL, NULL, NULL, NULL),
(11448, 11459, 1, 'Плеєри', 'portatyvni-kolonky-mp3-mp4-pleery/pleery', NULL, NULL, NULL, NULL, NULL, NULL),
(11449, 11460, 1, 'Інструменти та обладнання для ремонту мобільних телефонів', 'instrumenty-ta-obladnannya-dlya-remontu-mobilnykh-telefoniv', NULL, NULL, NULL, NULL, NULL, NULL),
(11450, 11461, 1, 'Паяльні станції та обладнання до них', 'instrumenty-ta-obladnannya-dlya-remontu-mobilnykh-telefoniv/payalni-stantsiyi-ta-obladnannya-do-nykh', NULL, NULL, NULL, NULL, NULL, NULL),
(11451, 11462, 1, 'Інструменти', 'instrumenty-ta-obladnannya-dlya-remontu-mobilnykh-telefoniv/instrumenty', NULL, NULL, NULL, NULL, NULL, NULL),
(11452, 11463, 1, 'Пристрої для ремонту', 'instrumenty-ta-obladnannya-dlya-remontu-mobilnykh-telefoniv/prystroyi-dlya-remontu', NULL, NULL, NULL, NULL, NULL, NULL),
(11453, 11464, 1, 'Різне', 'instrumenty-ta-obladnannya-dlya-remontu-mobilnykh-telefoniv/rizne', NULL, NULL, NULL, NULL, NULL, NULL),
(11454, 11465, 1, 'Пристрої та обладнання для прошивки телефонів', 'instrumenty-ta-obladnannya-dlya-remontu-mobilnykh-telefoniv/prystroyi-ta-obladnannya-dlya-proshyvky-telefoniv', NULL, NULL, NULL, NULL, NULL, NULL),
(11455, 11466, 1, 'Пульти', 'pulty', NULL, NULL, NULL, NULL, NULL, NULL),
(11456, 11467, 1, 'Akai', 'pulty/akai', NULL, NULL, NULL, NULL, NULL, NULL),
(11457, 11468, 1, 'Funai', 'pulty/funai', NULL, NULL, NULL, NULL, NULL, NULL),
(11458, 11469, 1, 'Xenon', 'pulty/xenon', NULL, NULL, NULL, NULL, NULL, NULL),
(11459, 11470, 1, 'Elektron', 'pulty/elektron', NULL, NULL, NULL, NULL, NULL, NULL),
(11460, 11471, 1, 'Start', 'pulty/start', NULL, NULL, NULL, NULL, NULL, NULL),
(11461, 11472, 1, 'Elenberg', 'pulty/elenberg', NULL, NULL, NULL, NULL, NULL, NULL),
(11462, 11473, 1, 'Sharp', 'pulty/sharp', NULL, NULL, NULL, NULL, NULL, NULL),
(11463, 11474, 1, 'Seg', 'pulty/seg', NULL, NULL, NULL, NULL, NULL, NULL),
(11464, 11475, 1, 'Toshiba', 'pulty/toshiba', NULL, NULL, NULL, NULL, NULL, NULL),
(11465, 11476, 1, 'Універсальні', 'pulty/universalni', NULL, NULL, NULL, NULL, NULL, NULL),
(11466, 11477, 1, 'Philips', 'pulty/philips', NULL, NULL, NULL, NULL, NULL, NULL),
(11467, 11478, 1, 'Saturn', 'pulty/saturn', NULL, NULL, NULL, NULL, NULL, NULL),
(11468, 11479, 1, 'Orion', 'pulty/orion', NULL, NULL, NULL, NULL, NULL, NULL),
(11469, 11480, 1, 'Grundig', 'pulty/grundig', NULL, NULL, NULL, NULL, NULL, NULL),
(11470, 11481, 1, 'Samsung', 'pulty/samsung', NULL, NULL, NULL, NULL, NULL, NULL),
(11471, 11482, 1, 'Beko', 'pulty/beko', NULL, NULL, NULL, NULL, NULL, NULL),
(11472, 11483, 1, 'Sony', 'pulty/sony', NULL, NULL, NULL, NULL, NULL, NULL),
(11473, 11484, 1, 'JVS', 'pulty/jvs', NULL, NULL, NULL, NULL, NULL, NULL),
(11474, 11485, 1, 'Thomson', 'pulty/thomson', NULL, NULL, NULL, NULL, NULL, NULL),
(11475, 11486, 1, 'Daewoo', 'pulty/daewoo', NULL, NULL, NULL, NULL, NULL, NULL),
(11476, 11487, 1, 'Globo', 'pulty/globo', NULL, NULL, NULL, NULL, NULL, NULL),
(11477, 11488, 1, 'Pnasonic', 'pulty/pnasonic', NULL, NULL, NULL, NULL, NULL, NULL),
(11478, 11489, 1, 'LG', 'pulty/lg', NULL, NULL, NULL, NULL, NULL, NULL),
(11479, 11490, 1, 'Пульти різні', 'pulty/pulty-rizni', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблиці `e_content_meta`
--

CREATE TABLE IF NOT EXISTS `e_content_meta` (
  `id` int(11) unsigned NOT NULL,
  `content_id` int(10) unsigned NOT NULL,
  `meta_k` varchar(45) DEFAULT NULL,
  `meta_v` text
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблиці `e_content_relationship`
--

CREATE TABLE IF NOT EXISTS `e_content_relationship` (
  `id` int(11) unsigned NOT NULL,
  `content_id` int(10) unsigned NOT NULL,
  `categories_id` int(10) unsigned NOT NULL,
  `is_main` tinyint(1) unsigned DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10214 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_content_relationship`
--

INSERT INTO `e_content_relationship` (`id`, `content_id`, `categories_id`, `is_main`) VALUES
(1, 18, 16, 0),
(2, 19, 16, 0),
(3, 20, 16, 0),
(4, 21, 16, 0),
(5, 22, 16, 0),
(6, 23, 16, 0);

-- --------------------------------------------------------

--
-- Структура таблиці `e_content_types`
--

CREATE TABLE IF NOT EXISTS `e_content_types` (
  `id` tinyint(3) unsigned NOT NULL,
  `parent_id` tinyint(3) unsigned DEFAULT '0',
  `isfolder` tinyint(1) unsigned DEFAULT '0',
  `type` varchar(45) NOT NULL,
  `name` varchar(60) NOT NULL,
  `is_main` tinyint(1) unsigned DEFAULT NULL,
  `settings` text
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_content_types`
--

INSERT INTO `e_content_types` (`id`, `parent_id`, `isfolder`, `type`, `name`, `is_main`, `settings`) VALUES
(1, 0, 1, 'pages', 'Сторінки', 1, NULL),
(2, 0, 0, 'guide', 'Guides', NULL, NULL),
(16, 1, 0, 'home', 'home', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}'),
(17, 1, 0, 'news', 'Новини', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}'),
(18, 0, 0, 'post', 'post', NULL, NULL),
(19, 0, 0, 'posts_categories', 'Post categories', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}'),
(20, 1, 0, 'account', 'account', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}'),
(21, 1, 0, 'contacts', 'Контакти', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}'),
(22, 0, 0, 'products_categories', 'Магазин категорії', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}'),
(23, 0, 0, 'product', 'Магазин / товари', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}'),
(24, 1, 0, 'search', 'Пошук', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}'),
(25, 1, 0, 'checkout', 'Checkout', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}'),
(26, 1, 0, 'cart', 'Кошик', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}'),
(27, 1, 0, 'wishlist', 'Wish List', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}');

-- --------------------------------------------------------

--
-- Структура таблиці `e_content_types_images_sizes`
--

CREATE TABLE IF NOT EXISTS `e_content_types_images_sizes` (
  `id` int(10) unsigned NOT NULL,
  `types_id` tinyint(3) unsigned NOT NULL,
  `images_sizes_id` tinyint(3) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Дамп даних таблиці `e_content_types_images_sizes`
--

INSERT INTO `e_content_types_images_sizes` (`id`, `types_id`, `images_sizes_id`) VALUES
(1, 18, 3),
(2, 23, 4),
(3, 23, 5);

-- --------------------------------------------------------

--
-- Структура таблиці `e_currency`
--

CREATE TABLE IF NOT EXISTS `e_currency` (
  `id` tinyint(3) unsigned NOT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `symbol` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rate` decimal(7,3) DEFAULT NULL,
  `is_main` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `on_site` tinyint(1) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп даних таблиці `e_currency`
--

INSERT INTO `e_currency` (`id`, `name`, `code`, `symbol`, `rate`, `is_main`, `on_site`) VALUES
(1, 'Доляр', 'USD', '$', 1.000, 1, 0),
(2, 'Гривня', 'UAH', 'грн.', 25.000, 0, 1);

-- --------------------------------------------------------

--
-- Структура таблиці `e_delivery`
--

CREATE TABLE IF NOT EXISTS `e_delivery` (
  `id` tinyint(3) unsigned NOT NULL,
  `free_from` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `module` varchar(30) DEFAULT NULL,
  `settings` text,
  `published` tinyint(1) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_delivery`
--

INSERT INTO `e_delivery` (`id`, `free_from`, `price`, `module`, `settings`, `published`) VALUES
(1, 0.00, 0.00, '', NULL, 1),
(2, 0.00, 0.00, 'NovaPoshta', 'a:2:{s:3:"key";s:1:"0";s:8:"password";s:1:"0";}', 1);

-- --------------------------------------------------------

--
-- Структура таблиці `e_delivery_info`
--

CREATE TABLE IF NOT EXISTS `e_delivery_info` (
  `id` tinyint(3) unsigned NOT NULL,
  `delivery_id` tinyint(3) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_delivery_info`
--

INSERT INTO `e_delivery_info` (`id`, `delivery_id`, `languages_id`, `name`, `description`) VALUES
(1, 1, 1, 'Самовивіз', 'Головний офіс, вул. Наукова 7а \n(Офісний центр “Оптіма Плаза”)'),
(2, 2, 1, 'Нова пошта', 'Забрати в відділенні нової пошти');

-- --------------------------------------------------------

--
-- Структура таблиці `e_delivery_payment`
--

CREATE TABLE IF NOT EXISTS `e_delivery_payment` (
  `id` int(10) unsigned NOT NULL,
  `delivery_id` tinyint(3) unsigned NOT NULL,
  `payment_id` tinyint(3) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_delivery_payment`
--

INSERT INTO `e_delivery_payment` (`id`, `delivery_id`, `payment_id`) VALUES
(2, 1, 1),
(3, 1, 2),
(4, 2, 2);

-- --------------------------------------------------------

--
-- Структура таблиці `e_features`
--

CREATE TABLE IF NOT EXISTS `e_features` (
  `id` int(10) unsigned NOT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `type` enum('text','textarea','select','file','folder','value','checkbox','number') DEFAULT NULL,
  `code` varchar(45) NOT NULL,
  `multiple` tinyint(1) DEFAULT NULL,
  `on_filter` tinyint(1) DEFAULT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `owner_id` int(11) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('blank','published','hidden') DEFAULT 'blank',
  `position` tinyint(3) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_features`
--

INSERT INTO `e_features` (`id`, `parent_id`, `type`, `code`, `multiple`, `on_filter`, `required`, `owner_id`, `created`, `status`, `position`) VALUES
(2, 1, 'value', 'bb1fcb3772f61bb9e05d40df97b67d6d', NULL, NULL, 0, 2, '2016-07-08 16:28:39', 'published', 0),
(3, 1, 'value', '902c05a0ef489f0317116e4eebc1feec', NULL, NULL, 0, 2, '2016-07-08 16:28:42', 'published', 0),
(4, 0, 'select', 'vyrobnyk', 0, 1, 0, 2, '2016-07-09 17:04:16', 'published', 0),
(5, 4, 'value', '2228602ae05225cf06f774257cca1188', NULL, NULL, 0, 2, '2016-07-09 17:04:33', 'published', 0),
(6, 4, 'value', '53e08b232c5ee874ef109df6b6e76564', NULL, NULL, 0, 2, '2016-07-09 17:04:36', 'published', 0),
(7, 4, 'value', 'fe658469d6281df9c07146493b3087a7', NULL, NULL, 0, 2, '2016-07-09 17:04:40', 'published', 0),
(8, 4, 'value', 'c4e8ed1950b7651c9550cd825f6cfe4c', NULL, NULL, 0, 2, '2016-07-09 17:04:43', 'published', 0),
(10, 0, 'select', 'typ', 0, 1, 0, 2, '2016-07-09 18:19:51', 'published', 0),
(11, 0, 'select', 'diagonal', 0, 1, 0, 2, '2016-07-09 18:20:44', 'published', 0),
(12, 0, 'select', 'vyd', 0, 1, 0, 2, '2016-07-09 18:21:07', 'published', 0),
(13, 0, 'select', 'pokryttya', 0, 1, 0, 2, '2016-07-09 18:21:22', 'published', 0),
(14, 0, 'select', 'vyrobnyk_telefonu', 0, 1, 0, 2, '2016-07-09 18:21:49', 'published', 0),
(15, 10, 'value', 'ed9ebed3ab9f55dd6ccea9426f0c0d3a', NULL, NULL, 0, 2, '2016-07-09 18:24:43', 'published', 0),
(16, 10, 'value', '78a6ce6bb8c3130ad7aae748b64ed8c5', NULL, NULL, 0, 2, '2016-07-09 18:25:02', 'published', 0),
(17, 11, 'value', 'fb6c81984e96bcb407b9b1855dad523b', NULL, NULL, 0, 2, '2016-07-09 18:25:19', 'published', 0),
(18, 11, 'value', 'bf82101f7137784843f7a9df386ea90a', NULL, NULL, 0, 2, '2016-07-09 18:25:24', 'published', 0),
(19, 11, 'value', '8c00955b0c39636e7e6d9a7200a62f36', NULL, NULL, 0, 2, '2016-07-09 18:25:28', 'published', 0),
(21, 12, 'value', '593ee4e887f95f65793d6c81c4b14d8b', NULL, NULL, 0, 2, '2016-07-09 18:28:27', 'published', 0),
(22, 12, 'value', '89dbec93a949164ec8fa4e3d8f28deb2', NULL, NULL, 0, 2, '2016-07-09 18:28:39', 'published', 0),
(23, 13, 'value', '084d6fc9b5aa7b7bb0fe7acc2f8b151c', NULL, NULL, 0, 2, '2016-07-09 18:29:05', 'published', 0),
(24, 13, 'value', '3c704adb0b67e7eaa7c667f84f5640fe', NULL, NULL, 0, 2, '2016-07-09 18:29:11', 'published', 0),
(25, 14, 'value', 'ec234d275759dced16f8f4efdf3ca165', NULL, NULL, 0, 2, '2016-07-09 18:29:58', 'published', 0),
(26, 14, 'value', '99124c34c781a8219f094ad4f54d7c7d', NULL, NULL, 0, 2, '2016-07-09 18:30:03', 'published', 0),
(27, 14, 'value', '87b0e983a23f892f535d490581cc7797', NULL, NULL, 0, 2, '2016-07-09 18:30:11', 'published', 0),
(28, 14, 'value', '0a02044d8ed185f7fe455c57053e988f', NULL, NULL, 0, 2, '2016-07-09 18:30:14', 'published', 0),
(29, 14, 'value', '8db5c6461f41fde1531bd8d9baa23852', NULL, NULL, 0, 2, '2016-07-09 18:30:24', 'published', 0),
(30, 14, 'value', 'b7bb39a2a866dffb29447f512f78358c', NULL, NULL, 0, 2, '2016-07-09 18:30:29', 'published', 0);

-- --------------------------------------------------------

--
-- Структура таблиці `e_features_content`
--

CREATE TABLE IF NOT EXISTS `e_features_content` (
  `id` int(10) unsigned NOT NULL,
  `features_id` int(10) unsigned NOT NULL,
  `content_types_id` tinyint(3) unsigned NOT NULL,
  `content_subtypes_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `content_id` int(10) unsigned NOT NULL DEFAULT '0',
  `position` tinyint(3) unsigned DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_features_content`
--

INSERT INTO `e_features_content` (`id`, `features_id`, `content_types_id`, `content_subtypes_id`, `content_id`, `position`) VALUES
(2, 4, 22, 22, 49, 5),
(3, 10, 22, 22, 49, 0),
(4, 11, 22, 22, 49, 2),
(5, 12, 22, 22, 49, 3),
(6, 13, 22, 22, 49, 4),
(7, 14, 22, 22, 49, 1);

-- --------------------------------------------------------

--
-- Структура таблиці `e_features_info`
--

CREATE TABLE IF NOT EXISTS `e_features_info` (
  `id` int(10) unsigned NOT NULL,
  `features_id` int(10) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_features_info`
--

INSERT INTO `e_features_info` (`id`, `features_id`, `languages_id`, `name`) VALUES
(2, 2, 1, '1'),
(3, 3, 1, '2'),
(4, 4, 1, 'Виробник'),
(5, 5, 1, 'a'),
(6, 6, 1, 'b'),
(7, 7, 1, 'c'),
(8, 8, 1, 'd'),
(9, 10, 1, 'Тип'),
(10, 11, 1, 'Діагональ'),
(11, 12, 1, 'Вид'),
(12, 13, 1, 'Покриття'),
(13, 14, 1, 'Виробник телефону'),
(14, 15, 1, 'захисна плівка'),
(15, 16, 1, 'захисне скло'),
(16, 17, 1, '4" - 4.9"'),
(17, 18, 1, '5" - 5.9"'),
(18, 19, 1, '6"'),
(20, 21, 1, 'Глянцева'),
(21, 22, 1, 'Матова'),
(22, 23, 1, 'антибактеріальне'),
(23, 24, 1, 'анти-блік'),
(24, 25, 1, 'Apple'),
(25, 26, 1, 'Asus'),
(26, 27, 1, 'Fly'),
(27, 28, 1, 'Htc'),
(28, 29, 1, 'Lg'),
(29, 30, 1, 'Nokia');

-- --------------------------------------------------------

--
-- Структура таблиці `e_feedbacks`
--

CREATE TABLE IF NOT EXISTS `e_feedbacks` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(60) NOT NULL,
  `email` varchar(60) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `message` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('new','processed') NOT NULL DEFAULT 'new',
  `ip` char(15) NOT NULL,
  `manager_id` int(10) unsigned NOT NULL,
  `updated` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_feedbacks`
--

INSERT INTO `e_feedbacks` (`id`, `name`, `email`, `phone`, `message`, `created`, `status`, `ip`, `manager_id`, `updated`) VALUES
(6, 'Жорік', 'otakoyi@gmail.com', '+38(333)33-33-333', 'nkjb', '2016-07-16 17:23:53', 'processed', '127.0.0.1', 2, 127);

-- --------------------------------------------------------

--
-- Структура таблиці `e_languages`
--

CREATE TABLE IF NOT EXISTS `e_languages` (
  `id` tinyint(3) unsigned NOT NULL,
  `code` char(2) NOT NULL,
  `name` varchar(30) NOT NULL,
  `is_main` tinyint(1) unsigned DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_languages`
--

INSERT INTO `e_languages` (`id`, `code`, `name`, `is_main`) VALUES
(1, 'uk', 'УКР', 1);

-- --------------------------------------------------------

--
-- Структура таблиці `e_nav`
--

CREATE TABLE IF NOT EXISTS `e_nav` (
  `id` tinyint(3) unsigned NOT NULL,
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `code` varchar(30) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_nav`
--

INSERT INTO `e_nav` (`id`, `name`, `code`) VALUES
(1, 'top', 'top'),
(3, 'bottom', 'bottom'),
(4, 'user', 'user');

-- --------------------------------------------------------

--
-- Структура таблиці `e_nav_items`
--

CREATE TABLE IF NOT EXISTS `e_nav_items` (
  `id` int(10) unsigned NOT NULL,
  `nav_id` tinyint(3) unsigned NOT NULL,
  `content_id` int(11) unsigned NOT NULL,
  `position` tinyint(3) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_nav_items`
--

INSERT INTO `e_nav_items` (`id`, `nav_id`, `content_id`, `position`) VALUES
(1, 1, 4, 0),
(2, 1, 5, 0),
(3, 1, 7, 0),
(4, 1, 6, 0),
(5, 3, 4, 0),
(7, 3, 25, 0),
(9, 4, 30, 0),
(10, 4, 31, 0),
(11, 4, 32, 0),
(12, 4, 28, 0),
(13, 4, 12, 0),
(6, 3, 6, 1),
(8, 3, 7, 2);

-- --------------------------------------------------------

--
-- Структура таблиці `e_orders`
--

CREATE TABLE IF NOT EXISTS `e_orders` (
  `id` int(10) unsigned NOT NULL,
  `oid` varchar(45) DEFAULT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `status_id` int(10) unsigned NOT NULL,
  `manager_id` int(11) DEFAULT NULL,
  `one_click` tinyint(1) unsigned DEFAULT '0',
  `users_id` int(11) unsigned NOT NULL,
  `users_group_id` tinyint(3) unsigned NOT NULL,
  `currency_id` tinyint(3) unsigned NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `paid` tinyint(1) unsigned DEFAULT NULL,
  `paid_date` timestamp NULL DEFAULT NULL,
  `payment_id` tinyint(3) DEFAULT NULL,
  `delivery_id` tinyint(3) DEFAULT NULL,
  `delivery_state_id` int(11) DEFAULT NULL,
  `delivery_city_id` int(11) DEFAULT NULL,
  `delivery_department_id` int(11) DEFAULT NULL,
  `delivery_cost` decimal(10,2) DEFAULT NULL,
  `prepayment` decimal(10,2) DEFAULT NULL,
  `delivery_address` varchar(45) DEFAULT NULL,
  `pay_shipping` varchar(45) DEFAULT NULL,
  `pay_return_shipping` varchar(45) DEFAULT NULL,
  `delivery_back` varchar(45) DEFAULT NULL,
  `edited` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_orders`
--

INSERT INTO `e_orders` (`id`, `oid`, `languages_id`, `status_id`, `manager_id`, `one_click`, `users_id`, `users_group_id`, `currency_id`, `comment`, `created`, `paid`, `paid_date`, `payment_id`, `delivery_id`, `delivery_state_id`, `delivery_city_id`, `delivery_department_id`, `delivery_cost`, `prepayment`, `delivery_address`, `pay_shipping`, `pay_return_shipping`, `delivery_back`, `edited`) VALUES
(17, '160721-110756', 1, 6, 2, 0, 16, 5, 2, '', '2016-07-21 20:08:56', 1, NULL, 1, 1, NULL, NULL, NULL, 0.00, 0.00, '', NULL, NULL, NULL, NULL),
(18, '160721-110748', 1, 4, NULL, 1, 16, 5, 0, NULL, '2016-07-21 20:49:48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(19, '160721-110715', 1, 3, 2, 1, 16, 5, 2, NULL, '2016-07-21 20:53:15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(20, '160721-110747', 1, 2, NULL, 1, 16, 5, 2, NULL, '2016-07-21 20:55:47', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(21, '160721-110732', 1, 3, 2, 1, 16, 5, 2, NULL, '2016-07-21 20:56:32', 1, '2016-07-22 10:54:06', 1, 1, NULL, NULL, NULL, 0.00, 0.00, '', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблиці `e_orders_products`
--

CREATE TABLE IF NOT EXISTS `e_orders_products` (
  `id` int(10) unsigned NOT NULL,
  `orders_id` int(10) unsigned NOT NULL,
  `products_id` int(10) unsigned NOT NULL,
  `variants_id` int(10) unsigned DEFAULT NULL,
  `quantity` int(10) unsigned DEFAULT NULL,
  `price` decimal(10,2) unsigned DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблиці `e_orders_status`
--

CREATE TABLE IF NOT EXISTS `e_orders_status` (
  `id` int(10) unsigned NOT NULL,
  `bg_color` char(7) DEFAULT NULL,
  `txt_color` varchar(7) DEFAULT NULL,
  `on_site` tinyint(1) unsigned DEFAULT NULL,
  `external_id` varchar(64) DEFAULT NULL,
  `is_main` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_orders_status`
--

INSERT INTO `e_orders_status` (`id`, `bg_color`, `txt_color`, `on_site`, `external_id`, `is_main`) VALUES
(1, '#bef50c', '#ffffff', 1, 'blank', 0),
(2, '#066e0e', '#ffffff', 1, 'new', 1),
(3, '#04440d', '#f3f20c', 1, 'accepted', 0),
(4, '#fe0000', '#b7ff09', 1, 'canceled', 0),
(6, '#ffffff', '#000000', 1, 'ok', 0),
(7, '#00a808', '#000000', 1, 'send', 0),
(8, '#0bd0e7', '#000000', 1, 'delivered', 0),
(10, '#1621ed', '#ffffff', 1, 'paid', 0),
(11, '#2ffc17', '#633af2', 0, 'close', 0);

-- --------------------------------------------------------

--
-- Структура таблиці `e_orders_status_history`
--

CREATE TABLE IF NOT EXISTS `e_orders_status_history` (
  `id` int(11) NOT NULL,
  `orders_id` int(10) unsigned NOT NULL,
  `status_id` int(10) unsigned NOT NULL,
  `manager_id` int(10) unsigned DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `comment` varchar(100) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Дамп даних таблиці `e_orders_status_history`
--

INSERT INTO `e_orders_status_history` (`id`, `orders_id`, `status_id`, `manager_id`, `created`, `comment`) VALUES
(2, 17, 1, NULL, '2016-07-21 20:08:56', NULL),
(3, 17, 3, 2, '2016-07-21 20:09:27', NULL),
(4, 17, 6, 2, '2016-07-21 20:48:40', ''),
(5, 18, 1, NULL, '2016-07-21 20:49:49', NULL),
(6, 18, 2, 2, '2016-07-21 20:51:04', NULL),
(7, 18, 4, 2, '2016-07-21 20:52:03', NULL),
(8, 19, 1, NULL, '2016-07-21 20:53:15', NULL),
(9, 20, 2, NULL, '2016-07-21 20:55:47', NULL),
(10, 19, 3, 2, '2016-07-21 20:56:59', NULL),
(11, 21, 3, 2, '2016-07-22 10:53:43', NULL);

-- --------------------------------------------------------

--
-- Структура таблиці `e_orders_status_info`
--

CREATE TABLE IF NOT EXISTS `e_orders_status_info` (
  `id` int(10) unsigned NOT NULL,
  `status_id` int(10) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `status` varchar(45) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_orders_status_info`
--

INSERT INTO `e_orders_status_info` (`id`, `status_id`, `languages_id`, `status`) VALUES
(1, 1, 1, 'Чорновик'),
(2, 2, 1, 'Нове'),
(3, 3, 1, 'Опрацьовується менеджером'),
(4, 4, 1, 'Скасовано'),
(5, 6, 1, 'Перевірено'),
(6, 7, 1, 'Відправлено'),
(7, 8, 1, 'Отримано'),
(8, 11, 1, 'Закрито'),
(9, 10, 1, 'Оплачено');

-- --------------------------------------------------------

--
-- Структура таблиці `e_payment`
--

CREATE TABLE IF NOT EXISTS `e_payment` (
  `id` tinyint(3) unsigned NOT NULL,
  `published` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `module` varchar(60) NOT NULL,
  `settings` text,
  `position` tinyint(3) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_payment`
--

INSERT INTO `e_payment` (`id`, `published`, `module`, `settings`, `position`) VALUES
(1, 1, '', NULL, 0),
(2, 1, '', NULL, 0);

-- --------------------------------------------------------

--
-- Структура таблиці `e_payment_info`
--

CREATE TABLE IF NOT EXISTS `e_payment_info` (
  `id` tinyint(3) unsigned NOT NULL,
  `payment_id` tinyint(3) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(60) DEFAULT NULL,
  `description` text
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_payment_info`
--

INSERT INTO `e_payment_info` (`id`, `payment_id`, `languages_id`, `name`, `description`) VALUES
(1, 1, 1, 'Готівкою', ''),
(2, 2, 1, 'Онлайн через Privat24', '');

-- --------------------------------------------------------

--
-- Структура таблиці `e_posts_tags`
--

CREATE TABLE IF NOT EXISTS `e_posts_tags` (
  `id` int(10) unsigned NOT NULL,
  `posts_id` int(11) unsigned NOT NULL,
  `tags_id` int(10) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблиці `e_posts_views`
--

CREATE TABLE IF NOT EXISTS `e_posts_views` (
  `id` int(10) unsigned NOT NULL,
  `posts_id` int(10) unsigned NOT NULL,
  `date` date NOT NULL,
  `views` int(10) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_posts_views`
--

INSERT INTO `e_posts_views` (`id`, `posts_id`, `date`, `views`) VALUES
(1, 18, '2016-07-05', 16),
(2, 19, '2016-07-05', 1),
(3, 20, '2016-07-05', 2),
(4, 20, '2016-07-06', 18),
(5, 19, '2016-07-06', 112),
(6, 18, '2016-07-06', 40),
(7, 20, '2016-07-07', 4),
(8, 18, '2016-07-08', 1),
(9, 18, '2016-07-11', 4),
(10, 18, '2016-07-12', 1),
(11, 19, '2016-07-12', 1);

-- --------------------------------------------------------

--
-- Структура таблиці `e_products_prices`
--

CREATE TABLE IF NOT EXISTS `e_products_prices` (
  `id` int(10) unsigned NOT NULL,
  `content_id` int(10) unsigned NOT NULL,
  `group_id` tinyint(3) unsigned NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `price_old` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10212 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблиці `e_products_variants`
--

CREATE TABLE IF NOT EXISTS `e_products_variants` (
  `id` int(10) unsigned NOT NULL,
  `content_id` int(10) unsigned NOT NULL,
  `in_stock` tinyint(1) DEFAULT '1',
  `img` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблиці `e_products_variants_features`
--

CREATE TABLE IF NOT EXISTS `e_products_variants_features` (
  `id` int(10) unsigned NOT NULL,
  `variants_id` int(10) unsigned NOT NULL,
  `features_id` int(10) unsigned NOT NULL,
  `values_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблиці `e_products_variants_prices`
--

CREATE TABLE IF NOT EXISTS `e_products_variants_prices` (
  `id` int(10) unsigned NOT NULL,
  `variants_id` int(10) unsigned NOT NULL,
  `content_id` int(10) unsigned NOT NULL,
  `group_id` tinyint(3) unsigned NOT NULL,
  `price` decimal(10,2) unsigned DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблиці `e_search_history`
--

CREATE TABLE IF NOT EXISTS `e_search_history` (
  `id` int(10) unsigned NOT NULL,
  `q` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_search_history`
--

INSERT INTO `e_search_history` (`id`, `q`) VALUES
(3, '4032'),
(2, 'htc'),
(1, 'іфьі');

-- --------------------------------------------------------

--
-- Структура таблиці `e_search_history_stat`
--

CREATE TABLE IF NOT EXISTS `e_search_history_stat` (
  `id` int(10) unsigned NOT NULL,
  `search_history_id` int(10) unsigned NOT NULL,
  `date` date DEFAULT NULL,
  `hits` int(10) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_search_history_stat`
--

INSERT INTO `e_search_history_stat` (`id`, `search_history_id`, `date`, `hits`) VALUES
(1, 1, '2016-07-12', 1),
(6, 2, '2016-07-12', 5),
(7, 3, '2016-07-21', 3);

-- --------------------------------------------------------

--
-- Структура таблиці `e_settings`
--

CREATE TABLE IF NOT EXISTS `e_settings` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(45) NOT NULL,
  `value` text NOT NULL,
  `block` enum('company','common','images','themes','editor','content','seo','analitycs','robots','mail') NOT NULL,
  `type` enum('text','textarea') NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_settings`
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
(19, 'page_404', '11', 'common', 'text', 1),
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
(39, 'mail_header', '', 'mail', 'text', 0),
(40, 'mail_footer', '', 'mail', 'text', 0),
(41, 'mail_smtp_on', '0', 'mail', 'text', 1),
(42, 'mail_smtp_host', '', 'mail', 'text', 0),
(43, 'mail_smtp_port', '', 'mail', 'text', 0),
(44, 'mail_smtp_user', '', 'mail', 'text', 0),
(45, 'mail_smtp_password', '', 'mail', 'text', 0),
(46, 'mail_smtp_secure', 'tls', 'mail', 'text', 0),
(47, 'company_name', 'Premium Shop', 'company', 'text', 1),
(48, 'company_phone', '111111', 'company', 'text', 1),
(49, 'seo', 'a:6:{s:5:"guide";a:1:{i:1;a:4:{s:5:"title";s:0:"";s:8:"keywords";s:0:"";s:11:"description";s:0:"";s:2:"h1";s:0:"";}}s:5:"pages";a:1:{i:1;a:4:{s:5:"title";s:34:"{title} {delimiter} {company_name}";s:8:"keywords";s:37:"{keywords} {delimiter} {company_name}";s:11:"description";s:13:"{description}";s:2:"h1";s:4:"{h1}";}}s:4:"post";a:1:{i:1;a:4:{s:5:"title";s:67:"{title} {delimiter}  {category} {delimiter} блог {company_name}";s:8:"keywords";s:46:"{keywords} {delimiter} блог {company_name}";s:11:"description";s:49:"{description} {delimiter} блог {company_name}";s:2:"h1";s:4:"{h1}";}}s:16:"posts_categories";a:1:{i:1;a:4:{s:5:"title";s:67:"{title} {delimiter}  {category} {delimiter} блог {company_name}";s:8:"keywords";s:46:"{keywords} {delimiter} блог {company_name}";s:11:"description";s:46:"{keywords} {delimiter} блог {company_name}";s:2:"h1";s:4:"{h1}";}}s:7:"product";a:1:{i:1;a:4:{s:5:"title";s:58:"{title} {delimiter}  {category} {delimiter} {company_name}";s:8:"keywords";s:37:"{keywords} {delimiter} {company_name}";s:11:"description";s:37:"{keywords} {delimiter} {company_name}";s:2:"h1";s:4:"{h1}";}}s:19:"products_categories";a:1:{i:1;a:4:{s:5:"title";s:59:"{title} {delimiter}  {category} {delimiter}  {company_name}";s:8:"keywords";s:37:"{keywords} {delimiter} {company_name}";s:11:"description";s:37:"{keywords} {delimiter} {company_name}";s:2:"h1";s:4:"{h1}";}}}', '', '', 0),
(50, 'home_id', '1', 'common', 'text', 1),
(51, 'widgets', 'a:1:{s:14:', 'common', 'text', 1),
(52, 'modules', 'a:14:{s:8:"Feedback";a:1:{s:6:"status";s:7:"enabled";}s:9:"Callbacks";a:1:{s:6:"status";s:7:"enabled";}s:8:"Comments";a:1:{s:6:"status";s:7:"enabled";}s:8:"Currency";a:1:{s:6:"status";s:7:"enabled";}s:7:"Payment";a:1:{s:6:"status";s:7:"enabled";}s:5:"Users";a:2:{s:6:"status";s:7:"enabled";s:6:"config";a:1:{s:14:"guest_group_id";s:2:"20";}}s:7:"Banners";a:1:{s:6:"status";s:7:"enabled";}s:5:"Share";a:1:{s:6:"status";s:7:"enabled";}s:8:"Wishlist";a:1:{s:6:"status";s:7:"enabled";}s:5:"Order";a:1:{s:6:"status";s:7:"enabled";}s:4:"Shop";a:1:{s:6:"status";s:7:"enabled";}s:8:"Delivery";a:1:{s:6:"status";s:7:"enabled";}s:4:"Blog";a:1:{s:6:"status";s:7:"enabled";}s:11:"Breadcrumbs";a:1:{s:6:"status";s:7:"enabled";}}', 'common', 'text', 1);

-- --------------------------------------------------------

--
-- Структура таблиці `e_tags`
--

CREATE TABLE IF NOT EXISTS `e_tags` (
  `id` int(10) unsigned NOT NULL,
  `tag` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблиці `e_users`
--

CREATE TABLE IF NOT EXISTS `e_users` (
  `id` int(11) unsigned NOT NULL,
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
  `status` enum('active','ban','deleted') NOT NULL DEFAULT 'active'
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_users`
--

INSERT INTO `e_users` (`id`, `group_id`, `languages_id`, `sessid`, `name`, `surname`, `phone`, `email`, `password`, `avatar`, `skey`, `created`, `updated`, `lastlogin`, `status`) VALUES
(2, 1, 0, '57huioc81fsthdv9or3beb6i67', 'Володимир', 'Годяк', '+38 (067) 6736242', 'wmgodyak@gmail.com', 'MTTuFPm3y4m2o', '/uploads/avatars/c81e728d9d4c2f636f067f89cc14862c.png', NULL, '2016-03-03 13:25:08', '2016-04-21 11:24:28', '2016-07-25 18:51:30', 'active'),
(3, 5, 0, '6idmprjk07d5ns37rac8g6iuu5', 'Меган', 'Меган', '+11 (111) 1111111', 'm@otakoyi.com', 'MjMZqb1Pe1Ht6', NULL, 'YToxNzp7czoyOiJpZCI7czoxOiIzIjtzOjg6Imdyb3VwX2lkIjtzOjI6IjIwIjtz', '2016-07-06 10:22:58', '2016-07-09 15:54:17', '2016-07-07 08:26:17', 'active'),
(4, 5, 0, NULL, 'Жорік', '', '', 'otakoyi@gmail.com', 'NjDwRk3ebROnU', NULL, NULL, '2016-07-06 15:29:55', '2016-07-06 18:48:05', NULL, 'active'),
(5, 5, 0, '3h0o3ejajr9d7vhdsnv3fufu36', 'Гена', '', '', 'g@otakoyi.com', 'MTTuFPm3y4m2o', NULL, 'YToxNzp7czoyOiJpZCI7czoxOiI1IjtzOjg6Imdyb3VwX2lkIjtzOjI6IjIwIjtz', '2016-07-06 15:32:05', '2016-07-21 16:41:49', '2016-07-21 12:23:14', 'active'),
(6, 5, 0, NULL, 'Гоша', '', '', 'gosha@otakoyi.com', 'MTk1WPl9Wq.uY', NULL, NULL, '2016-07-07 10:45:22', '2016-07-07 13:55:13', NULL, 'active'),
(7, 5, 0, NULL, 'Андрій', '', '', 'a@otakoyi.com', 'MTTuFPm3y4m2o', NULL, NULL, '2016-07-09 12:55:27', '0000-00-00 00:00:00', NULL, 'active'),
(8, 5, 0, NULL, 'Ірина', '', '', 'i@otakoyi.com', 'MTTuFPm3y4m2o', NULL, NULL, '2016-07-10 14:59:19', '0000-00-00 00:00:00', NULL, 'active'),
(9, 5, 0, NULL, 'Дмитро', '', '', 'd@otakoyi.com', 'MTTuFPm3y4m2o', NULL, NULL, '2016-07-11 11:26:07', '0000-00-00 00:00:00', NULL, 'active'),
(10, 5, 0, NULL, 'Галина', '', '', 'ag@otakoyi.com', 'MTTuFPm3y4m2o', NULL, NULL, '2016-07-12 15:48:42', '0000-00-00 00:00:00', NULL, 'active'),
(11, 5, 0, NULL, 'Джорж', 'Буш', '+38(111)11-11-111', 'j@otakoyi.com', 'MjQCkqQenXh9E', NULL, NULL, '2016-07-14 12:52:16', '2016-07-14 18:58:32', NULL, 'active'),
(12, 5, 0, NULL, '3123213', 'wrwerwer', '+38(132)12-31-232', '381321231232@one.click', 'MTJUihFTUvRwQ', NULL, NULL, '2016-07-15 10:39:02', '2016-07-15 15:03:35', NULL, 'active'),
(13, 5, 0, NULL, 'yrtyrty', '', '+38(456)45-65-465', '384564565465@one.click', 'MTZTs0GJmFTa.', NULL, NULL, '2016-07-15 14:20:49', '0000-00-00 00:00:00', NULL, 'active'),
(14, 5, 0, NULL, 'Гоша', 'Резьвий', '+38(555)55-55-555', '385555555555@one.click', 'MTkPN.F2jkOkg', NULL, NULL, '2016-07-16 17:53:42', '2016-07-16 21:18:23', NULL, 'active'),
(15, 5, 0, NULL, 'Фокс', '', '', 'otakoyi11@gmail.com', 'MTes/mY.vTwj6', NULL, NULL, '2016-07-21 13:50:57', '0000-00-00 00:00:00', NULL, 'active'),
(16, 5, 0, NULL, 'Каха', 'ХЗ', '+38 (966) 6666666', 'kaha@otakoyi.com', 'OD3tC0OLsNU8Y', NULL, NULL, '2016-07-21 20:08:56', '2016-07-22 13:54:04', NULL, 'active');

-- --------------------------------------------------------

--
-- Структура таблиці `e_users_group`
--

CREATE TABLE IF NOT EXISTS `e_users_group` (
  `id` tinyint(3) unsigned NOT NULL,
  `parent_id` tinyint(3) unsigned NOT NULL,
  `isfolder` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `backend` tinyint(1) unsigned DEFAULT NULL,
  `permissions` text,
  `position` tinyint(3) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_users_group`
--

INSERT INTO `e_users_group` (`id`, `parent_id`, `isfolder`, `backend`, `permissions`, `position`) VALUES
(1, 0, 0, 1, 'a:1:{s:11:"full_access";s:1:"1";}', 1),
(2, 0, 0, 1, 'a:15:{s:11:"full_access";s:1:"0";s:9:"Dashboard";a:3:{i:0;s:5:"index";i:1;s:6:"create";i:2;s:4:"edit";}s:12:"content\\Post";a:6:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";i:4;s:3:"pub";i:5;s:4:"hide";}s:9:"Customers";a:7:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";i:4;s:6:"remove";i:5;s:3:"ban";i:6;s:7:"restore";}s:8:"Comments";a:9:{i:0;s:5:"index";i:1;s:3:"tab";i:2;s:5:"items";i:3;s:6:"create";i:4;s:4:"edit";i:5;s:5:"reply";i:6;s:7:"approve";i:7;s:4:"spam";i:8;s:7:"restore";}s:4:"Shop";a:3:{i:0;s:5:"index";i:1;s:6:"create";i:2;s:4:"edit";}s:16:"content\\Products";a:6:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";i:4;s:3:"pub";i:5;s:4:"hide";}s:26:"content\\ProductsCategories";a:6:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";i:4;s:3:"pub";i:5;s:4:"hide";}s:8:"Currency";a:4:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";}s:8:"Delivery";a:7:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";i:4;s:17:"getModuleSettings";i:5;s:3:"pub";i:6;s:4:"hide";}s:9:"Callbacks";a:8:{i:0;s:5:"index";i:1;s:3:"tab";i:2;s:5:"items";i:3;s:6:"create";i:4;s:4:"edit";i:5;s:5:"reply";i:6;s:4:"spam";i:7;s:7:"restore";}s:13:"content\\Pages";a:6:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";i:4;s:3:"pub";i:5;s:4:"hide";}s:32:"plugins\\ProductsCategoriesSelect";a:4:{i:0;s:5:"index";i:1;s:6:"create";i:2;s:4:"edit";i:3;s:7:"setMeta";}s:26:"plugins\\ProductsCategories";a:8:{i:0;s:5:"index";i:1;s:6:"create";i:2;s:4:"edit";i:3;s:4:"tree";i:4;s:4:"move";i:5;s:16:"createCategories";i:6;s:14:"editCategories";i:7;s:7:"setMeta";}s:17:"plugins\\PagesTree";a:6:{i:0;s:5:"index";i:1;s:6:"create";i:2;s:4:"edit";i:3;s:4:"tree";i:4;s:4:"move";i:5;s:7:"setMeta";}}', 0),
(4, 0, 0, 1, 'a:2:{s:11:"full_access";s:1:"0";s:5:"Admin";a:9:{i:0;s:4:"data";i:1;s:2:"id";i:2;s:5:"login";i:3;s:2:"fp";i:4;s:6:"logout";i:5;s:7:"profile";i:6;s:5:"index";i:7;s:6:"create";i:8;s:4:"edit";}}', 0),
(5, 0, 0, 0, '', 0),
(6, 0, 0, 0, 'N;', 0),
(7, 0, 0, 0, 'N;', 0),
(8, 0, 0, 0, 'N;', 0);

-- --------------------------------------------------------

--
-- Структура таблиці `e_users_group_info`
--

CREATE TABLE IF NOT EXISTS `e_users_group_info` (
  `id` int(11) unsigned NOT NULL,
  `group_id` tinyint(3) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_users_group_info`
--

INSERT INTO `e_users_group_info` (`id`, `group_id`, `languages_id`, `name`) VALUES
(15, 1, 1, 'Адміністратори'),
(16, 2, 1, 'Редактори'),
(18, 4, 1, 'Модератори'),
(34, 5, 1, 'Ціна1'),
(35, 6, 1, 'Ціна 2'),
(36, 7, 1, 'Ціна 3'),
(37, 8, 1, 'Ціна 4');

-- --------------------------------------------------------

--
-- Структура таблиці `e_wishlist`
--

CREATE TABLE IF NOT EXISTS `e_wishlist` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `users_id` int(11) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_wishlist`
--

INSERT INTO `e_wishlist` (`id`, `name`, `users_id`, `created`) VALUES
(1, 'Мій курва список', 3, '2016-07-16 07:20:43'),
(2, 'Мій список бажань', 15, '2016-07-21 15:12:27');

-- --------------------------------------------------------

--
-- Структура таблиці `e_wishlist_products`
--

CREATE TABLE IF NOT EXISTS `e_wishlist_products` (
  `id` int(10) unsigned NOT NULL,
  `wishlist_id` int(10) unsigned NOT NULL,
  `products_id` int(10) unsigned NOT NULL,
  `variants_id` int(10) unsigned DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

--
-- Індекси збережених таблиць
--

--
-- Індекси таблиці `e_banners`
--
ALTER TABLE `e_banners`
  ADD PRIMARY KEY (`id`,`places_id`,`languages_id`),
  ADD UNIQUE KEY `skey_UNIQUE` (`skey`),
  ADD KEY `fk_banners_banners_places1_idx` (`places_id`),
  ADD KEY `fk_banners_languages1_idx` (`languages_id`);

--
-- Індекси таблиці `e_banners_places`
--
ALTER TABLE `e_banners_places`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code_UNIQUE` (`code`);

--
-- Індекси таблиці `e_callbacks`
--
ALTER TABLE `e_callbacks`
  ADD PRIMARY KEY (`id`);

--
-- Індекси таблиці `e_comments`
--
ALTER TABLE `e_comments`
  ADD PRIMARY KEY (`id`,`content_id`),
  ADD KEY `fk_comments_content1_idx` (`content_id`),
  ADD KEY `approved` (`status`),
  ADD KEY `users_id` (`users_id`),
  ADD KEY `token` (`skey`),
  ADD KEY `isfolder` (`isfolder`);

--
-- Індекси таблиці `e_comments_likers`
--
ALTER TABLE `e_comments_likers`
  ADD PRIMARY KEY (`id`,`users_id`,`comments_id`),
  ADD KEY `fk_comments_likers_users1_idx` (`users_id`),
  ADD KEY `fk_comments_likers_comments1_idx` (`comments_id`);

--
-- Індекси таблиці `e_comments_subscribers`
--
ALTER TABLE `e_comments_subscribers`
  ADD PRIMARY KEY (`id`,`content_id`,`users_id`),
  ADD UNIQUE KEY `content_id` (`content_id`,`users_id`),
  ADD KEY `fk_comments_subscribe_content1_idx` (`content_id`),
  ADD KEY `fk_comments_subscribe_users1_idx` (`users_id`);

--
-- Індекси таблиці `e_content`
--
ALTER TABLE `e_content`
  ADD PRIMARY KEY (`id`,`types_id`,`subtypes_id`,`owner_id`),
  ADD KEY `fk_content_content_types1_idx` (`types_id`),
  ADD KEY `fk_content_content_subtypes1_idx` (`subtypes_id`),
  ADD KEY `fk_content_owner_idx` (`owner_id`),
  ADD KEY `status` (`status`),
  ADD KEY `published` (`published`),
  ADD KEY `code` (`sku`);

--
-- Індекси таблиці `e_content_features`
--
ALTER TABLE `e_content_features`
  ADD PRIMARY KEY (`id`,`content_id`,`features_id`),
  ADD UNIQUE KEY `content_id` (`content_id`,`features_id`,`values_id`,`languages_id`),
  ADD KEY `fk_content_features_values_content1_idx` (`content_id`),
  ADD KEY `fk_content_features_values_features1_idx` (`features_id`);

--
-- Індекси таблиці `e_content_images`
--
ALTER TABLE `e_content_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_content_images_content1_idx` (`content_id`),
  ADD KEY `position` (`position`);

--
-- Індекси таблиці `e_content_images_sizes`
--
ALTER TABLE `e_content_images_sizes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `size` (`size`);

--
-- Індекси таблиці `e_content_info`
--
ALTER TABLE `e_content_info`
  ADD PRIMARY KEY (`id`,`content_id`,`languages_id`),
  ADD UNIQUE KEY `languages_id` (`languages_id`,`url`),
  ADD KEY `fk_content_info_content1_idx` (`content_id`),
  ADD KEY `fk_content_info_languages1_idx` (`languages_id`);

--
-- Індекси таблиці `e_content_meta`
--
ALTER TABLE `e_content_meta`
  ADD PRIMARY KEY (`id`,`content_id`),
  ADD KEY `fk_e_content_meta_e_content1_idx` (`content_id`),
  ADD KEY `meta_k` (`meta_k`);

--
-- Індекси таблиці `e_content_relationship`
--
ALTER TABLE `e_content_relationship`
  ADD PRIMARY KEY (`id`,`content_id`,`categories_id`),
  ADD UNIQUE KEY `content_id` (`content_id`,`categories_id`),
  ADD KEY `fk_content_relationship_content1_idx` (`content_id`),
  ADD KEY `fk_content_relationship_content2_idx` (`categories_id`),
  ADD KEY `is_main` (`is_main`);

--
-- Індекси таблиці `e_content_types`
--
ALTER TABLE `e_content_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `parent_id` (`parent_id`,`type`),
  ADD UNIQUE KEY `parent_id_2` (`parent_id`,`is_main`),
  ADD KEY `is_main` (`is_main`);

--
-- Індекси таблиці `e_content_types_images_sizes`
--
ALTER TABLE `e_content_types_images_sizes`
  ADD PRIMARY KEY (`id`,`types_id`,`images_sizes_id`),
  ADD KEY `fk_content_types_images_sizes1_idx` (`types_id`),
  ADD KEY `fk_content_types_images_sizes2_idx` (`images_sizes_id`);

--
-- Індекси таблиці `e_currency`
--
ALTER TABLE `e_currency`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `is_main` (`is_main`),
  ADD KEY `on_site` (`on_site`);

--
-- Індекси таблиці `e_delivery`
--
ALTER TABLE `e_delivery`
  ADD PRIMARY KEY (`id`);

--
-- Індекси таблиці `e_delivery_info`
--
ALTER TABLE `e_delivery_info`
  ADD PRIMARY KEY (`id`,`delivery_id`,`languages_id`),
  ADD KEY `fk_delivery_info_delivery1_idx` (`delivery_id`),
  ADD KEY `fk_delivery_info_languages1_idx` (`languages_id`);

--
-- Індекси таблиці `e_delivery_payment`
--
ALTER TABLE `e_delivery_payment`
  ADD PRIMARY KEY (`id`,`delivery_id`,`payment_id`),
  ADD UNIQUE KEY `delivery_id` (`delivery_id`,`payment_id`),
  ADD KEY `fk_delivery_payment_delivery1_idx` (`delivery_id`),
  ADD KEY `fk_delivery_payment_payment1_idx` (`payment_id`);

--
-- Індекси таблиці `e_features`
--
ALTER TABLE `e_features`
  ADD PRIMARY KEY (`id`,`owner_id`),
  ADD UNIQUE KEY `code_UNIQUE` (`code`),
  ADD KEY `fk_features_users1_idx` (`owner_id`),
  ADD KEY `position` (`position`);

--
-- Індекси таблиці `e_features_content`
--
ALTER TABLE `e_features_content`
  ADD PRIMARY KEY (`id`,`features_id`,`content_types_id`,`content_subtypes_id`,`content_id`),
  ADD UNIQUE KEY `features_id` (`features_id`,`content_types_id`,`content_subtypes_id`,`content_id`),
  ADD KEY `fk_content_features_idx` (`features_id`);

--
-- Індекси таблиці `e_features_info`
--
ALTER TABLE `e_features_info`
  ADD PRIMARY KEY (`id`,`features_id`,`languages_id`),
  ADD KEY `fk_features_info_features1_idx` (`features_id`),
  ADD KEY `fk_features_info_languages1_idx` (`languages_id`);

--
-- Індекси таблиці `e_feedbacks`
--
ALTER TABLE `e_feedbacks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `manager_id` (`manager_id`);

--
-- Індекси таблиці `e_languages`
--
ALTER TABLE `e_languages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `is_main` (`is_main`);

--
-- Індекси таблиці `e_nav`
--
ALTER TABLE `e_nav`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Індекси таблиці `e_nav_items`
--
ALTER TABLE `e_nav_items`
  ADD PRIMARY KEY (`id`,`nav_id`,`content_id`),
  ADD UNIQUE KEY `nav_id` (`nav_id`,`content_id`),
  ADD KEY `fk_nav_items_nav1_idx` (`nav_id`),
  ADD KEY `fk_nav_items_content1_idx` (`content_id`),
  ADD KEY `position` (`position`);

--
-- Індекси таблиці `e_orders`
--
ALTER TABLE `e_orders`
  ADD PRIMARY KEY (`id`,`languages_id`,`users_id`,`users_group_id`,`currency_id`),
  ADD UNIQUE KEY `oid` (`oid`),
  ADD KEY `fk_orders_languages1_idx` (`languages_id`),
  ADD KEY `fk_orders_users1_idx` (`users_id`,`users_group_id`),
  ADD KEY `status_id` (`status_id`),
  ADD KEY `fk_e_orders_e_currency1_idx` (`currency_id`);

--
-- Індекси таблиці `e_orders_products`
--
ALTER TABLE `e_orders_products`
  ADD PRIMARY KEY (`id`,`orders_id`,`products_id`),
  ADD KEY `fk_orders_products_orders1_idx` (`orders_id`),
  ADD KEY `fk_orders_products_content1_idx` (`products_id`);

--
-- Індекси таблиці `e_orders_status`
--
ALTER TABLE `e_orders_status`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `external_id_2` (`external_id`),
  ADD KEY `on_site` (`on_site`),
  ADD KEY `external_id` (`external_id`);

--
-- Індекси таблиці `e_orders_status_history`
--
ALTER TABLE `e_orders_status_history`
  ADD PRIMARY KEY (`id`,`status_id`,`orders_id`),
  ADD KEY `fk_e_orders_status_history_e_orders_status1_idx` (`status_id`),
  ADD KEY `fk_e_orders_status_history_e_orders1_idx` (`orders_id`),
  ADD KEY `manager_id` (`manager_id`);

--
-- Індекси таблиці `e_orders_status_info`
--
ALTER TABLE `e_orders_status_info`
  ADD PRIMARY KEY (`id`,`status_id`,`languages_id`),
  ADD KEY `fk_orders_status_info_languages1_idx` (`languages_id`),
  ADD KEY `fk_orders_status_info_orders_status1_idx` (`status_id`);

--
-- Індекси таблиці `e_payment`
--
ALTER TABLE `e_payment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `module` (`module`);

--
-- Індекси таблиці `e_payment_info`
--
ALTER TABLE `e_payment_info`
  ADD PRIMARY KEY (`id`,`payment_id`,`languages_id`),
  ADD KEY `fk_payment_info_payment1_idx` (`payment_id`),
  ADD KEY `fk_payment_info_languages1_idx` (`languages_id`);

--
-- Індекси таблиці `e_posts_tags`
--
ALTER TABLE `e_posts_tags`
  ADD PRIMARY KEY (`id`,`posts_id`,`tags_id`,`languages_id`),
  ADD UNIQUE KEY `posts_id` (`posts_id`,`tags_id`),
  ADD KEY `fk_tags_content_content1_idx` (`posts_id`),
  ADD KEY `fk_tags_posts_tags1_idx` (`tags_id`),
  ADD KEY `fk_posts_tags_languages1_idx` (`languages_id`);

--
-- Індекси таблиці `e_posts_views`
--
ALTER TABLE `e_posts_views`
  ADD PRIMARY KEY (`id`),
  ADD KEY `posts_id` (`posts_id`),
  ADD KEY `date` (`date`);

--
-- Індекси таблиці `e_products_prices`
--
ALTER TABLE `e_products_prices`
  ADD PRIMARY KEY (`id`,`content_id`,`group_id`),
  ADD UNIQUE KEY `content_id` (`content_id`,`group_id`),
  ADD KEY `fk_products_prices_content1_idx` (`content_id`),
  ADD KEY `fk_products_prices_users_group1_idx` (`group_id`);

--
-- Індекси таблиці `e_products_variants`
--
ALTER TABLE `e_products_variants`
  ADD PRIMARY KEY (`id`,`content_id`),
  ADD KEY `fk_products_variants_content1_idx` (`content_id`);

--
-- Індекси таблиці `e_products_variants_features`
--
ALTER TABLE `e_products_variants_features`
  ADD PRIMARY KEY (`id`,`variants_id`,`features_id`,`values_id`),
  ADD UNIQUE KEY `variants_id` (`variants_id`,`features_id`,`values_id`),
  ADD KEY `fk_products_variants_features_features1_idx` (`features_id`),
  ADD KEY `fk_products_variants_features_products_variants1_idx` (`variants_id`),
  ADD KEY `fk_products_variants_features_features2_idx` (`values_id`);

--
-- Індекси таблиці `e_products_variants_prices`
--
ALTER TABLE `e_products_variants_prices`
  ADD PRIMARY KEY (`id`,`variants_id`,`content_id`,`group_id`),
  ADD UNIQUE KEY `variants_id` (`variants_id`,`content_id`,`group_id`),
  ADD KEY `fk_products_variants_prices_products_variants1_idx` (`variants_id`,`content_id`),
  ADD KEY `fk_products_variants_prices_users_group1_idx` (`group_id`);

--
-- Індекси таблиці `e_search_history`
--
ALTER TABLE `e_search_history`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `q` (`q`);

--
-- Індекси таблиці `e_search_history_stat`
--
ALTER TABLE `e_search_history_stat`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `search_history_id` (`search_history_id`,`date`);

--
-- Індекси таблиці `e_settings`
--
ALTER TABLE `e_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sname` (`name`);

--
-- Індекси таблиці `e_tags`
--
ALTER TABLE `e_tags`
  ADD PRIMARY KEY (`id`);

--
-- Індекси таблиці `e_users`
--
ALTER TABLE `e_users`
  ADD PRIMARY KEY (`id`,`group_id`,`languages_id`),
  ADD UNIQUE KEY `phone` (`phone`,`email`),
  ADD KEY `fk_users_group1_idx` (`group_id`),
  ADD KEY `status` (`status`),
  ADD KEY `skey` (`skey`);

--
-- Індекси таблиці `e_users_group`
--
ALTER TABLE `e_users_group`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`parent_id`),
  ADD KEY `sort` (`position`),
  ADD KEY `isfolder` (`isfolder`),
  ADD KEY `backend` (`backend`);

--
-- Індекси таблиці `e_users_group_info`
--
ALTER TABLE `e_users_group_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `group_id` (`group_id`,`languages_id`),
  ADD KEY `fk_users_group_info_users_group1_idx` (`group_id`),
  ADD KEY `fk_users_group_info_languages1_idx` (`languages_id`);

--
-- Індекси таблиці `e_wishlist`
--
ALTER TABLE `e_wishlist`
  ADD PRIMARY KEY (`id`,`users_id`),
  ADD KEY `fk_wishlist_e_users1_idx` (`users_id`);

--
-- Індекси таблиці `e_wishlist_products`
--
ALTER TABLE `e_wishlist_products`
  ADD PRIMARY KEY (`id`,`wishlist_id`,`products_id`),
  ADD UNIQUE KEY `wishlist_id` (`wishlist_id`,`products_id`,`variants_id`),
  ADD KEY `fk_wishlist_products_e_wishlist1_idx` (`wishlist_id`),
  ADD KEY `fk_wishlist_products_e_content1_idx` (`products_id`),
  ADD KEY `variants_id` (`variants_id`);

--
-- AUTO_INCREMENT для збережених таблиць
--

--
-- AUTO_INCREMENT для таблиці `e_banners`
--
ALTER TABLE `e_banners`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT для таблиці `e_banners_places`
--
ALTER TABLE `e_banners_places`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблиці `e_callbacks`
--
ALTER TABLE `e_callbacks`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблиці `e_comments`
--
ALTER TABLE `e_comments`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT для таблиці `e_comments_likers`
--
ALTER TABLE `e_comments_likers`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT для таблиці `e_comments_subscribers`
--
ALTER TABLE `e_comments_subscribers`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT для таблиці `e_content`
--
ALTER TABLE `e_content`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11491;
--
-- AUTO_INCREMENT для таблиці `e_content_features`
--
ALTER TABLE `e_content_features`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=70;
--
-- AUTO_INCREMENT для таблиці `e_content_images`
--
ALTER TABLE `e_content_images`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10208;
--
-- AUTO_INCREMENT для таблиці `e_content_images_sizes`
--
ALTER TABLE `e_content_images_sizes`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT для таблиці `e_content_info`
--
ALTER TABLE `e_content_info`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11480;
--
-- AUTO_INCREMENT для таблиці `e_content_meta`
--
ALTER TABLE `e_content_meta`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT для таблиці `e_content_relationship`
--
ALTER TABLE `e_content_relationship`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10214;
--
-- AUTO_INCREMENT для таблиці `e_content_types`
--
ALTER TABLE `e_content_types`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=28;
--
-- AUTO_INCREMENT для таблиці `e_content_types_images_sizes`
--
ALTER TABLE `e_content_types_images_sizes`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблиці `e_currency`
--
ALTER TABLE `e_currency`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблиці `e_delivery`
--
ALTER TABLE `e_delivery`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблиці `e_delivery_info`
--
ALTER TABLE `e_delivery_info`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблиці `e_delivery_payment`
--
ALTER TABLE `e_delivery_payment`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT для таблиці `e_features`
--
ALTER TABLE `e_features`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT для таблиці `e_features_content`
--
ALTER TABLE `e_features_content`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT для таблиці `e_features_info`
--
ALTER TABLE `e_features_info`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT для таблиці `e_feedbacks`
--
ALTER TABLE `e_feedbacks`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT для таблиці `e_languages`
--
ALTER TABLE `e_languages`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблиці `e_nav`
--
ALTER TABLE `e_nav`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT для таблиці `e_nav_items`
--
ALTER TABLE `e_nav_items`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT для таблиці `e_orders`
--
ALTER TABLE `e_orders`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT для таблиці `e_orders_products`
--
ALTER TABLE `e_orders_products`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT для таблиці `e_orders_status`
--
ALTER TABLE `e_orders_status`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT для таблиці `e_orders_status_history`
--
ALTER TABLE `e_orders_status_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT для таблиці `e_orders_status_info`
--
ALTER TABLE `e_orders_status_info`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT для таблиці `e_payment`
--
ALTER TABLE `e_payment`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблиці `e_payment_info`
--
ALTER TABLE `e_payment_info`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблиці `e_posts_tags`
--
ALTER TABLE `e_posts_tags`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблиці `e_posts_views`
--
ALTER TABLE `e_posts_views`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT для таблиці `e_products_prices`
--
ALTER TABLE `e_products_prices`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10212;
--
-- AUTO_INCREMENT для таблиці `e_products_variants`
--
ALTER TABLE `e_products_variants`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT для таблиці `e_products_variants_features`
--
ALTER TABLE `e_products_variants_features`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT для таблиці `e_products_variants_prices`
--
ALTER TABLE `e_products_variants_prices`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT для таблиці `e_search_history`
--
ALTER TABLE `e_search_history`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблиці `e_search_history_stat`
--
ALTER TABLE `e_search_history_stat`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT для таблиці `e_settings`
--
ALTER TABLE `e_settings`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=53;
--
-- AUTO_INCREMENT для таблиці `e_tags`
--
ALTER TABLE `e_tags`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблиці `e_users`
--
ALTER TABLE `e_users`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT для таблиці `e_users_group`
--
ALTER TABLE `e_users_group`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT для таблиці `e_users_group_info`
--
ALTER TABLE `e_users_group_info`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=38;
--
-- AUTO_INCREMENT для таблиці `e_wishlist`
--
ALTER TABLE `e_wishlist`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблиці `e_wishlist_products`
--
ALTER TABLE `e_wishlist_products`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
--
-- Обмеження зовнішнього ключа збережених таблиць
--

--
-- Обмеження зовнішнього ключа таблиці `e_banners`
--
ALTER TABLE `e_banners`
  ADD CONSTRAINT `fk_banners_banners_places1` FOREIGN KEY (`places_id`) REFERENCES `e_banners_places` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_banners_languages1` FOREIGN KEY (`languages_id`) REFERENCES `e_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_comments`
--
ALTER TABLE `e_comments`
  ADD CONSTRAINT `fk_comments_content1` FOREIGN KEY (`content_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_users_id` FOREIGN KEY (`users_id`) REFERENCES `e_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_comments_likers`
--
ALTER TABLE `e_comments_likers`
  ADD CONSTRAINT `fk_comments_likers_comments1` FOREIGN KEY (`comments_id`) REFERENCES `e_comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_comments_likers_users1` FOREIGN KEY (`users_id`) REFERENCES `e_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_comments_subscribers`
--
ALTER TABLE `e_comments_subscribers`
  ADD CONSTRAINT `fk_comments_subscribers_content1` FOREIGN KEY (`content_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_comments_subscribers_users1` FOREIGN KEY (`users_id`) REFERENCES `e_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_content`
--
ALTER TABLE `e_content`
  ADD CONSTRAINT `fk_content_content_subtypes1` FOREIGN KEY (`subtypes_id`) REFERENCES `e_content_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_content_content_types1` FOREIGN KEY (`types_id`) REFERENCES `e_content_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_content_owner_id1` FOREIGN KEY (`owner_id`) REFERENCES `e_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_content_features`
--
ALTER TABLE `e_content_features`
  ADD CONSTRAINT `fk_content_features_values_content1` FOREIGN KEY (`content_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_content_features_values_features1` FOREIGN KEY (`features_id`) REFERENCES `e_features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_content_images`
--
ALTER TABLE `e_content_images`
  ADD CONSTRAINT `fk_content_images_content1` FOREIGN KEY (`content_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_content_info`
--
ALTER TABLE `e_content_info`
  ADD CONSTRAINT `fk_content_info_content1` FOREIGN KEY (`content_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_content_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `e_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_content_meta`
--
ALTER TABLE `e_content_meta`
  ADD CONSTRAINT `fk_e_content_meta_e_content1` FOREIGN KEY (`content_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_content_relationship`
--
ALTER TABLE `e_content_relationship`
  ADD CONSTRAINT `fk_content_relationship_content1` FOREIGN KEY (`content_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_content_relationship_content2` FOREIGN KEY (`categories_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_content_types_images_sizes`
--
ALTER TABLE `e_content_types_images_sizes`
  ADD CONSTRAINT `fk_content_types_images_sizes1` FOREIGN KEY (`types_id`) REFERENCES `e_content_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_content_types_images_sizes2` FOREIGN KEY (`images_sizes_id`) REFERENCES `e_content_images_sizes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_delivery_info`
--
ALTER TABLE `e_delivery_info`
  ADD CONSTRAINT `fk_delivery_info_delivery1` FOREIGN KEY (`delivery_id`) REFERENCES `e_delivery` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_delivery_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `e_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_delivery_payment`
--
ALTER TABLE `e_delivery_payment`
  ADD CONSTRAINT `fk_delivery_payment_delivery1` FOREIGN KEY (`delivery_id`) REFERENCES `e_delivery` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_delivery_payment_payment1` FOREIGN KEY (`payment_id`) REFERENCES `e_payment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_features`
--
ALTER TABLE `e_features`
  ADD CONSTRAINT `fk_features_users1` FOREIGN KEY (`owner_id`) REFERENCES `e_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_features_content`
--
ALTER TABLE `e_features_content`
  ADD CONSTRAINT `fk_content_features_idx` FOREIGN KEY (`features_id`) REFERENCES `e_features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_features_info`
--
ALTER TABLE `e_features_info`
  ADD CONSTRAINT `fk_features_info_features1` FOREIGN KEY (`features_id`) REFERENCES `e_features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_features_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `e_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_nav_items`
--
ALTER TABLE `e_nav_items`
  ADD CONSTRAINT `fk_nav_items_content1` FOREIGN KEY (`content_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_nav_items_nav1` FOREIGN KEY (`nav_id`) REFERENCES `e_nav` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_orders`
--
ALTER TABLE `e_orders`
  ADD CONSTRAINT `fk_orders_languages1` FOREIGN KEY (`languages_id`) REFERENCES `e_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_orders_users1` FOREIGN KEY (`users_id`, `users_group_id`) REFERENCES `e_users` (`id`, `group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_status_id` FOREIGN KEY (`status_id`) REFERENCES `e_orders_status` (`id`);

--
-- Обмеження зовнішнього ключа таблиці `e_orders_products`
--
ALTER TABLE `e_orders_products`
  ADD CONSTRAINT `fk_orders_products_content1` FOREIGN KEY (`products_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_orders_products_orders1` FOREIGN KEY (`orders_id`) REFERENCES `e_orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_orders_status_history`
--
ALTER TABLE `e_orders_status_history`
  ADD CONSTRAINT `fk_e_orders_status_history_e_orders1` FOREIGN KEY (`orders_id`) REFERENCES `e_orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_e_orders_status_history_e_orders_status1` FOREIGN KEY (`status_id`) REFERENCES `e_orders_status` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_orders_status_info`
--
ALTER TABLE `e_orders_status_info`
  ADD CONSTRAINT `fk_orders_status_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `e_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_orders_status_info_orders_status1` FOREIGN KEY (`status_id`) REFERENCES `e_orders_status` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_payment_info`
--
ALTER TABLE `e_payment_info`
  ADD CONSTRAINT `fk_payment_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `e_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_payment_info_payment1` FOREIGN KEY (`payment_id`) REFERENCES `e_payment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_posts_tags`
--
ALTER TABLE `e_posts_tags`
  ADD CONSTRAINT `fk_posts_tags_languages1` FOREIGN KEY (`languages_id`) REFERENCES `e_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tags_content1` FOREIGN KEY (`posts_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tags_posts_tags1` FOREIGN KEY (`tags_id`) REFERENCES `e_tags` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_posts_views`
--
ALTER TABLE `e_posts_views`
  ADD CONSTRAINT `fk_posts_id` FOREIGN KEY (`posts_id`) REFERENCES `e_content` (`id`);

--
-- Обмеження зовнішнього ключа таблиці `e_products_prices`
--
ALTER TABLE `e_products_prices`
  ADD CONSTRAINT `fk_products_prices_content1` FOREIGN KEY (`content_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_products_prices_users_group1` FOREIGN KEY (`group_id`) REFERENCES `e_users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_products_variants`
--
ALTER TABLE `e_products_variants`
  ADD CONSTRAINT `fk_products_variants_content1` FOREIGN KEY (`content_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_products_variants_features`
--
ALTER TABLE `e_products_variants_features`
  ADD CONSTRAINT `fk_products_variants_features_features1` FOREIGN KEY (`features_id`) REFERENCES `e_features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_products_variants_features_features2` FOREIGN KEY (`values_id`) REFERENCES `e_features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_products_variants_features_products_variants1` FOREIGN KEY (`variants_id`) REFERENCES `e_products_variants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_products_variants_prices`
--
ALTER TABLE `e_products_variants_prices`
  ADD CONSTRAINT `fk_products_variants_prices_products_variants1` FOREIGN KEY (`variants_id`, `content_id`) REFERENCES `e_products_variants` (`id`, `content_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_products_variants_prices_users_group1` FOREIGN KEY (`group_id`) REFERENCES `e_users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_search_history_stat`
--
ALTER TABLE `e_search_history_stat`
  ADD CONSTRAINT `fk_search_history_stat_search_guery1` FOREIGN KEY (`search_history_id`) REFERENCES `e_search_history` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_users`
--
ALTER TABLE `e_users`
  ADD CONSTRAINT `fk_users_users_group1` FOREIGN KEY (`group_id`) REFERENCES `e_users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_users_group_info`
--
ALTER TABLE `e_users_group_info`
  ADD CONSTRAINT `fk_users_group_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `e_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_users_group_info_users_group1` FOREIGN KEY (`group_id`) REFERENCES `e_users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_wishlist`
--
ALTER TABLE `e_wishlist`
  ADD CONSTRAINT `fk_wishlist_users1` FOREIGN KEY (`users_id`) REFERENCES `e_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_wishlist_products`
--
ALTER TABLE `e_wishlist_products`
  ADD CONSTRAINT `fk_wishlist_products_e_content1` FOREIGN KEY (`products_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_wishlist_products_e_wishlist1` FOREIGN KEY (`wishlist_id`) REFERENCES `e_wishlist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
