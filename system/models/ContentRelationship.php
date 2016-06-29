<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 24.06.16
 * Time: 21:19
 */

namespace system\models;

class ContentRelationship extends Model
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

    public function getMainCategoriesId($content_id)
    {
        return self::$db
            ->select("select categories_id from __content_relationship where content_id={$content_id} and is_main = 1 ")
            ->row('categories_id');
    }

    public function deleteMainCategories($content_id)
    {
        return self::$db->delete
        (
            '__content_relationship',
            " content_id={$content_id} and is_main=1"
        );
    }

    /**
     * @param $content_id
     */
    public function saveContentCategories($content_id)
    {
        $categories = $this->request->post('categories');
        $selected = $this->getCategories($content_id);
        if($categories){
            foreach ($categories as $k=>$categories_id) {

                $c = array_search($categories_id, $selected);

                if($c !== FALSE){
                    unset($selected[$c]);
                    continue;
                }

                $this->create($content_id, $categories_id);
            }
        }

        if(!empty($selected)){
            foreach ($selected as $k=>$categories_id) {
                $this->delete($content_id, $categories_id);
            }
        }
    }
}