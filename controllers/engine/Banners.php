<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 16.03.16 : 16:47
 */

namespace controllers\engine;

use controllers\Engine;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use helpers\FormValidation;

defined("CPATH") or die();

/**
 * Class Banners
 * @name Банери
 * @icon fa-cogs
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @position 6
 * @package controllers\engine
 */
class Banners extends Engine
{
    private $banners;
    private $places;

    public function __construct()
    {
        parent::__construct();

        $this->banners = new \models\engine\Banners();
        $this->places  = new \models\engine\BannersPlaces();
    }

    public function index()
    {
        $this->appendToPanel
        (
            (string)Button::create($this->t('common.button_create'), ['class' => 'btn-md b-banners-places-create'])
        );

        $t = new DataTables();
        $t  -> setId('banners')
            -> ajaxConfig('banners/items')
            -> th($this->t('common.id'), '', 'width: 20px')
            -> th($this->t('banners_places.name'))
            -> th($this->t('banners_places.code'))
            -> th($this->t('banners_places.width'))
            -> th($this->t('banners_places.height'))
            -> th($this->t('banners_places.total'))
            -> th($this->t('common.tbl_func'), '', 'width: 120px')
        ;

        $this->output($t->render());
    }

    public function items()
    {
        $t = new DataTables();
        $t  -> table('banners_places')
            -> get('id, name, code, width, height');
        $t  -> execute();

        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {
            $res[$i][] = $row['id'];
            $res[$i][] = "<a href='banners/bannersSlides/{$row['id']}'>{$row['name']}</a>";
            $res[$i][] = $row['code'];
            $res[$i][] = $row['width'];
            $res[$i][] = $row['height'];
            $res[$i][] = $this->places->getTotalBanners($row['id']);
            $res[$i][] =
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    ['class' => 'b-banners-places-edit', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
                ) .
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'b-banners-places-delete', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                )
            ;
        }

        return $t->renderJSON($res, $t->getTotal());
    }

    public function bannersSlides($place_id)
    {
        if($this->request->isXhr()){
            $t = new DataTables();
            $t  -> table('banners')
                -> get('id, img, languages_id,  published, permanent, df, dt');
            $t  -> execute();
            $lang = $this->banners->getLanguages();
            $res = array();
            foreach ($t->getResults(false) as $i=>$row) {
                $res[$i][] = $row['id'];
                $res[$i][] = "<img src='{$row['img']}' align='banner' style='max-height: 60px; max-width: 120px;'>";
                $res[$i][] = $lang[$row['languages_id']];
                if($row['permanent'] == 1){
                    $res[$i][] = $this->t('banners.permanent_y');
                } else{
                    $res[$i][] = $this->t('banners.permanent_n');
                }

                $res[$i][] =
                    (string)Button::create
                    (
                        Icon::create(Icon::TYPE_EDIT),
                        ['class' => 'b-banners-edit', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
                    ) .
                    (string)Button::create
                    (
                        Icon::create(Icon::TYPE_DELETE),
                        ['class' => 'b-banners-delete', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                    )
                ;
            }

            return $t->renderJSON($res, $t->getTotal());
        }

        $this->appendToPanel((string)Link::create
        (
            $this->t('common.back'),
            ['class' => 'btn-md', 'href'=> 'banners']
        )
        );
        $this->appendToPanel
        (
            (string)Button::create($this->t('common.button_create'), ['class' => 'btn-md b-banners-create', 'data-id'=>$place_id])
        );

        $t = new DataTables();
        $t  -> setId('banners')
            -> ajaxConfig('banners/bannersSlides/' . $place_id)
            -> th($this->t('common.id'), '', 'width: 20px')
            -> th($this->t('banners.img'))
            -> th($this->t('banners.lang'))
            -> th($this->t('banners.active'))
            -> th($this->t('common.tbl_func'), '', 'width: 120px')
        ;

        $this->output($t->render());
    }

    public function create($id=null)
    {
        $this->template->assign('action', 'create');
        $this->template->assign('place_id', $id);
        $this->response->body($this->template->fetch('banners/banner'))->asHtml();
    }
    public function edit($id)
    {
        $this->template->assign('data', $this->banners->getData($id));
        $this->template->assign('action', 'edit');
        $this->response->body($this->template->fetch('banners/banner'))->asHtml();
    }

    public function process($id= null)
    {
        if(! $this->request->isPost()) die;

        $data = $this->request->post('data');
        $s=0; $i=[];

        FormValidation::setRule(['url'], FormValidation::REQUIRED);

        FormValidation::run($data);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } elseif($data['permanent'] == 0  && (empty($data['df']) || empty($data['dt']))){
            $i[] = ["data[df]" => $this->t('banners.df_dt_error')];
        } else {
            switch($this->request->post('action')){
                case 'create':
                    $s = $this->banners->create();
                    break;
                case 'edit':
                    if( $id > 0 ){
                        $s = $this->banners->update($id);
                    }
                    break;
            }
            if(! $s){
                echo $this->banners->getDBErrorMessage();
            }

        }

        $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
    }

    public function delete($id)
    {
        return $this->banners->delete($id);
    }


    public function plCreate()
    {
        $this->template->assign('action', 'create');
        $this->response->body($this->template->fetch('banners/place'))->asHtml();
    }

    public function plEdit($id)
    {
        $this->template->assign('data', $this->places->getData($id));
        $this->template->assign('action', 'edit');
        $this->response->body($this->template->fetch('banners/place'))->asHtml();
    }

    public function plProcess($id= null)
    {
        if(! $this->request->isPost()) die;

        $banners = $this->request->post('data');
        $s=0; $i=[];

        FormValidation::setRule(['name','width','height','code'], FormValidation::REQUIRED);

        FormValidation::run($banners);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } else {
            switch($this->request->post('action')){
                case 'create':
                    $s = $this->places->create();
                    break;
                case 'edit':
                    if( $id > 0 ){
                        $s = $this->places->update($id);
                    }
                    break;
            }
            if(! $s){
                echo $this->places->getDBErrorMessage();
            }

        }

        $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
    }

    public function plDelete($id)
    {
        return $this->places->delete($id);
    }

}