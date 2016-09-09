<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 09.09.16 : 17:55
 */


namespace modules\productsSimilar\models\admin;


defined("CPATH") or die();

class ProductsSimilar extends \modules\productsSimilar\models\ProductsSimilar
{
    public function create($products_id, $features_id)
    {
        return $this->createRow('__products_similar', ['products_id' => $products_id, 'features_id' => $features_id]);
    }

    public function getFeatures($products_id)
    {
        return self::$db
            ->select("
              select ps.id, f.name
              from __products_similar ps
              join __features_info f on f.features_id=ps.features_id and f.languages_id={$this->languages_id}
              where ps.products_id={$products_id}
              ")
            ->all();
    }

    public function update($products_id)
    {
        $similar = $this->request->post('features');

        self::$db->delete('__products_similar', " products_id={$products_id}");

        foreach ($similar as $k=>$features_id) {
            $this->create($products_id, $features_id);
        }

        return ! $this->hasError();
    }

    public function delete($id)
    {
        return $this->deleteRow('__products_similar', $id);
    }
}