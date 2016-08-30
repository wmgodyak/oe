<?php

namespace modules\waitlist\controllers\admin;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\DateTime;
use system\core\DataTables2;
use system\Engine;

/**
 * Class Waitlist
 * @package modules\waitlist\controllers\admin
 */
class Waitlist extends Engine
{
    private $mWaitlist;

    public function __construct()
    {
        parent::__construct();

        $this->mWaitlist = new \modules\waitlist\models\Waitlist();
    }

    public function init()
    {
        // додаю в меню
        $this->assignToNav('Бажані товари', 'module/run/waitlist', 'fa-phone', 'module/run/shop', 100);

        $this->template->assignScript("modules/waitlist/js/admin/Waitlist.js");
    }

    public function index()
    {
        $t = new DataTables2('waitlist');

        $t  -> ajax('module/run/waitlist/index')
            -> orderDef(0, 'desc')
            -> th($this->t('common.id'), 'wl.id', 1,1, 'width:60px')
            -> th($this->t('waitlist.name'), 'ci.name as product', 1, 1, 'width: 200px')
            -> th($this->t('waitlist.email'), 'wl.name', 1, 1)
            -> th($this->t('waitlist.email'), 'wl.email', 1, 1)
            -> th($this->t('waitlist.created'), 'created', 0, 0, 'width: 200px')
//            -> th($this->t('common.tbl_func'), null, 0, 0, 'width: 180px')
        ;

        if($this->request->isPost()){

            $t-> from('__waitlist wl');
            $t->join("__content_info ci on ci.content_id=wl.products_id and ci.languages_id={$this->languages_id}");

            $t-> execute();

            $res = array();
            foreach ($t->getResults(false) as $i=>$row) {

                $res[$i][] = $row['id'];
                $res[$i][] = $row['product'];
                $res[$i][] = $row['name'];
                $res[$i][] = $row['email'];

                $res[$i][] = DateTime::ago(strtotime($row['created']));
            }

            echo $t->render($res, $t->getTotal());die;
        }

        $this->output($t->init());
    }

    public function tab($status)
    {

    }

    public function create()
    {
    }

    public function edit($id)
    {
    }

    public function process($id= null)
    {
    }

    public function delete($id)
    {
        return $this->mWaitlist->delete($id);
    }
}