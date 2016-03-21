<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 21.03.16 : 12:13
 */

namespace models\app;

use models\App;

defined("CPATH") or die();

/**
 * Class Content
 * @package models\app
 */
class Content extends App
{
    public function getUrlById($id)
    {
        $url = self::$db
            ->select("select url from content_info where content_id = '{$id}' and languages_id={$this->languages_id} limit 1")
            ->row('url');

        if($this->languages_id == $this->languages->getDefault('id')){
            return $url;
        }

        $code = $this->languages->getData($this->languages_id, 'code');

        return $code .'/'. $url;
    }
}