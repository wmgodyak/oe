<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 07.07.16 : 16:29
 */

namespace modules\shop\models\admin;

use system\models\Languages;
use system\models\Model;

defined("CPATH") or die();

/**
 * Class Import
 * @package modules\shop\models\admin
 */
class Import extends Model
{
    private $cat_type_id;
    private $cat_sub_type_id;

    private $owner;

    private $languages;

    public function __construct($languages_id, $owner)
    {
        parent::__construct();

        $this->languages_id = $languages_id;
        $this->owner = $owner;

        $this->languages = new Languages();

        $this->cat_type_id = $this->getContentTypeIDByType('products_categories');
        $this->cat_sub_type_id = $this->cat_type_id;
    }

    public function category($ex_id, $name, $ex_parentId = 0)
    {
        $id = self::$db->select("select id from __content where external_id='{$ex_id}' limit 1")->row('id');

        if($id){

            return ;
        }

        $parent_id = 0;

        if($ex_parentId > 0){
            $parent_id = self::$db->select("select id from __content where external_id='{$ex_parentId}' limit 1")->row('id');
        }

        $this->beginTransaction();

        $content_id = parent::createRow
        (
            '__content',
            [
                'parent_id'    => $parent_id,
                'types_id'     => $this->cat_type_id,
                'subtypes_id'  => $this->cat_sub_type_id,
                'owner_id'     => $this->owner['id']
            ]
        );

        foreach ($this->languages->get() as $lang) {
            $a = [
                
            ];
        }
    }

    private function getContentTypeIDByType($type)
    {
        return self::$db
            -> select("select id from __content_types where type = '{$type}' and parent_id = 0  limit 1")
            -> row('id');
    }
}