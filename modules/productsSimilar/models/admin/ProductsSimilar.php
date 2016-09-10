<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 09.09.16 : 17:55
 */

namespace modules\productsSimilar\models\admin;

defined("CPATH") or die();

/**
 * Class ProductsSimilar
 * @package modules\productsSimilar\models\admin
 */
class ProductsSimilar extends \modules\productsSimilar\models\ProductsSimilar
{
    public function create($categories_id, $features_id)
    {
        return $this->createRow('__products_similar', ['categories_id' => $categories_id, 'features_id' => $features_id]);
    }

    public function getFeatures($categories_id)
    {
        return self::$db
            ->select("
              select ps.id, f.name
              from __products_similar ps
              join __features_info f on f.features_id=ps.features_id and f.languages_id={$this->languages_id}
              where ps.categories_id={$categories_id}
              ")
            ->all();
    }

    public function getSelectedFeaturesId($categories_id)
    {
        return self::$db
            ->select("
              select features_id
              from __products_similar
              where categories_id={$categories_id}
              ")
            ->all('features_id');
    }

    public function update($categories_id)
    {
        $similar = $this->request->post('features');

        self::$db->delete('__products_similar', " categories_id={$categories_id}");

        foreach ($similar as $k=>$features_id) {
            $this->create($categories_id, $features_id);
        }

        return ! $this->hasError();
    }

    public function delete($id)
    {
        return $this->deleteRow('__products_similar', $id);
    }
}