-- phpMyAdmin SQL Dump
-- version 4.4.13.1deb1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Час створення: Лип 04 2016 р., 22:11
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

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
  `message` text NOT NULL,
  `comment` text,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` char(16) NOT NULL,
  `status` enum('processed','spam','new') NOT NULL DEFAULT 'new',
  `manager_id` int(11) DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `status` enum('approved','spam','new') NOT NULL DEFAULT 'new',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` char(15) DEFAULT NULL,
  `skey` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблиці `e_comments_subscribers`
--

CREATE TABLE IF NOT EXISTS `e_comments_subscribers` (
  `id` int(10) unsigned NOT NULL,
  `content_id` int(10) unsigned NOT NULL,
  `users_id` int(10) unsigned NOT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблиці `e_content_images_sizes`
--

CREATE TABLE IF NOT EXISTS `e_content_images_sizes` (
  `id` tinyint(3) unsigned NOT NULL,
  `size` varchar(16) NOT NULL,
  `width` int(5) unsigned NOT NULL,
  `height` int(5) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблиці `e_content_relationship`
--

CREATE TABLE IF NOT EXISTS `e_content_relationship` (
  `id` int(11) unsigned NOT NULL,
  `content_id` int(10) unsigned NOT NULL,
  `categories_id` int(10) unsigned NOT NULL,
  `is_main` tinyint(1) unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблиці `e_content_types_images_sizes`
--

CREATE TABLE IF NOT EXISTS `e_content_types_images_sizes` (
  `id` int(10) unsigned NOT NULL,
  `types_id` tinyint(3) unsigned NOT NULL,
  `images_sizes_id` tinyint(3) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `is_main` tinyint(1) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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

-- --------------------------------------------------------

--
-- Структура таблиці `e_delivery_payment`
--

CREATE TABLE IF NOT EXISTS `e_delivery_payment` (
  `id` int(10) unsigned NOT NULL,
  `delivery_id` tinyint(3) unsigned NOT NULL,
  `payment_id` tinyint(3) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблиці `e_features_info`
--

CREATE TABLE IF NOT EXISTS `e_features_info` (
  `id` int(10) unsigned NOT NULL,
  `features_id` int(10) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8;

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
  `status` enum('new','processed') CHARACTER SET utf8 NOT NULL DEFAULT 'new',
  `ip` char(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
(1, 'uk', 'Українська', 1);

-- --------------------------------------------------------

--
-- Структура таблиці `e_mail_templates`
--

CREATE TABLE IF NOT EXISTS `e_mail_templates` (
  `id` tinyint(3) unsigned NOT NULL,
  `code` varchar(30) NOT NULL,
  `name` varchar(60) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_mail_templates`
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
-- Структура таблиці `e_mail_templates_info`
--

CREATE TABLE IF NOT EXISTS `e_mail_templates_info` (
  `id` smallint(6) unsigned NOT NULL,
  `templates_id` tinyint(3) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_mail_templates_info`
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
-- Структура таблиці `e_nav`
--

CREATE TABLE IF NOT EXISTS `e_nav` (
  `id` tinyint(3) unsigned NOT NULL,
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `code` varchar(30) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_nav`
--

INSERT INTO `e_nav` (`id`, `name`, `code`) VALUES
(1, 'top', 'top'),
(2, 'aaa', 'qqqqqq');

-- --------------------------------------------------------

--
-- Структура таблиці `e_nav_items`
--

CREATE TABLE IF NOT EXISTS `e_nav_items` (
  `id` int(10) unsigned NOT NULL,
  `nav_id` tinyint(3) unsigned NOT NULL,
  `content_id` int(11) unsigned NOT NULL,
  `position` tinyint(3) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_orders_status`
--

INSERT INTO `e_orders_status` (`id`, `bg_color`, `txt_color`, `on_site`, `external_id`, `is_main`) VALUES
(5, '#f8f5f5', '#000000', 1, '1234234', 1);

-- --------------------------------------------------------

--
-- Структура таблиці `e_orders_status_info`
--

CREATE TABLE IF NOT EXISTS `e_orders_status_info` (
  `id` int(10) unsigned NOT NULL,
  `status_id` int(10) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `status` varchar(45) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_orders_status_info`
--

INSERT INTO `e_orders_status_info` (`id`, `status_id`, `languages_id`, `status`) VALUES
(4, 5, 1, 'sdfsdfds');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблиці `e_posts_tags`
--

CREATE TABLE IF NOT EXISTS `e_posts_tags` (
  `id` int(10) unsigned NOT NULL,
  `posts_id` int(11) unsigned NOT NULL,
  `tags_id` int(10) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблиці `e_products_variants`
--

CREATE TABLE IF NOT EXISTS `e_products_variants` (
  `id` int(10) unsigned NOT NULL,
  `content_id` int(10) unsigned NOT NULL,
  `in_stock` tinyint(1) DEFAULT '1',
  `img` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблиці `e_products_variants_features`
--

CREATE TABLE IF NOT EXISTS `e_products_variants_features` (
  `id` int(10) unsigned NOT NULL,
  `variants_id` int(10) unsigned NOT NULL,
  `features_id` int(10) unsigned NOT NULL,
  `values_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблиці `e_products_variants_prices`
--

CREATE TABLE IF NOT EXISTS `e_products_variants_prices` (
  `id` int(10) unsigned NOT NULL,
  `variants_id` int(10) unsigned NOT NULL,
  `content_id` int(10) unsigned NOT NULL,
  `group_id` tinyint(3) unsigned NOT NULL,
  `price` decimal(10,0) unsigned DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

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
-- Структура таблиці `e_tags`
--

CREATE TABLE IF NOT EXISTS `e_tags` (
  `id` int(10) unsigned NOT NULL,
  `tag` varchar(60) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_users`
--

INSERT INTO `e_users` (`id`, `group_id`, `languages_id`, `sessid`, `name`, `surname`, `phone`, `email`, `password`, `avatar`, `skey`, `created`, `updated`, `lastlogin`, `status`) VALUES
(2, 1, 0, 'p5bu55ttgb974047nvd53ucj86', 'Володимир', 'Годяк', '+38 (067) 6736242', 'wmgodyak@gmail.com', 'MTTuFPm3y4m2o', '/uploads/avatars/c81e728d9d4c2f636f067f89cc14862c.png', NULL, '2016-03-03 13:25:08', '2016-04-21 11:24:28', '2016-07-04 18:38:13', 'active');

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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_users_group`
--

INSERT INTO `e_users_group` (`id`, `parent_id`, `isfolder`, `backend`, `permissions`, `position`) VALUES
(1, 0, 0, 1, 'a:1:{s:11:"full_access";s:1:"1";}', 1),
(2, 0, 0, 1, 'a:15:{s:11:"full_access";s:1:"0";s:9:"Dashboard";a:3:{i:0;s:5:"index";i:1;s:6:"create";i:2;s:4:"edit";}s:12:"content\\Post";a:6:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";i:4;s:3:"pub";i:5;s:4:"hide";}s:9:"Customers";a:7:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";i:4;s:6:"remove";i:5;s:3:"ban";i:6;s:7:"restore";}s:8:"Comments";a:9:{i:0;s:5:"index";i:1;s:3:"tab";i:2;s:5:"items";i:3;s:6:"create";i:4;s:4:"edit";i:5;s:5:"reply";i:6;s:7:"approve";i:7;s:4:"spam";i:8;s:7:"restore";}s:4:"Shop";a:3:{i:0;s:5:"index";i:1;s:6:"create";i:2;s:4:"edit";}s:16:"content\\Products";a:6:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";i:4;s:3:"pub";i:5;s:4:"hide";}s:26:"content\\ProductsCategories";a:6:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";i:4;s:3:"pub";i:5;s:4:"hide";}s:8:"Currency";a:4:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";}s:8:"Delivery";a:7:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";i:4;s:17:"getModuleSettings";i:5;s:3:"pub";i:6;s:4:"hide";}s:9:"Callbacks";a:8:{i:0;s:5:"index";i:1;s:3:"tab";i:2;s:5:"items";i:3;s:6:"create";i:4;s:4:"edit";i:5;s:5:"reply";i:6;s:4:"spam";i:7;s:7:"restore";}s:13:"content\\Pages";a:6:{i:0;s:5:"index";i:1;s:5:"items";i:2;s:6:"create";i:3;s:4:"edit";i:4;s:3:"pub";i:5;s:4:"hide";}s:32:"plugins\\ProductsCategoriesSelect";a:4:{i:0;s:5:"index";i:1;s:6:"create";i:2;s:4:"edit";i:3;s:7:"setMeta";}s:26:"plugins\\ProductsCategories";a:8:{i:0;s:5:"index";i:1;s:6:"create";i:2;s:4:"edit";i:3;s:4:"tree";i:4;s:4:"move";i:5;s:16:"createCategories";i:6;s:14:"editCategories";i:7;s:7:"setMeta";}s:17:"plugins\\PagesTree";a:6:{i:0;s:5:"index";i:1;s:6:"create";i:2;s:4:"edit";i:3;s:4:"tree";i:4;s:4:"move";i:5;s:7:"setMeta";}}', 0),
(4, 0, 0, 1, 'a:2:{s:11:"full_access";s:1:"0";s:5:"Admin";a:9:{i:0;s:4:"data";i:1;s:2:"id";i:2;s:5:"login";i:3;s:2:"fp";i:4;s:6:"logout";i:5;s:7:"profile";i:6;s:5:"index";i:7;s:6:"create";i:8;s:4:"edit";}}', 0),
(20, 0, 0, 0, '', 0);

-- --------------------------------------------------------

--
-- Структура таблиці `e_users_group_info`
--

CREATE TABLE IF NOT EXISTS `e_users_group_info` (
  `id` int(11) unsigned NOT NULL,
  `group_id` tinyint(3) unsigned NOT NULL,
  `languages_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `e_users_group_info`
--

INSERT INTO `e_users_group_info` (`id`, `group_id`, `languages_id`, `name`) VALUES
(15, 1, 1, 'Адміністратори'),
(16, 2, 1, 'Редактори'),
(18, 4, 1, 'Модератори'),
(34, 20, 1, 'Роздріб');

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
  ADD KEY `is_main` (`is_main`);

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
  ADD PRIMARY KEY (`id`);

--
-- Індекси таблиці `e_languages`
--
ALTER TABLE `e_languages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `is_main` (`is_main`);

--
-- Індекси таблиці `e_mail_templates`
--
ALTER TABLE `e_mail_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code_UNIQUE` (`code`);

--
-- Індекси таблиці `e_mail_templates_info`
--
ALTER TABLE `e_mail_templates_info`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_mail_templates_info_idx` (`templates_id`),
  ADD KEY `fk_mail_templates_info_languages1_idx` (`languages_id`);

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
-- Індекси таблиці `e_orders_status`
--
ALTER TABLE `e_orders_status`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `external_id_2` (`external_id`),
  ADD KEY `on_site` (`on_site`),
  ADD KEY `external_id` (`external_id`);

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
-- AUTO_INCREMENT для збережених таблиць
--

--
-- AUTO_INCREMENT для таблиці `e_banners`
--
ALTER TABLE `e_banners`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблиці `e_banners_places`
--
ALTER TABLE `e_banners_places`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT для таблиці `e_callbacks`
--
ALTER TABLE `e_callbacks`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблиці `e_comments`
--
ALTER TABLE `e_comments`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблиці `e_comments_subscribers`
--
ALTER TABLE `e_comments_subscribers`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблиці `e_content`
--
ALTER TABLE `e_content`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблиці `e_content_features`
--
ALTER TABLE `e_content_features`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблиці `e_content_images`
--
ALTER TABLE `e_content_images`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблиці `e_content_images_sizes`
--
ALTER TABLE `e_content_images_sizes`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблиці `e_content_info`
--
ALTER TABLE `e_content_info`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблиці `e_content_relationship`
--
ALTER TABLE `e_content_relationship`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблиці `e_content_types`
--
ALTER TABLE `e_content_types`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT для таблиці `e_content_types_images_sizes`
--
ALTER TABLE `e_content_types_images_sizes`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблиці `e_currency`
--
ALTER TABLE `e_currency`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT;
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
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT для таблиці `e_features`
--
ALTER TABLE `e_features`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=173;
--
-- AUTO_INCREMENT для таблиці `e_features_content`
--
ALTER TABLE `e_features_content`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=89;
--
-- AUTO_INCREMENT для таблиці `e_features_info`
--
ALTER TABLE `e_features_info`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=156;
--
-- AUTO_INCREMENT для таблиці `e_feedbacks`
--
ALTER TABLE `e_feedbacks`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблиці `e_languages`
--
ALTER TABLE `e_languages`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблиці `e_mail_templates`
--
ALTER TABLE `e_mail_templates`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT для таблиці `e_mail_templates_info`
--
ALTER TABLE `e_mail_templates_info`
  MODIFY `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT для таблиці `e_nav`
--
ALTER TABLE `e_nav`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблиці `e_nav_items`
--
ALTER TABLE `e_nav_items`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблиці `e_orders_status`
--
ALTER TABLE `e_orders_status`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT для таблиці `e_orders_status_info`
--
ALTER TABLE `e_orders_status_info`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT для таблиці `e_payment`
--
ALTER TABLE `e_payment`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT для таблиці `e_payment_info`
--
ALTER TABLE `e_payment_info`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблиці `e_posts_tags`
--
ALTER TABLE `e_posts_tags`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT для таблиці `e_products_prices`
--
ALTER TABLE `e_products_prices`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблиці `e_products_variants`
--
ALTER TABLE `e_products_variants`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=73;
--
-- AUTO_INCREMENT для таблиці `e_products_variants_features`
--
ALTER TABLE `e_products_variants_features`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=99;
--
-- AUTO_INCREMENT для таблиці `e_products_variants_prices`
--
ALTER TABLE `e_products_variants_prices`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=115;
--
-- AUTO_INCREMENT для таблиці `e_settings`
--
ALTER TABLE `e_settings`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=52;
--
-- AUTO_INCREMENT для таблиці `e_tags`
--
ALTER TABLE `e_tags`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT для таблиці `e_users`
--
ALTER TABLE `e_users`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT для таблиці `e_users_group`
--
ALTER TABLE `e_users_group`
  MODIFY `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT для таблиці `e_users_group_info`
--
ALTER TABLE `e_users_group_info`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=37;
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
-- Обмеження зовнішнього ключа таблиці `e_mail_templates_info`
--
ALTER TABLE `e_mail_templates_info`
  ADD CONSTRAINT `fk_mail_templates_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `e_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_mail_templates_info_mail_templates1` FOREIGN KEY (`templates_id`) REFERENCES `e_mail_templates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `e_nav_items`
--
ALTER TABLE `e_nav_items`
  ADD CONSTRAINT `fk_nav_items_content1` FOREIGN KEY (`content_id`) REFERENCES `e_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_nav_items_nav1` FOREIGN KEY (`nav_id`) REFERENCES `e_nav` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
