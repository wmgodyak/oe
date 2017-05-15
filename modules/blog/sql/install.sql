
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
  (3, 0, 0, 'blog_post', 'Posts', NULL, NULL),
  (4, 0, 0, 'blog_category', 'PostsCategories', NULL, 'a:2:{s:7:"ext_url";s:1:"0";s:9:"parent_id";s:0:"";}');

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
  (1, 'Main', 'blog_main');

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