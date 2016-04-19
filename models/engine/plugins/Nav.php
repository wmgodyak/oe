<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 21.01.16 : 17:22
 */


namespace models\engine\plugins;

use models\core\Model;
use models\engine\Content;

defined("CPATH") or die();

class Nav extends Content
{
    public function __construct()
    {
        parent::__construct('pages');
    }

    public function getItems($parent_id)
    {
        $parent_id = (int) $parent_id;

        return self::$db->select("
          select c.id, c.isfolder, c.status, ci.name as text
          from __content c
          join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
          where c.parent_id={$parent_id} and c.status in ('published', 'hidden')
          ")->all();
    }
}