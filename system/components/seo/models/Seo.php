<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 16.06.16
 * Time: 10:41
 */

namespace system\components\seo\models;

use system\models\Model;
use system\models\Settings;

defined("CPATH") or die();

/**
 * Class Seo
 * @package system\components\seo\models
 */
class Seo extends Model
{
    public function getContentTypes()
    {
        return self::$db->select("select id, type, name from __content_types where parent_id = 0")->all();
    }

    public function get()
    {
        return Settings::getInstance()->get('seo');
    }

    public function update()
    {
        $seo = $this->request->post('seo');
        return Settings::getInstance()->set('seo', $seo);
    }
}