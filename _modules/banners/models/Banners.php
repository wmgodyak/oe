<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:12
 */

namespace modules\banners\models;

use system\models\Model;

class Banners extends Model
{
    public function get($code)
    {
        return self::$db
            ->select
            ("
              select b.skey, b.img, b.target
              from __banners_places bp
              join __banners b on b.places_id=bp.id and b.published=1 and b.languages_id={$this->languages_id}
              where bp.code = '$code'
              order by b.id desc
            ")
            ->all();
    }

    public function getUrlByKey($skey)
    {
        return self::$db->select("select url from __banners where skey='{$skey}' limit 1")->row('url');
    }
}