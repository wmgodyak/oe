<?php

namespace modules\fixes\controllers;

use helpers\Translit;
use system\core\DB;
use system\Front;

class Fixes extends Front
{
    private $db;

    public function __construct()
    {
        parent::__construct();

        $this->db = DB::getInstance();
    }

    public function generateUrl()
    {
        $p = isset($_GET['p']) ? $_GET['p'] : 0; $num = 100;
        $start = $p * $num;

        $r = $this->db
            ->select("
                select i.id, i.name, i.url
                from __content c
                join __content_info i on i.content_id=c.id
                where c.types_id = 23
                limit {$start}, {$num}
                ")
            ->all();

        if(empty($r)) return;

        foreach ($r as $item) {
            $url = Translit::str2url($item['name']);
            $this->db->update('__content_info', ['url' => $url], " id={$item['id']} limit 1",1);
        }

        $p++;
        echo "<script>self.location.href='/route/Fixes/generateUrl?p={$p}';</script>";
    }
}