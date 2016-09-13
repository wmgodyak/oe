<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 01.07.16 : 12:24
 */

namespace modules\shop\models\products;

defined("CPATH") or die();

/**
 * Class Features
 * @package modules\shop\models\products
 */
class Features extends \system\models\Features
{
    /**
     * @param $products_id
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get($products_id)
    {
        $features = self::$db
            ->select("
                select f.id, f.type, fi.name
                from __content_features cf
                join __features f on f.id = cf.features_id and f.status = 'published' and f.hide = 0
                join __features_info fi on fi.features_id = cf.features_id and fi.languages_id = {$this->languages_id}
                where cf.content_id={$products_id}
            ")
            ->all();

        foreach ($features as $k=>$feature) {
            $features[$k]['values'] = self::$db
                ->select("
                select f.id, f.type, fi.name
                from __content_features cf
                join __features f on f.id = cf.values_id and f.status = 'published'
                join __features_info fi on fi.features_id = cf.values_id and fi.languages_id = {$this->languages_id}
                where cf.content_id={$products_id} and cf.features_id={$feature['id']}
                ")
                ->all();
        }

        return $features;
    }
}