<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 28.08.16
 * Time: 13:20
 */

namespace modules\shop\models\products;

use system\models\Model;

/**
 * Class KitsProducts
 * @package modules\shop\models\products
 */
class KitsProducts extends Model
{

    /**
     * @param $kits_id
     * @param $products_id
     * @param int $discount
     * @return bool|string
     */
    public function create($kits_id, $products_id, $discount = 0)
    {
        $a = self::$db
            ->select("select id from __kits_products where kits_id = {$kits_id} and products_id = {$products_id} limit 1")
            ->row('id');
        if( ! empty($a['id'])) return false;

        return $this->createRow
        (
            '__kits_products',
            ['kits_id' => $kits_id, 'products_id'=> $products_id, 'discount' => $discount]
        );
    }

    /**
     * @param $kits_id
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get($kits_id)
    {
        return self::$db
            ->select("
                select kp.id, c.id as products_id, i.name, kp.discount
                from __kits_products kp
                join __content c on c.id=kp.products_id
                join __content_info i on i.content_id=c.id and i.languages_id='{$this->languages_id}'
                where kp.kits_id='{$kits_id}'
            ")
            ->all();
    }

    public function delete($id)
    {
        return $this->deleteRow('__kits_products', $id);
    }

    public function setDiscount()
    {
        $discount = $this->request->post('discount');
        foreach ($discount as $id => $d) {
            $this->updateRow('__kits_products', $id, ['discount' => $d]);
        }

        return ! $this->hasError();
    }

    /**
     * @param $q
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function searchProducts($q)
    {
        $where = [];
        $q = explode(' ', $q);
        foreach ($q as $k=>$v) {
            $v = trim($v);
            if(empty($v)) continue;

            $where[] = " ((i.name like '%{$v}%') or (p.sku like '{$v}%') )";
        }

        $w = implode('and ', $where);

        return self::$db
            ->select("
                select SQL_CALC_FOUND_ROWS c.id, i.name
                from __content c
                join __products p on p.content_id=c.id
                join __content_types ct on ct.type='product' and ct.id=c.types_id
                join __content_info i on i.content_id=c.id and i.languages_id='{$this->languages_id}'
                where {$w}  and c.status ='published'
            ")
            ->all();
    }

    public function searchTotal()
    {
        return self::$db->select('SELECT FOUND_ROWS() as t')->row('t');
    }
}