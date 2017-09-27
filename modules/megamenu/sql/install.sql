DROP TABLE IF EXISTS `__megamenu`;
CREATE TABLE IF NOT EXISTS `__megamenu` (
  `id` smallint(6) NOT NULL COMMENT 'Menu ID',
  `alias` varchar(255) NOT NULL COMMENT 'Alias',
  `name` varchar(255) NOT NULL COMMENT 'Menu Name',
  `mobile_template` varchar(255) NOT NULL COMMENT 'Mobile Template',
  `structure` text NOT NULL COMMENT 'Structure',
  `disable_bellow` smallint(6) NOT NULL COMMENT 'Disable Bellow',
  `status` smallint(6) NOT NULL COMMENT 'Status',
  `html` text NOT NULL COMMENT 'Html',
  `creation_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Menu Creation Time',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Menu Modification Time',
  `desktop_template` varchar(255) DEFAULT NULL COMMENT 'Desktop Template',
  `disable_iblocks` smallint(6) DEFAULT NULL COMMENT 'Disable Item Blocks',
  `event` varchar(255) DEFAULT NULL COMMENT 'Event',
  `classes` varchar(255) DEFAULT NULL COMMENT 'Classes',
  `width` varchar(255) DEFAULT NULL COMMENT 'Width',
  `scrolltofixed` smallint(6) DEFAULT NULL COMMENT 'Scroll to fixed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='__megamenu';

-- --------------------------------------------------------

--
-- Table structure for table `__megamenu_content_types`
--

DROP TABLE IF EXISTS `__megamenu_content_types`;
CREATE TABLE IF NOT EXISTS `__megamenu_content_types` (
  `menu_id` smallint(6) NOT NULL,
  `types_id` tinyint(3) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Megamenu Menu Store';

-- --------------------------------------------------------

--
-- Table structure for table `__megamenu_item`
--

DROP TABLE IF EXISTS `__megamenu_item`;
CREATE TABLE IF NOT EXISTS `__megamenu_item` (
  `id` bigint(20) NOT NULL,
  `parent_id` bigint(20) NOT NULL DEFAULT '0' COMMENT 'ID',
  `menu_id` smallint(6) NOT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT 'Item Name',
  `show_name` smallint(6) DEFAULT NULL COMMENT 'Show Name',
  `classes` varchar(255) DEFAULT NULL COMMENT 'Classes',
  `child_col` varchar(255) DEFAULT NULL COMMENT 'Child Menu Col',
  `sub_width` varchar(255) DEFAULT NULL COMMENT 'Sub Width',
  `align` varchar(255) DEFAULT NULL COMMENT 'Alignment Type',
  `icon_position` varchar(255) DEFAULT NULL COMMENT 'Icon Position',
  `icon_classes` varchar(255) DEFAULT NULL COMMENT 'Icon Classes',
  `is_group` smallint(6) DEFAULT NULL COMMENT 'Is Group',
  `status` smallint(6) DEFAULT NULL COMMENT 'Status',
  `disable_bellow` smallint(6) NOT NULL COMMENT 'Disable Bellow',
  `show_icon` smallint(6) NOT NULL COMMENT 'Show Icon',
  `icon` varchar(255) DEFAULT NULL COMMENT 'Icon',
  `show_header` smallint(6) DEFAULT NULL COMMENT 'Show Header',
  `header_html` text COMMENT 'Header',
  `show_left_sidebar` smallint(6) DEFAULT NULL COMMENT 'Show Left Sidebar',
  `left_sidebar_width` varchar(255) DEFAULT NULL COMMENT 'Left Sidebar Width',
  `left_sidebar_html` text COMMENT 'Left Sidebar HTML',
  `show_content` smallint(6) DEFAULT NULL COMMENT 'Show Content',
  `content_width` varchar(255) DEFAULT NULL COMMENT 'Content Width',
  `content_type` varchar(255) DEFAULT NULL COMMENT 'Content Type',
  `link_type` varchar(255) DEFAULT NULL COMMENT 'Link',
  `link` varchar(255) DEFAULT NULL COMMENT 'Link',
  `category` text COMMENT 'Link',
  `target` varchar(255) DEFAULT NULL COMMENT 'Link',
  `content_html` text COMMENT 'Content HTML',
  `show_right_sidebar` smallint(6) DEFAULT NULL COMMENT 'Show Right Sidebar',
  `right_sidebar_width` varchar(255) DEFAULT NULL COMMENT 'Right Sidebar Width',
  `right_sidebar_html` text COMMENT 'Right Sidebar HTML',
  `show_footer` smallint(6) DEFAULT NULL COMMENT 'Show Footer',
  `footer_html` text COMMENT 'Footer HTML',
  `color` varchar(255) DEFAULT NULL COMMENT 'Color',
  `hover_color` varchar(255) DEFAULT NULL COMMENT 'Hover Color',
  `bg_color` varchar(255) DEFAULT NULL COMMENT 'Background Color',
  `bg_hover_color` varchar(255) DEFAULT NULL COMMENT 'Background Hover Color',
  `inline_css` text COMMENT 'Inline CSS',
  `hover_icon` varchar(255) DEFAULT NULL COMMENT 'Hover Icon',
  `dropdown_bgcolor` varchar(255) DEFAULT NULL COMMENT 'Dropdown Background Color',
  `dropdown_bgimage` varchar(255) DEFAULT NULL COMMENT 'Dropdown Bakground Image',
  `dropdown_bgimagerepeat` varchar(255) DEFAULT NULL COMMENT 'Dropdown Bakground Image Repeat',
  `dropdown_bgpositionx` varchar(255) DEFAULT NULL COMMENT 'Dropdown Background Position X',
  `dropdown_bgpositiony` varchar(255) DEFAULT NULL COMMENT 'Dropdown Background Position Y',
  `dropdown_inlinecss` varchar(255) DEFAULT NULL COMMENT 'Dropdown Inline CSS',
  `parentcat` varchar(255) DEFAULT NULL COMMENT 'Parent Category'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Megamenu Menu Item';

-- --------------------------------------------------------

--
-- Table structure for table `__megamenu_users_group`
--

DROP TABLE IF EXISTS `__megamenu_users_group`;
CREATE TABLE IF NOT EXISTS `__megamenu_users_group` (
  `menu_id` smallint(6) NOT NULL,
  `group_id` tinyint(3) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Menu Custom Group';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `__megamenu`
--
ALTER TABLE `__megamenu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `MEGAMENU_MENU_ID` (`id`);

--
-- Indexes for table `__megamenu_content_types`
--
ALTER TABLE `__megamenu_content_types`
  ADD PRIMARY KEY (`menu_id`,`types_id`),
  ADD KEY `fk_megamenu_content_types_megamenu_idx` (`menu_id`),
  ADD KEY `fk_megamenu_content_types_content_types_idx` (`types_id`);

--
-- Indexes for table `__megamenu_item`
--
ALTER TABLE `__megamenu_item`
  ADD PRIMARY KEY (`id`,`parent_id`,`menu_id`),
  ADD KEY `fk_megamenu_item_megamenu_idx` (`menu_id`);

--
-- Indexes for table `__megamenu_users_group`
--
ALTER TABLE `__megamenu_users_group`
  ADD PRIMARY KEY (`menu_id`,`group_id`),
  ADD KEY `fk_megamenu_users_group_megamenu_idx` (`menu_id`),
  ADD KEY `fk_megamenu_users_group_users_group_idx` (`group_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `__megamenu`
--
ALTER TABLE `__megamenu`
  MODIFY `id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Menu ID';
--
-- AUTO_INCREMENT for table `__megamenu_item`
--
ALTER TABLE `__megamenu_item`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `__megamenu_content_types`
--
ALTER TABLE `__megamenu_content_types`
  ADD CONSTRAINT `fk_megamenu_content_types_content_types` FOREIGN KEY (`types_id`) REFERENCES `__content_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_megamenu_content_types_megamenu` FOREIGN KEY (`menu_id`) REFERENCES `__megamenu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `__megamenu_item`
--
ALTER TABLE `__megamenu_item`
  ADD CONSTRAINT `fk_megamenu_item_megamenu` FOREIGN KEY (`menu_id`) REFERENCES `__megamenu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `__megamenu_users_group`
--
ALTER TABLE `__megamenu_users_group`
  ADD CONSTRAINT `fk_megamenu_users_group_megamenu` FOREIGN KEY (`menu_id`) REFERENCES `__megamenu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_megamenu_users_group_users_group` FOREIGN KEY (`group_id`) REFERENCES `__users_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
