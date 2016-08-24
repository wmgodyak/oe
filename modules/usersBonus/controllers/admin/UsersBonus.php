<?php

namespace modules\usersBonus\controllers\admin;

use modules\order\models\admin\OrdersProducts;
use system\core\DataFilter;
use system\core\EventsHandler;
use system\Engine;
use system\models\Settings;

/**
 * Class UsersBonus
 * @package modules\usersBonus\controllers\admin
 */
class UsersBonus extends Engine
{
    private $ub;

    public function __construct()
    {
        parent::__construct();

        $this->ub = new \modules\usersBonus\models\UsersBonus();
    }

    public function init()
    {
        parent::init();

        EventsHandler::getInstance()->add('orders.change_status', [$this, 'calcBonus']);

        DataFilter::add
        (
            'users.list.row',
            function($row)
            {
                $bonus = $this->ub->get($row['id']);
                if($bonus > 0){
                    $row['username'] .= "<br><span class='label label-success'>СМА бонус: {$bonus} грн.</span>";
                }
                return $row;
            }
        );
    }

    public function calcBonus($data)
    {
        $status = Settings::getInstance()->get('modules.UsersBonus.config.status_id');
        if($data['status_id'] == $status && $data['pay'] == 1){
            $op = new OrdersProducts();
            $amount = $op->amount($data['id']);
            $rate   = Settings::getInstance()->get('modules.Shop.config.bonus_rate');
            $bonus  = $amount * $rate * $data['currency_rate'];
            $this->ub->create($data['users_id'], $data['id'], $bonus);
        }

//        d($data);
    }

    public function index()
    {
        // TODO: Implement index() method.
    }

    public function create()
    {
        // TODO: Implement create() method.
    }
    public function edit($id)
    {
        // TODO: Implement edit() method.
    }
    public function process($id)
    {
        // TODO: Implement process() method.
    }
    public function delete($id)
    {
        // TODO: Implement delete() method.
    }
}