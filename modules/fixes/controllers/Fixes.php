<?php

namespace modules\fixes\controllers;

use helpers\Translit;
use system\core\DB;
use system\core\exceptions\Exception;
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
            try {
                $this->db->update('__content_info', ['url' => $url], " id={$item['id']} limit 1");
            } catch(Exception $e){
                $this->db->update('__content_info', ['url' => $url . '-' . $item['id']], " id={$item['id']} limit 1");
            }

        }

        $p++;
        echo "<script>self.location.href='/route/Fixes/generateUrl?p={$p}';</script>";
    }

    /**
     * http://engine.loc/route/Fixes/parseMage
     * @throws Exception
     */
    public function parseMage()
    {
        echo '<pre>';
        $conf = [
            'type'     => 'mysql',
            'host'     => '185.25.117.79',
            'db'       => 'cma',
            'prefix'   => '',
            'user'     => 'v',
            'pass'     => 'v',
            'port'     => 3306,
            'charset'  => 'utf8',
            'debug'    => true
        ];

        $cdb = new DB($conf);
        var_dump($cdb);die;
        $num = 10;
        $p = isset($_GET['p']) ? (int)$_GET['p'] : 0;
        $start = $p * $num;

        $r = $this->db->select("select id, external_id from __content where types_id=23 limit {$start}, {$num}",1)->all();
        foreach ($r as $item) {

        }

        $p ++;

        echo "<script>self.location.href='/route/Fixes/parseMage?p={$p}';</script>";
    }
}