<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 29.02.16 : 14:11
 */


namespace controllers\engine;

use controllers\Engine;

defined("CPATH") or die();

class Content extends Engine
{
    protected $mContent;

    protected $form_template = 'content/default';

    public function __construct()
    {
        parent::__construct();

        $this->mContent = new \models\engine\Content();
    }

    public function index()
    {
        echo 'ShopCategories::index';
    }
    public function create($id=0)
    {
        echo 'ShopCategories::create';
    }
    public function edit($id)
    {
        // TODO: Implement edit() method.
    }
    public function delete($id)
    {
        // TODO: Implement delete() method.
    }
    public function process($id)
    {
        // TODO: Implement process() method.
    }
}