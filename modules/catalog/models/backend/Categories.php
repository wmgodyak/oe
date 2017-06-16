<?php

namespace modules\catalog\models\backend;

use system\models\Content;

/**
 * Class Categories
 * @package modules\catalog\models\backend
 */
class Categories extends Content
{
    public function getChildrensId($parent_id)
    {
        $in = [];
        foreach (self::$db->select("select id, isfolder from __content where parent_id={$parent_id}")->all() as $item)
        {
            $in[] = $item['id'];
            if($item['isfolder']){
                $in = array_merge($in, $this->getChildrensId($item['id']));
            }
        }
        return $in;
    }

    public function isFolder($id)
    {
        return self::$db->select("select isfolder from __content where id={$id} limit 1")->row('isfolder') > 0;
    }
}