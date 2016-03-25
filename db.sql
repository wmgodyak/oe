-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Мар 25 2016 г., 17:29
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=68 ;

--
-- Дамп данных таблицы `components`
--

INSERT INTO `components` (`id`, `parent_id`, `isfolder`, `icon`, `author`, `version`, `controller`, `position`, `published`, `rang`, `settings`, `created`) VALUES
(1, 0, 0, 'fa-home', 'Volodymyr Hodiak', '1.0.0', 'dashboard', 1, 1, 300, NULL, '2016-03-18 15:27:32'),
(43, 0, 0, 'fa-file-text', 'Volodymyr Hodiak', '1.0.0', 'content/Pages', 2, 1, 300, NULL, '2016-03-16 15:09:36'),
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
(64, 45, 0, 'fa-envelope-o', 'Volodymyr Hodiak', '1.0.0', 'mailTemplates', 64, 1, 300, NULL, '2016-03-18 10:14:32'),
(65, 0, 1, 'fa-cogs', 'Volodymyr Hodiak', '1.0.0', 'settingsGroup', 65, 1, 300, NULL, '2016-03-18 11:41:11'),
(66, 60, 0, 'fa-puzzle-piece', 'Volodymyr Hodiak', '1.0.0', 'modules', 0, 1, 300, NULL, '2016-03-23 13:50:46'),
(67, 0, 0, 'fa-pencil', 'Volodymyr Hodiak', '1.0.0', 'content/Post', 3, 1, 300, NULL, '2016-03-25 10:43:43');

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
  PRIMARY KEY (`id`,`types_id`,`subtypes_id`,`owner_id`),
  KEY `fk_content_content_types1_idx` (`types_id`),
  KEY `fk_content_content_subtypes1_idx` (`subtypes_id`),
  KEY `fk_content_owner_idx` (`owner_id`),
  KEY `status` (`status`),
  KEY `published` (`published`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=28 ;

--
-- Дамп данных таблицы `content`
--

INSERT INTO `content` (`id`, `types_id`, `subtypes_id`, `owner_id`, `parent_id`, `isfolder`, `position`, `created`, `updated`, `published`, `settings`, `status`) VALUES
(1, 1, 6, 2, 0, 1, 0, '2016-03-21 07:55:55', '2016-03-24 09:32:59', '2016-03-21', 'a:1:{s:7:"modules";a:1:{i:0;s:12:"First::index";}}', 'published'),
(2, 1, 1, 2, 1, 0, 0, '2016-03-21 07:56:43', '2016-03-24 07:03:27', '2016-03-21', 'a:1:{s:7:"modules";a:1:{i:0;s:12:"First::index";}}', 'published'),
(3, 1, 7, 2, 1, 0, 0, '2016-03-21 07:56:57', '2016-03-24 14:04:03', '2016-03-21', 'a:1:{s:7:"modules";a:1:{i:0;s:11:"Blog::index";}}', 'published'),
(4, 1, 1, 2, 1, 0, 0, '2016-03-21 07:57:10', NULL, '2016-03-21', NULL, 'published'),
(5, 1, 1, 2, 1, 0, 0, '2016-03-21 07:57:23', NULL, '2016-03-21', NULL, 'published'),
(6, 1, 1, 2, 1, 0, 0, '2016-03-21 07:57:34', NULL, '2016-03-21', NULL, 'published'),
(7, 1, 1, 2, 1, 0, 0, '2016-03-21 07:58:13', NULL, '2016-03-21', NULL, 'published'),
(8, 1, 1, 2, 1, 0, 0, '2016-03-21 07:58:21', NULL, '2016-03-21', NULL, 'published'),
(9, 1, 4, 2, 1, 0, 0, '2016-03-21 12:44:48', NULL, '2016-03-21', NULL, 'published'),
(13, 3, 3, 2, 0, 0, 0, '2016-03-24 13:23:43', '2016-03-25 09:56:19', '2016-03-25', NULL, 'published'),
(14, 3, 3, 2, 0, 0, 0, '2016-03-24 13:24:00', '2016-03-25 09:56:29', '2016-03-25', NULL, 'published'),
(15, 3, 3, 2, 0, 0, 0, '2016-03-24 13:24:10', '2016-03-24 13:24:10', '2016-03-24', NULL, 'published'),
(16, 2, 2, 2, 0, 0, 0, '2016-03-24 13:24:14', '2016-03-25 15:25:02', '2016-03-24', NULL, 'published'),
(17, 2, 2, 2, 0, 0, 0, '2016-03-24 13:30:28', '2016-03-24 13:31:01', '2016-03-24', NULL, 'published'),
(18, 2, 2, 2, 0, 0, 0, '2016-03-24 13:31:04', '2016-03-24 13:31:31', '2016-03-24', NULL, 'published'),
(19, 2, 2, 2, 0, 0, 0, '2016-03-24 13:31:33', '2016-03-24 13:32:11', '2016-03-24', NULL, 'published'),
(20, 2, 2, 2, 0, 0, 0, '2016-03-24 13:32:19', '2016-03-25 13:02:57', '2016-03-24', NULL, 'published'),
(21, 2, 2, 2, 0, 0, 0, '2016-03-24 13:32:39', '2016-03-24 13:33:06', '2016-03-24', NULL, 'published'),
(22, 2, 2, 2, 0, 0, 0, '2016-03-24 13:33:07', '2016-03-24 13:33:34', '2016-03-24', NULL, 'published'),
(23, 2, 2, 2, 0, 0, 0, '2016-03-24 13:33:41', '2016-03-24 13:34:21', '2016-03-24', NULL, 'published'),
(24, 2, 2, 2, 0, 0, 0, '2016-03-24 13:34:28', '2016-03-24 13:34:46', '2016-03-24', NULL, 'published'),
(25, 1, 1, 2, 1, 0, 0, '2016-03-25 09:45:43', '2016-03-25 09:46:08', '2016-03-25', NULL, 'published'),
(27, 3, 3, 2, 0, 0, 0, '2016-03-25 11:52:31', '2016-03-25 11:52:31', '2016-03-25', NULL, 'published');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

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
(15, 1, 'uploads/content/2016/03/25/', 'testimonial3-1x14.jpg', 6, '2016-03-25 12:33:08');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=31 ;

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
(30, 27, 1, 'Всяка всячина', 'vsyaka-vsyachyna', '', 'Всяка всячина', '', '', NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

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
(10, 16, 15, 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

--
-- Дамп данных таблицы `content_tags`
--

INSERT INTO `content_tags` (`id`, `content_id`, `tags_id`, `languages_id`) VALUES
(21, 16, 17, 1),
(22, 16, 18, 1),
(23, 16, 19, 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Дамп данных таблицы `content_types`
--

INSERT INTO `content_types` (`id`, `parent_id`, `isfolder`, `type`, `name`, `is_main`, `settings`) VALUES
(1, 0, 1, 'pages', 'Сторінки', NULL, 'a:2:{s:9:"parent_id";s:0:"";s:7:"modules";a:1:{i:0;s:10:"Nav::index";}}'),
(2, 0, 0, 'post', 'Стаття', NULL, 'a:2:{s:9:"parent_id";s:0:"";s:7:"modules";a:2:{i:0;s:10:"Blog::post";i:1;s:8:"Nav::top";}}'),
(3, 0, 0, 'posts_cat', 'Категорії статтей', NULL, 'a:2:{s:9:"parent_id";s:0:"";s:7:"modules";a:2:{i:0;s:11:"Blog::index";i:1;s:10:"Nav::index";}}'),
(4, 1, 0, '404', '404', NULL, 'a:2:{s:9:"parent_id";s:0:"";s:11:"modules_ext";s:1:"1";}'),
(6, 1, 0, 'main', 'Головна', NULL, 'a:2:{s:9:"parent_id";s:0:"";s:7:"modules";a:1:{i:0;s:10:"Nav::index";}}'),
(7, 1, 0, 'blog', 'Блог', NULL, 'a:2:{s:9:"parent_id";s:0:"";s:11:"modules_ext";s:1:"1";}');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

--
-- Дамп данных таблицы `content_types_images_sizes`
--

INSERT INTO `content_types_images_sizes` (`id`, `types_id`, `images_sizes_id`) VALUES
(16, 1, 1),
(17, 1, 2),
(20, 2, 1),
(11, 6, 2);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `features`
--

INSERT INTO `features` (`id`, `parent_id`, `type`, `code`, `multiple`, `on_filter`, `required`, `owner_id`, `created`, `status`) VALUES
(2, 0, NULL, 'feature_1458737968', NULL, NULL, 0, 2, '2016-03-23 12:59:28', 'blank');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Дамп данных таблицы `modules`
--

INSERT INTO `modules` (`id`, `icon`, `author`, `version`, `controller`, `settings`, `created`) VALUES
(6, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'second', NULL, '2016-03-23 14:22:40'),
(7, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'first', NULL, '2016-03-23 14:22:41'),
(8, 'fa-nav', 'Volodymyr Hodiak', '1.0.0', 'nav', NULL, '2016-03-24 08:44:14'),
(9, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'blog', NULL, '2016-03-24 13:36:39');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=27 ;

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
(26, 'fa-users', 'Volodymyr Hodiak', '1.0.0', 'tags', 'after_params', 1, 300, NULL, '2016-03-25 14:12:23');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

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
(11, 26, 67, 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=20 ;

--
-- Дамп данных таблицы `tags`
--

INSERT INTO `tags` (`id`, `tag`) VALUES
(17, 'php'),
(18, 'mysql'),
(19, 'jquery');

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
(2, 1, 0, '6nfali47nf3gngndq9hfbv5a10', 'Володимир', 'Годяк', '380676736242', 'wmgodyak@gmail.com', 'MTTuFPm3y4m2o', '/uploads/avatars/c81e728d9d4c2f636f067f89cc14862c.png', NULL, '2016-03-03 13:25:08', '2016-03-24 16:42:51', '2016-03-25 11:47:24', 'active');

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
