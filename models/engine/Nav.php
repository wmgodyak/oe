<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 09.03.16
 * Time: 23:12
 */

namespace models\engine;

use models\Engine;

class Nav extends Engine
{
    public function create()
    {
        $data = $this->request->post('data');
        return $this->createRow('nav', $data);
    }

    public function getData($id, $key = '*')
    {
        $data = self::$db->select("select {$key} from __nav where id={$id} limit 1")->row($key);

        if ($key != '*') return $data;

        $data['items'] = $this->getSelectedItems($id);

        return $data;
    }
    
    public function update($id)
    {
        $data = $this->request->post('data');

        $this->beginTransaction();

        $this->updateRow('__nav', $id, $data);

        if($this->hasDBError()){
            $this->rollback();
            return false;
        }

        $this->sortItems($id);

        if($this->hasDBError()){
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
        return $this->deleteRow('__nav_items', $id);
    }

    public function getItems($parent_id, $level = 3)
    {
        $parent_id = (int) $parent_id;
        $res = [];
        $r = self::$db->select("
          select c.id, c.isfolder, c.status, ci.name
          from __content c
          join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
          where c.parent_id={$parent_id} and c.status = 'published'
          ")->all();

        foreach ($r as $item) {
            if($item['isfolder'] && $level > 0){
                $item['items'] = $this->getItems($item['id'], --$level);
            }
            $res[] = $item;
        }

        return $res;
    }

    /**
     * @param $nav_id
     * @param $item_id
     * @return bool|string
     */
    public function addItem($nav_id, $item_id)
    {
        return $this->createRow('nav_items', ['nav_id'=> $nav_id, 'content_id' => $item_id]);
    }

    public function getSelectedItems($nav_id)
    {
        return self::$db->select("
          select ni.id,c.id as content_id, ci.name
          from __nav_items ni
          join __content c on c.id=ni.content_id and c.status = 'published'
          join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
          where ni.nav_id={$nav_id}
          order by abs(ni.position) asc
          " )->all();
    }

    private function sortItems($nav_id)
    {
        $pos = $this->request->post('pos');

        if(empty($pos)) return ;

        $a = explode('x', $pos);
        foreach ($a as $position=>$item_id) {
            self::$db->update("nav_items", ['position' => $position], " nav_id= {$nav_id} and content_id={$item_id} limit 1");
        }
    }

}