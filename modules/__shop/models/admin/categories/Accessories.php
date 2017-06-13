<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 26.08.16
 * Time: 22:52
 */

namespace modules\shop\models\admin\categories;

use system\models\Model;

/**
 * Class Accessories
 * @package modules\shop\models\categories
 */
class Accessories extends Model
{
    public $features;

    public function __construct()
    {
        parent::__construct();

        $this->features = new AccessoriesFeatures();
    }

    /**
     * @param $products_categories_id
     * @param $categories_id
     * @return bool|string
     */
    public function create($products_categories_id, $categories_id)
    {
        $id = self::$db
            ->select
            ("
                select id
                from __products_accessories
                where products_categories_id = {$products_categories_id} and categories_id = {$categories_id} limit 1
            ")
            ->row('id');

        if($id > 0 ) return false;

        return $this->createRow
        (
            '__products_accessories',
            [
                'products_categories_id' => $products_categories_id,
                'categories_id'          => $categories_id
            ]
        );
    }

    public function getCategories($products_categories_id)
    {
        $cat = self::$db
        ->select("
                select pc.id,c.id as categories_id, i.name
                from __products_accessories pc
                join __content c on c.id=pc.categories_id
                join __content_info i on i.content_id=c.id and i.languages_id={$this->languages_id}
                where pc.products_categories_id = {$products_categories_id}
                order by i.name asc
            ")
        ->all();
        foreach ($cat as $k=>$item) {
            $cat[$k]['features'] = $this->features->get($item['id']);
        }
        return $cat;
    }

    public function delete($id)
    {
        return parent::deleteRow('__products_accessories', $id);
    }

    /**
     * @param $w
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function searchCategories($w)
    {
        $w = implode('and ', $w);

        return self::$db
            ->select("
                select SQL_CALC_FOUND_ROWS c.id, i.name
                from __content c
                join __content_types ct on ct.type='products_categories' and ct.id=c.types_id
                join __content_info i on i.content_id=c.id and i.languages_id={$this->languages_id}
                where {$w}  and c.status ='published'
            ")
            ->all();
    }

    public function searchTotal()
    {
        return self::$db->select('SELECT FOUND_ROWS() as t')->row('t');
    }

}