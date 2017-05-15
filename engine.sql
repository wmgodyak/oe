-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Май 15 2017 г., 08:15
-- Версия сервера: 5.7.18-0ubuntu0.16.04.1-log
-- Версия PHP: 7.0.15-0ubuntu0.16.04.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `engine`
--

-- --------------------------------------------------------

--
-- Структура таблицы `x_content`
--

CREATE TABLE `x_content` (
  `id` int(10) UNSIGNED NOT NULL,
  `types_id` tinyint(3) UNSIGNED NOT NULL,
  `subtypes_id` tinyint(3) UNSIGNED NOT NULL,
  `owner_id` int(11) UNSIGNED NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT '0',
  `isfolder` tinyint(1) UNSIGNED DEFAULT '0',
  `position` tinyint(3) UNSIGNED DEFAULT '0',
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT NULL,
  `published` date DEFAULT NULL,
  `settings` text,
  `status` enum('blank','hidden','published','deleted') DEFAULT 'blank',
  `external_id` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `x_content`
--

INSERT INTO `x_content` (`id`, `types_id`, `subtypes_id`, `owner_id`, `parent_id`, `isfolder`, `position`, `created`, `updated`, `published`, `settings`, `status`, `external_id`) VALUES
(1, 1, 5, 1, 0, 1, 0, '2017-03-09 08:13:35', '2017-05-13 21:46:30', '2017-03-09', NULL, 'published', ''),
(2, 1, 1, 1, 1, 0, 0, '2017-03-09 08:13:35', '2017-05-13 21:46:11', '2017-03-09', NULL, 'published', ''),
(3, 1, 1, 1, 1, 0, 0, '2017-03-09 08:13:44', '2017-03-09 08:13:49', '2017-03-09', NULL, 'published', ''),
(4, 4, 4, 1, 0, 1, 0, '2017-03-09 08:18:39', '2017-03-09 10:53:09', '2017-03-09', NULL, 'published', ''),
(5, 4, 4, 1, 4, 0, 0, '2017-03-09 10:49:03', '2017-03-09 10:49:03', '2017-03-09', NULL, 'published', ''),
(6, 4, 4, 1, 4, 0, 0, '2017-03-09 10:49:11', '2017-03-09 10:49:11', '2017-03-09', NULL, 'published', ''),
(7, 3, 3, 1, 0, 0, 0, '2017-03-09 10:49:14', '2017-03-09 10:52:16', '2017-03-09', NULL, 'published', ''),
(8, 3, 3, 1, 0, 0, 0, '2017-03-09 10:53:16', '2017-03-09 10:53:48', '2017-03-09', NULL, 'published', ''),
(9, 3, 3, 1, 0, 0, 0, '2017-03-09 10:54:36', '2017-03-09 10:55:23', '2017-03-09', NULL, 'published', ''),
(10, 1, 1, 1, 1, 0, 0, '2017-05-13 15:14:23', '2017-05-13 15:14:39', '2017-05-13', NULL, 'published', '');

-- --------------------------------------------------------

--
-- Структура таблицы `x_content_features`
--

CREATE TABLE `x_content_features` (
  `id` int(10) UNSIGNED NOT NULL,
  `features_id` int(10) UNSIGNED NOT NULL,
  `content_id` int(10) UNSIGNED NOT NULL,
  `values_id` int(10) UNSIGNED DEFAULT NULL,
  `languages_id` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `value` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `x_content_images`
--

CREATE TABLE `x_content_images` (
  `id` int(11) UNSIGNED NOT NULL,
  `content_id` int(10) UNSIGNED NOT NULL,
  `path` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `position` tinyint(5) UNSIGNED NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `x_content_images_sizes`
--

CREATE TABLE `x_content_images_sizes` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `size` varchar(16) NOT NULL,
  `width` int(5) UNSIGNED NOT NULL,
  `height` int(5) UNSIGNED NOT NULL,
  `quality` tinyint(3) UNSIGNED NOT NULL,
  `watermark` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `watermark_position` tinyint(1) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `x_content_images_sizes`
--

INSERT INTO `x_content_images_sizes` (`id`, `size`, `width`, `height`, `quality`, `watermark`, `watermark_position`) VALUES
(1, 'post', 320, 240, 70, 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `x_content_info`
--

CREATE TABLE `x_content_info` (
  `id` int(10) UNSIGNED NOT NULL,
  `content_id` int(10) UNSIGNED NOT NULL,
  `languages_id` tinyint(3) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `h1` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `intro` text,
  `content` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `x_content_info`
--

INSERT INTO `x_content_info` (`id`, `content_id`, `languages_id`, `name`, `url`, `h1`, `title`, `keywords`, `description`, `intro`, `content`) VALUES
(1, 1, 1, 'Home', '', '', 'Home', '', '', '', '<p>As you can see, we simply pass the incoming HTTP request and desired validation rules into the&nbsp;<code>validate</code>&nbsp;method. Again, if the validation fails, the proper response will automatically be generated. If the validation passes, our controller will continue executing normally.</p>\n\n<h4>Stopping On First Validation Failure</h4>\n\n<p>Sometimes you may wish to stop running validation rules on an attribute after the first validation failure. To do so, assign the&nbsp;<code>bail</code>&nbsp;rule to the attribute:</p>\n\n<pre>\n<code>$this-&gt;validate($request, [\n    &#39;title&#39; =&gt; &#39;bail|required|unique:posts|max:255&#39;,\n    &#39;body&#39; =&gt; &#39;required&#39;,\n]);</code></pre>\n\n<p>In this example, if the&nbsp;<code>required</code>&nbsp;rule on the&nbsp;<code>title</code>&nbsp;attribute fails, the&nbsp;<code>unique</code>&nbsp;rule will not be checked. Rules will be validated in the order they are assigned.</p>\n'),
(2, 2, 1, 'About', 'about', '', 'About', '', '', '', '<p>As you can see, we simply pass the incoming HTTP request and desired validation rules into the&nbsp;<code>validate</code>&nbsp;method. Again, if the validation fails, the proper response will automatically be generated. If the validation passes, our controller will continue executing normally.</p>\n\n<h4>Stopping On First Validation Failure</h4>\n\n<p>Sometimes you may wish to stop running validation rules on an attribute after the first validation failure. To do so, assign the&nbsp;<code>bail</code>&nbsp;rule to the attribute:</p>\n\n<pre>\n<code>$this-&gt;validate($request, [\n    &#39;title&#39; =&gt; &#39;bail|required|unique:posts|max:255&#39;,\n    &#39;body&#39; =&gt; &#39;required&#39;,\n]);</code></pre>\n\n<p>In this example, if the&nbsp;<code>required</code>&nbsp;rule on the&nbsp;<code>title</code>&nbsp;attribute fails, the&nbsp;<code>unique</code>&nbsp;rule will not be checked. Rules will be validated in the order they are assigned.</p>\n'),
(3, 3, 1, '404', '404', '', '404', '', '', '', ''),
(4, 4, 1, 'Blog', 'blog', '', 'Blog', '', 'The official example template of creating a blog with Bootstrap.', NULL, NULL),
(5, 5, 1, 'Category A', 'category-a', '', 'Category A', '', '', NULL, NULL),
(6, 6, 1, 'Category B', 'category-b', '', 'Category B', '', '', NULL, NULL),
(7, 7, 1, 'Sample blog post', 'sample-blog-post', '', 'Sample blog post', '', '', '<p>This blog post shows a few different types of content that\'s supported and styled with Bootstrap. Basic typography, images, and code are all supported.</p>\n                <hr>\n                <p>Cum sociis natoque penatibus et magnis <a href="#">dis parturient montes</a>, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Sed posuere consectetur est at lobortis. Cras mattis consectetur purus sit amet fermentum.</p>\n                <blockquote>\n                    <p>Curabitur blandit tempus porttitor. <strong>Nullam quis risus eget urna mollis</strong> ornare vel eu leo. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>\n                </blockquote>\n                <p>Etiam porta <em>sem malesuada magna</em> mollis euismod. Cras mattis consectetur purus sit amet fermentum. Aenean lacinia bibendum nulla sed consectetur.</p>\n                <h2>Heading</h2>\n                <p>Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.</p>     ', '                <p>This blog post shows a few different types of content that\'s supported and styled with Bootstrap. Basic typography, images, and code are all supported.</p>\n                <hr>\n                <p>Cum sociis natoque penatibus et magnis <a href="#">dis parturient montes</a>, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Sed posuere consectetur est at lobortis. Cras mattis consectetur purus sit amet fermentum.</p>\n                <blockquote>\n                    <p>Curabitur blandit tempus porttitor. <strong>Nullam quis risus eget urna mollis</strong> ornare vel eu leo. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>\n                </blockquote>\n                <p>Etiam porta <em>sem malesuada magna</em> mollis euismod. Cras mattis consectetur purus sit amet fermentum. Aenean lacinia bibendum nulla sed consectetur.</p>\n                <h2>Heading</h2>\n                <p>Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.</p>\n                <h3>Sub-heading</h3>\n                <p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>\n                <pre><code>Example code block</code></pre>\n                <p>Aenean lacinia bibendum nulla sed consectetur. Etiam porta sem malesuada magna mollis euismod. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa.</p>\n                <h3>Sub-heading</h3>\n                <p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean lacinia bibendum nulla sed consectetur. Etiam porta sem malesuada magna mollis euismod. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>\n                <ul>\n                    <li>Praesent commodo cursus magna, vel scelerisque nisl consectetur et.</li>\n                    <li>Donec id elit non mi porta gravida at eget metus.</li>\n                    <li>Nulla vitae elit libero, a pharetra augue.</li>\n                </ul>\n                <p>Donec ullamcorper nulla non metus auctor fringilla. Nulla vitae elit libero, a pharetra augue.</p>\n                <ol>\n                    <li>Vestibulum id ligula porta felis euismod semper.</li>\n                    <li>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</li>\n                    <li>Maecenas sed diam eget risus varius blandit sit amet non magna.</li>\n                </ol>\n                <p>Cras mattis consectetur purus sit amet fermentum. Sed posuere consectetur est at lobortis.</p>\n            '),
(8, 8, 1, 'Another blog post', 'another-blog-post', '', 'Another blog post', '', '', '<p>Cum sociis natoque penatibus et magnis <a href="#">dis parturient montes</a>, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Sed posuere consectetur est at lobortis. Cras mattis consectetur purus sit amet fermentum.</p>', '<p>Cum sociis natoque penatibus et magnis <a href="#">dis parturient montes</a>, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Sed posuere consectetur est at lobortis. Cras mattis consectetur purus sit amet fermentum.</p>\n                <blockquote>\n                    <p>Curabitur blandit tempus porttitor. <strong>Nullam quis risus eget urna mollis</strong> ornare vel eu leo. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>\n                </blockquote>\n                <p>Etiam porta <em>sem malesuada magna</em> mollis euismod. Cras mattis consectetur purus sit amet fermentum. Aenean lacinia bibendum nulla sed consectetur.</p>\n                <p>Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.</p>\n            '),
(9, 9, 1, 'New feature', 'new-feature', '', 'New feature', '', '', '<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean lacinia bibendum nulla sed consectetur. Etiam porta sem malesuada magna mollis euismod. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>\n', '<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean lacinia bibendum nulla sed consectetur. Etiam porta sem malesuada magna mollis euismod. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>\n\n<ul>\n	<li>Praesent commodo cursus magna, vel scelerisque nisl consectetur et.</li>\n	<li>Donec id elit non mi porta gravida at eget metus.</li>\n	<li>Nulla vitae elit libero, a pharetra augue.</li>\n</ul>\n\n<p>Etiam porta&nbsp;<em>sem malesuada magna</em>&nbsp;mollis euismod. Cras mattis consectetur purus sit amet fermentum. Aenean lacinia bibendum nulla sed consectetur.</p>\n\n<p>Donec ullamcorper nulla non metus auctor fringilla. Nulla vitae elit libero, a pharetra augue.</p>\n\n<nav>&nbsp;</nav>\n'),
(10, 10, 1, 'Contacts', 'contacts', '', 'Contacts', '', '', '', '');

-- --------------------------------------------------------

--
-- Структура таблицы `x_content_meta`
--

CREATE TABLE `x_content_meta` (
  `id` int(11) UNSIGNED NOT NULL,
  `content_id` int(10) UNSIGNED NOT NULL,
  `meta_k` varchar(45) DEFAULT NULL,
  `meta_v` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `x_content_meta`
--

INSERT INTO `x_content_meta` (`id`, `content_id`, `meta_k`, `meta_v`) VALUES
(1, 9, 'views', '5'),
(2, 8, 'views', '1');

-- --------------------------------------------------------

--
-- Структура таблицы `x_content_relationship`
--

CREATE TABLE `x_content_relationship` (
  `id` int(11) UNSIGNED NOT NULL,
  `content_id` int(10) UNSIGNED NOT NULL,
  `categories_id` int(10) UNSIGNED NOT NULL,
  `is_main` tinyint(1) UNSIGNED DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `x_content_relationship`
--

INSERT INTO `x_content_relationship` (`id`, `content_id`, `categories_id`, `is_main`, `type`) VALUES
(1, 7, 5, 0, 'post_category'),
(2, 8, 5, 0, 'post_category'),
(3, 9, 5, 0, 'post_category');

-- --------------------------------------------------------

--
-- Структура таблицы `x_content_types`
--

CREATE TABLE `x_content_types` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `parent_id` tinyint(3) UNSIGNED DEFAULT '0',
  `isfolder` tinyint(1) UNSIGNED DEFAULT '0',
  `type` varchar(45) NOT NULL,
  `name` varchar(60) NOT NULL,
  `is_main` tinyint(1) UNSIGNED DEFAULT NULL,
  `settings` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `x_content_types`
--

INSERT INTO `x_content_types` (`id`, `parent_id`, `isfolder`, `type`, `name`, `is_main`, `settings`) VALUES
(1, 0, 1, 'pages', 'Pages', 1, NULL),
(2, 0, 0, 'guide', 'Guides', NULL, NULL),
(3, 0, 0, 'blog_post', 'Posts', NULL, NULL),
(4, 0, 0, 'blog_category', 'Blog category', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}'),
(5, 1, 0, 'home', 'home', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}'),
(6, 1, 0, 'fw', 'Full width', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}'),
(7, 1, 0, 'sb-sl', 'Sidebar left', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}'),
(8, 1, 0, 'sb-sr', 'Sidebar right', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}');

-- --------------------------------------------------------

--
-- Структура таблицы `x_content_types_images_sizes`
--

CREATE TABLE `x_content_types_images_sizes` (
  `id` int(10) UNSIGNED NOT NULL,
  `types_id` tinyint(3) UNSIGNED NOT NULL,
  `images_sizes_id` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `x_content_types_images_sizes`
--

INSERT INTO `x_content_types_images_sizes` (`id`, `types_id`, `images_sizes_id`) VALUES
(1, 3, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `x_features`
--

CREATE TABLE `x_features` (
  `id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `owner_id` int(11) UNSIGNED NOT NULL,
  `type` enum('text','textarea','select','file','folder','value','checkbox','number','image') DEFAULT NULL,
  `code` varchar(45) NOT NULL,
  `multiple` tinyint(1) DEFAULT NULL,
  `on_filter` tinyint(1) DEFAULT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `hide` tinyint(1) NOT NULL DEFAULT '0',
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('blank','published','hidden') DEFAULT 'blank',
  `position` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `x_features_content`
--

CREATE TABLE `x_features_content` (
  `id` int(10) UNSIGNED NOT NULL,
  `features_id` int(10) UNSIGNED NOT NULL,
  `content_types_id` tinyint(3) UNSIGNED NOT NULL,
  `content_subtypes_id` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `content_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `position` tinyint(3) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `x_features_info`
--

CREATE TABLE `x_features_info` (
  `id` int(10) UNSIGNED NOT NULL,
  `features_id` int(10) UNSIGNED NOT NULL,
  `languages_id` tinyint(3) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `x_languages`
--

CREATE TABLE `x_languages` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `code` char(2) NOT NULL,
  `name` varchar(30) NOT NULL,
  `is_main` tinyint(1) UNSIGNED DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `x_languages`
--

INSERT INTO `x_languages` (`id`, `code`, `name`, `is_main`) VALUES
(1, 'en', 'English', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `x_nav`
--

CREATE TABLE `x_nav` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `code` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `x_nav`
--

INSERT INTO `x_nav` (`id`, `name`, `code`) VALUES
(1, 'Blog main menu', 'blog-main');

-- --------------------------------------------------------

--
-- Структура таблицы `x_nav_items`
--

CREATE TABLE `x_nav_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `nav_id` tinyint(3) UNSIGNED NOT NULL,
  `content_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `parent_id` int(10) UNSIGNED DEFAULT '0',
  `isfolder` tinyint(3) UNSIGNED DEFAULT '0',
  `position` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `url` varchar(160) DEFAULT NULL,
  `display_children` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `published` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `css_class` varchar(30) DEFAULT NULL,
  `target` enum('_blank','_self') NOT NULL DEFAULT '_self'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `x_nav_items`
--

INSERT INTO `x_nav_items` (`id`, `nav_id`, `content_id`, `parent_id`, `isfolder`, `position`, `url`, `display_children`, `published`, `css_class`, `target`) VALUES
(8, 1, 1, 0, 0, 0, NULL, 0, 1, NULL, '_self'),
(9, 1, 4, 0, 0, 2, NULL, 0, 1, NULL, '_self'),
(10, 1, 2, 0, 0, 1, NULL, 0, 1, NULL, '_self'),
(11, 1, 10, 0, 0, 3, NULL, 0, 1, NULL, '_self');

-- --------------------------------------------------------

--
-- Структура таблицы `x_nav_items_info`
--

CREATE TABLE `x_nav_items_info` (
  `id` int(10) UNSIGNED NOT NULL,
  `nav_items_id` int(10) UNSIGNED NOT NULL,
  `languages_id` tinyint(3) UNSIGNED NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `title` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Структура таблицы `x_posts_tags`
--

CREATE TABLE `x_posts_tags` (
  `id` int(10) UNSIGNED NOT NULL,
  `posts_id` int(10) UNSIGNED NOT NULL,
  `tags_id` int(10) UNSIGNED NOT NULL,
  `languages_id` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `x_posts_tags`
--

INSERT INTO `x_posts_tags` (`id`, `posts_id`, `tags_id`, `languages_id`) VALUES
(1, 7, 1, 1),
(2, 7, 2, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `x_settings`
--

CREATE TABLE `x_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(45) NOT NULL,
  `value` longtext,
  `block` enum('company','common','images','themes','editor','content','seo','analitycs','robots','mail','') DEFAULT NULL,
  `type` enum('text','textarea','') DEFAULT NULL,
  `required` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `display` tinyint(1) UNSIGNED DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `x_settings`
--

INSERT INTO `x_settings` (`id`, `name`, `value`, `block`, `type`, `required`, `display`) VALUES
(1, 'autofil_title', '1', 'common', 'text', 1, 1),
(2, 'autofill_url', '1', 'common', 'text', 1, 1),
(3, 'backend_url', 'cp', '', 'text', 1, 0),
(4, 'editor_bodyId', 'cms_content', 'editor', 'text', 1, 1),
(5, 'editor_body_class', 'cms_content', 'editor', 'text', 1, 1),
(6, 'editor_contents_css', '/themes/default/assets/css/style.css', 'editor', 'textarea', 1, 1),
(9, 'app_theme_current', 'blog', 'themes', 'text', 1, 1),
(12, 'themes_path', 'themes/', 'themes', 'text', 1, 1),
(13, 'content_images_dir', 'uploads/content/', 'images', 'text', 1, 1),
(14, 'content_images_thumb_dir', 'thumbs/', 'images', 'text', 1, 1),
(15, 'content_images_source_dir', 'source/', 'images', 'text', 1, 1),
(17, 'backend_theme', 'backend', 'themes', 'text', 1, 0),
(19, 'page_404', '3', 'common', 'text', 1, 1),
(20, 'content_images_source_size', '1600x1200', 'images', 'text', 1, 1),
(21, 'content_images_thumbs_size', '125x125', 'images', 'text', 1, 1),
(23, 'content_images_quality', '90', 'images', 'text', 1, 1),
(24, 'active', '1', 'common', 'text', 1, 1),
(25, 'site_index', '1', 'robots', 'text', 1, 1),
(26, 'robots_index_sample', '# цей файл створено автоматично. Не редагуйте його вручну. Змінити його ви можете в розділі налаштування\n\nUser-agent: *\nDisallow:\n\nUser-agent: Yandex\nDisallow:\nHost: {app}\n\nSitemap: {appurl}route/XmlSitemap/index', 'robots', 'textarea', 1, 1),
(28, 'robots_no_index_sample', '# цей файл створено автоматично. Не редагуйте його вручну. Змінити його ви можете в розділі налаштування\n\nUser-agent: *\nDisallow: /', 'robots', 'textarea', 1, 1),
(29, 'google_analytics_id', '', 'analitycs', 'text', 0, 1),
(30, 'google_webmaster', '', 'analitycs', 'text', 0, 1),
(31, 'yandex_webmaster', '', 'analitycs', 'text', 0, 1),
(32, 'yandex_metric', '', 'analitycs', 'text', 0, 1),
(36, 'mail_email_from', 'vh@otakoyi.com', 'mail', 'text', 1, 1),
(37, 'mail_email_to', 'vh@otakoyi.com', 'mail', 'text', 1, 1),
(38, 'mail_from_name', 'Demo', 'mail', 'text', 1, 1),
(39, 'mail_header', '', 'mail', 'textarea', 0, 1),
(40, 'mail_footer', '', 'mail', 'textarea', 0, 1),
(41, 'mail_smtp_on', '0', 'mail', 'text', 1, 1),
(42, 'mail_smtp_host', '', 'mail', 'text', 0, 1),
(43, 'mail_smtp_port', '', 'mail', 'text', 0, 1),
(44, 'mail_smtp_user', '', 'mail', 'text', 0, 1),
(45, 'mail_smtp_password', '', 'mail', 'text', 0, 1),
(46, 'mail_smtp_secure', 'tls', 'mail', 'text', 0, 1),
(47, 'company_name', 'Demo', 'company', 'text', 1, 1),
(48, 'company_phone', '', 'company', 'text', 1, 1),
(49, 'seo', 'a:6:{s:5:"guide";a:1:{i:1;a:4:{s:5:"title";s:0:"";s:8:"keywords";s:0:"";s:11:"description";s:0:"";s:2:"h1";s:0:"";}}s:5:"pages";a:1:{i:1;a:4:{s:5:"title";s:34:"{title} {delimiter} {company_name}";s:8:"keywords";s:37:"{keywords} {delimiter} {company_name}";s:11:"description";s:13:"{description}";s:2:"h1";s:4:"{h1}";}}s:4:"post";a:1:{i:1;a:4:{s:5:"title";s:67:"{title} {delimiter}  {category} {delimiter} блог {company_name}";s:8:"keywords";s:46:"{keywords} {delimiter} блог {company_name}";s:11:"description";s:49:"{description} {delimiter} блог {company_name}";s:2:"h1";s:4:"{h1}";}}s:16:"posts_categories";a:1:{i:1;a:4:{s:5:"title";s:67:"{title} {delimiter}  {category} {delimiter} блог {company_name}";s:8:"keywords";s:46:"{keywords} {delimiter} блог {company_name}";s:11:"description";s:46:"{keywords} {delimiter} блог {company_name}";s:2:"h1";s:4:"{h1}";}}s:7:"product";a:1:{i:1;a:4:{s:5:"title";s:58:"{title} {delimiter}  {category} {delimiter} {company_name}";s:8:"keywords";s:37:"{keywords} {delimiter} {company_name}";s:11:"description";s:37:"{keywords} {delimiter} {company_name}";s:2:"h1";s:4:"{h1}";}}s:19:"products_categories";a:1:{i:1;a:4:{s:5:"title";s:59:"{title} {delimiter}  {category} {delimiter}  {company_name}";s:8:"keywords";s:37:"{keywords} {delimiter} {company_name}";s:11:"description";s:37:"{keywords} {delimiter} {company_name}";s:2:"h1";s:4:"{h1}";}}}', '', '', 0, NULL),
(50, 'home_id', '1', 'common', 'text', 1, 1),
(52, 'modules', 'a:1:{s:4:"Blog";a:2:{s:6:"status";s:7:"enabled";s:6:"config";a:2:{s:3:"ipp";s:1:"5";s:7:"blog_id";s:1:"4";}}}', 'common', 'text', 1, NULL),
(53, 'watermark_src', '', 'images', 'text', 1, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `x_tags`
--

CREATE TABLE `x_tags` (
  `id` int(10) UNSIGNED NOT NULL,
  `tag` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `x_tags`
--

INSERT INTO `x_tags` (`id`, `tag`) VALUES
(1, 'tag'),
(2, 'tag2');

-- --------------------------------------------------------

--
-- Структура таблицы `x_users`
--

CREATE TABLE `x_users` (
  `id` int(11) UNSIGNED NOT NULL,
  `languages_id` tinyint(3) UNSIGNED NOT NULL,
  `group_id` tinyint(3) UNSIGNED NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `x_users`
--

INSERT INTO `x_users` (`id`, `languages_id`, `group_id`, `sessid`, `name`, `surname`, `phone`, `email`, `password`, `avatar`, `skey`, `created`, `updated`, `lastlogin`, `status`) VALUES
(1, 1, 1, 'btcvg55ngkv7rlstct97d244c4', 'admin', '', '', 'vh@otakoyi.com', '025QwM9.cl3TU', NULL, NULL, '2017-05-01 07:15:44', '0000-00-00 00:00:00', '2017-05-13 20:51:00', 'active');

-- --------------------------------------------------------

--
-- Структура таблицы `x_users_group`
--

CREATE TABLE `x_users_group` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `parent_id` tinyint(3) UNSIGNED NOT NULL,
  `isfolder` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `backend` tinyint(1) UNSIGNED DEFAULT NULL,
  `permissions` text,
  `position` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `x_users_group`
--

INSERT INTO `x_users_group` (`id`, `parent_id`, `isfolder`, `backend`, `permissions`, `position`) VALUES
(1, 0, 0, 1, 'a:1:{s:11:"full_access";s:1:"1";}', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `x_users_group_info`
--

CREATE TABLE `x_users_group_info` (
  `id` int(11) UNSIGNED NOT NULL,
  `group_id` tinyint(3) UNSIGNED NOT NULL,
  `languages_id` tinyint(3) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `x_users_group_info`
--

INSERT INTO `x_users_group_info` (`id`, `group_id`, `languages_id`, `name`) VALUES
(1, 1, 1, 'Адміністратори');

-- --------------------------------------------------------

--
-- Структура таблицы `x_users_meta`
--

CREATE TABLE `x_users_meta` (
  `id` int(11) UNSIGNED NOT NULL,
  `users_id` int(11) UNSIGNED NOT NULL,
  `meta_k` varchar(45) DEFAULT NULL,
  `meta_v` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `x_content`
--
ALTER TABLE `x_content`
  ADD PRIMARY KEY (`id`,`types_id`,`subtypes_id`,`owner_id`),
  ADD KEY `fk_content_owner_idx` (`owner_id`),
  ADD KEY `status` (`status`),
  ADD KEY `published` (`published`);

--
-- Индексы таблицы `x_content_features`
--
ALTER TABLE `x_content_features`
  ADD PRIMARY KEY (`id`,`features_id`,`content_id`),
  ADD KEY `fk_content_features_content1_idx` (`content_id`),
  ADD KEY `fk_content_features_features1_idx` (`features_id`);

--
-- Индексы таблицы `x_content_images`
--
ALTER TABLE `x_content_images`
  ADD PRIMARY KEY (`id`,`content_id`),
  ADD KEY `position` (`position`),
  ADD KEY `fk_content_images_content1_idx` (`content_id`);

--
-- Индексы таблицы `x_content_images_sizes`
--
ALTER TABLE `x_content_images_sizes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `size` (`size`);

--
-- Индексы таблицы `x_content_info`
--
ALTER TABLE `x_content_info`
  ADD PRIMARY KEY (`id`,`content_id`,`languages_id`),
  ADD UNIQUE KEY `languages_id` (`languages_id`,`url`),
  ADD KEY `fk_content_info_content1_idx` (`content_id`),
  ADD KEY `fk_content_info_languages1_idx` (`languages_id`);

--
-- Индексы таблицы `x_content_meta`
--
ALTER TABLE `x_content_meta`
  ADD PRIMARY KEY (`id`,`content_id`),
  ADD KEY `meta_k` (`meta_k`),
  ADD KEY `fk_content_meta_content1_idx` (`content_id`);

--
-- Индексы таблицы `x_content_relationship`
--
ALTER TABLE `x_content_relationship`
  ADD PRIMARY KEY (`id`,`content_id`,`categories_id`),
  ADD KEY `fk_content_relationship_content2_idx` (`categories_id`),
  ADD KEY `is_main` (`is_main`),
  ADD KEY `fk_content_relationship_content1_idx` (`content_id`);

--
-- Индексы таблицы `x_content_types`
--
ALTER TABLE `x_content_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `is_main` (`is_main`);

--
-- Индексы таблицы `x_content_types_images_sizes`
--
ALTER TABLE `x_content_types_images_sizes`
  ADD PRIMARY KEY (`id`,`types_id`,`images_sizes_id`),
  ADD KEY `fk_content_types_images_sizes_content_images_sizes1_idx` (`images_sizes_id`);

--
-- Индексы таблицы `x_features`
--
ALTER TABLE `x_features`
  ADD PRIMARY KEY (`id`,`owner_id`),
  ADD UNIQUE KEY `code_UNIQUE` (`code`),
  ADD KEY `fk_features_users1_idx` (`owner_id`),
  ADD KEY `position` (`position`);

--
-- Индексы таблицы `x_features_content`
--
ALTER TABLE `x_features_content`
  ADD PRIMARY KEY (`id`,`features_id`,`content_types_id`,`content_subtypes_id`,`content_id`),
  ADD KEY `fk_features_content_features1_idx` (`features_id`),
  ADD KEY `fk_features_content_content_types1_idx` (`content_types_id`);

--
-- Индексы таблицы `x_features_info`
--
ALTER TABLE `x_features_info`
  ADD PRIMARY KEY (`id`,`features_id`,`languages_id`),
  ADD KEY `fk_features_info_languages_idx` (`languages_id`),
  ADD KEY `fk_features_info_features1_idx` (`features_id`);

--
-- Индексы таблицы `x_languages`
--
ALTER TABLE `x_languages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `is_main` (`is_main`);

--
-- Индексы таблицы `x_nav`
--
ALTER TABLE `x_nav`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Индексы таблицы `x_nav_items`
--
ALTER TABLE `x_nav_items`
  ADD PRIMARY KEY (`id`,`nav_id`,`content_id`),
  ADD KEY `fk_nav_items_nav1_idx` (`nav_id`),
  ADD KEY `position` (`position`),
  ADD KEY `published` (`published`);

--
-- Индексы таблицы `x_nav_items_info`
--
ALTER TABLE `x_nav_items_info`
  ADD PRIMARY KEY (`id`,`nav_items_id`,`languages_id`),
  ADD KEY `fk_nav_items_info_nav_items1_idx` (`nav_items_id`),
  ADD KEY `fk_nav_items_info_languages1_idx` (`languages_id`);

--
-- Индексы таблицы `x_posts_tags`
--
ALTER TABLE `x_posts_tags`
  ADD PRIMARY KEY (`id`,`posts_id`,`tags_id`,`languages_id`),
  ADD KEY `fk_tags_posts_tags1_idx` (`tags_id`),
  ADD KEY `fk_e_posts_tags_e_content_idx` (`posts_id`),
  ADD KEY `fk_e_posts_tags_e_tags1_idx` (`tags_id`),
  ADD KEY `fk_e_posts_tags_e_languages1_idx` (`languages_id`);

--
-- Индексы таблицы `x_settings`
--
ALTER TABLE `x_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sname` (`name`);

--
-- Индексы таблицы `x_tags`
--
ALTER TABLE `x_tags`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `x_users`
--
ALTER TABLE `x_users`
  ADD PRIMARY KEY (`id`,`languages_id`,`group_id`),
  ADD KEY `status` (`status`),
  ADD KEY `skey` (`skey`),
  ADD KEY `fk_users_languages1_idx` (`languages_id`),
  ADD KEY `fk_users_users_group1_idx` (`group_id`);

--
-- Индексы таблицы `x_users_group`
--
ALTER TABLE `x_users_group`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`parent_id`),
  ADD KEY `sort` (`position`),
  ADD KEY `isfolder` (`isfolder`),
  ADD KEY `backend` (`backend`);

--
-- Индексы таблицы `x_users_group_info`
--
ALTER TABLE `x_users_group_info`
  ADD PRIMARY KEY (`id`,`group_id`,`languages_id`),
  ADD KEY `fk_users_group_info_languages1_idx` (`languages_id`),
  ADD KEY `fk_users_group_info_users_group_idx` (`group_id`);

--
-- Индексы таблицы `x_users_meta`
--
ALTER TABLE `x_users_meta`
  ADD PRIMARY KEY (`id`,`users_id`),
  ADD KEY `meta_k` (`meta_k`),
  ADD KEY `fk_users_meta_users_idx` (`users_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `x_content`
--
ALTER TABLE `x_content`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT для таблицы `x_content_features`
--
ALTER TABLE `x_content_features`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `x_content_images`
--
ALTER TABLE `x_content_images`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `x_content_images_sizes`
--
ALTER TABLE `x_content_images_sizes`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `x_content_info`
--
ALTER TABLE `x_content_info`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT для таблицы `x_content_meta`
--
ALTER TABLE `x_content_meta`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `x_content_relationship`
--
ALTER TABLE `x_content_relationship`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `x_content_types`
--
ALTER TABLE `x_content_types`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT для таблицы `x_content_types_images_sizes`
--
ALTER TABLE `x_content_types_images_sizes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `x_features`
--
ALTER TABLE `x_features`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `x_features_content`
--
ALTER TABLE `x_features_content`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `x_features_info`
--
ALTER TABLE `x_features_info`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `x_languages`
--
ALTER TABLE `x_languages`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `x_nav`
--
ALTER TABLE `x_nav`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `x_nav_items`
--
ALTER TABLE `x_nav_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT для таблицы `x_nav_items_info`
--
ALTER TABLE `x_nav_items_info`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `x_posts_tags`
--
ALTER TABLE `x_posts_tags`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `x_settings`
--
ALTER TABLE `x_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;
--
-- AUTO_INCREMENT для таблицы `x_tags`
--
ALTER TABLE `x_tags`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `x_users`
--
ALTER TABLE `x_users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `x_users_group`
--
ALTER TABLE `x_users_group`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `x_users_group_info`
--
ALTER TABLE `x_users_group_info`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `x_users_meta`
--
ALTER TABLE `x_users_meta`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `x_content_features`
--
ALTER TABLE `x_content_features`
  ADD CONSTRAINT `fk_content_features_content1` FOREIGN KEY (`content_id`) REFERENCES `x_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_content_features_features1` FOREIGN KEY (`features_id`) REFERENCES `x_features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `x_content_images`
--
ALTER TABLE `x_content_images`
  ADD CONSTRAINT `fk_content_images_content1` FOREIGN KEY (`content_id`) REFERENCES `x_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `x_content_info`
--
ALTER TABLE `x_content_info`
  ADD CONSTRAINT `fk_content_info_content1` FOREIGN KEY (`content_id`) REFERENCES `x_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_content_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `x_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `x_content_meta`
--
ALTER TABLE `x_content_meta`
  ADD CONSTRAINT `fk_content_meta_content1` FOREIGN KEY (`content_id`) REFERENCES `x_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `x_content_relationship`
--
ALTER TABLE `x_content_relationship`
  ADD CONSTRAINT `fk_content_relationship_content1` FOREIGN KEY (`content_id`) REFERENCES `x_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_content_relationship_content2` FOREIGN KEY (`categories_id`) REFERENCES `x_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `x_content_types_images_sizes`
--
ALTER TABLE `x_content_types_images_sizes`
  ADD CONSTRAINT `fk_content_types_images_sizes_content_images_sizes1` FOREIGN KEY (`images_sizes_id`) REFERENCES `x_content_images_sizes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `x_features_content`
--
ALTER TABLE `x_features_content`
  ADD CONSTRAINT `fk_features_content_content_types1` FOREIGN KEY (`content_types_id`) REFERENCES `x_content_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_features_content_features1` FOREIGN KEY (`features_id`) REFERENCES `x_features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `x_features_info`
--
ALTER TABLE `x_features_info`
  ADD CONSTRAINT `fk_features_info_features1` FOREIGN KEY (`features_id`) REFERENCES `x_features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_features_info_languages` FOREIGN KEY (`languages_id`) REFERENCES `x_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `x_nav_items`
--
ALTER TABLE `x_nav_items`
  ADD CONSTRAINT `fk_nav_items_nav1` FOREIGN KEY (`nav_id`) REFERENCES `x_nav` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `x_nav_items_info`
--
ALTER TABLE `x_nav_items_info`
  ADD CONSTRAINT `fk_nav_items_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `x_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_nav_items_info_nav_items1` FOREIGN KEY (`nav_items_id`) REFERENCES `x_nav_items` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `x_posts_tags`
--
ALTER TABLE `x_posts_tags`
  ADD CONSTRAINT `fk_e_posts_tags_e_content` FOREIGN KEY (`posts_id`) REFERENCES `x_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_e_posts_tags_e_languages1` FOREIGN KEY (`languages_id`) REFERENCES `x_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_e_posts_tags_e_tags1` FOREIGN KEY (`tags_id`) REFERENCES `x_tags` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `x_users`
--
ALTER TABLE `x_users`
  ADD CONSTRAINT `fk_users_users_group1` FOREIGN KEY (`group_id`) REFERENCES `x_users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `x_users_group_info`
--
ALTER TABLE `x_users_group_info`
  ADD CONSTRAINT `fk_users_group_info_languages1` FOREIGN KEY (`languages_id`) REFERENCES `x_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_users_group_info_users_group` FOREIGN KEY (`group_id`) REFERENCES `x_users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `x_users_meta`
--
ALTER TABLE `x_users_meta`
  ADD CONSTRAINT `fk_users_meta_users` FOREIGN KEY (`users_id`) REFERENCES `x_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
