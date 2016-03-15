<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 15.03.16 : 10:53
 */

namespace models\engine;

use models\Engine;

defined("CPATH") or die();

class Trash extends Engine
{
    private function getData($id, $key = '*')
    {
        return self::$db->select("select {$key} from content where id={$id} limit 1")->row($key);
    }
    public function remove($id)
    {
        $s = self::$db->delete("content", "id={$id} limit 1");
        if($s){
            self::$db->delete("content_features", "content_id={$id}");
            self::$db->delete("features_content", "content_id={$id}");
        }
    }

    public function restore($id)
    {
        $parent_id = $this->getData($id, 'parent_id');

        $s = parent::updateRow('content', $id, ['status' => 'published']);

        if($s > 0 && $parent_id > 0){
            parent::updateRow('content', $parent_id, ['isfolder' => 0]);
        }
    }
}