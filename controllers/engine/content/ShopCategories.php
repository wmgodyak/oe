<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 26.02.16 : 16:00
 */

namespace controllers\engine\content;

use controllers\Engine;

defined("CPATH") or die();
/**
 * Class ShopCategories
 * @name Категорії товарів
 * @icon fa-pages
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine\content_types
 */
class ShopCategories extends Engine
{
    public function index()
    {
        echo 'ShopCategories::index';
    }
    public function create()
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