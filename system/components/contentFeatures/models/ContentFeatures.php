<?php

namespace system\components\contentFeatures\models;

use system\core\Languages;
use system\models\Backend;

/**
 * Class ContentFeatures
 * @package system\components\contentFeatures\models
 */
class ContentFeatures extends Backend
{

    public function getByCategoryId($category_id, $content_id)
    {
        $page = self::$db->select("select types_id, subtypes_id from __content where id={$category_id} limit 1")->row();
        $res = self::$db
            ->select
            ("
                select f.id, f.type, f.required, f.multiple, fi.name
                from __features_content fc
                join __features f on f.id=fc.features_id and f.status='published'
                join __features_info fi on fi.features_id=f.id and fi.languages_id={$this->languages->id}
                where
                  fc.content_types_id={$page['types_id']} and
                  fc.content_subtypes_id in (0, {$page['subtypes_id']}) and
                  fc.content_id in (0, {$category_id})
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
     * @param $content_id
     * @param null $settings
     * @return mixed
     */
    public static function get($content_id, $settings = null)
    {
//        echo '<pre>'; print_r($settings);die;
        $ex_content_id = $content_id;

        $page = [];

        if(isset($settings['ex_types_id']) && !empty($settings['ex_types_id'])){
            $page['types_id'] = $settings['ex_types_id'];
            $page['subtypes_id'] = $settings['ex_types_id'];

            // get main category
            $cat_id = self::$db
                ->select("select categories_id from __content_relationship where content_id={$content_id} and is_main=1")
                ->row('categories_id');
            if(!empty($cat_id)) $ex_content_id = $cat_id;

        } else {
            $page = self::$db->select("select types_id, subtypes_id from __content where id={$content_id} limit 1")->row();
        }

        $languages_id = Languages::getInstance()->id;

        $res = self::$db
            ->select
            ("
                select f.id, f.type, f.required, f.multiple, fi.name, f.code
                from __features_content fc
                join __features f on f.id=fc.features_id and f.status='published' and f.parent_id=0
                join __features_info fi on fi.features_id=f.id and fi.languages_id={$languages_id}
                where
                  fc.content_types_id={$page['types_id']} and
                  fc.content_subtypes_id in (0, {$page['subtypes_id']}) and
                  fc.content_id in (0, {$ex_content_id})
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
     * @param $content_id
     * @return mixed
     */
    private static function getFeatures($parent_id, $content_id)
    {
        $languages_id = Languages::getInstance()->id;

        $res = self::$db
            ->select
            ("
                select f.id, f.type, f.multiple, fi.name
                from __features f
                join __features_info fi on fi.features_id=f.id and fi.languages_id={$languages_id}
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

    /**
     * @param $features_id
     * @param $content_id
     * @return array
     */
    private static function getContentFeaturesValues($features_id, $content_id)
    {
        $res = [];
        $a = self::$db
            ->select("select languages_id, value from __content_features where content_id={$content_id} and features_id={$features_id}")
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
            ->select("select id from __content_features where content_id={$content_id} and values_id = {$values_id} limit 1")
            ->row('id') > 0;
    }

    /**
     * @param $features_id
     * @param $content_id
     * @return bool
     * @throws \system\core\exceptions\Exception
     */
    private static function isChecked($features_id, $content_id)
    {
        return self::$db
            ->select("select id from __content_features where content_id={$content_id} and features_id = {$features_id} limit 1")
            ->row('id') > 0;
    }

    public function getFeaturesTypes($allowed = null)
    {
        $data = self::$db->enumValues('__features', 'type');

        foreach ($data as $k => $type) {
            if ($type == 'value' || ($allowed && !in_array($type, $allowed))) {
                unset($data[$k]);
            }
        }

        return $data;
    }

    private function getTypeSettings($id)
    {
        $s = self::$db->select("select settings from __content_types where id={$id} limit 1")->row('settings');
        if(empty($s)) return null;

        return unserialize($s);
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

        $id = $this->createRow('__features', $data);

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        foreach ($info as $languages_id=> $item) {
            $item['languages_id']    = $languages_id;
            $item['features_id']     = $id;
            $this->createRow('__features_info', $item);
        }

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        $page = self::$db->select("select types_id, subtypes_id from __content where id={$content_id} limit 1")->row();

        $ts = $this->getTypeSettings($page['types_id']);

        if(isset($ts['features']['ex_types_id']) && !empty($ts['features']['ex_types_id'])){

            $page['types_id']    = $ts['features']['ex_types_id'];
            $page['subtypes_id'] = $ts['features']['ex_types_id'];

            // get main category
            $cat_id = self::$db
                ->select("select categories_id from __content_relationship where content_id={$content_id} and is_main=1")
                ->row('categories_id');

            if(!empty($cat_id)){
                $page_only = 1;
                $content_id = $cat_id;
            }
        }

        $this->createRow
        (
            '__features_content',
            [
                'features_id'          => $id,
                'content_types_id'     => $page['types_id'],
                'content_subtypes_id'  => $page['subtypes_id'],
                'content_id'           => $page_only == 1 ? $content_id : 0
            ]
        );

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        $this->commit();

        return $id;
    }

    /**
     * todo deprecated
     * @deprecated
     * @return bool|string
     */
    public function createValue()
    {
        $data = $this->request->post('data');
        $info = $this->request->post('info');

        $this->beginTransaction();

        $data['owner_id'] = $this->admin['id'];

        if(!isset($data['code']) || empty($data['code'])){
            $data['code'] = md5($this->admin['id'] . 'x' . microtime());
        }

        $id = $this->createRow('__features', $data);

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        foreach ($info as $languages_id=> $item) {
            $item['languages_id']    = $languages_id;
            $item['features_id']     = $id;
            $this->createRow('__features_info', $item);
        }

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        if($this->hasError()){
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
        if(!isset($_POST['content_features'])) return ;

        foreach ($_POST['content_features'] as $features_id => $a) {
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
                case 'image':
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
                            "content_features",
                            " content_id={$content_id} and features_id={$features_id} and values_id in ($in)"
                        );
                    }

                    break;
            }
        }
    }
}