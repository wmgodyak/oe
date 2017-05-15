CREATE TABLE IF NOT EXISTS `__settings` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `value` LONGTEXT NULL DEFAULT NULL,
  `block` ENUM('company','common','images','themes','editor','content','seo','analitycs','robots','mail','') NULL DEFAULT NULL,
  `type` ENUM('text','textarea','') NULL DEFAULT NULL,
  `required` TINYINT(1) UNSIGNED NOT NULL DEFAULT '1',
  `display` TINYINT(1)  UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `sname` (`name` ASC))
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8;
INSERT INTO `__settings` (`id`, `name`, `value`, `block`, `type`, `required`, `display`) VALUES
  (1, 'autofil_title', '1', 'common', 'text', 1, 1),
  (2, 'autofill_url', '1', 'common', 'text', 1, 1),
  (3, 'backend_url', 'backend', '', 'text', 1, 0),
  (4, 'editor_bodyId', 'cms_content', 'editor', 'text', 1, 1),
  (5, 'editor_body_class', 'cms_content', 'editor', 'text', 1, 1),
  (6, 'editor_contents_css', '/themes/default/assets/css/style.css', 'editor', 'textarea', 1, 1),
  (9, 'app_theme_current', 'default', 'themes', 'text', 1, 1),
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
  (36, 'mail_email_from', '', 'mail', 'text', 1, 1),
  (37, 'mail_email_to', '', 'mail', 'text', 1, 1),
  (38, 'mail_from_name', '', 'mail', 'text', 1, 1),
  (39, 'mail_header', '', 'mail', 'textarea', 0, 1),
  (40, 'mail_footer', '', 'mail', 'textarea', 0, 1),
  (41, 'mail_smtp_on', '0', 'mail', 'text', 1, 1),
  (42, 'mail_smtp_host', '', 'mail', 'text', 0, 1),
  (43, 'mail_smtp_port', '', 'mail', 'text', 0, 1),
  (44, 'mail_smtp_user', '', 'mail', 'text', 0, 1),
  (45, 'mail_smtp_password', '', 'mail', 'text', 0, 1),
  (46, 'mail_smtp_secure', 'tls', 'mail', 'text', 0, 1),
  (47, 'company_name', '', 'company', 'text', 1, 1),
  (48, 'company_phone', '', 'company', 'text', 1, 1),
  (49, 'seo', 'a:6:{s:5:"guide";a:1:{i:1;a:4:{s:5:"title";s:0:"";s:8:"keywords";s:0:"";s:11:"description";s:0:"";s:2:"h1";s:0:"";}}s:5:"pages";a:1:{i:1;a:4:{s:5:"title";s:34:"{title} {delimiter} {company_name}";s:8:"keywords";s:37:"{keywords} {delimiter} {company_name}";s:11:"description";s:13:"{description}";s:2:"h1";s:4:"{h1}";}}s:4:"post";a:1:{i:1;a:4:{s:5:"title";s:67:"{title} {delimiter}  {category} {delimiter} блог {company_name}";s:8:"keywords";s:46:"{keywords} {delimiter} блог {company_name}";s:11:"description";s:49:"{description} {delimiter} блог {company_name}";s:2:"h1";s:4:"{h1}";}}s:16:"posts_categories";a:1:{i:1;a:4:{s:5:"title";s:67:"{title} {delimiter}  {category} {delimiter} блог {company_name}";s:8:"keywords";s:46:"{keywords} {delimiter} блог {company_name}";s:11:"description";s:46:"{keywords} {delimiter} блог {company_name}";s:2:"h1";s:4:"{h1}";}}s:7:"product";a:1:{i:1;a:4:{s:5:"title";s:58:"{title} {delimiter}  {category} {delimiter} {company_name}";s:8:"keywords";s:37:"{keywords} {delimiter} {company_name}";s:11:"description";s:37:"{keywords} {delimiter} {company_name}";s:2:"h1";s:4:"{h1}";}}s:19:"products_categories";a:1:{i:1;a:4:{s:5:"title";s:59:"{title} {delimiter}  {category} {delimiter}  {company_name}";s:8:"keywords";s:37:"{keywords} {delimiter} {company_name}";s:11:"description";s:37:"{keywords} {delimiter} {company_name}";s:2:"h1";s:4:"{h1}";}}}', '', '', 0, NULL),
  (50, 'home_id', '1', 'common', 'text', 1, 1),
  (52, 'modules', '', 'common', 'text', 1, NULL),
  (53, 'watermark_src', '', 'images', 'text', 1, NULL);
CREATE TABLE IF NOT EXISTS `__languages` (
  `id` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` CHAR(2) NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `is_main` TINYINT(1) UNSIGNED NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code` (`code` ASC),
  INDEX `is_main` (`is_main` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;
INSERT INTO `__languages` (`id`, `code`, `name`, `is_main`) VALUES
  (1, '', '', 1);
CREATE TABLE IF NOT EXISTS `__users_group` (
  `id` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` TINYINT(3) UNSIGNED NOT NULL,
  `isfolder` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  `backend` TINYINT(1) UNSIGNED NULL DEFAULT NULL,
  `permissions` TEXT NULL DEFAULT NULL,
  `position` TINYINT(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `pid` (`parent_id` ASC),
  INDEX `sort` (`position` ASC),
  INDEX `isfolder` (`isfolder` ASC),
  INDEX `backend` (`backend` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;
INSERT INTO `__users_group` (`id`, `parent_id`, `isfolder`, `backend`, `permissions`, `position`) VALUES
  (1, 0, 0, 1, 'a:1:{s:11:"full_access";s:1:"1";}', 1);
CREATE TABLE IF NOT EXISTS `__users_group_info` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `group_id` TINYINT(3) UNSIGNED NOT NULL,
  `languages_id` TINYINT(3) UNSIGNED NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`, `group_id`, `languages_id`),
  INDEX `fk_users_group_info_languages1_idx` (`languages_id` ASC),
  INDEX `fk_users_group_info_users_group_idx` (`group_id` ASC),
  CONSTRAINT `fk_users_group_info_users_group`
    FOREIGN KEY (`group_id`)
    REFERENCES `__users_group` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_users_group_info_languages1`
    FOREIGN KEY (`languages_id`)
    REFERENCES `__languages` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;
INSERT INTO `__users_group_info` (`id`, `group_id`, `languages_id`, `name`) VALUES
  (1, 1, 1, 'Admins');
CREATE TABLE IF NOT EXISTS `__users` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `languages_id` TINYINT(3) UNSIGNED NOT NULL,
  `group_id` TINYINT(3) UNSIGNED NOT NULL,
  `sessid` CHAR(35) NULL DEFAULT NULL,
  `name` VARCHAR(60) NOT NULL,
  `surname` VARCHAR(60) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `email` VARCHAR(60) NOT NULL,
  `password` VARCHAR(64) NOT NULL,
  `avatar` VARCHAR(100) NULL DEFAULT NULL,
  `skey` VARCHAR(64) NULL DEFAULT NULL,
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` DATETIME NOT NULL,
  `lastlogin` TIMESTAMP NULL DEFAULT NULL,
  `status` ENUM('active','ban','deleted') NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`, `languages_id`, `group_id`),
  INDEX `status` (`status` ASC),
  INDEX `skey` (`skey` ASC),
  INDEX `fk_users_languages1_idx` (`languages_id` ASC),
  INDEX `fk_users_users_group1_idx` (`group_id` ASC),
  CONSTRAINT `fk_users_users_group1`
    FOREIGN KEY (`group_id`)
    REFERENCES `__users_group` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;
CREATE TABLE IF NOT EXISTS `__users_meta` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `users_id` INT(11) UNSIGNED NOT NULL,
  `meta_k` VARCHAR(45) NULL DEFAULT NULL,
  `meta_v` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `users_id`),
  INDEX `meta_k` (`meta_k` ASC),
  INDEX `fk_users_meta_users_idx` (`users_id` ASC),
  CONSTRAINT `fk_users_meta_users`
    FOREIGN KEY (`users_id`)
    REFERENCES `__users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;
CREATE TABLE IF NOT EXISTS `__content_types` (
  `id` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` TINYINT(3) UNSIGNED NULL DEFAULT '0',
  `isfolder` TINYINT(1) UNSIGNED NULL DEFAULT '0',
  `type` VARCHAR(45) NOT NULL,
  `name` VARCHAR(60) NOT NULL,
  `is_main` TINYINT(1) UNSIGNED NULL DEFAULT NULL,
  `settings` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `is_main` (`is_main` ASC))
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8;
INSERT INTO `__content_types` (`id`, `parent_id`, `isfolder`, `type`, `name`, `is_main`, `settings`) VALUES
  (1, 0, 1, 'pages', 'Pages', 1, NULL),
  (2, 0, 0, 'guide', 'Guides', NULL, NULL);
CREATE TABLE IF NOT EXISTS `__content` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `types_id` TINYINT(3) UNSIGNED NOT NULL,
  `subtypes_id` TINYINT(3) UNSIGNED NOT NULL,
  `owner_id` INT(11) UNSIGNED NOT NULL,
  `parent_id` INT(10) UNSIGNED NULL DEFAULT '0',
  `isfolder` TINYINT(1) UNSIGNED NULL DEFAULT '0',
  `position` TINYINT(3) UNSIGNED NULL DEFAULT '0',
  `created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` TIMESTAMP NULL DEFAULT NULL,
  `published` DATE NULL DEFAULT NULL,
  `settings` TEXT NULL DEFAULT NULL,
  `status` ENUM('blank','hidden','published','deleted') NULL DEFAULT 'blank',
  `external_id` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id`, `types_id`, `subtypes_id`, `owner_id`),
  INDEX `fk_content_owner_idx` (`owner_id` ASC),
  INDEX `status` (`status` ASC),
  INDEX `published` (`published` ASC))
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8;
CREATE TABLE IF NOT EXISTS `__content_info` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `content_id` INT(10) UNSIGNED NOT NULL,
  `languages_id` TINYINT(3) UNSIGNED NOT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `url` VARCHAR(255) NULL DEFAULT NULL,
  `h1` VARCHAR(255) NULL DEFAULT NULL,
  `title` VARCHAR(255) NULL DEFAULT NULL,
  `keywords` VARCHAR(255) NULL DEFAULT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  `intro` TEXT NULL DEFAULT NULL,
  `content` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `content_id`, `languages_id`),
  UNIQUE INDEX `languages_id` (`languages_id`, `url`),
  INDEX `fk_content_info_content1_idx` (`content_id` ASC),
  INDEX `fk_content_info_languages1_idx` (`languages_id` ASC),
  CONSTRAINT `fk_content_info_content1`
  FOREIGN KEY (`content_id`)
  REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_content_info_languages1`
  FOREIGN KEY (`languages_id`)
  REFERENCES `__languages` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8;
CREATE TABLE IF NOT EXISTS `__content_meta` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `content_id` INT(10) UNSIGNED NOT NULL,
  `meta_k` VARCHAR(45) NULL DEFAULT NULL,
  `meta_v` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `content_id`),
  INDEX `meta_k` (`meta_k` ASC),
  INDEX `fk_content_meta_content1_idx` (`content_id` ASC),
  CONSTRAINT `fk_content_meta_content1`
  FOREIGN KEY (`content_id`)
  REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8;
CREATE TABLE IF NOT EXISTS `__content_relationship` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `content_id` INT(10) UNSIGNED NOT NULL,
  `categories_id` INT(10) UNSIGNED NOT NULL,
  `is_main` TINYINT(1) UNSIGNED NULL DEFAULT NULL,
  `type` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `content_id`, `categories_id`),
  INDEX `fk_content_relationship_content2_idx` (`categories_id` ASC),
  INDEX `is_main` (`is_main` ASC),
  INDEX `fk_content_relationship_content1_idx` (`content_id` ASC),
  CONSTRAINT `fk_content_relationship_content1`
  FOREIGN KEY (`content_id`)
  REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_content_relationship_content2`
  FOREIGN KEY (`categories_id`)
  REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8;
CREATE TABLE IF NOT EXISTS `__content_images` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `content_id` INT(10) UNSIGNED NOT NULL,
  `path` VARCHAR(255) NOT NULL,
  `image` VARCHAR(255) NOT NULL,
  `position` TINYINT(5) UNSIGNED NOT NULL,
  `created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `content_id`),
  INDEX `position` (`position` ASC),
  INDEX `fk_content_images_content1_idx` (`content_id` ASC),
  CONSTRAINT `fk_content_images_content1`
  FOREIGN KEY (`content_id`)
  REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8;
  CREATE TABLE IF NOT EXISTS `__nav` (
  `id` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `code` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code` (`code` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__nav_items` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nav_id` TINYINT(3) UNSIGNED NOT NULL,
  `content_id` INT(10) UNSIGNED DEFAULT 0,
  `parent_id` INT UNSIGNED NULL DEFAULT 0,
  `isfolder` TINYINT UNSIGNED NULL DEFAULT 0,
  `position` TINYINT(3) UNSIGNED NOT NULL DEFAULT 0,
  `url` VARCHAR(160) NULL DEFAULT NULL,
  `display_children` TINYINT( 1 ) UNSIGNED NOT NULL DEFAULT  '0',
  `published` TINYINT( 1 ) UNSIGNED NOT NULL DEFAULT  '1',
  `css_class` VARCHAR( 30 ) NULL DEFAULT NULL,
  `target` ENUM(  '_blank',  '_self' ) NOT NULL DEFAULT  '_self',
  PRIMARY KEY (`id`, `nav_id`, `content_id`),
  INDEX `fk_nav_items_nav1_idx` (`nav_id` ASC),
  INDEX `position` (`position` ASC),
  INDEX `published` (`published` ASC),
  CONSTRAINT `fk_nav_items_nav1`
    FOREIGN KEY (`nav_id`)
    REFERENCES `__nav` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__nav_items_info` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nav_items_id` INT(10) UNSIGNED NOT NULL,
  `languages_id` TINYINT(3) UNSIGNED NOT NULL,
  `name` VARCHAR(45) NULL,
  `title` VARCHAR(45) NULL,
  PRIMARY KEY (`id`, `nav_items_id`, `languages_id`),
  INDEX `fk_nav_items_info_nav_items1_idx` (`nav_items_id` ASC),
  INDEX `fk_nav_items_info_languages1_idx` (`languages_id` ASC),
  CONSTRAINT `fk_nav_items_info_nav_items1`
    FOREIGN KEY (`nav_items_id`)
    REFERENCES `__nav_items` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nav_items_info_languages1`
    FOREIGN KEY (`languages_id`)
    REFERENCES `__languages` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `__features` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `owner_id` INT(11) UNSIGNED NOT NULL,
  `type` ENUM('text','textarea','select','file','folder','value','checkbox','number', 'image') NULL DEFAULT NULL,
  `code` VARCHAR(45) NOT NULL,
  `multiple` TINYINT(1) NULL DEFAULT NULL,
  `on_filter` TINYINT(1) NULL DEFAULT NULL,
  `required` TINYINT(1) NOT NULL DEFAULT '0',
  `hide` TINYINT(1) NOT NULL DEFAULT '0',
  `created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `status` ENUM('blank','published','hidden') NULL DEFAULT 'blank',
  `position` TINYINT(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `owner_id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  INDEX `fk_features_users1_idx` (`owner_id` ASC),
  INDEX `position` (`position` ASC))
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8;
CREATE TABLE IF NOT EXISTS `__features_info` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `features_id` INT(10) UNSIGNED NOT NULL,
  `languages_id` TINYINT(3) UNSIGNED NOT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `features_id`, `languages_id`),
  INDEX `fk_features_info_languages_idx` (`languages_id` ASC),
  INDEX `fk_features_info_features1_idx` (`features_id` ASC),
  CONSTRAINT `fk_features_info_languages`
  FOREIGN KEY (`languages_id`)
  REFERENCES `__languages` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_features_info_features1`
  FOREIGN KEY (`features_id`)
  REFERENCES `__features` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8;
CREATE TABLE IF NOT EXISTS `__features_content` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `features_id` INT(10) UNSIGNED NOT NULL,
  `content_types_id` TINYINT(3) UNSIGNED NOT NULL,
  `content_subtypes_id` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `content_id` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `position` TINYINT(3) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `features_id`, `content_types_id`, `content_subtypes_id`, `content_id`),
  INDEX `fk_features_content_features1_idx` (`features_id` ASC),
  INDEX `fk_features_content_content_types1_idx` (`content_types_id` ASC),
  CONSTRAINT `fk_features_content_features1`
  FOREIGN KEY (`features_id`)
  REFERENCES `__features` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_features_content_content_types1`
  FOREIGN KEY (`content_types_id`)
  REFERENCES `__content_types` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8;
CREATE TABLE IF NOT EXISTS `__content_features` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `features_id` INT(10) UNSIGNED NOT NULL,
  `content_id` INT(10) UNSIGNED NOT NULL,
  `values_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `languages_id` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `value` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `features_id`, `content_id`),
  INDEX `fk_content_features_content1_idx` (`content_id` ASC),
  INDEX `fk_content_features_features1_idx` (`features_id` ASC),
  CONSTRAINT `fk_content_features_content1`
  FOREIGN KEY (`content_id`)
  REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_content_features_features1`
  FOREIGN KEY (`features_id`)
  REFERENCES `__features` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8;
CREATE TABLE IF NOT EXISTS `__content_images_sizes` (
  `id` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `size` VARCHAR(16) NOT NULL,
  `width` INT(5) UNSIGNED NOT NULL,
  `height` INT(5) UNSIGNED NOT NULL,
  `quality` TINYINT(3) UNSIGNED NOT NULL,
  `watermark` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  `watermark_position` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `size` (`size` ASC))
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8;
CREATE TABLE IF NOT EXISTS `__content_types_images_sizes` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `types_id` TINYINT(3) UNSIGNED NOT NULL,
  `images_sizes_id` TINYINT(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `types_id`, `images_sizes_id`),
  INDEX `fk_content_types_images_sizes_content_images_sizes1_idx` (`images_sizes_id` ASC),
  CONSTRAINT `fk_content_types_images_sizes_content_images_sizes1`
  FOREIGN KEY (`images_sizes_id`)
  REFERENCES `__content_images_sizes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8;

-- INSTALL BLOG
CREATE TABLE IF NOT EXISTS `__tags` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tag` VARCHAR(60) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `__posts_tags` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `posts_id` INT(10) UNSIGNED NOT NULL,
  `tags_id` INT(10) UNSIGNED NOT NULL,
  `languages_id` TINYINT(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `posts_id`, `tags_id`, `languages_id`),
  INDEX `fk_tags_posts_tags1_idx` (`tags_id` ASC),
  INDEX `fk_e_posts_tags_e_content_idx` (`posts_id` ASC),
  INDEX `fk_e_posts_tags_e_tags1_idx` (`tags_id` ASC),
  INDEX `fk_e_posts_tags_e_languages1_idx` (`languages_id` ASC),
  CONSTRAINT `fk_e_posts_tags_e_content`
  FOREIGN KEY (`posts_id`)
  REFERENCES `__content` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_posts_tags_e_tags1`
  FOREIGN KEY (`tags_id`)
  REFERENCES `__tags` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_e_posts_tags_e_languages1`
  FOREIGN KEY (`languages_id`)
  REFERENCES `__languages` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8;

INSERT INTO `__content_types` (`id`,`parent_id`, `isfolder`, `type`, `name`, `is_main`, `settings`) VALUES
  (3, 0, 0, 'post', 'Posts', NULL, NULL),
  (4, 0, 0, 'posts_categories', 'PostsCategories', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}');

-- SAMPLE DATA

INSERT INTO `__content` (`id`, `types_id`, `subtypes_id`, `owner_id`, `parent_id`, `isfolder`, `position`, `created`, `updated`, `published`, `settings`, `status`, `external_id`) VALUES
  (1, 1, 1, 1, 0, 1, 0, '2017-03-09 10:13:35', '2017-03-09 13:01:11', '2017-03-09', NULL, 'published', ''),
  (2, 1, 1, 1, 1, 0, 0, '2017-03-09 10:13:35', '2017-03-09 13:01:11', '2017-03-09', NULL, 'published', ''),
  (3, 1, 1, 1, 1, 0, 0, '2017-03-09 10:13:44', '2017-03-09 10:13:49', '2017-03-09', NULL, 'published', ''),
  (4, 4, 4, 1, 0, 1, 0, '2017-03-09 10:18:39', '2017-03-09 12:53:09', '2017-03-09', NULL, 'published', ''),
  (5, 4, 4, 1, 4, 0, 0, '2017-03-09 12:49:03', '2017-03-09 12:49:03', '2017-03-09', NULL, 'published', ''),
  (6, 4, 4, 1, 4, 0, 0, '2017-03-09 12:49:11', '2017-03-09 12:49:11', '2017-03-09', NULL, 'published', ''),
  (7, 3, 3, 1, 0, 0, 0, '2017-03-09 12:49:14', '2017-03-09 12:52:16', '2017-03-09', NULL, 'published', ''),
  (8, 3, 3, 1, 0, 0, 0, '2017-03-09 12:53:16', '2017-03-09 12:53:48', '2017-03-09', NULL, 'published', ''),
  (9, 3, 3, 1, 0, 0, 0, '2017-03-09 12:54:36', '2017-03-09 12:55:23', '2017-03-09', NULL, 'published', '');

INSERT INTO `__content_info` (`id`, `content_id`, `languages_id`, `name`, `url`, `h1`, `title`, `keywords`, `description`, `intro`, `content`) VALUES
  (1, 1, 1, 'Home', '', '', 'Home', '', '', '', ''),
  (2, 2, 1, 'About', 'about', '', 'About', '', '', '', ''),
  (3, 3, 1, '404', '404', '', '404', '', '', '', ''),
  (4, 4, 1, 'Blog', 'blog', '', 'Blog', '', 'The example template of creating a blog.', NULL, NULL),
  (5, 5, 1, 'Category A', 'category-a', '', 'Category A', '', '', NULL, NULL),
  (6, 6, 1, 'Category B', 'category-b', '', 'Category B', '', '', NULL, NULL),
  (7, 7, 1, 'Sample blog post', 'sample-blog-post', '', 'Sample blog post', '', '', '<p>This blog post shows a few different types of content that''s supported and styled with Bootstrap. Basic typography, images, and code are all supported.</p>\n                <hr>\n                <p>Cum sociis natoque penatibus et magnis <a href="#">dis parturient montes</a>, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Sed posuere consectetur est at lobortis. Cras mattis consectetur purus sit amet fermentum.</p>\n                <blockquote>\n                    <p>Curabitur blandit tempus porttitor. <strong>Nullam quis risus eget urna mollis</strong> ornare vel eu leo. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>\n                </blockquote>\n                <p>Etiam porta <em>sem malesuada magna</em> mollis euismod. Cras mattis consectetur purus sit amet fermentum. Aenean lacinia bibendum nulla sed consectetur.</p>\n                <h2>Heading</h2>\n                <p>Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.</p>     ', '                <p>This blog post shows a few different types of content that''s supported and styled with Bootstrap. Basic typography, images, and code are all supported.</p>\n                <hr>\n                <p>Cum sociis natoque penatibus et magnis <a href="#">dis parturient montes</a>, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Sed posuere consectetur est at lobortis. Cras mattis consectetur purus sit amet fermentum.</p>\n                <blockquote>\n                    <p>Curabitur blandit tempus porttitor. <strong>Nullam quis risus eget urna mollis</strong> ornare vel eu leo. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>\n                </blockquote>\n                <p>Etiam porta <em>sem malesuada magna</em> mollis euismod. Cras mattis consectetur purus sit amet fermentum. Aenean lacinia bibendum nulla sed consectetur.</p>\n                <h2>Heading</h2>\n                <p>Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.</p>\n                <h3>Sub-heading</h3>\n                <p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>\n                <pre><code>Example code block</code></pre>\n                <p>Aenean lacinia bibendum nulla sed consectetur. Etiam porta sem malesuada magna mollis euismod. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa.</p>\n                <h3>Sub-heading</h3>\n                <p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean lacinia bibendum nulla sed consectetur. Etiam porta sem malesuada magna mollis euismod. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>\n                <ul>\n                    <li>Praesent commodo cursus magna, vel scelerisque nisl consectetur et.</li>\n                    <li>Donec id elit non mi porta gravida at eget metus.</li>\n                    <li>Nulla vitae elit libero, a pharetra augue.</li>\n                </ul>\n                <p>Donec ullamcorper nulla non metus auctor fringilla. Nulla vitae elit libero, a pharetra augue.</p>\n                <ol>\n                    <li>Vestibulum id ligula porta felis euismod semper.</li>\n                    <li>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</li>\n                    <li>Maecenas sed diam eget risus varius blandit sit amet non magna.</li>\n                </ol>\n                <p>Cras mattis consectetur purus sit amet fermentum. Sed posuere consectetur est at lobortis.</p>\n            '),
  (8, 8, 1, 'Another blog post', 'another-blog-post', '', 'Another blog post', '', '', '<p>Cum sociis natoque penatibus et magnis <a href="#">dis parturient montes</a>, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Sed posuere consectetur est at lobortis. Cras mattis consectetur purus sit amet fermentum.</p>', '<p>Cum sociis natoque penatibus et magnis <a href="#">dis parturient montes</a>, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Sed posuere consectetur est at lobortis. Cras mattis consectetur purus sit amet fermentum.</p>\n                <blockquote>\n                    <p>Curabitur blandit tempus porttitor. <strong>Nullam quis risus eget urna mollis</strong> ornare vel eu leo. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>\n                </blockquote>\n                <p>Etiam porta <em>sem malesuada magna</em> mollis euismod. Cras mattis consectetur purus sit amet fermentum. Aenean lacinia bibendum nulla sed consectetur.</p>\n                <p>Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.</p>\n            '),
  (9, 9, 1, 'New feature', 'new-feature', '', 'New feature', '', '', '<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean lacinia bibendum nulla sed consectetur. Etiam porta sem malesuada magna mollis euismod. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>\n', '<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean lacinia bibendum nulla sed consectetur. Etiam porta sem malesuada magna mollis euismod. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>\n\n<ul>\n	<li>Praesent commodo cursus magna, vel scelerisque nisl consectetur et.</li>\n	<li>Donec id elit non mi porta gravida at eget metus.</li>\n	<li>Nulla vitae elit libero, a pharetra augue.</li>\n</ul>\n\n<p>Etiam porta&nbsp;<em>sem malesuada magna</em>&nbsp;mollis euismod. Cras mattis consectetur purus sit amet fermentum. Aenean lacinia bibendum nulla sed consectetur.</p>\n\n<p>Donec ullamcorper nulla non metus auctor fringilla. Nulla vitae elit libero, a pharetra augue.</p>\n\n<nav>&nbsp;</nav>\n');

INSERT INTO `__content_relationship` (`id`, `content_id`, `categories_id`, `is_main`, `type`) VALUES
  (1, 7, 5, 0, 'blog_category'),
  (2, 8, 5, 0, 'blog_category'),
  (3, 9, 5, 0, 'blog_category');

INSERT INTO `__nav` (`id`, `name`, `code`) VALUES
  (1, 'Main', 'main');

INSERT INTO `__nav_items` (`id`, `nav_id`, `content_id`, `parent_id`, `isfolder`, `position`, `url`, `display_children`, `published`, `css_class`, `target`) VALUES
  (1, 1, 4, 0, 0, 2, NULL, 0, 1, NULL, '_self'),
  (2, 1, 2, 0, 0, 1, NULL, 0, 1, NULL, '_self'),
  (4, 1, 1, 0, 0, 0, NULL, 0, 1, NULL, '_self');

INSERT INTO `__tags` (`id`, `tag`) VALUES
  (1, 'oyi'),
  (2, 'php');

INSERT INTO `__posts_tags` (`id`, `posts_id`, `tags_id`, `languages_id`) VALUES
  (1, 7, 1, 1),
  (2, 7, 2, 1);


