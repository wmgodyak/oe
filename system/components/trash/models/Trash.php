<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 16.06.16
 * Time: 20:27
 */

namespace system\components\trash\models;

use system\models\Backend;

defined("CPATH") or die();

/**
 * Class Trash
 * @package system\components\trash\models
 */
class Trash extends Backend
{
    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     * @throws \system\core\exceptions\Exception
     */
    private function getData($id, $key = '*')
    {
        return self::$db->select("select {$key} from __content where id={$id} limit 1")->row($key);
    }

    /**
     * @param $id
     * @throws \system\core\exceptions\Exception
     */
    public function remove($id)
    {
        $s = self::$db->delete("__content", "id={$id} limit 1");
        if($s){
            self::$db->delete("__content_features", "content_id={$id}");
            self::$db->delete("__features_content", "content_id={$id}");
        }
    }

    /**
     * @param $id
     */
    public function restore($id)
    {
        $parent_id = $this->getData($id, 'parent_id');

        $s = parent::updateRow('__content', $id, ['status' => 'published']);

        if($s > 0 && $parent_id > 0){
            parent::updateRow('__content', $parent_id, ['isfolder' => 1]);
        }
    }
}