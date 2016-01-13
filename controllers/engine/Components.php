<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 25.12.15 : 17:46
 */

namespace controllers\engine;

use controllers\Engine;

defined("CPATH") or die();

/**
 * Class Components
 * @name Компоненти
 * @icon fa fa-users
 * @position 5
 * @author Volodymyr Hodiak
 * @version 7.0.0
 * @package controllers\engine
 */
class Components extends Engine
{
    public function index($component = '')
    {
        if(empty($component)) $component = 'components';

        $cl = ComponentsFactory::create($component);
        $cl ->index();
    }

    public function items($component = '')
    {
        if(empty($component)) $component = 'components';

        $cl = ComponentsFactory::create($component);
        $cl ->items();
    }

    public function create()
    {
        // TODO: Implement create() method.
    }

    public function edit($id)
    {
        // TODO: Implement edit() method.
    }

    public function delete($id)
    {
        // TODO: Implement delete() method.
    }

    public function process($id)
    {
        // TODO: Implement process() method.
    }
}