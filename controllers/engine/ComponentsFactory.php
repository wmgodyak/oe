<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 13.01.16 : 9:38
 */

namespace controllers\engine;

use controllers\core\exceptions\FileNotFoundException;

class ComponentsFactory
{
    private function __construct(){}
    private function __clone(){}

    public static function create($component)
    {
        if(! file_exists(DOCROOT . 'controllers/engine/components/' . ucfirst($component) . '.php')) {
            throw new FileNotFoundException("Контроллер компоненту {$component} не знайдено.");
        }

        $cl = '\controllers\engine\components\\' .  ucfirst($component);
        return new $cl;
    }
}