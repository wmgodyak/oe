<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 12.06.16
 * Time: 0:34
 */

namespace system\models;

use system\components\contentFeatures\models\ContentFeatures;
use system\core\exceptions\Exception;

if ( !defined("CPATH") ) die();

class Content extends Frontend
{
    /**
     * content_type_id
     * @var int
     */
    protected $type;
    public    $types_id;
    public    $subtypes_id;
//    protected $languages;
    public $meta;

    /**
     * Content constructor.
     * @param $type
     */
    public function __construct($type = null)
    {
        parent::__construct();

        if($type){
            $this->setTypeAndSubtype($type);
        }

        $languages = new Languages();
        $this->languages = $languages->get();
        $this->meta = new ContentMeta();
    }

    private function setTypeAndSubtype($type)
    {
        $this->type = $type;

        $type = self::$db
            ->select("select id, isfolder from __content_types where parent_id=0 and type='{$type}' limit 1")
            ->row();

        if(empty($type)){
            throw new \Exception('Невірний тип контенту');
        }

        $this->types_id    = $type['id'];
        $this->subtypes_id = $type['id'];
    }

    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key= '*')
    {
        $d = self::$db->select("select {$key} from __content where id='{$id}' limit 1")->row($key);

        if(empty($d)) return null;

        if($key != '*') {
            return $d;
        }

        $d['type'] = $this->getContentType($id);

        if(!empty($d['settings'])){
            $d['settings'] = unserialize($d['settings']);
        }

        if(empty($d['published'])){
            $d['published'] = date('d.m.Y');
        } else {
            $d['published'] = date('d.m.Y', strtotime($d['published']));
        }

        $d['statuses'] = $this->getStatus();

        foreach ($d['statuses'] as $k=>$s) {
            if($s == 'blank') unset($d['statuses'][$k]);
            elseif($s == 'deleted') unset($d['statuses'][$k]);
        }

        $d['owners'] = $this->getOwners();

        $d['info']   = $this->getInfo($id);

//        $d['meta'] = $this->meta->get($id);

        if($d['parent_id'] > 0){
            $d['parent_url'] = $this->getParentUrl($d['parent_id']);
        }

        $d['settings']['type'] = $this->getTypeSettings($d['types_id']);

        // todo тимчасово закоментував features
        $s = isset($d['settings']['type']['features']) ? $d['settings']['type']['features'] : null;
        $d['features'] = ContentFeatures::get($id, $s);


        return $d;
    }

    public function getParents($id)
    {
        $res = [];
        $cat = self::$db
            ->select("
                select c.id, i.name, c.parent_id
                from __content c
                join __content_info i on i.content_id=c.id
                where c.id={$id} limit 1
            ")
            ->row();

        if($cat['parent_id'] > 0){
            $res = array_merge($res, $this->getParents($cat['parent_id']));
        }

        $res[] = $cat;

        return $res;
    }

    private function getTypeSettings($id)
    {
        $s = self::$db->select("select settings from __content_types where id={$id} limit 1")->row('settings');
        if(empty($s)) return null;

        return unserialize($s);
    }

    private function getInfo($content_id)
    {
        $info = [];

        foreach ($this->languages as $language) {
            $info[$language['id']] = self::$db
                ->select("select * from __content_info where content_id={$content_id} and languages_id={$language['id']} limit 1")
                ->row();
        }

        return $info;
    }
    private function getParentUrl($content_id)
    {
        $info = [];

        foreach ($this->languages as $language) {
            $info[$language['id']] = self::$db
                ->select("select url from __content_info where content_id={$content_id} and languages_id={$language['id']} limit 1")
                ->row('url');
        }

        return $info;
    }

    /**
     * @param $parent_id
     * @param $owner_id
     * @return bool|string
     */
    public function create($parent_id, $owner_id)
    {
        // delete blank records
        self::$db->delete("__content", "owner_id={$owner_id} and status = 'blank'");

        // create record
        return parent::createRow(
            '__content',
            [
                'parent_id'    => $parent_id,
                'types_id'     => $this->types_id,
                'subtypes_id'  => $this->subtypes_id,
                'owner_id'     => $owner_id
            ]
        );
    }

    /**
     * @param $id
     * @return bool
     * @throws \Exception
     */
    public function update($id)
    {
        $content = $this->request->post('content');
        if(isset($content['settings'])) {
            $content['settings'] = serialize($content['settings']);
        } else{
            $content['settings'] = null;
        }

        $info = $this->request->post('content_info');

//        FormValidation::setRule(['name', 'url'], FormValidation::REQUIRED);
//
//        foreach($info as $languages_id => $data){
//            FormValidation::run($data);
//        }
//
//        if(FormValidation::hasErrors()){
//            $this->error = FormValidation::getErrors();
//            return false;
//        }

        foreach ($info as $languages_id=> $item) {
            if(empty($item['name'])){
                $this->error[] = ["content_info[$languages_id][name]" => 'field_required'];
            }

            if( $this->settings->get('home_id') != $id && empty($item['url'])){
                $this->error[] = ["content_info[$languages_id][url]" => 'field_required'];
            }

        }

        if(!empty($this->error)) {
            return false;
        }

        $this->beginTransaction();

        if(!empty($content['published'])){
            $content['published'] = date('Y-m-d', strtotime($content['published']));
        } else {
            $content['published'] = date('Y-m-d');
        }

        $content['updated'] = $this->now();
        $this->updateRow('__content', $id, $content);

        if($this->hasError()){
            $this->rollback();
            $this->error = $this->getErrorMessage();
            return false;
        }

        foreach($info as $languages_id => $data){

            if($this->settings->get('home_id') == $id){
                $data['url'] = '';
            }

            $aid = self::$db
                ->select("select id from __content_info where content_id={$id} and languages_id={$languages_id} limit 1")
                ->row('id');

            if($aid > 0) {
                // update
                self::$db->update('__content_info', $data, "id={$aid} limit 1");
            } else {
                // insert
                $data['content_id']   = $id;
                $data['languages_id'] = $languages_id;
                self::$db->insert('__content_info', $data);
            }

            if($this->hasError()){
                $this->rollback();

                return false;
            }
        }

        if(isset($content['parent_id']) && $content['parent_id'] > 0){
            $this->updateRow('__content', $content['parent_id'], ['isfolder' => 1]);
        }

        // content_meta
        $this->updateMeta($id);

        // todo modify contentFeatures

        $cf = new ContentFeatures();
        $cf->save($id);

        if($this->hasError()){
            $this->rollback();

            return false;
        }

        $this->commit();

        return true;
    }

    /**
     * @param $content_id
     */
    private function updateMeta($content_id)
    {
        $cm = $this->request->post('content_meta');
        if($cm){
            foreach ($cm as $meta_k => $a) {
                if(is_array($a)){
//                    foreach ($a as $k=>$meta_v) {
//                       todo треба подумати
//                    }
                } else {
                    $this->meta->update($content_id, $meta_k, $a);
                }
            }
        }
    }

    public function delete($id)
    {
        $isfolder  = $this->getData($id, 'isfolder');
        if($isfolder) {
            $this->setError("Item is folder. Cannot delete.");
            return false;
        }

        $parent_id = $this->getData($id, 'parent_id');

        $s = parent::updateRow('__content', $id, ['status' => 'deleted']);
//
        if($s > 0 && $parent_id > 0){
            $t = self::$db
                ->select("select count(id) as t from __content where parent_id = {$parent_id} and status in ('hidden', 'published')")
                ->row('t');

            if($t == 0){
                parent::updateRow('__content', $parent_id, ['isfolder' => 0]);
            }
        }

        return true;
    }

    /**
     * @param $id
     * @return bool
     */
    public function pub($id)
    {
        return $this->updateRow('__content', $id, ['status' => 'published']);
    }

    /**
     * @param $id
     * @return bool
     */
    public function hide($id)
    {
        return $this->updateRow('__content', $id, ['status' => 'hidden']);
    }

    public function getStatus()
    {
        return self::$db->enumValues('__content', 'status');
    }

    public function getOwners()
    {
        return self::$db
            ->select("select u.id, u.name, u.surname from __users u, __users_group ug where u.group_id=ug.id and ug.backend=1")
            ->all();
    }

    /**
     * drag & drop
     * @param $id
     * @param $old_parent
     * @param $parent
     * @param $position
     */
    public function move($id, $old_parent, $parent, $position)
    {
        $this->beginTransaction();

        $s = self::$db->update('__content', ['parent_id' => $parent, 'position' => $position], "id={$id} limit 1");

        if($s > 0){
            self::$db->update('__content', ['isfolder' => 1], "id={$parent} limit 1");
        }

        if($s > 0 && $old_parent > 0){
            $c = self::$db->select("select count(id) as t from __content where parent_id={$old_parent}")->row('t');
            if($c == 0){
                self::$db->update('__content', ['isfolder' => 0], "id={$old_parent} limit 1");
            }
        }

        if($this->hasError()){
            $this->rollback();
        } else {
            $this->commit();
        }
    }

    public function getSubtypes($types_id)
    {
        $res = [['id' => $types_id, 'name' => 'Default']];
        $r = self::$db->select("select id, name from __content_types where parent_id={$types_id}")->all();
        $res = array_merge($res, $r);
        return $res;
    }

    public function getContentType($content_id)
    {
        return self::$db->select("
          select ct.type
          from __content c
           join __content_types ct on ct.id=c.types_id
          where c.id='{$content_id}' limit 1
          ")->row('type');
    }

    /**
     * @param int $parent_id
     * @param null $type
     * @return mixed
     * @throws Exception
     */
    public function tree($parent_id = 0, $type = null)
    {
        if(! $type) $type = $this->type;

        return self::$db->select("
          select c.id, c.isfolder, c.status, ci.name as text
          from __content c
          join __content_types ct on ct.type = '{$type}' and ct.id=c.types_id
          join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
          where c.parent_id='{$parent_id}' and c.status in ('published', 'hidden')
          order by abs(c.position) asc, abs(c.id) asc
          ")->all();
    }

    public function getSubcategoriesId($parent_id)
    {
        $in = [];

        $r = self::$db->select("select id, isfolder from __content where parent_id={$parent_id} and status='published'")->all();

        foreach ($r as $item) {
            $in[] = $item['id'];
            if($item['isfolder']){
                $in = array_merge($in, $this->getSubcategoriesId($item['id']));
            }
        }

        return $in;
    }
}