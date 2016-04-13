<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 17.03.16 : 9:42
 */

namespace models\engine;

use models\Engine;

defined("CPATH") or die();

/**
 * Class Seo
 * @package models\engine
 */
class Seo extends Engine
{
    public function getContentTypes()
    {
        return self::$db->select("select id, type, name from content_types where parent_id=0")->all();
    }

    public function get()
    {
        $v = self::$db->select("select value from settings where name = 'seo' limit 1")->row('value');
        if(empty($v)) return [];

        return unserialize($v);
    }

    public function update()
    {
        $seo = $this->request->post('seo');
        return self::$db->update('settings', ['value' => serialize($seo)], "name='seo' limit 1");
    }
}