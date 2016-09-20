<?php
namespace modules\shopActions\models;

use system\models\ContentMeta;
use system\models\Model;

class ShopActions extends Model
{
    public $meta;

    public function __construct()
    {
        parent::__construct();

        $this->meta = new ContentMeta();
    }

    /**
     * @param $place
     * @param null $limit
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function getBanners($place, $limit = null)
    {
        $n = date('Ymd');

        $limit = $limit ? " limit {$limit}" : '';
        $items = self::$db
            ->select("
              select c.id, img.meta_v as image,
                CONCAT('route/shopActions/click/', c.id) as url, cl.meta_v as clickable
              from __content c
              join __content_types ct on ct.id=c.types_id and ct.type='actions'
              join __content_meta p on p.content_id=c.id and p.meta_k='place' and p.meta_v='{$place}'
              join __content_meta img on img.content_id=c.id and img.meta_k='image_{$this->languages_id}'
              left join __content_meta pos on pos.content_id=c.id and pos.meta_k='position'
              join __content_meta xp  on xp.content_id=c.id and xp.meta_k='expired' and IF(xp.meta_v = '', {$n}, DATE_FORMAT(STR_TO_DATE(xp.meta_v, '%d.%m.%Y'), '%Y%m%d')) >= {$n}
              join __content_meta cl  on cl.content_id=c.id and cl.meta_k='clickable'
              where c.status = 'published'
              -- order by abs(IF(pos.meta_v = '', 0 , pos.meta_v)) asc
              order by abs(pos.meta_v) asc, abs(c.id) desc
              {$limit}
            ")
            ->all();

        return $items;
    }
}