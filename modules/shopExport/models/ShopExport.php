<?php

namespace modules\shopExport\models;

use modules\shop\models\Products;
use system\models\Model;

defined("CPATH") or die();

class ShopExport extends Model
{
    private $cat_types_id = 22;
    private $p_types_id = 23;


    public function getCategories($in, $languages_id)
    {
        $this->languages_id = $languages_id;
        $items = [];
        if(!empty($in)){
            foreach ($this->getSelectedCategories($in) as $selectedCategory) {
                $items[] = $selectedCategory;
            }
        } else {
            foreach ($this->tree($languages_id, $this->cat_types_id) as $item) {
                $items[] = $item;
            }
        }

        $data = [];
        foreach ($items as $item) {
            $data[] = $item;
            if($item['isfolder']){
                $data = array_merge($data, $this->catR($item['id']));
            }
        }
        return $data;
    }

    /**
     * @param $parent_id
     * @return array
     */
    private function catR($parent_id)
    {
        $data = [];
        foreach ($this->tree($this->languages_id, $this->cat_types_id, $parent_id) as $item) {
            $data[] = $item;
            if($item['isfolder']){
                $data = array_merge($data, $this->tree($this->languages_id, $this->cat_types_id, $item['id']));
            }
        }
        return $data;
    }

    /**
     * @param $categories_id
     */
    public function getProducts($categories, $settings)
    {
        if(empty($categories)) return [];
        $in = [];
        foreach ($categories as $category) {
            $in[] = $category['id'];
        }
        $p = new Products();

        $p->languages_id = $settings['languages_id'];
        $p->currency_id = $settings['currency_id'];
        $p->group_id    = $settings['group_id'];
        $p->join("join e_content_relationship cr on cr.categories_id in (". implode(',', $in) .") and cr.content_id=c.id");
        $p->round_price = true;
        $p->start = 0;
        $p->num = 100000;

        return $p->get();
    }

    /**
     * @param $in
     * @param null $languages_id
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function getSelectedCategories($in, $languages_id = null)
    {
        if( ! $languages_id) $languages_id = $this->languages_id;

        return self::$db->select("
          select c.id, c.parent_id, c.isfolder, c.status, ci.name
          from __content c
          join __content_info ci on ci.content_id=c.id and ci.languages_id='{$languages_id}'
          where c.id in ($in) and c.status = 'published'
          order by abs(c.position) asc
          ")->all();
    }

    /**
     * @param $languages_id
     * @param $types_id
     * @param int $parent_id
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function tree($languages_id, $types_id, $parent_id = 0)
    {
        return self::$db->select("
          select c.id, c.parent_id, c.isfolder, ci.name
          from __content c
          join __content_info ci on ci.content_id=c.id and ci.languages_id={$languages_id}
          where
               c.parent_id = '{$parent_id}'
           and c.types_id = {$types_id}
           and c.status = 'published'
          ")->all();
    }
}