<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 18.03.16 : 9:51
 */

namespace controllers\engine\plugins;

use controllers\engine\Plugin;
use models\engine\ContentRelationship;

defined("CPATH") or die();

/**
 * Class ProductsSimilar
 * @name Вибір параметрів схожих товарів
 * @icon fa-users
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @position 5
 * @package controllers\engine
 */
class ProductsSimilar extends Plugin
{
    private $sp;
    
    public function __construct()
    {
        parent::__construct();

        $this->disallow_actions = ['index'];
        $this->sp = new \models\engine\plugins\ProductsSimilar();
    }

    public function index(){}

    private function getFeatures($parent_id)
    {
        $items = $this->sp->getFeatures($parent_id);

        foreach ($items as $k=>$item) {
            if($item['type'] == 'folder'){
                $items[$k]['items'] = $this->sp->getFeatures($item['id']);
            }
        }

        return $items;
    }

    public function create()
    {
        $this->template->assign('selected_similar', []);
        $this->template->assign('features', $this->getFeatures(0));
        return $this->template->fetch('plugins/shop/similar');
    }

    public function edit($id)
    {
        $this->template->assign('selected_similar', $this->sp->getSelected($id));
        $this->template->assign('features', $this->getFeatures(0));
        return $this->template->fetch('plugins/shop/similar');
    }

    public function delete($id){}

    public function process($id)
    {
        $s = $this->sp->save($id);

        if(! $s){
            echo $this->sp->getDBErrorMessage();
        }
    }
}