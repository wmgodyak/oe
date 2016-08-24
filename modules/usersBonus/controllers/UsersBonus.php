<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.08.16
 * Time: 22:42
 */

namespace modules\usersBonus\controllers;

use system\core\EventsHandler;
use system\Front;

/**
 * Class UsersBonus
 * @name Users Bonus
 * @package modules\usersBonus\controllers
 */
class UsersBonus extends Front
{
    private $ub;

    public function __construct()
    {
        parent::__construct();

        $this->ub = new \modules\usersBonus\models\UsersBonus();
    }

    public function get($users_id)
    {
        return $this->ub->get($users_id);
    }

    public function init()
    {
        parent::init();

        EventsHandler::getInstance()->add('user.profile.nav', [$this, 'myBonus']);
    }

    public function myBonus($user)
    {
        if(! $user ) return null;

        $bonus = $this->ub->get($user['id']);
        if(empty($bonus)) $bonus = 0;

        return  "<li><a>Мій СМА бонус: <b>{$bonus} грн.</b></a></li>";
    }
}