<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 27.08.16 : 15:42
 */

namespace modules\shop\models\products;

use system\models\Model;

defined("CPATH") or die();

/**
 * Class Kits
 * @package modules\shop\models\products
 */
class Kits extends Model
{
    public $products;

    public function __construct()
    {
        parent::__construct();

        $this->products = new KitsProducts();
    }

    public function create()
    {
        $data = $this->request->post('data');
        return parent::createRow('__kits', $data);
    }

    public function get($products_id)
    {
        return self::$db->select("select id, name from __kits where products_id={$products_id}")->all();
    }

    public function delete($id)
    {
        return $this->deleteRow('__kits', $id);
    }
}