<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 29.08.16 : 14:43
 */

namespace modules\shop\models\admin\products;

defined("CPATH") or die();

/**
 * Class Kits
 * @package modules\shop\models\admin\products
 */
class Kits extends \modules\shop\models\products\Kits
{
    /**
     * @return bool|string
     */
    public function create()
    {
        $data = $this->request->post('data');
        return parent::createRow('__kits', $data);
    }

    /**
     * @param $id
     * @return int
     */
    public function delete($id)
    {
        return $this->deleteRow('__kits', $id);
    }

    /**
     * @param $products_id
     * @return array|mixed
     */
    public function count($products_id)
    {
        return self::$db
            ->select("select count(id) as t from __kits where products_id = {$products_id}")
            ->row('t');
    }
}