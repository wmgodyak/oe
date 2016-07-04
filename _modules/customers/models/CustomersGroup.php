<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:12
 */

namespace modules\customers\models;

use system\models\UsersGroup;

/**
 * Class CustomersGroup
 * @package modules\customers\models
 */
class CustomersGroup extends UsersGroup
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