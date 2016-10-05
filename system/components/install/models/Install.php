<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 05.10.16 : 19:05
 */

namespace system\components\install\models;

use system\models\Model;

defined("CPATH") or die();

class Install extends Model
{
    public function go()
    {
        $q = file_get_contents(DOCROOT . "system/components/install/sql/install.sql");
        return self::$db->exec($q);
    }
}