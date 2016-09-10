<?php
namespace modules\shopBlog\models;

use system\models\ContentRelationship;
use system\models\Model;

class ShopBlog extends Model
{

    public function getCategoriesPosts($categories_id, $start = 0, $num = 5)
    {
        return self::$db
            ->select("
                  select c.id, ci.name, ci.title, ci.intro, UNIX_TIMESTAMP(c.created) as created
                  from __content_relationship cr
                  join __content c on c.status  = 'published'
                  -- join __content_types ct on ct.type = 'post' and ct.id=c.types_id
                  join __content_info ci on ci.content_id=c.id and ci.languages_id='{$this->languages_id}'
                  where  cr.categories_id={$categories_id} and cr.content_id=c.id and cr.type='post_shop_cat'
                  order by c.published desc
                  limit {$start}, {$num}
            ")
            ->all();
    }

    public function getProductsPosts($products_id, $start = 0, $num = 5)
    {
        return self::$db
            ->select("
                  select c.id, ci.name, ci.title, ci.intro, UNIX_TIMESTAMP(c.created) as created
                  from __content_relationship cr
                  join __content c on c.status  = 'published'
                  -- join __content_types ct on ct.type = 'post' and ct.id=c.types_id
                  join __content_info ci on ci.content_id=c.id and ci.languages_id='{$this->languages_id}'
                  where  cr.categories_id={$products_id} and cr.content_id=c.id and cr.type='post_shop_product'
                  order by c.published desc
                  limit {$start}, {$num}
            ")
            ->all();
    }

    public function getPosts($products_id, $start = 0, $num = 5)
    {
        $w = "cr.categories_id={$products_id} ";

        $rel = new ContentRelationship();
        $cat_id = $rel->getMainCategoriesId($products_id);

        if($cat_id > 0){
            $w = "cr.categories_id in ($products_id, $cat_id) ";
        }

        return self::$db
            ->select("
                  select DISTINCT c.id, ci.name, ci.title, ci.intro, UNIX_TIMESTAMP(c.created) as created
                  from __content_relationship cr
                  join __content c on c.status = 'published'
                  join __content_info ci on ci.content_id=c.id and ci.languages_id='{$this->languages_id}'
                  where  {$w}
                  and cr.content_id=c.id
                  and cr.type in ('post_shop_cat','post_shop_product')
                  order by c.published desc
                  limit {$start}, {$num}
            ")
            ->all();
    }
}