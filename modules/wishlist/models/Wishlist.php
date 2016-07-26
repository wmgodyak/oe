<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 15.07.16 : 16:35
 */

namespace modules\wishlist\models;

use system\core\Session;
use system\models\Model;

defined("CPATH") or die();

class Wishlist extends Model
{
    private $products;

    public function __construct()
    {
        parent::__construct();
        $this->products = new WishlistProducts();
    }

    public function get()
    {
        $user = Session::get('user');
        if( ! $user) return null;

        $res = self::$db
            ->select("select id, name from __wishlist where users_id='{$user['id']}' order by id desc")
            ->all();

        foreach ($res as $k=>$row) {
            $res[$k]['products'] = $this->products->get($row['id']);
        }

        return $res;
    }

    public function create($name, $users_id)
    {
        return $this->createRow('__wishlist', ['name' => $name, 'users_id' => $users_id]);
    }
}