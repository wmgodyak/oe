<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 05.02.16 : 16:42
 */

namespace models\engine;

use controllers\core\exceptions\DbException;
use helpers\FormValidation;
use models\Engine;

defined("CPATH") or die();

/**
 * Class ContentTypes
 * @package models\engine
 */
class Content extends Engine
{
    /**
     * content_type_id
     * @var int
     */
    protected $type;
    protected $types_id;
    protected $subtypes_id;

    /**
     * Content constructor.
     * @param $type
     */
    public function __construct($type)
    {
        $this->type = $type;

        $this->setTypeAndSubtype($type);

        parent::__construct();
    }

    private function setTypeAndSubtype($type)
    {
        $type = self::$db
            ->select("select id, isfolder from content_types where parent_id=0 and type='{$type}' limit 1")
            ->row();
        if(empty($type)){
            throw new \Exception('Невірний тип контенту');
        }

        $this->types_id = $type['id'];

        if($type['isfolder'] == 0){
            $this->subtypes_id = $type['id'];
        } else {
            $subtype = self::$db
                ->select("select id, isfolder from content_types where parent_id='{$type['id']}' and is_main=1 limit 1")
                ->row();

            if(empty($subtype)){
                $this->subtypes_id = $type['id'];
            }
        }

        if(empty($this->subtypes_id)){
            throw new DbException("SubtypesID cannot be empty");
        }
    }

    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key= '*')
    {
        $d = self::$db->select("select {$key} from content where id={$id} limit 1")->row($key);

        if($key != '*') {
            return $d;
        }

        if(empty($d['published'])){
            $d['published'] = date('d.m.Y');
        } else{
            $d['published'] = date('d.m.Y', strtotime($d['published']));
        }

        $d['statuses'] = $this->getStatus();

        foreach ($d['statuses'] as $k=>$s) {
            if($s == 'blank') unset($d['statuses'][$k]);
            elseif($s == 'deleted') unset($d['statuses'][$k]);
        }

        $d['owners'] = $this->getOwners();

        $d['info']   = $this->getInfo($id);

        // features

        $d['features'] = ContentFeatures::get($id);

        return $d;
    }

    private function getInfo($content_id)
    {
        $info = [];

        foreach ($this->languages as $language) {
            $info[$language['id']] = self::$db
                ->select("select * from content_info where content_id={$content_id} and languages_id={$language['id']} limit 1")
                ->row();
        }

        return $info;
    }

    /**
     * @param $parent_id
     * @return bool|string
     */
    public function create($parent_id)
    {
        // delete blank records
        self::$db->delete("content", "owner_id={$this->admin['id']} and status = 'blank'");

        // create record
        return parent::createRow(
            'content',
            [
                'parent_id'    => $parent_id,
                'types_id'     => $this->types_id,
                'subtypes_id'  => $this->subtypes_id,
                'owner_id'     => $this->admin['id']
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
        $info = $this->request->post('content_info');

        FormValidation::setRule(['name', 'url'], FormValidation::REQUIRED);

        foreach($info as $languages_id => $data){
            FormValidation::run($data);
        }

        if(FormValidation::hasErrors()){
            $this->error = FormValidation::getErrors();
            return false;
        }

        $this->beginTransaction();

        $content['published'] = date('Y-m-d', strtotime($content['published']));
        $this->updateRow('content', $id, $content);

        if($this->hasDBError()){
            $this->rollback();
            $this->error = $this->getDBErrorMessage();
            return false;
        }

        foreach($info as $languages_id => $data){
            $aid = self::$db
                ->select("select id from content_info where content_id={$id} and languages_id={$languages_id} limit 1")
            ->row('id');

            if($aid > 0) {
                // update
                self::$db->update('content_info', $data, "id={$aid} limit 1");
            } else {
                // insert
                $data['content_id']   = $id;
                $data['languages_id'] = $languages_id;
                self::$db->insert('content_info', $data);
            }

            if($this->hasDBError()){
                $this->rollback();

                return false;
            }
        }

        if($content['parent_id'] > 0){
            $this->updateRow('content', $content['parent_id'], ['isfolder' => 1]);
        }

        // contentFeatures

        $cf = new ContentFeatures();
        $cf->save($id);

        if($this->hasDBError()){
            $this->rollback();

            return false;
        }

        $this->commit();

        return true;
    }

    public function delete($id)
    {
        $isfolder  = $this->getData($id, 'isfolder');
        if($isfolder) {
            $this->error = "Item is folder. Cannot delete.";
            return false;
        }

        $parent_id = $this->getData($id, 'parent_id');

//
        $s = parent::updateRow('content', $id, ['status' => 'deleted']);
//
        if($s > 0 && $parent_id > 0){
            $t = self::$db
                ->select("select count(id) as t from content where parent_id = {$parent_id} and status in ('hidden', 'published')")
                ->row('t');

            if($t == 0){
                parent::updateRow('content', $parent_id, ['isfolder' => 0]);
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
        return $this->updateRow('content', $id, ['status' => 'published']);
    }

    /**
     * @param $id
     * @return bool
     */
    public function hide($id)
    {
        return $this->updateRow('content', $id, ['status' => 'hidden']);
    }

    public function getStatus()
    {
        return self::$db->enumValues('content', 'status');
    }

    public function getOwners()
    {
        return self::$db
            ->select("select u.id, u.name, u.surname from users u, users_group ug where u.group_id=ug.id and ug.rang > 100")
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

        $s = self::$db->update('content', ['parent_id' => $parent, 'position' => $position], "id={$id} limit 1");

        if($s > 0){
            self::$db->update('content', ['isfolder' => 1], "id={$parent} limit 1");
        }

        if($s > 0 && $old_parent > 0){
            $c = self::$db->select("select count(id) as t from content where parent_id={$old_parent}")->row('t');
            if($c == 0){
                self::$db->update('content', ['isfolder' => 0], "id={$old_parent} limit 1");
            }
        }

        if($this->hasDBError()){
            $this->rollback();
        } else {
            $this->commit();
        }
    }
}