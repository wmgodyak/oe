<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 05.02.16 : 16:42
 */

namespace models\engine;

use models\Engine;

defined("CPATH") or die();

/**
 * Class Themes
 * @package models\engine
 */
class Themes extends Engine
{
    public function activate($theme)
    {
        return self::$db->update('__settings', ['value' => $theme], "name='app_theme_current' limit 1");
    }
}