<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 18.03.16 : 10:38
 */

namespace models\engine;

use models\Engine;

defined("CPATH") or die();

/**
 * Class ContentRelationship
 * @package models\engine
 */
class ContentRelationship extends Engine
{
    /**
     * @param $content_id
     * @param $categories_id
     * @param int $is_main
     * @return bool|string
     */
    public function create($content_id, $categories_id, $is_main = 0)
    {
        return $this->createRow
        (
            '__content_relationship',
            ['content_id' => $content_id, 'categories_id' => $categories_id, 'is_main' => $is_main]
        );
    }

    /**
     * @param $content_id
     * @param $categories_id
     * @return int
     */
    public function delete($content_id, $categories_id)
    {
        return self::$db->delete
        (
            '__content_relationship',
            " content_id={$content_id} and categories_id={$categories_id} limit 1"
        );
    }

    /**
     * @param $content_id
     * @return mixed
     */
    public function getCategories($content_id)
    {
        return self::$db
            ->select("select categories_id from __content_relationship where content_id={$content_id} and is_main=0")
            ->all('categories_id');
    }

    public function getMainCategoryId($content_id)
    {
        return self::$db
            ->select("select categories_id from __content_relationship where content_id={$content_id} and is_main = 1 ")
            ->row('categories_id');
    }

    public function clearMainCategory($content_id)
    {
        return self::$db->delete
        (
            '__content_relationship',
            " content_id={$content_id} and is_main=1 limit 1"
        );
    }


}