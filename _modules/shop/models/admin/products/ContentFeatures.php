<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 03.07.16
 * Time: 0:35
 */

namespace modules\shop\models\admin\products;

class ContentFeatures extends \system\models\ContentFeatures
{
    /**
     * @param int $parent_id
     * @param null $content_id
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get($content_id = null, $parent_id = 0)
    {
        $items =
            self::$db->select("
              select f.id, fi.name, f.code,f.type
              from __features f
              join __features_content fc on fc.content_id={$content_id} and fc.features_id=f.id
              join __features_info fi on fi.features_id=f.id and fi.languages_id={$this->languages_id}
              where f.parent_id = {$parent_id}
               and f.type in ('select', 'folder')
               and f.status='published'
              order by fi.name asc
           ")->all();

        foreach ($items as $k=>$item) {

            if($item['type'] == 'folder'){
                $items[$k]['items'] = $this->get($content_id, $item['id']);
            } else{
                $items[$k]['items'] = $this->getValues($item['id']);
            }
        }

        return $items;
    }
    /**
     * @param $parent_id
     * @param int $content_id
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function getValues($parent_id)
    {
        return self::$db->select("
              select f.id, fi.name
              from __features f
              join __features_info fi on fi.features_id=f.id and fi.languages_id={$this->languages_id}
              where f.parent_id = {$parent_id} and f.type = 'value' and f.status='published'
              order by fi.name asc
           ")->all();
    }
}