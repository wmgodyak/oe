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

/**
 * Class Sample
 * @package modules\blog\widgets
 */
class Sample extends Widget
{
    public function __construct()
    {
        parent::__construct('blog.sample', 'Sample One', 'Sample description');
    }

    /**
     * @param array $data
     * @return string
     */
    public function form(array $data = [])
    {
        return parent::form($data);
    }

    public function display($args, $data)
    {
        return parent::display($args, $data);
    }
}