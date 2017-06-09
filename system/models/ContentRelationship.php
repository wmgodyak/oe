<?php
namespace system\models;
use system\core\exceptions\Exception;

/**
 * Class ContentRelationship
 * @package system\models
 */
class ContentRelationship extends Frontend
{
    /**
     * @param $content_id
     * @param $categories_id
     * @param int $is_main
     * @param null $type
     * @return bool|string
     */
    public function create($content_id, $categories_id, $is_main = 0, $type = null)
    {
        return $this->createRow
        (
            '__content_relationship',
            [
                'content_id'    => $content_id,
                'categories_id' => $categories_id,
                'is_main'       => $is_main,
                'type'          => $type
            ]
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
     * @param null $type
     * @return array|mixed
     * @throws Exception
     */
    public function getCategoriesFull($content_id, $is_main = 0, $type = null)
    {
        $limit = $is_main ? "limit 1" : "";
        $w = $type ? " and cr.type='{$type}'" : '';
        $r = self::$db
            ->select("
                select cr.categories_id as id, ci.name
                from __content_relationship cr
                join __content_info ci on ci.content_id = cr.categories_id and ci.languages_id='{$this->languages->id}'
                where cr.content_id={$content_id} and cr.is_main={$is_main} {$w}
                {$limit}
                ");

        return $is_main ? $r->row() : $r->all();
    }

    /**
     * @param $content_id
     * @param null $is_main
     * @param null $type
     * @return mixed
     * @throws Exception
     */
    public function getCategories($content_id, $is_main = null, $type = null)
    {
        $w = $is_main !== null ? "and is_main={$is_main}" : null;
        $w .= $type ? " and type='{$type}'" : '';
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
            " content_id={$content_id} and is_main = 1 "
        );
    }

    /**
     * @param $content_id
     * @param null $categories_id
     * @param null $type
     * @return bool
     * @throws Exception
     */
    public function saveMainCategory($content_id, $categories_id = null, $type = null)
    {
        if(! $categories_id){
            $categories_id = $this->request->post('main_categories_id', 'i');
        }

        if($content_id > 0 && $categories_id > 0) {

            self::$db->delete
            (
                '__content_relationship',
                " content_id={$content_id} and is_main = 1 limit 1"
            );

            $this->create($content_id, $categories_id, 1, $type);
        }

        return ! $this->hasError();
    }

    /**
     * @param $content_id
     * @param null $categories
     * @param null $type
     * @return bool
     */
    public function saveContentCategories($content_id, $categories = null, $type = null)
    {
        if( !$categories){
            $categories = $this->request->post('categories');
        }

        $selected = $this->getCategories($content_id, 0, $type);

        if($categories){
            foreach ($categories as $k=>$categories_id) {

                $c = array_search($categories_id, $selected);

                if($c !== FALSE){
                    unset($selected[$c]);
                    continue;
                }

                $this->create($content_id, $categories_id, 0, $type);
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