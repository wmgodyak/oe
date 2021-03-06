<?php

namespace system\components\nav\models;
use system\core\DataFilter;
use system\models\Backend;

defined("CPATH") or die();

/**
 * Class Nav
 * @package system\components\nav\models
 */
class Nav extends Backend
{
    /**
     * @var array
     */
    private $c_types = ['pages'];
    public $items;
    public $items_info;

    public function __construct()
    {
        parent::__construct();

        $this->items = new NavItems();
        $this->items_info = new NavItemsInfo();
    }


    public function create($data)
    {
        return $this->createRow('__nav', $data);
    }

    public function getData($id, $key = '*')
    {
        return self::$db->select("select {$key} from __nav where id={$id} limit 1")->row($key);
    }

    public function update($id)
    {
        $data = $this->request->post('data');

        $this->beginTransaction();

        $this->updateRow('__nav', $id, $data);

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        $this->sortItems($id);

        if($this->hasError()){
            $this->rollback();
            return false;
        }


        $this->commit();

        return true;
    }

    public function delete($id)
    {
        return $this->deleteRow('__nav', $id);
    }

    public function deleteItem($id)
    {
        $parent_id = self::$db->select("select parent_id from __nav_items where id = {$id} limit 1")
            ->row('parent_id');

        $s = $this->deleteRow('__nav_items', $id);
        $c = self::$db->select("select count(*) as t from __nav_items where parent_id = {$parent_id}")->row('t');

        if($c == 0){
            $this->updateRow('__nav_items', $parent_id, ['isfolder' => 0]);
        }

        return $s;
    }

    public function buildTree()
    {
        $c_types = DataFilter::apply('nav.items.content_types', $this->c_types);
        foreach ($c_types as $k=>$type) {
            $c_types[$k] = "'$type'";
        }
        $types_in = implode(',', $c_types);

        $res = [];
        $r = self::$db->select("select id, name from __content_types where type in ({$types_in})")->all();

        foreach ($r as $type) {
            $res[] = $type;
        }

        return $res;
    }

    /**
     * @param $types_id
     * @param int $parent_id
     * @return mixed
     */
    public function tree($types_id, $parent_id = 0)
    {
        return self::$db
            ->select("
              select c.id, c.isfolder, c.status, ci.name
              from __content c
              join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages->id}
              where c.parent_id={$parent_id} and c.types_id = {$types_id} and c.status = 'published'
              ")
            ->all();
    }

    /**
     * @param $nav_id
     * @param $item_id
     * @return bool|string
     */
    public function addItem($nav_id, $item_id)
    {
        return $this->createRow('__nav_items', ['nav_id'=> $nav_id, 'content_id' => $item_id]);
    }

    /**
     * @param $nav_id
     * @param int $parent_id
     * @return mixed
     */
    public function getSelectedItems($nav_id, $parent_id = 0)
    {
        $res = self::$db->select("
          select n.id, n.isfolder, n.parent_id, n.published,
           IF(ni.name is null, ci.name, ni.name) as name
          from __nav_items n
          left join __content_info ci on ci.content_id=n.content_id and ci.languages_id={$this->languages->id}
          left join __nav_items_info ni on ni.nav_items_id=n.id and ni.languages_id={$this->languages->id}
          where n.nav_id={$nav_id} and n.parent_id={$parent_id}
          order by abs(n.position) asc
          " )->all();

        foreach ($res as $k=>$row) {
            if($row['isfolder']){
                $res[$k]['items'] = $this->getSelectedItems($nav_id, $row['id']);
            }
        }

        return $res;
    }

    /**
     * @param $nav_id
     * @throws \system\core\exceptions\Exception
     */
    private function sortItems($nav_id)
    {
        $pos = $this->request->post('pos');

        if(empty($pos)) return ;

        $a = explode('x', $pos);
        foreach ($a as $position=>$item_id) {
            self::$db->update("__nav_items", ['position' => $position], " nav_id= {$nav_id} and content_id={$item_id} limit 1");
        }
    }

    /**
     * @param $item_id
     * @return bool
     */
    public function updateItem($item_id)
    {
        $data = $this->request->post('data');
        $info = $this->request->post('info');

        $this->updateRow('__nav_items', $item_id, $data);

        foreach ($info as $languages_id => $cols) {
            $this->items_info->update($item_id, $languages_id, $cols);
        }

        return ! $this->hasError();
    }

    public function createItem($parent_id)
    {
        $data = $this->request->post('data');
        $info = $this->request->post('info');
        $data['parent_id'] = $parent_id;
        $data['nav_id']    = self::$db->select("select nav_id from __nav_items where id = {$parent_id} limit 1")
            ->row('nav_id');

        $item_id = $this->createRow('__nav_items', $data);

        if(empty($item_id)) {
            return false;
        }

        $this->updateRow('__nav_items', $parent_id, ['isfolder' => 1]);

        foreach ($info as $languages_id => $cols) {
            $this->items_info->update($item_id, $languages_id, $cols);
        }

        return ! $this->hasError();
    }
}