<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 12.01.16 : 11:59
 */

namespace models\engine;

use models\core\Model;

/**
 * Class Components
 * @package models\engine
 */
class Components extends Model
{
    public function create($data)
    {
        $data['controller'] = lcfirst($data['controller']);
        return self::$db->insert('components', $data);
    }
    /**
     * @param $controller
     * @return bool
     */
    public function isInstalled($controller)
    {
        $controller = lcfirst($controller);
        return self::$db->select("select id from components where controller = '{$controller}' limit 1")->row('id') > 0;
    }

    /**
     * @param $controller
     * @param $type
     * @param string $key
     * @return array|mixed
     */
    public function data($controller, $type, $key = '*')
    {
        return self::$db->select("select {$key} from components where controller = '{$controller}' and type='{$type}' limit 1")->row($key);
    }

    /**
     * @param $id
     * @return bool
     */
    public function is($id)
    {
        return self::$db->select("select id from components where id = '{$id}' limit 1")->row('id') > 0;
    }


    /**
     * @param $id
     * @return bool
     */
    public function pub($id)
    {
        return self::$db->update('components', ['published' => 1], "id= '{$id}' limit 1");
    }

    /**
     * @param $id
     * @return bool
     */
    public function hide($id)
    {
        return self::$db->update('components', ['published' => 0], "id= '{$id}' limit 1");
    }

    /**
     * @return array
     */
    public function tree()
    {
        $res = [];
        foreach ($this->treeItems(0) as $item) {
            if($item['isfolder']) $item['children'] = $this->treeItems($item['id']);
            $res[] = $item;
        }
        return $res;
    }

    /**
     * @param $parent_id
     * @return mixed
     */
    private function treeItems($parent_id)
    {
        return self::$db
            ->select("select id,isfolder,controller from components where type='component' and parent_id={$parent_id} and published=1")
            ->all();
    }

    /**
     * @param $id
     * @return int
     */
    public function delete($id)
    {
        return self::$db->delete('components', " id={$id} limit 1");
    }
}