<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 26.08.16
 * Time: 23:23
 */

namespace modules\shop\models\admin\categories;

use system\models\Model;

/**
 * Class AccessoriesFeatures
 * @package modules\shop\models\admin\categories
 */
class AccessoriesFeatures extends Model
{
    /**
     * @param $id
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get($id)
    {
        $items = self::$db
            ->select("
              select pf.features_id,pf.id, fi.name,  pf.values
              from __products_accessories_features pf
              join __features_info fi on fi.features_id = pf.features_id and fi.languages_id={$this->languages_id}
              where pf.products_accessories_id = {$id}
              ")->all();

        foreach ($items as $k=>$item) {
            if($item['values'] == '') continue;

            $items[$k]['values'] = self::$db->select("
              select f.id, fi.name
              from __features f
              join __features_info fi on fi.features_id = f.features_id and fi.languages_id={$this->languages_id}
              where f.id in ({$item['values']})
              ")->all();
        }

        return $items;
    }

    /**
     * @param $products_accessories_id
     * @param $features_id
     * @param null $values
     * @return bool|string
     */
    public function create($products_accessories_id, $features_id, $values = null)
    {
        $id = self::$db
            ->select("select id from __products_accessories_features where products_accessories_id = {$products_accessories_id} and features_id = {$features_id} limit 1")
            ->row('id');

        if($id > 0 ) return false;

        return parent::createRow
        (
            '__products_accessories_features',
            [
                'products_accessories_id' => $products_accessories_id,
                'features_id' => $features_id,
                'values'      => $values
            ]
        );
    }

    public function delete($id)
    {
        return parent::deleteRow('__products_accessories_features', $id);
    }
}