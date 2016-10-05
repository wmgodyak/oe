<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 23.08.16 : 15:41
 */

namespace system\components\install\controllers;

defined("CPATH") or die();

class Install
{
    private $install;

    public function __construct()
    {
        $this->install = new \system\components\install\models\Install();
    }

    public function init(){}

    public function index()
    {
        var_dump($this->install->go());
    }
}