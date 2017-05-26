<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 15.01.16 : 18:24
 */

namespace system\models;

use system\core\Session;

defined("CPATH") or die();

/**
 * Class Engine
 * @package models
 */
class Backend extends Model
{
    protected $admin;
    protected $languages; // todo change it to object

    public function __construct()
    {
        parent::__construct();

        $this->admin = Session::get('backend.admin');
        $this->languages = \system\core\Languages::getInstance();
    }
}