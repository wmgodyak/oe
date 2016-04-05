<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 21.03.16 : 16:51
 */

namespace models\app;

use models\App;

defined("CPATH") or die();

/**
 * Class Nav
 * @package models\app
 */
class Nav extends App
{
    /**
     * @param $code
     * @param int $level
     * @return mixed
     */
    public function get($code, $level=0)
    {
        $items = self::$db
            ->select("
              select c.id, c.isfolder, ci.name,ci.title
              from nav n
              join nav_items ni on ni.nav_id = n.id
              join content c on c.id=ni.content_id and c.status='published'
              join content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
              where n.code = '{$code}'
              order by abs(ni.position) asc
              ")
            ->all();

        if($level == 0){
            return $items;
        }

        foreach ($items as $k=>$item) {
            if($item['isfolder']){
                $items[$k]['items'] = $this->items($item['id'], --$level);
            }
        }

        echo $this->getDBErrorMessage();
        return $items;
    }

    /**
     * @param $parent_id
     * @param $level
     * @return mixed
     */
    private function items($parent_id, $level)
    {
        $items = self::$db
            ->select("
              select c.id, c.isfolder, ci.name,ci.title
              from content c on c.id=ni.content_id and c.status='published'
              join content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
              where c.parent_id={$parent_id}
              ")
            ->all();

        foreach ($items as $k=>$item) {
            if($item['isfolder'] && $level > 0){
                $items[$k]['items'] = $this->items($item['id'], --$level);
            }
        }

        return $items;
    }
}