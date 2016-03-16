<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 15.03.16 : 11:51
 */

namespace models\engine;

use models\Engine;

defined("CPATH") or die();

class ContentFeatures extends Engine
{
    public static function get($content_id)
    {
        $page = self::$db->select("select types_id, subtypes_id from content where id={$content_id} limit 1")->row();

        $languages_id = self::$language_id;

        $res = self::$db
            ->select
            ("
                select f.id, f.type, f.required, f.multiple, fi.name
                from features_content fc
                join features f on f.id=fc.features_id and f.status='published'
                join features_info fi on fi.features_id=f.id and fi.languages_id={$languages_id}
                where
                  fc.content_types_id={$page['types_id']} and
                  fc.content_subtypes_id in (0, {$page['subtypes_id']}) and
                  fc.content_id in (0, {$content_id})
                order by abs(fc.position) asc
            ")
            ->all();

        foreach ($res as $k=>$item) {
            if($item['type'] == 'folder' || $item['type'] == 'select'){
                $res[$k]['items'] = self::getFeatures($item['id'], $content_id);
            } elseif($item['type'] == 'checkbox'){
                $res[$k]['checked'] = self::isChecked($item['id'], $content_id);
            }  else {
                $res[$k]['values'] = self::getContentFeaturesValues($item['id'], $content_id);
            }
        }

        return $res;
    }

    /**
     * @param $parent_id
     * @return mixed
     */
    private static function getFeatures($parent_id, $content_id)
    {
        $languages_id = self::$language_id;

        $res = self::$db
            ->select
            ("
                select f.id, f.type, f.multiple, fi.name
                from features f
                join features_info fi on fi.features_id=f.id and fi.languages_id={$languages_id}
                where f.parent_id={$parent_id} and f.status='published'
            ")
            ->all();

        foreach ($res as $k=>$item) {
            if($item['type'] == 'folder' || $item['type'] == 'select'){
                $res[$k]['items'] = self::getFeatures($item['id'], $content_id);
            } elseif($item['type'] == 'value'){
                $res[$k]['selected'] = self::isSelectedValue($item['id'], $content_id);
            } elseif($item['type'] == 'checkbox'){
                $res[$k]['checked'] = self::isChecked($item['id'], $content_id);
            } else {
                $res[$k]['values'] = self::getContentFeaturesValues($item['id'], $content_id);
            }
        }

        return $res;
    }

    private static function getContentFeaturesValues($features_id, $content_id)
    {
        $res = [];
        $a = self::$db
            ->select("select languages_id, value from content_features where content_id={$content_id} and features_id={$features_id}")
            ->all();
        foreach ($a as $item) {
            $res[$item['languages_id']] = $item['value'];
        }
        return $res;
    }

    /**
     * @param $values_id
     * @param $content_id
     * @return mixed
     */
    private static function isSelectedValue($values_id, $content_id)
    {
        return self::$db
            ->select("select id from content_features where content_id={$content_id} and values_id = {$values_id} limit 1")
            ->row('id') > 0;
    }

    /**
     * @param $values_id
     * @param $content_id
     * @return mixed
     */
    private static function isChecked($features_id, $content_id)
    {
        return self::$db
            ->select("select id from content_features where content_id={$content_id} and features_id = {$features_id} limit 1")
            ->row('id') > 0;
    }

    public function getFeaturesTypes()
    {
        $data = self::$db->enumValues('features', 'type');

        foreach ($data as $k => $type) {
            if ($type == 'value') {
                unset($data[$k]);
            }
        }

        return $data;
    }

    public function create()
    {
        $data = $this->request->post('data');
        $info = $this->request->post('info');
        $content_id = $this->request->post('content_id');
        $page_only  = $this->request->post('page_only');

        $this->beginTransaction();

        $data['owner_id'] = $this->admin['id'];

        if(!isset($data['code']) || empty($data['code'])){
            $data['code'] = md5($this->admin['id'] . 'x' . microtime());
        }

        $id = $this->createRow('features', $data);

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        foreach ($info as $languages_id=> $item) {
            $item['languages_id']    = $languages_id;
            $item['features_id']     = $id;
            $this->createRow('features_info', $item);
        }

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        $page = self::$db->select("select types_id, subtypes_id from content where id={$content_id} limit 1")->row();

        $this->createRow
        (
            'features_content',
            [
                'features_id'          => $id,
                'content_types_id'     => $page['types_id'],
                'content_subtypes_id'  => $page['subtypes_id'],
                'content_id'           => $page_only == 1 ? $content_id : 0
            ]
        );

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        $this->commit();

        return $id;
    }

    public function createValue()
    {
        $data = $this->request->post('data');
        $info = $this->request->post('info');

        $this->beginTransaction();

        $data['owner_id'] = $this->admin['id'];

        if(!isset($data['code']) || empty($data['code'])){
            $data['code'] = md5($this->admin['id'] . 'x' . microtime());
        }

        $id = $this->createRow('features', $data);

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        foreach ($info as $languages_id=> $item) {
            $item['languages_id']    = $languages_id;
            $item['features_id']     = $id;
            $this->createRow('features_info', $item);
        }

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        $this->commit();

        return $id;
    }

    /**
     * @param $content_id
     */
    public function save($content_id)
    {
        foreach ($_POST['content_features'] as $features_id => $a) {
            $fdata = self::$db->select("select type, multiple from features where id={$features_id} limit 1")->row();
            switch($fdata['type']){
                case 'text':
                case 'textarea':
                    foreach ($a as $languages_id => $value) {
                        $aid = self::$db
                            ->select("select id from content_features where content_id={$content_id} and features_id={$features_id} and languages_id={$languages_id} limit 1")
                            ->row('id');
                        if(empty($aid)){
                            $this->createRow('content_features', ['content_id' => $content_id, 'features_id' => $features_id, 'languages_id' => $languages_id, 'value' =>$value]);
                        } else {
                            $this->updateRow('content_features', $aid, ['value' => $value]);
                        }
                    }
                    break;

                case 'file':
                    $aid = self::$db
                        ->select("select id from content_features where content_id={$content_id} and features_id={$features_id} and languages_id = 0 limit 1")
                        ->row('id');
                    if(empty($aid)){
                        $this->createRow('content_features', ['content_id' => $content_id, 'features_id' => $features_id, 'value' => $a]);
                    } else {
                        $this->updateRow('content_features', $aid, ['value' => $a]);
                    }
                    break;

                case 'number':
                    $aid = self::$db
                        ->select("select id from content_features where content_id={$content_id} and features_id={$features_id} and languages_id = 0 limit 1")
                        ->row('id');
                    if(empty($aid)){
                        $this->createRow('content_features', ['content_id' => $content_id, 'features_id' => $features_id, 'value' => $a]);
                    } else {
                        $this->updateRow('content_features', $aid, ['value' => $a]);
                    }
                    break;

                case 'checkbox':
                    $aid = self::$db
                        ->select("select id from content_features where content_id={$content_id} and features_id={$features_id} and languages_id = 0 limit 1")
                        ->row('id');
                    if(empty($aid) && $a == 1){
                        $this->createRow('content_features', ['content_id' => $content_id, 'features_id' => $features_id, 'value' => 1]);
                    } elseif($a == 0 && $aid > 0) {
                        $this->deleteRow('content_features', $aid);
                    }

                    break;
                case 'select':
                    $selected = self::$db
                        ->select("select values_id from content_features where content_id={$content_id} and features_id={$features_id} ")
                        ->all('values_id');

                    if($fdata['multiple']){

                        foreach ($a as $i => $values_id) {
                            $aid = self::$db
                                ->select("select id from content_features where content_id={$content_id} and features_id={$features_id} and values_id={$values_id} limit 1")
                                ->row('id');

                            if(empty($aid)){
                                $this->createRow('content_features', ['content_id' => $content_id, 'features_id' => $features_id, 'values_id' => $values_id]);
                            }
                            $c = array_search($values_id, $selected);

                            if($c !== FALSE){
                                unset($selected[$c]);
                            }
                        }
                    } else {
                        $aid = self::$db
                            ->select("select id from content_features where content_id={$content_id} and features_id={$features_id} and values_id={$a} limit 1")
                            ->row('id');

                        if(empty($aid)){
                            $this->createRow('content_features', ['content_id' => $content_id, 'features_id' => $features_id, 'values_id' => $a]);
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
                            "content_features",
                            " content_id={$content_id} and features_id={$features_id} and values_id in ($in)"
                        );
                    }

                    break;
            }
        }
    }
}