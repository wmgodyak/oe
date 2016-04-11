<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 11.04.16 : 10:16
 */

namespace models\modules;

use controllers\core\Session;

defined("CPATH") or die();

class Callback extends \models\components\Callback
{
    public function create($data)
    {
        $user = Session::get('user');
        if($user){
            $data['users_id'] = $user['id'];
        }
        return parent::create($data);
    }
}