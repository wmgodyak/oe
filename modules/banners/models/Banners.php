<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:12
 */

namespace modules\banners\models;

use system\models\Model;

/**
 * Class Banners
 * @package modules\banners\models
 */
class Banners extends Model
{
    /**
     * @param $code
     * @param null $limit
     * @param null $order_by
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get($code, $limit = null, $order_by = null)
    {

        switch($order_by){
            case 'asc':
                $ob = "b.id asc";
                break;
            case 'desc':
                $ob = "b.id desc";
                break;
            case 'rand':
                $ob = " rand()";
                break;
            default:
                $ob = "b.id desc";
                break;
        }

        $limit = $limit ? " limit {$limit}" : '';

        return self::$db
            ->select
            ("
              select Concat('route/banners/click/', b.skey) as url, b.img, b.target
              from __banners_places bp
              join __banners b on b.places_id=bp.id and b.published=1 and b.languages_id={$this->languages_id}
              where bp.code = '$code'
              order by {$ob}
              {$limit}
            ")
            ->all();
    }

    public function getUrlByKey($skey)
    {
        return self::$db->select("select url from __banners where skey='{$skey}' limit 1")->row('url');
    }
}