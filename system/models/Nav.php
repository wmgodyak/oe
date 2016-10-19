<?php

namespace system\models;
/**
 * Class Nav
 * @package system\models
 */
class Nav extends Model
{
    /**
     * @param $code
     * @param int $level
     * @return mixed
     */
    public function get($code, $parent_id = 0)
    {
        $items = self::$db
            ->select("
              select ni.id as nav_item_id, ni.content_id,
              IF( ni.url is null, ni.content_id, IF(trim(ni.url) = '', ni.content_id , ni.url) ) as url,
              IF( nii.name is null, ci.name, IF(trim(nii.name) = '', ci.name , nii.name) ) as name,
              IF( nii.title is null, ci.title, IF(trim(nii.title) = '', ci.title , nii.title) ) as title,
              ni.isfolder,
              ni.css_class,
              ni.target,
              ni.display_children
              from __nav n
              join __nav_items ni on ni.nav_id = n.id
              left join __nav_items_info nii on nii.nav_items_id = ni.id and nii.languages_id='{$this->languages_id}'
              -- left join __content c on c.id=ni.content_id and c.status='published'
              left join __content_info ci on ci.content_id=ni.content_id and ci.languages_id='{$this->languages_id}'
              where n.code = '{$code}' and ni.parent_id = {$parent_id}
              order by abs(ni.position) asc
              ")
            ->all();

        foreach ($items as $k=>$item) {

            if($item['isfolder'] && $item['display_children'] == 1){
                $a = $this->items($item['nav_item_id']);
            } elseif($item['isfolder'] && $item['display_children'] == 0){
                $a = $this->get($code, $item['nav_item_id']);
            }

            if(!empty($a)){
                $items[$k]['items'] = $a;
            }
        }

        return $items;
    }

    /**
     * @param $parent_id
     * @param $level
     * @return mixed
     */
    private function items($parent_id, $level = 5)
    {
        $level--;
        $items = self::$db
            ->select("
              select c.id, c.id as url, c.isfolder, ci.name, ci.title
              from __content c
              join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
              where c.parent_id='{$parent_id}' and c.status='published'
              ")
            ->all();

        foreach ($items as $k=>$item) {
            if($item['isfolder'] && $level > 0){
                $a = $this->items($item['id'], $level);
                if(!empty($a)){
                    $items[$k]['items'] = $a;
                }
            }
        }

        return $items;
    }

}