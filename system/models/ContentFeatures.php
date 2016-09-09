<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 03.07.16
 * Time: 0:37
 */

namespace system\models;

class ContentFeatures extends Model
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

    public function save($content_id, $data)
    {
        foreach ($data as $features_id => $a) {
            $fdata = self::$db->select("select type, multiple from __features where id={$features_id} limit 1")->row();
            switch($fdata['type']){
                case 'text':
                case 'textarea':
                    foreach ($a as $languages_id => $value) {
                        $aid = self::$db
                            ->select("select id from __content_features where content_id={$content_id} and features_id={$features_id} and languages_id={$languages_id} limit 1")
                            ->row('id');
                        if(empty($aid)){
                            $this->createRow('__content_features', ['content_id' => $content_id, 'features_id' => $features_id, 'languages_id' => $languages_id, 'value' =>$value]);
                        } else {
                            $this->updateRow('__content_features', $aid, ['value' => $value]);
                        }
                    }
                    break;

                case 'file':
                    $aid = self::$db
                        ->select("select id from __content_features where content_id={$content_id} and features_id={$features_id} and languages_id = 0 limit 1")
                        ->row('id');
                    if(empty($aid)){
                        $this->createRow('__content_features', ['content_id' => $content_id, 'features_id' => $features_id, 'value' => $a]);
                    } else {
                        $this->updateRow('__content_features', $aid, ['value' => $a]);
                    }
                    break;

                case 'number':
                    $aid = self::$db
                        ->select("select id from __content_features where content_id={$content_id} and features_id={$features_id} and languages_id = 0 limit 1")
                        ->row('id');
                    if(empty($aid)){
                        $this->createRow('__content_features', ['content_id' => $content_id, 'features_id' => $features_id, 'value' => $a]);
                    } else {
                        $this->updateRow('__content_features', $aid, ['value' => $a]);
                    }
                    break;

                case 'checkbox':
                    $aid = self::$db
                        ->select("select id from __content_features where content_id={$content_id} and features_id={$features_id} and languages_id = 0 limit 1")
                        ->row('id');
                    if(empty($aid) && $a == 1){
                        $this->createRow('__content_features', ['content_id' => $content_id, 'features_id' => $features_id, 'value' => 1]);
                    } elseif($a == 0 && $aid > 0) {
                        $this->deleteRow('__content_features', $aid);
                    }

                    break;
                case 'select':
                    $selected = self::$db
                        ->select("select values_id from __content_features where content_id={$content_id} and features_id={$features_id} ")
                        ->all('values_id');

                    if($fdata['multiple']){

                        foreach ($a as $i => $values_id) {
                            $aid = self::$db
                                ->select("select id from __content_features where content_id={$content_id} and features_id={$features_id} and values_id={$values_id} limit 1")
                                ->row('id');

                            if(empty($aid)){
                                $this->createRow('__content_features', ['content_id' => $content_id, 'features_id' => $features_id, 'values_id' => $values_id]);
                            }
                            $c = array_search($values_id, $selected);

                            if($c !== FALSE){
                                unset($selected[$c]);
                            }
                        }
                    } else {
                        $aid = self::$db
                            ->select("select id from __content_features where content_id={$content_id} and features_id={$features_id} and values_id={$a} limit 1")
                            ->row('id');

                        if(empty($aid)){
                            $this->createRow('__content_features', ['content_id' => $content_id, 'features_id' => $features_id, 'values_id' => $a]);
                        }

                        $c = array_search($a, $selected);

                        if($c !== FALSE){
                            unset($selected[$c]);
                        }
                    }

                    // видалю невибрані
                    if(!empty($selected)){
                        $in = implode(',', $selected);
                        self::$db->delete
                        (
                            "__content_features",
                            " content_id={$content_id} and features_id={$features_id} and values_id in ($in)"
                        );
                    }

                    break;
            }
        }
    }
}