<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 23.12.15 : 12:13
 */

namespace models\engine;


use models\core\DB;
use models\core\Model;

class Admin extends Model
{
    /**
     * check if is user online
     * @param $id
     * @param $sid
     * @return $this
     */
    public static function isOnline($id, $sid)
    {
        return
            DB::instance()
            ->select("select id from users where id = '{$id}' and sessid = '{$sid}' limit 1")
            ->row('id') > 0;
    }

    public function logout($id)
    {
        return self::$db->update('users', array('sessid'=>''), " id = '{$id}' limit 1");
    }
}