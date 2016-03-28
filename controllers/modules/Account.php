<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 28.03.16 : 9:23
 */

namespace controllers\modules;

use controllers\App;

defined("CPATH") or die();

/**
 * Class Account
 * @name Account
 * @icon fa-user
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class Account extends App
{
    private $reg_group_id=0;

    public function __construct()
    {
        parent::__construct();

        $this->reg_group_id = 2;
    }

    public function login()
    {

    }
    public function logout(){}
    public function fp(){}

    public function register()
    {
//        $this->dump($_POST);
        if($this->request->isPost()){

        }

        $this->template->assign('acc_content', $this->template->fetch('modules/account/register'));
    }

    public function profile(){}
}