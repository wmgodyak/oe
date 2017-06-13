<?php

namespace modules\shop\controllers\admin;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use system\core\DataTables2;
use system\Backend;

/**
 * Class Video
 * @package modules\shop\controllers\admin
 */
class Kits extends Backend
{
    public function __construct()
    {
        parent::__construct();
    }

    public function init()
    {
        parent::init();
    }

    public function index()
    {
        $t = new DataTables2('content');

        $t  -> ajax('module/run/shop/kits/index/')
            -> th($this->t('common.id'), 'k.id', 1, 1, 'width: 60px')
            -> th($this->t('common.name'), 'k.name', 1, 1)
            -> th($this->t('common.tbl_func'), null, 0, 0, 'width: 80px')
        ;
        $t->get('k.products_id');
        $t->get('ci.name as product');

        if($this->request->isXhr()){
            $t  -> from('__kits k')
                -> join("__content_info ci on ci.content_id=k.products_id and ci.languages_id={$this->languages_id}")
                ;

            $t-> execute();

            $res = array();
            foreach ($t->getResults(false) as $i=>$row) {

                $res[$i][] = $row['id'];
                $res[$i][] =  "{$row['name']} для {$row['product']}";
                $res[$i][] =
                    (string)Link::create
                    (
                        Icon::create(Icon::TYPE_EDIT),
                        ['class' => 'btn-primary', 'href' => "module/run/shop/products/edit/" . $row['products_id'], 'title' => $this->t('common.title_edit')]
                    )
                ;
            }

            echo $t->render($res, $t->getTotal());//$this->response->body($t->render($res, $t->getTotal()))->asJSON();
            return;
        }

        $this->output($t->init());
    }
    
    public function create()
    {
    }

    public function edit($id)
    {
    }

    public function delete($id){}

    public function process($id = null)
    {

    }

}