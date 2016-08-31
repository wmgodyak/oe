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
     * @param int $is_main
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function getCategoriesFull($content_id, $is_main = 0)
    {
        $limit = $is_main ? "limit 1" : "";
        $r = self::$db
            ->select("
                select cr.categories_id as id, ci.name
                from __content_relationship cr
                join __content_info ci on ci.content_id = cr.categories_id and ci.languages_id='{$this->languages_id}'
                where cr.content_id={$content_id} and cr.is_main={$is_main}
                {$limit}
                ");

        return $is_main ? $r->row() : $r->all();
    }

    /**
     * @param $content_id
     * @param null $is_main
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function getCategories($content_id, $is_main = null)
    {
        $w = $is_main ? "and is_main={$is_main}" : null;
        return self::$db
            ->select("select categories_id from __content_relationship where content_id={$content_id} {$w}")
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
     * @param null $categories_id
     * @throws \system\core\exceptions\Exception
     */
    public function saveMainCategory($content_id, $categories_id = null)
    {
        self::$db->delete
        (
            '__content_relationship',
            " content_id={$content_id} and is_main = 1 limit 1"
        );

        if(!$categories_id){
            $categories_id = $this->request->post('main_categories_id', 'i');
        }

        if($categories_id){
            $this->create($content_id, $categories_id, 1);
        }

        return ! $this->hasError();
    }

    /**
     * @param $content_id
     * @param null $categories
     * @return bool
     */
    public function saveContentCategories($content_id, $categories = null)
    {
        if( !$categories){
            $categories = $this->request->post('categories');
        }
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

        return ! $this->hasError();
    }
}