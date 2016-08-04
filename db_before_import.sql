-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Июл 07 2016 г., 14:19
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Дамп данных таблицы `e_banners`
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `e_banners_places`
--

INSERT INTO `e_banners_places` (`id`, `code`, `name`, `width`, `height`) VALUES
(1, 'home-top', 'Голоана', 730, 330),
(2, 'home-bottom', 'Головна внизу', 350, 175);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
  `likes` int(10) unsigned NOT NULL,
  `dislikes` int(10) unsigned NOT NULL,
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- Дамп данных таблицы `e_comments`
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
-- Структура таблицы `e_comments_likers`
--

CREATE TABLE IF NOT EXISTS `e_comments_likers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` int(11) unsigned NOT NULL,
  `comments_id` int(10) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`users_id`,`comments_id`),
  KEY `fk_comments_likers_users1_idx` (`users_id`),
  KEY `fk_comments_likers_comments1_idx` (`comments_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Дамп данных таблицы `e_comments_likers`
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Дамп данных таблицы `e_comments_subscribers`
--

INSERT INTO `e_comments_subscribers` (`id`, `content_id`, `users_id`, `created`) VALUES
(7, 20, 3, '2016-07-06 12:08:38'),
(11, 18, 3, '2016-07-06 14:34:20');

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
  `sku` varchar(60) DEFAULT NULL,
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
  KEY `code` (`sku`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=43 ;

--
-- Дамп данных таблицы `e_content`
--

INSERT INTO `e_content` (`id`, `types_id`, `subtypes_id`, `owner_id`, `parent_id`, `isfolder`, `position`, `created`, `updated`, `published`, `settings`, `status`, `sku`, `currency_id`, `unit_id`, `has_variants`, `in_stock`, `external_id`) VALUES
(1, 1, 16, 2, 0, 1, 0, '2016-07-04 19:39:41', '2016-07-04 20:00:21', '2016-07-04', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(4, 1, 1, 2, 1, 0, 0, '2016-07-04 20:09:38', '2016-07-04 20:09:53', '2016-07-04', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(5, 1, 17, 2, 1, 0, 0, '2016-07-04 20:09:55', '2016-07-05 06:44:32', '2016-07-04', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(6, 1, 1, 2, 1, 0, 0, '2016-07-04 20:10:10', '2016-07-04 20:14:44', '2016-07-04', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(7, 1, 21, 2, 1, 0, 0, '2016-07-04 20:10:43', '2016-07-07 07:39:05', '2016-07-04', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(16, 19, 19, 2, 0, 0, 0, '2016-07-05 07:03:56', '2016-07-05 07:03:56', '2016-07-05', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(17, 19, 19, 2, 0, 0, 0, '2016-07-05 07:04:05', '2016-07-05 07:04:05', '2016-07-05', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(18, 18, 18, 2, 0, 0, 0, '2016-07-05 07:04:07', '2016-07-05 09:26:56', '2016-07-05', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(19, 18, 18, 2, 0, 0, 0, '2016-07-05 07:22:12', '2016-07-05 09:28:34', '2016-07-05', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(20, 18, 18, 2, 0, 0, 0, '2016-07-05 07:25:51', '2016-07-05 09:29:28', '2016-07-05', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(21, 18, 18, 2, 0, 0, 0, '2016-07-05 07:26:32', '2016-07-05 07:26:59', '2016-07-05', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(22, 18, 18, 2, 0, 0, 0, '2016-07-05 07:27:13', '2016-07-05 07:27:36', '2016-07-05', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(23, 18, 18, 2, 0, 0, 0, '2016-07-05 07:27:41', '2016-07-05 07:28:44', '2016-07-05', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(25, 1, 1, 2, 1, 0, 0, '2016-07-06 13:05:47', '2016-07-06 13:05:54', '2016-07-06', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(26, 1, 20, 2, 1, 1, 0, '2016-07-07 07:34:56', '2016-07-07 07:35:54', '2016-07-07', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(28, 1, 20, 2, 26, 1, 0, '2016-07-07 07:35:12', '2016-07-07 07:36:00', '2016-07-07', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(29, 1, 20, 2, 28, 0, 0, '2016-07-07 08:08:57', '2016-07-07 08:09:05', '2016-07-07', NULL, 'deleted', NULL, NULL, NULL, NULL, NULL, NULL),
(30, 1, 20, 2, 26, 0, 0, '2016-07-07 08:09:06', '2016-07-07 08:14:47', '2016-07-07', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(31, 1, 20, 2, 26, 0, 0, '2016-07-07 08:14:53', '2016-07-07 08:15:02', '2016-07-07', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(32, 1, 20, 2, 26, 0, 0, '2016-07-07 08:15:17', '2016-07-07 08:15:43', '2016-07-07', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(34, 2, 2, 2, 0, 1, 0, '2016-07-07 11:11:18', '2016-07-07 11:12:46', '2016-07-07', NULL, 'published', NULL, NULL, NULL, NULL, NULL, 'units'),
(35, 2, 2, 2, 34, 0, 0, '2016-07-07 11:11:31', '2016-07-07 11:11:31', '2016-07-07', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(36, 2, 2, 2, 34, 0, 0, '2016-07-07 11:11:48', '2016-07-07 11:11:48', '2016-07-07', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(37, 2, 2, 2, 34, 0, 0, '2016-07-07 11:11:55', '2016-07-07 11:11:55', '2016-07-07', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(38, 2, 2, 2, 34, 0, 0, '2016-07-07 11:12:06', '2016-07-07 11:12:06', '2016-07-07', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(39, 2, 2, 2, 34, 0, 0, '2016-07-07 11:12:12', '2016-07-07 11:12:12', '2016-07-07', NULL, 'published', NULL, NULL, NULL, NULL, NULL, NULL),
(42, 23, 23, 2, 0, 0, 0, '2016-07-07 11:14:29', NULL, NULL, NULL, 'blank', NULL, NULL, NULL, NULL, NULL, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `e_content_images`
--

INSERT INTO `e_content_images` (`id`, `content_id`, `path`, `image`, `position`, `created`) VALUES
(1, 18, 'uploads/content/2016/07/05/', 'new1-18x.png', 1, '2016-07-05 07:11:35'),
(2, 20, 'uploads/content/2016/07/05/', 'new2-20x.png', 1, '2016-07-05 07:26:22'),
(3, 22, 'uploads/content/2016/07/05/', 'new4-22x.png', 1, '2016-07-05 07:27:33'),
(4, 23, 'uploads/content/2016/07/05/', 'new_one-23x.png', 1, '2016-07-05 07:28:20');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Дамп данных таблицы `e_content_images_sizes`
--

INSERT INTO `e_content_images_sizes` (`id`, `size`, `width`, `height`) VALUES
(3, 'post', 240, 220);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

--
-- Дамп данных таблицы `e_content_info`
--

INSERT INTO `e_content_info` (`id`, `content_id`, `languages_id`, `name`, `url`, `h1`, `title`, `keywords`, `description`, `intro`, `content`) VALUES
(1, 1, 1, 'Головна', '', '', 'Головна', '', '', '', ''),
(2, 4, 1, 'Про нас', 'pro-nas', '', 'Про нас', '', '', '', ''),
(3, 5, 1, 'Новини та Акції', 'novyny-ta-akcii', '', 'Новини та Акції', '', '', '', ''),
(4, 6, 1, 'Доставка і оплата', 'dostavka-i-oplata', '', 'Доставка і оплата', '', '', '', ''),
(5, 7, 1, 'Контакти', 'kontakty', '', 'Контакти', '', '', '', ''),
(7, 16, 1, 'Новини', 'novyny', '', 'Новини', '', '', NULL, NULL),
(8, 17, 1, 'Акції', 'akcii', '', 'Акції', '', '', NULL, NULL),
(9, 18, 1, 'Samsung Galaxy S7 дві SIM і microSD', 'samsung-galaxy-s7-dvi-sim-i-microsd', '', 'Samsung Galaxy S7: як змусити працювати дві SIM і microSD разом', '', '', '<p>Samsung услышала просьбы фанатов и оснастила флагманы Galaxy S7 и Galaxy S7&nbsp;</p>\n', '<p>Samsung услышала просьбы фанатов и оснастила флагманы Galaxy S7 и Galaxy S7 edge слотом для карт microSD. Правда, сделала это, как сейчас модно, с помощью гибридного лотка, то есть пользователь должен выбрать, будет ли он использовать две SIM-карты или одну SIM и microSD. &laquo;Очумелые ручки&raquo; желающих получить все и сразу привели к появлению инструкции, как добиться одновременной работы двух SIM-карт и microSD. Для этого вам необходимо осторожно отделить чип SIM-карты от корпуса (по словам автора, это занимает не больше минуты времени), обрезать по 1-2 мм с каждой стороны, чтобы она не выходила за пределы карты памяти, приклеить симку к обратной стороне microSD строго, как показано на картинке</p>\n'),
(10, 19, 1, 'Фоновий малюнок HTC 10 на Sense UI', 'fonovyj-malyunok-htc-10-na-sense-ui', '', 'Фоновий малюнок HTC 10 на Sense UI у повномурозмірі доступний для Вас', '', '', '<p>Волна повышения тарифов заставила потребителей перейти на коммунальную диету.</p>\n', '<p>Волна повышения тарифов заставила потребителей перейти на коммунальную диету. Активный самостоятельный поиск альтернативных источников тепла обращает внимание &nbsp;на твердотопливные котельные. Доступность топливной составляющей &mdash; весомое преимущество отопительного спецоборудования. Желающим получить максимальный экономический эффект, необходимо смотреть на систему как на единое целое<strong>. &nbsp;</strong>Монтаж и&nbsp;<strong><a target="_blank">проектирование котельных</a></strong>&nbsp;&ndash; удел специалистов. Вам предлагается &nbsp;эффективные, простые в эксплуатации, отопительные системы на твердом топливе, которые неприхотливы в обслуживании и отличаются низкой себестоимостью.</p>\n'),
(11, 20, 1, 'Экономный источник тепловой энергии', 'ekonomnyj-ystochnyk-teplovoj-energyy', '', 'Экономный источник тепловой энергии', '', '', '<p>Устанавливаются &nbsp;на любую&nbsp;площадку.</p>\n', '<p><strong><a href="http://e-service.biz.ua/produktsiya/modulnye-kotelnye-na-tverdom-toplive" target="_blank">Модульные котельные</a></strong>&nbsp;установки, собраны и настроены на заводе, предназначены для отопления и горячего водоснабжения объектов промышленного или жилого назначения. Устанавливаются в непосредственной близости к отапливаемому сооружению на любую ровную площадку. Высокие показатели эффективности работы твердотопливной котельной установки позволяют значительно экономить на энергоресурсах.</p>\n\n<p>На этапе проектирования, расчет тепловых нагрузок выполняется под конкретное техническое задание. Блочно-модульный принцип комплектации котельной&nbsp; предусматривает возможность&nbsp; подбора технологического оборудования в широком диапазоне мощностей под каждого потребителя. Максимально сжатые сроки от начала проектирования и до момента запуска в эксплуатацию &mdash; весомый аргумент в пользу блочно-модульных котельных, работающих на твердом топливе.</p>\n'),
(12, 21, 1, 'Мифы, которые развенчает любой магазин стиральных машин.', 'myfy-kotorye-razvenchaet-lyuboj-magazyn-styral-nyh-mashyn', '', 'Мифы, которые развенчает любой магазин стиральных машин.', '', '', '<p>Ежедневно на рынке совершается несколько тысяч сделок по покупке бытовой техники. Однако любой магазин стиральных машин подтвердит, что при выборе данного оборудования многие покупатели руководствуются очень нелепыми заблуждениями, навязанными общественным мнением. Существует целый ряд мифов о стиральных машинах. И именно эти заблуждения порой препятствуют правильному выбору или эксплуатации техники.</p>\n', '<p>Ежедневно на рынке совершается несколько тысяч сделок по покупке бытовой техники. Однако любой магазин стиральных машин подтвердит, что при выборе данного оборудования многие покупатели руководствуются очень нелепыми заблуждениями, навязанными общественным мнением. Существует целый ряд мифов о стиральных машинах. И именно эти заблуждения порой препятствуют правильному выбору или эксплуатации техники.</p>\n\n<p>Итак, крупный интернет&nbsp;<strong>магазин стиральных машин</strong>&nbsp;предлагает ТОП 5 заблуждений:</p>\n\n<p><img alt="магазин стиральных машин" height="384" src="http://freecentre.com.ua/wp-content/uploads/2015/04/4f4e766ab5a3e.jpg" width="640" /></p>\n\n<p>1. Калгон &ndash; это панацея. Зачастую современные стиральные порошки уже содержат в составе средства, смягчающие воду. Однако их содержание в порошке минимально, поэтому накипь все равно образовывается. И Калгон по мнению специалистов не препятствует этому процессу, не удаляет уже образовавшуюся накипь. Лучше использовать обычную лимонную кислоту, которая добавляется в отсек стиральной машины. При этом барабан не загружается бельем, машинка работает в холостую на режиме стирки при максимально высокой температуре. Результат будет заметен даже невооруженным глазом.</p>\n\n<p>2. Вертикальная загрузка более предпочтительна. Люди, которые приходят в&nbsp;<strong>магазин стиральных машин</strong>, часто выбирают более дорогие вертикальные машины лишь потому, что, по их мнению, в такой технике баки крепятся лучше. И именно качественное крепление обеспечивает длительный срок эксплуатации машины, а также меньшую вибрацию при отжиме. На самом деле это лишь заблуждение. И вертикальные машины ломаются. Важно правильно загружать барабан бельем, не перегружать и не стирать по одной вещи. Тогда вы сможете избежать перекосов барабана и как следствие &ndash; поломок или усиленной вибрации.</p>\n\n<p><img alt="как выбрать стиральную машину" height="398" src="http://freecentre.com.ua/wp-content/uploads/2015/04/2dc373d18b880d0a4d7864324fc9ad5c_h.jpg" width="550" /></p>\n\n<p>3. Нужно набивать барабан плотно, тогда машинка не будет &laquo;прыгать&raquo;. В данном случае дело не в степени загрузки барабана, а в других особенностях. Каждый вид ткани обладает своими свойствами. При намокании хлопок лишь немного увеличивает вес, а вот махровые полотенца становятся гораздо тяжелее. Отсюда и &laquo;прыжки&raquo; техники во время отжима, затянутое время стирки по причине того, что машина не может раскрутить барабан. Нужно обязательно застегивать все пуговицы, молнии, иные застежки перед тем, как класть вещь в барабан. Используйте мешки для стирки деликатных тканей.</p>\n\n<p>4. Фильтр для машины продлит ее срок службы. Но его установка производит обратный эффект. Фильтры не справляются с очисткой воды, поэтому осадок и накипь никуда не исчезают. Однако возрастает риск образования засоров. Так называемые солевые фильтры могут засорить входной клапан солью, поэтому техника будет постепенно набирать воду даже в режиме покоя. И рано или поздно эта вода станет литься на пол. В отдельных случаях вы можете даже затопить соседей снизу. Лучше устанавливать фильтр на всю поступающую в дом воду. Конечно, такой способ дороже, но гораздо эффективнее.</p>\n\n<p>5. Ультразвуковая стиральная машина. Любой&nbsp;<strong>магазин стиральных машин</strong>&nbsp;подтвердит, что такие устройства не несут в себе никакой пользы. Эффективность от их применения соизмерима с простым замачиванием белья. Без усилий и механического воздействия избавиться от пятен у вас не получится.</p>\n'),
(13, 22, 1, 'Доставка техники из Китая', 'dostavka-tehnyky-yz-kytaya', '', 'Доставка техники из Китая', '', '', '<p>Поставка груза из Китая в Украину реализуется по сформированной схеме.Товар направляется к месту назначения, в это время работники логистического предприятия занимаются оформлением документов для его таможенного оформления. Доставленный в Украину груз, подвергается особой проверке. Когда груз прошел всю процедуру проверки успешно, тогда он готов для отправки в разные города Украины.</p>\n', '<p>Важнейшим функциональным предметом владения доносящего постоянный доход бизнеса, есть как иное маркетинговые исследования во множество разных грузоперевозок промышленных товаров из-за рубежа.На данный момент торговые структуры обращают пристально внимание на&nbsp;<a href="http://proficargo.com.ua/geografiya-perevozok/aziya/kitaj.html">доставку сборных грузов из Китая</a>, которые возрастают на особые результаты каждый год. Проанализировано грузопотоки на основе данных из таможни, образовавшими структурами госслужб, которые позволяют определить не только сферы развития международной торговли, но и возрастание спроса по разным предприятиям.<br />\n<img alt="доставка сборных грузов из китая" height="690" src="http://freecentre.com.ua/wp-content/uploads/2015/03/dostavka-sbornyh-gruzov-iz-kitaya-1030x826.jpg" width="861" /><br />\nКомпании которые конкуренты имеют доступ к изучению по разным ступеням руководства собственного производства: закупку различной продукции, каким видом грузоперевозок поставляется и период между поставок груза. Такой доступ открыт только для крупных предприятий.<br />\nЧаще всего бизнесмены, закупающие товар в Китае, ошибаются в выборе грузоперевозки определенным транспортом, который позаботится о хорошей и своевременной доставки. Большинство торговых предприятий выбирают способ грузоперевозки ориентируясь на экономию в тарифах или быстроту доставки. Грузоперевозки из Китая не так просты, ведь тут задействуют все основные факторы, с помощью которых уменьшают основные растраты при ведении особых условий.</p>\n\n<p>Поставка груза из Китая в Украину реализуется по сформированной схеме.Товар направляется к месту назначения, в это время работники логистического предприятия занимаются оформлением документов для его таможенного оформления. Доставленный в Украину груз, подвергается особой проверке. Когда груз прошел всю процедуру проверки успешно, тогда он готов для отправки в разные города Украины.</p>\n'),
(15, 23, 1, 'Экономный источник тепловой энергии 2', 'ekonomnyj-ystochnyk-teplovoj-energyy-2', '', 'Экономный источник тепловой энергии 2', '', '', '<p>Модульные твердотопливные котельные &ndash; надежные, безопасные решения &mdash; не требуют согласования с различными инстанциями, прошли испытания, что подтверждается сертификатом соответствия.</p>\n', '<p>Волна повышения тарифов заставила потребителей перейти на коммунальную диету. Активный самостоятельный поиск альтернативных источников тепла обращает внимание &nbsp;на твердотопливные котельные. Доступность топливной составляющей &mdash; весомое преимущество отопительного спецоборудования. Желающим получить максимальный экономический эффект, необходимо смотреть на систему как на единое целое<strong>. &nbsp;</strong>Монтаж и&nbsp;<strong><a href="http://e-service.biz.ua/usluhy/proektnye-resheniya" target="_blank">проектирование котельных</a></strong>&nbsp;&ndash; удел специалистов. Вам предлагается &nbsp;эффективные, простые в эксплуатации, отопительные системы на твердом топливе, которые неприхотливы в обслуживании и отличаются низкой себестоимостью.</p>\n\n<p><img alt="Экономный источник тепловой энергии" height="437" src="http://freecentre.com.ua/wp-content/uploads/2015/04/2015-04-20-11-51-15-Rezultat-poiska-Google-dlya-http-www.porjati.ru-uploads-posts-2014-05-thumbs-1401181088_blst-14.jpg-.png" width="675" /></p>\n\n<p><strong><a href="http://e-service.biz.ua/produktsiya/modulnye-kotelnye-na-tverdom-toplive" target="_blank">Модульные котельные</a></strong>&nbsp;установки, собраны и настроены на заводе, предназначены для отопления и горячего водоснабжения объектов промышленного или жилого назначения. Устанавливаются в непосредственной близости к отапливаемому сооружению на любую ровную площадку. Высокие показатели эффективности работы твердотопливной котельной установки позволяют значительно экономить на энергоресурсах.</p>\n\n<p>На этапе проектирования, расчет тепловых нагрузок выполняется под конкретное техническое задание. Блочно-модульный принцип комплектации котельной&nbsp; предусматривает возможность&nbsp; подбора технологического оборудования в широком диапазоне мощностей под каждого потребителя. Максимально сжатые сроки от начала проектирования и до момента запуска в эксплуатацию &mdash; весомый аргумент в пользу блочно-модульных котельных, работающих на твердом топливе.</p>\n\n<p><img alt="модульные котельные на твердом топливе" height="789" src="http://freecentre.com.ua/wp-content/uploads/2015/04/2015-04-20-11-54-31-KlimatAkvaTEks-2014-.-Krasnoyarsk.-Rezultaty-vystavki.-Waterfox.png" width="793" /></p>\n\n<p>Корпус модульной котельной &ndash; цельнометаллический каркас, с высококачественной теплоизоляцией, пожаробезопасный, имеет высокую степень защиты от физических повреждений и влияния климатических условий. Простой монтаж исключает&nbsp; затраты на капитальное строительство. Показатели выбросов продуктов горения соответствуют европейским экологическим нормам. Автоматизированная система котельной управляет количеством выработанной тепловой энергии, распределяет её и передает по трубопроводам. Температура теплоносителя регулируется автоматически, учет вырабатываемого тепла осуществляется теплосчетчиком. Регулярность обслуживания зависит от объема бункера и не требует постоянного присутствия персонала.</p>\n\n<p>Модульные твердотопливные котельные &ndash; надежные, безопасные решения &mdash; не требуют согласования с различными инстанциями, прошли испытания, что подтверждается сертификатом соответствия.</p>\n'),
(16, 25, 1, 'Сервіс', 'servis', '', 'Сервіс', '', '', '', ''),
(17, 26, 1, 'Аккаунт', 'akkaunt', '', 'Аккаунт', '', '', '', ''),
(18, 28, 1, 'Профіль', 'akkaunt/profil', '', 'Профіль', '', '', '', ''),
(19, 29, 1, 'Загальна інформація', 'akkaunt/profil/zagal-na-informaciya', '', 'Загальна інформація', '', '', '', ''),
(20, 30, 1, 'Мій кошик', 'akkaunt/profil/mij-koshyk', '', 'Мій кошик', '', '', '', ''),
(21, 31, 1, 'Мої замовлення', 'akkaunt/profil/moi-zamovlennya', '', 'Мої замовлення', '', '', '', ''),
(22, 32, 1, 'Моя бонусна картка', 'akkaunt/profil/moya-bonusna-kartka', '', 'Моя бонусна картка', '', '', '', ''),
(23, 34, 1, 'Кількісні одиниці', 'units', '', 'Кількісні одиниці', '', '', NULL, NULL),
(24, 35, 1, 'шт.', 'pt', '', 'шт.', '', '', NULL, NULL),
(25, 36, 1, 'уп.', 'pk', '', 'уп.', '', '', NULL, NULL),
(26, 37, 1, 'г.', 'g', '', 'г.', '', '', NULL, NULL),
(27, 38, 1, 'кг.', 'kg', '', 'кг.', '', '', NULL, NULL),
(28, 39, 1, 'т.', 't', '', 'т.', '', '', NULL, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Дамп данных таблицы `e_content_relationship`
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

--
-- Дамп данных таблицы `e_content_types`
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
(23, 0, 0, 'product', 'Магазин / товари', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `e_content_types_images_sizes`
--

INSERT INTO `e_content_types_images_sizes` (`id`, `types_id`, `images_sizes_id`) VALUES
(1, 18, 3);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
(1, 'uk', 'УКР', 1);

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
(1, 'user_register', 'Реєстрація користувача'),
(2, 'user_fp', 'Відновлення паролю'),
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
-- Структура таблицы `e_nav`
--

CREATE TABLE IF NOT EXISTS `e_nav` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `code` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `e_nav`
--

INSERT INTO `e_nav` (`id`, `name`, `code`) VALUES
(1, 'top', 'top'),
(3, 'bottom', 'bottom'),
(4, 'user', 'user');

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
(6, 3, 6, 1),
(8, 3, 7, 2);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `e_posts_views`
--

CREATE TABLE IF NOT EXISTS `e_posts_views` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `posts_id` int(10) unsigned NOT NULL,
  `date` date NOT NULL,
  `views` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `posts_id` (`posts_id`),
  KEY `date` (`date`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Дамп данных таблицы `e_posts_views`
--

INSERT INTO `e_posts_views` (`id`, `posts_id`, `date`, `views`) VALUES
(1, 18, '2016-07-05', 16),
(2, 19, '2016-07-05', 1),
(3, 20, '2016-07-05', 2),
(4, 20, '2016-07-06', 18),
(5, 19, '2016-07-06', 112),
(6, 18, '2016-07-06', 40),
(7, 20, '2016-07-07', 4);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Дамп данных таблицы `e_users`
--

INSERT INTO `e_users` (`id`, `group_id`, `languages_id`, `sessid`, `name`, `surname`, `phone`, `email`, `password`, `avatar`, `skey`, `created`, `updated`, `lastlogin`, `status`) VALUES
(2, 1, 0, '6idmprjk07d5ns37rac8g6iuu5', 'Володимир', 'Годяк', '+38 (067) 6736242', 'wmgodyak@gmail.com', 'MTTuFPm3y4m2o', '/uploads/avatars/c81e728d9d4c2f636f067f89cc14862c.png', NULL, '2016-03-03 13:25:08', '2016-04-21 11:24:28', '2016-07-07 11:04:09', 'active'),
(3, 20, 0, '6idmprjk07d5ns37rac8g6iuu5', 'Меган', 'Меган', '+11 (111) 1111111', 'm@otakoyi.com', 'MjMZqb1Pe1Ht6', NULL, NULL, '2016-07-06 10:22:58', '2016-07-07 11:57:39', '2016-07-07 08:26:17', 'active'),
(4, 20, 0, NULL, 'Жорік', '', '', 'otakoyi@gmail.com', 'NjDwRk3ebROnU', NULL, NULL, '2016-07-06 15:29:55', '2016-07-06 18:48:05', NULL, 'active'),
(5, 20, 0, NULL, 'Гена', '', '', 'g@otakoyi.com', 'MTTuFPm3y4m2o', NULL, NULL, '2016-07-06 15:32:05', '0000-00-00 00:00:00', NULL, 'active'),
(6, 20, 0, NULL, 'Гоша', '', '', 'gosha@otakoyi.com', 'MTk1WPl9Wq.uY', NULL, NULL, '2016-07-07 10:45:22', '2016-07-07 13:55:13', NULL, 'active');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

--
-- Дамп данных таблицы `e_users_group`
--

INSERT INTO `e_users_group` (`id`, `parent_id`, `isfolder`, `backend`, `permissions`, `position`) VALUES
(1, 0, 0, 1, 'a:1:{s:11:"full_access";s:1:"1";}', 1),
(2, 0, 0, 1, 'a:15:{s:11:"full_access";s:1:"0";s:9:"Dashboard";a:3:{i:0;s:5:"index";i:1;s:6:"create";i:2;s:4:"edit";}s:12:"content\\Post";a:6:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";i:4;s:3:"pub";i:5;s:4:"hide";}s:9:"Customers";a:7:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";i:4;s:6:"remove";i:5;s:3:"ban";i:6;s:7:"restore";}s:8:"Comments";a:9:{i:0;s:5:"index";i:1;s:3:"tab";i:2;s:5:"items";i:3;s:6:"create";i:4;s:4:"edit";i:5;s:5:"reply";i:6;s:7:"approve";i:7;s:4:"spam";i:8;s:7:"restore";}s:4:"Shop";a:3:{i:0;s:5:"index";i:1;s:6:"create";i:2;s:4:"edit";}s:16:"content\\Products";a:6:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";i:4;s:3:"pub";i:5;s:4:"hide";}s:26:"content\\ProductsCategories";a:6:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";i:4;s:3:"pub";i:5;s:4:"hide";}s:8:"Currency";a:4:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";}s:8:"Delivery";a:7:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";i:4;s:17:"getModuleSettings";i:5;s:3:"pub";i:6;s:4:"hide";}s:9:"Callbacks";a:8:{i:0;s:5:"index";i:1;s:3:"tab";i:2;s:5:"items";i:3;s:6:"create";i:4;s:4:"edit";i:5;s:5:"reply";i:6;s:4:"spam";i:7;s:7:"restore";}s:13:"content\\Pages";a:6:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";i:4;s:3:"pub";i:5;s:4:"hide";}s:32:"plugins\\ProductsCategoriesSelect";a:4:{i:0;s:5:"index";i:1;s:6:"create";i:2;s:4:"edit";i:3;s:7:"setMeta";}s:26:"plugins\\ProductsCategories";a:8:{i:0;s:5:"index";i:1;s:6:"create";i:2;s:4:"edit";i:3;s:4:"tree";i:4;s:4:"move";i:5;s:16:"createCategories";i:6;s:14:"editCategories";i:7;s:7:"setMeta";}s:17:"plugins\\PagesTree";a:6:{i:0;s:5:"index";i:1;s:6:"create";i:2;s:4:"edit";i:3;s:4:"tree";i:4;s:4:"move";i:5;s:7:"setMeta";}}', 0),
(4, 0, 0, 1, 'a:2:{s:11:"full_access";s:1:"0";s:5:"Admin";a:9:{i:0;s:4:"data";i:1;s:2:"id";i:2;s:5:"login";i:3;s:2:"fp";i:4;s:6:"logout";i:5;s:7:"profile";i:6;s:5:"index";i:7;s:6:"create";i:8;s:4:"edit";}}', 0),
(20, 0, 0, 0, '', 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=35 ;

--
-- Дамп данных таблицы `e_users_group_info`
--

INSERT INTO `e_users_group_info` (`id`, `group_id`, `languages_id`, `name`) VALUES
(15, 1, 1, 'Адміністратори'),
(16, 2, 1, 'Редактори'),
(18, 4, 1, 'Модератори'),
(34, 20, 1, 'Роздріб');

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
-- Ограничения внешнего ключа таблицы `e_comments_likers`
--
ALTER TABLE `e_comments_likers`
  ADD CONSTRAINT `fk_comments_likers_comments1` FOREIGN KEY (`comments_id`) REFERENCES `e_comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_comments_likers_users1` FOREIGN KEY (`users_id`) REFERENCES `e_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
-- Ограничения внешнего ключа таблицы `e_posts_tags`
--
ALTER TABLE `e_posts_tags`
  ADD CONSTRAINT `fk_posts_tags_languages1` FOREIGN KEY (`languages_id`) REFERENCES `e_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tags_content1` FOREIGN KEY (`posts_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tags_posts_tags1` FOREIGN KEY (`tags_id`) REFERENCES `e_tags` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `e_posts_views`
--
ALTER TABLE `e_posts_views`
  ADD CONSTRAINT `fk_posts_id` FOREIGN KEY (`posts_id`) REFERENCES `e_content` (`id`);

--
-- Ограничения внешнего ключа таблицы `e_products_prices`
--
ALTER TABLE `e_products_prices`
  ADD CONSTRAINT `fk_products_prices_content1` FOREIGN KEY (`content_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_products_prices_users_group1` FOREIGN KEY (`group_id`) REFERENCES `e_users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
