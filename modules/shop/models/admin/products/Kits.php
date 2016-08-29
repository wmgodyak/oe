<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 29.08.16 : 14:43
 */

namespace modules\shop\models\admin\products;

defined("CPATH") or die();

class Kits extends \modules\shop\models\products\Kits
{
    public function create()
    {
        $data = $this->request->post('data');
        return parent::createRow('__kits', $data);
    }

    public function delete($id)
    {
        return $this->deleteRow('__kits', $id);
    }
}