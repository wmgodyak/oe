<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 28.06.16
 * Time: 22:21
 */

namespace modules\shop\models\admin;

use system\models\Content;

class Products extends Content
{

    /**
     * @param int $categories_id
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get($categories_id = 0, $start = 0, $num = 5)
    {
        $w = ''; $j = '';

        if($categories_id > 0){
            $j .= "join __content_relationship cr on cr.categories_id={$categories_id} and cr.content_id=c.id";
        }

        return self::$db
            ->select("
                  select c.id, c.isfolder, c.status, ci.name, ci.title, ci.intro, c.created, u.id as author_id, concat(u.name, ' ', u.surname) as author
                  from __content c
                  {$j}
                  join __content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id
                  join __content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
                  join __users u on u.id = c.owner_id
                  where {$w} c.status in ('published', 'hidden')
                  order by c.published desc
                  limit {$start}, {$num}
            ")
            ->all();
    }
}