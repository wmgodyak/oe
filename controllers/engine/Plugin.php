<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 28.01.16 : 11:07
 */

namespace controllers\engine;

use controllers\Engine;

defined("CPATH") or die();

/**
 * Class Plugin
 * @package controllers\engine
 */
abstract class Plugin extends Engine
{
    protected $meta;
    protected $settings;

    public function setMeta($meta)
    {
        $this->meta = $meta;

        $this->settings = $meta['settings'];
    }
}