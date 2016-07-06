<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:12
 */

namespace modules\users\models;

/**
 * Class usersGroup
 * @package modules\users\models
 */
class UsersGroup extends \system\models\UsersGroup
{
    /**
     * @param $parent_id
     * @return mixed
     */
    public function get($parent_id = 0)
    {
        $items = $this->getItems($parent_id, 0);
        foreach ($items as $k=>$item) {
            if($item['isfolder']){
                $items[$k]['items'] = $this->getItems($item['id'], 0);
            }
        }

        return $items;
    }
}