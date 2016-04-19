<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 23.03.16 : 17:41
 */

namespace models\engine\plugins;

use models\app\Images;
use models\Engine;

defined("CPATH") or die();

/**
 * Class ProductsAccessories
 * @package models\engine\plugins
 */
class ProductsAccessories extends Engine
{
    public function search($q, $content_id)
    {
        $and  = " and ( c.code like '$q%' or i.name like '$q%' )";
        return self::$db
            ->select("
                select c.id, concat(c.code, ' - ', i.name) as text
                from __content c
                join __content_info i on i.content_id=c.id and i.languages_id={$this->languages_id}
                where c.types_id=10 {$and} and c.id <> {$content_id} and c.status='published'
                limit 30
             ")
            ->all();
    }

    /**
     * @param $products_id
     * @param $accessories_id
     * @return bool
     */
    public function add($products_id, $accessories_id)
    {
        $id = self::$db
            ->select("select id from __products_accessories where products_id={$products_id} and accessories_id={$accessories_id} limit 1")
            ->row('id');

        if(!empty($id)) return false;

        $t = self::$db
            ->select("select count(id) as t from __products_accessories where products_id={$products_id}")
            ->row('t');

        self::$db->insert
        (
            "products_accessories",
            ['products_id' => $products_id, 'accessories_id' => $accessories_id, 'position' => ++$t]
        );
        return true;
    }

    public function get($products_id)
    {
        $r = self::$db
            ->select("
                select c.id, i.name, c.code, ct.type, pc.id as acc_id
                from __products_accessories pc
                join __content c on c.id=pc.accessories_id
                join __content_types ct on ct.id=c.types_id
                join __content_info i on i.content_id=c.id and i.languages_id={$this->languages_id}
                where pc.products_id={$products_id}
                order by abs(pc.position) asc
             ")
            ->all();
        $res = [];
        $im = new Images();
        foreach ($r as $item) {
            $item['img'] = $im->cover($item['id'], 'thumbs');
            $res[] = $item;
        }
        return $res;
    }

    public function delete($id)
    {
        return $this->deleteRow('__products_accessories',$id);
    }
}