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
              select pf.features_id,pf.id, fi.name,  pf.features_values
              from __products_accessories_features pf
              join __features_info fi on fi.features_id = pf.features_id and fi.languages_id={$this->languages_id}
              where pf.products_accessories_id = {$id}
              ")->all();

        foreach ($items as $k=>$item) {
            if($item['features_values'] == '') continue;

            $items[$k]['features_values'] = self::$db->select("
              select f.id, fi.name
              from __features f
              join __features_info fi on fi.features_id = f.id and fi.languages_id={$this->languages_id}
              where f.id in ({$item['features_values']})
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
            ->select("select id
                from __products_accessories_features
                 where products_accessories_id = {$products_accessories_id}
                  and features_id = {$features_id}
                   limit 1")
            ->row('id');

        if($id > 0 ) return false;

        return parent::createRow
        (
            '__products_accessories_features',
            [
                'products_accessories_id' => $products_accessories_id,
                'features_id' => $features_id,
                'features_values'      => $values
            ]
        );
    }

    public function getValues($features_id)
    {
        return self::$db->select("
              select f.id, fi.name
              from __features f
              join __features_info fi on fi.features_id = f.id and fi.languages_id='{$this->languages_id}'
              where f.parent_id='{$features_id}'
              ")->all();
    }

    public function getSelectedValues($id)
    {
        $v = self::$db->select("select features_values from __products_accessories_features where id = '{$id}' limit 1")->row('features_values');
        if(empty($v)) return [];

        return self::$db->select("
              select f.id, fi.name
              from __features f
              join __features_info fi on fi.features_id = f.id and fi.languages_id='{$this->languages_id}'
              where f.id in ({$v})
              ")->all();
    }

    public function delete($id)
    {
        return parent::deleteRow('__products_accessories_features', $id);
    }

    /**
     * @param $id
     * @param $value
     * @return bool
     * @throws \system\core\exceptions\Exception
     */
    public function setValue($id, $value)
    {
        $v = self::$db->select("select features_values from __products_accessories_features where id = '{$id}' limit 1")->row('features_values');
        $a = explode(',', $v);
        $a[] = $value;
        $a = array_unique($a);
        foreach ($a as $k=>$v) {
            if(empty($v)) unset($a[$k]);
        }

        return self::$db->update('__products_accessories_features',['features_values' => implode(',', $a)], "id = '{$id}' limit 1");
    }

    public function deleteFeaturesValues($id, $values_id)
    {
        $v = self::$db->select("select features_values from __products_accessories_features where id = '{$id}' limit 1")->row('features_values');
        $a = explode(',', $v);
        foreach ($a as $k=>$v) {
            if($v == $values_id) unset($a[$k]);
        }

        return self::$db->update('__products_accessories_features',['features_values' => implode(',', $a)], "id = '{$id}' limit 1");
    }
}