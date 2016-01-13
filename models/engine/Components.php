<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 12.01.16 : 11:59
 */

namespace models\engine;

use models\core\Model;

/**
 * Class Components
 * @package models\engine
 */
class Components extends Model
{
    public function isInstalled($controller)
    {
        $controller = mb_strtolower($controller);
        return self::$db->select("select id from components where controller = '{$controller}' limit 1")->row('id') > 0;
    }
}