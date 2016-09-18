<?php
namespace modules\shopActions\models\admin;

use system\models\Model;

/**
 * Class ShopActions
 * @package modules\shopActions\models\admin
 */
class ShopActions extends Model
{
    /**
     * @param $q
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function searchProducts($q)
    {
        $where = [];
        $q = explode(' ', $q);
        foreach ($q as $k=>$v) {
            $v = trim($v);
            if(empty($v)) continue;

            $where[] = " ((i.name like '%{$v}%') or (c.sku like '{$v}%') )";
        }

        $w = implode('and ', $where);

        return self::$db
            ->select("
                select SQL_CALC_FOUND_ROWS c.id, i.name
                from __content c
                join __content_types ct on ct.type='product' and ct.id=c.types_id
                join __content_info i on i.content_id=c.id and i.languages_id='{$this->languages_id}'
                where {$w}  and c.status ='published'
            ")
            ->all();
    }

    public function searchTotal()
    {
        return self::$db->select('SELECT FOUND_ROWS() as t')->row('t');
    }
}