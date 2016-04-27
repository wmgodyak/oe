<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 27.04.16 : 12:19
 */


namespace models\app;


use models\App;

defined("CPATH") or die();

class AdminPanel extends App
{
    public function updateContent($content_id, $col, $data)
    {
        return self::$db
            ->update
            (
                '__content_info',
                [$col => $data],
                " content_id={$content_id} and languages_id={$this->languages_id} limit 1"
            );
    }
}