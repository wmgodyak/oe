<?php

namespace system\models;
/**
 * Class UsersGroup
 * @package system\models
 */
class UsersGroup extends Backend
{
    /**
     * @param $data
     * @param $info
     * @return bool|string
     */
    public function create($data, $info)
    {
        $this->beginTransaction();

        $group_id = self::$db->insert("__users_group", $data);
        if($group_id > 0){
            foreach ($info as $languages_id => $in) {
                $in['languages_id'] = $languages_id;
                $in['group_id']     = $group_id;
                self::$db->insert("__users_group_info", $in);
            }

            if(! $this->hasError()){
                if($data['parent_id'] > 0){
                    self::$db->update('__users_group', ['isfolder' => 1], "id={$data['parent_id']} limit 1");
                }
            }
        }

        if(! $this->hasError()){
            $this->setPermissions($group_id);
        }

        if($this->hasError()){
            $this->rollback();
        } else {
            $this->commit();
        }

        return $group_id;
    }

    /**
     * @param $id
     * @param $data
     * @param $info
     * @return bool
     */
    public function update($id, $data, $info)
    {
        $this->beginTransaction();

        self::$db->update("__users_group", $data, "id={$id} limit 1");

        if(! $this->hasError()) {
            foreach ($info as $languages_id => $in) {
                $aid = self::$db->select("select id from __users_group_info where group_id={$id} and languages_id={$languages_id} limit 1")->row('id');
                if($aid>0){
                    self::$db->update("__users_group_info", $in, " id={$aid} limit 1");
                } else {
                    $in['languages_id'] = $languages_id;
                    $in['group_id']     = $id;
                    self::$db->insert("__users_group_info", $in);
                }
            }
        }
        if(! $this->hasError()){
            if($data['parent_id'] > 0){
                self::$db->update('__users_group', ['isfolder' => 1], "id={$data['parent_id']} limit 1");
            }
        }

        if(! $this->hasError()){
            $this->setPermissions($id);
        }

        if($this->hasError()){
            $this->rollback();
        } else {
            $this->commit();
        }

        return ! $this->hasError();
    }

    /**
     * @param $group_id
     * @return bool
     */
    private function setPermissions($group_id)
    {
        $permissions = $this->request->post('permissions');
        $s = self::updateRow('__users_group', $group_id, ['permissions' => serialize($permissions)]);
        if($s){
            self::$db->update('__users', ['sessid'=> null], "group_id={$group_id}");
        }
        return $s;
    }

    public function getItems($parent_id, $backend = 0)
    {
        $parent_id = (int) $parent_id;

        return self::$db->select("
          select g.id, g.isfolder, CONCAT(i.name, ' #', g.id) as text, i.name
          from __users_group g
          join __users_group_info i on i.group_id=g.id and i.languages_id = {$this->languages->id}
          where g.parent_id={$parent_id} and g.backend = {$backend}
          order by abs(g.position) asc
          ")->all();
    }

    public function getInfo($id)
    {
        $res = [];
        foreach (self::$db->select("select id from __languages")->all() as $item) {
            $res[$item['id']] = self::$db->select("select name from __users_group_info where group_id={$id} and languages_id={$item['id']} limit 1")->row();
        }
        return $res;
    }

    /**
     * @param $id
     * @return array|mixed
     */
    public function getData($id)
    {
        $d = self::$db->select("select * from __users_group where id = {$id} limit 1")->row();
        if(!empty($d['permissions'])){
            $d['permissions'] = unserialize($d['permissions']);
        }
        return $d;
    }

    public function delete($id)
    {
        $parent_id = self::$db->select("select parent_id from __users_group where id={$id} limit 1")->row('parent_id');
        if($parent_id > 0){
            $c = self::$db->select("select count(id) as t from __users_group where parent_id={$parent_id}")->row('t');
            if($c == 1){
                self::$db->update('__users_group', ['isfolder' => 0], "id={$parent_id} limit 1");
            }
        }

        $this->deleteChildren($id);
        return self::$db->delete("__users_group", "id={$id} limit 1");
    }

    /**
     * @param $parent_id
     */
    private function deleteChildren($parent_id)
    {
        foreach (self::$db->select("select id, isfolder from __users_group where parent_id={$parent_id}")->all() as $item) {
            if($item['isfolder']){
                $this->deleteChildren($item['id']);
            }
        }
        self::$db->delete("__users_group", " parent_id={$parent_id}");
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

        $s = self::$db->update('__users_group', ['parent_id' => $parent, 'position' => $position], "id={$id} limit 1");

        if($s > 0){
            self::$db->update('__users_group', ['isfolder' => 1], "id={$parent} limit 1");
        }

        if($s > 0 && $old_parent > 0){
            $c = self::$db->select("select count(id) as t from __users_group where parent_id={$old_parent}")->row('t');
            if($c == 0){
                self::$db->update('__users_group', ['isfolder' => 0], "id={$old_parent} limit 1");
            }
        }

        if($this->hasError()){
            $this->rollback();
        } else {
            $this->commit();
        }
    }
}