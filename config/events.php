<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 11.03.16 : 13:49
 */

defined("CPATH") or die();


    \controllers\core\Event::listen
    (
        'controllers\engine\Content::beforeDelete',
        'controllers\engine\plugins\ContentImages::ondDeleteContent'
    );