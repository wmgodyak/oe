<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 29.06.16 : 16:30
 */

namespace system\models;

use system\core\Session;

defined("CPATH") or die();

class Guides extends Model
{
    private $content_type = 'guide';
    private $types_id = 0;

    public function __construct()
    {
        parent::__construct();

        $this->types_id = self::$db
            ->select("select id from __content_types where parent_id=0 and type ='{$this->content_type}' limit 1")
            ->row('id');

        if(empty($this->types_id)){
            throw new \Exception('Невірний тип контенту');
        }
    }

    public function get($key, $order = null)
    {
        $res = self::$db
            ->select("
                select c.id, i.name
                from __content c
                join __content_info i on i.content_id=c.id and i.languages_id={$this->languages_id}
                where c.external_id='{$key}' limit 1
              ")
            ->row();

        if(!empty($res)){
            $ob = '';
            if($order){
                switch($order){
                    case 'id':
                        $ob = "order by abs(c.id) asc";
                        break;
                    case 'position':
                        $ob = "order by abs(c.position) asc";
                        break;
                    case 'name':
                        $ob = "order by i.name asc";
                        break;
                }
            }
            $res['items'] = self::$db
                ->select("
                select c.id, i.name, c.external_id
                from __content c
                join __content_info i on i.content_id=c.id and i.languages_id={$this->languages_id}
                where c.parent_id = '{$res['id']}' and c.status = 'published'
                {$ob}
              ")
                ->all();

        }
        return $res;
    }

    public function getItems($parent_id)
    {
        return  self::$db
            ->select("
                select c.id, i.name, c.external_id
                from __content c
                join __content_info i on i.content_id=c.id and i.languages_id='{$this->languages_id}'
                where c.parent_id = '{$parent_id}' and c.status = 'published'
              ")
            ->all();
    }

    public function create($data, $info)
    {
        $this->beginTransaction();

        $data['owner_id']    = Session::get('engine.admin.id');
        $data['types_id']    = $this->types_id;
        $data['subtypes_id'] = $this->types_id;
        $data['status']      = 'published';

        $id = $this->createRow('__content', $data);

        if($this->hasError()){
            $this->rollback();

            return false;
        }

        foreach($info as $languages_id => $data){
            $aid = self::$db
                ->select("select id from __content_info where content_id='{$id}' and languages_id={$languages_id} limit 1")
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

        if($this->hasError()){
            $this->rollback();

            return false;
        }

        if(isset($data['parent_id']) && $data['parent_id'] > 0){
            $this->updateRow('__content', $data['parent_id'], ['isfolder' => 1]);
        }

        $this->commit();

        return $id;
    }

    public function getID($key)
    {
        return self::$db->select("select id from __content where external_id='{$key}' limit 1")->row('id');
    }

    public function getUrl($content_id, $languages_id)
    {
        return self::$db
            ->select("select url from __content_info where content_id={$content_id} and languages_id = {$languages_id} limit 1")
            ->row('url');
    }
}