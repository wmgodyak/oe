<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 15.01.16 : 18:24
 */

namespace models;

use controllers\core\Session;
use controllers\engine\Permissions;
use models\core\Model;
use models\engine\Languages;

defined("CPATH") or die();

/**
 * Class Engine
 * @package models
 */
class Engine extends Model
{
    protected $admin;
    protected $languages;

    public function __construct()
    {
        parent::__construct();

        $this->admin = Session::get('engine.admin');

        $l = new Languages();
        $this->languages    = $l->get();
        $this->languages_id = $l->getDefault('id');
        self::$language_id  = $this->languages_id;
    }

    /**
     * @param int $parent_id
     * @return array
     */
    public function nav($parent_id=0)
    {
        $res = [];

        $r = self::$db
        ->select("
                    select id, icon, isfolder, controller, rang
                    from __components
                    where parent_id={$parent_id}
                    order by abs(position) asc
                ")
        ->all();

        foreach ($r as $item) {

            if(strpos($item['controller'], '/') === FALSE){
                $controller = ucfirst($item['controller']);
            } else {
                $a = explode('/', $item['controller']);
                $controller = ''; $c = count($a); $c --;
                foreach ($a as $i=>$v) {
                    if($i == $c) $v = ucfirst($v);
                    $controller .=  ($i>0 ? '\\' : '') . "$v";
                }
            }
            if(!Permissions::check($controller, 'index')){
                continue;
            }

            if($item['isfolder']) {
                $item['items'] = $this->nav($item['id']);
            }
            $res[] = $item;
        }
        return $res;
    }
}