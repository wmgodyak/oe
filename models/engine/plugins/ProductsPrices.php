<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 21.01.16 : 17:22
 */

namespace models\engine\plugins;

use models\core\Model;

defined("CPATH") or die();

/**
 * Class ProductsPrices
 * @package models\engine\plugins
 */
class ProductsPrices extends Model
{
    public function update($content_id, $group_id, $price)
    {
        $old = self::$db
            ->select("select id, price_old from __products_prices where content_id={$content_id} and group_id={$group_id} limit 1")
            ->row();

        if(empty($old)){
            return $this->createRow
            (
                "__products_prices",
                ['content_id' => $content_id, 'group_id' => $group_id, 'price' => $price, 'price_old' => $old['price_old']]
            );
        }

        return $this->updateRow
        (
            '__products_prices',
            $old['id'],
            ['price' => $price, 'price_old' => $old['price_old']]
        );
    }

    /**
     * @param int $parent_id
     * @return mixed
     */
    public function getUsersGroup($parent_id = 0)
    {
        return self::$db->select("
          select g.id, g.isfolder, name
          from __users_group g
          join __users_group_info i on i.group_id=g.id and i.languages_id = {$this->languages_id}
          where g.parent_id={$parent_id} and g.backend =0
          order by abs(g.position) asc
          ")->all();
    }

    /**
     * @param $content_id
     * @return array
     */
    public function get($content_id)
    {
        $r = self::$db->select("select group_id, price from __products_prices where content_id={$content_id}")->all();
        $res = [];
        foreach ($r as $item) {
            $res[$item['group_id']] = $item['price'];
        }
        return $res;
    }

    public function getContentData($id)
    {
        return self::$db->select("select * from __content where id={$id} limit 1")->row();
    }
}