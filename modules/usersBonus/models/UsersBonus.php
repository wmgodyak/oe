<?php
namespace modules\usersBonus\models;

use system\models\Model;
use system\models\UsersMeta;

/**
 * Class UsersBonus
 * @package modules\usersBonus\models
 */
class UsersBonus extends Model
{
    /**
     * @param $users_id
     * @param $orders_id
     * @param $bonus
     * @return bool|string
     */
    public function create($users_id, $orders_id, $bonus)
    {
        $s = $this->createRow
        (
            '__users_bonus',
            ['users_id' => $users_id, 'orders_id' => $orders_id, 'bonus' => $bonus]
        );
        if($s){
            $bonus = $this->get($users_id);
            $meta = new UsersMeta();
            $meta->update($users_id, 'bonus', $bonus);
        }

        return $s;
    }

    public function get($users_id)
    {
        return self::$db
            ->select("select sum(bonus) as t from __users_bonus where users_id='{$users_id}'")
            ->row('t');
    }
}