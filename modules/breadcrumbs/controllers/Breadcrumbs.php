<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 05.07.16 : 13:54
 */

namespace modules\breadcrumbs\controllers;

use system\Front;

defined("CPATH") or die();

/**
 * Class Breadcrumbs
 *
 * @name Хлібні крихти
 * @description Хлібні крихти для сайту
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @package modules\breadcrumbs\controllers
 */
class Breadcrumbs extends Front
{
    private $breadcrumbs;

    public function __construct()
    {
        parent::__construct();

        $this->breadcrumbs = new \modules\breadcrumbs\models\Breadcrumbs();
    }

    public function get()
    {
        return $this->breadcrumbs->get($this->page['id']);
    }
}