<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 27.06.16 : 10:47
 */

namespace modules\blog\widgets;

use system\core\Widget;

defined("CPATH") or die();

class Subscribe extends Widget
{
    public function __construct($id, $name, $description, array $options)
    {
        parent::__construct($id, $name, $description, $options);
    }

    public function display(array $args = [], array $data = [])
    {
        // TODO: Implement display() method.
    }
}