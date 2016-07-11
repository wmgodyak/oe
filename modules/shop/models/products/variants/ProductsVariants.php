<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 03.07.16
 * Time: 15:49
 */

namespace modules\shop\models\products\variants;

use system\models\Model;

/**
 * Class ProductsVariants
 * @package modules\shop\models\products\variants
 */
class ProductsVariants extends Model
{
    /**
     * @param $content_id
     * @param $group_id
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get($content_id, $group_id)
    {
        $variants = self::$db
            ->select("
              select v.id, v.in_stock, v.img, vp.price
              from __products_variants v
              join __products_variants_prices vp on
                vp.variants_id=v.id and vp.content_id={$content_id} and vp.group_id = {$group_id}
              where v.content_id={$content_id}
            ")
            ->all();

        foreach ($variants as $k=>$variant) {
            $variants[$k]['name'] = $this->makeName($variant['id']);
        }

        return $variants;
    }

    /**
     * @param $variants_id
     * @return string
     * @throws \system\core\exceptions\Exception
     */
    private function makeName($variants_id)
    {
        $r = self::$db
            ->select("select fi.name
                      from __products_variants_features vf
                      join __features_info fi on fi.features_id=vf.values_id and fi.languages_id='{$this->languages_id}'
                      where vf.variants_id={$variants_id}
                      order by vf.id asc
                    ")
            ->all('name');

        return implode('/', $r);
    }
}