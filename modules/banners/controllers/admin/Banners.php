<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:11
 */

namespace modules\banners\controllers\admin;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use helpers\FormValidation;
use system\core\DataTables2;
use system\Engine;

class Banners extends Engine
{
    private $banners;
    private $places;

    public function __construct()
    {
        parent::__construct();
        $this->banners = new \modules\banners\models\admin\Banners();
        $this->places  = new \modules\banners\models\admin\Places();
    }

    public function init()
    {
        $this->assignToNav('Банери', 'module/run/banners', 'fa-picture-o', null, 100);
        $this->template->assignScript("modules/banners/js/admin/banners.js");
    }

    public function index()
    {
        $this->template->assign('places', $this->places->get());
        $this->output($this->template->fetch('banners/index'));
    }

    public function place($id, $results = null)
    {

        $this->appendToPanel((string)Link::create
        (
            $this->t('common.back'),
            ['class' => 'btn-md', 'href'=> 'banners']
        )
        );
        $this->appendToPanel
        (
            (string)Button::create
            (
                $this->t('common.button_create'),
                ['class' => 'btn-md btn-primary b-banners-create', 'data-id'=>$id])
        );

        $t = new DataTables2('banners_' . $id);
        $t  -> ajax('module/run/banners/place/' . $id . '/1')
            -> th($this->t('common.id'), 'id', 0, 1, 'width: 20px')
            -> th($this->t('banners.img'), 'img', 0, 0)
            -> th($this->t('banners.name'), 'name', 1, 0)
            -> th($this->t('banners.url'), 'url', 1, 0)
            -> th($this->t('banners.lang'), 'languages_id', 0, 0)
            -> th($this->t('banners.active'), 'published', 0, 1)
            -> th($this->t('common.tbl_func'), null, 0, 0, 'width: 160px')
            -> get('permanent', 0 , 0)
        ;

        if($results){
            $t  -> from('__banners')
                -> get('id, img, url, languages_id,  published, permanent, df, dt')
                -> where(" places_id={$id}");

            $t  -> execute();
            $lang = $this->banners->getLanguages();
            $res = array(); $appurl = APPURL;
            foreach ($t->getResults(false) as $i=>$row) {

                $row['img'] = empty($row['img']) ? "/themes/engine/assets/img/no-image.png" : $row['img'];
                $res[$i][] = $row['id'];
                $res[$i][] = "<img src='{$row['img']}' align='banner' style='max-height: 60px; max-width: 120px;'>";
                $res[$i][] = $row['name'];
                $res[$i][] = "<a href='{$appurl}{$row['url']}' target='_blank'>{$row['url']}</a>";
                $res[$i][] = $lang[$row['languages_id']];
                if($row['permanent'] == 1){
                    $res[$i][] = $this->t('banners.permanent_y');
                } else {
                    $res[$i][] = $this->t('banners.permanent_n');
                }

                $res[$i][] =
                    (string)Button::create
                    (
                        Icon::create(Icon::TYPE_EDIT),
                        ['class' => 'b-banners-edit btn-primary', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
                    ) .
                    (string)Button::create
                    (
                        Icon::create(Icon::TYPE_DELETE),
                        ['class' => 'b-banners-delete btn-danger', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                    )
                ;
            }
            echo $t->render($res, $t->getTotal()); die;
//            $this->response->body($t->render($res, $t->getTotal()))->asJSON();
            return;
        }

        $button = Button::create($this->t('banners.create') , ['data-id' => $id, 'class' => 'btn-primary b-banners-create']);
        $button = "<div style='background: #fff;padding: 5px 10px;'>{$button}</div>";
        $this->output
        (
            $button . $t->init()
        );

    }

    public function create($id = 0)
    {
        $this->template->assign('action', 'create');
        $this->template->assign('place_id', $id);
        $this->template->assign('sizes', $this->banners->getPlaceSizes($id));
        $this->response->body($this->template->fetch('banners/banner'))->asHtml();
    }

    public function edit($id)
    {
        $data =$this->banners->getData($id);
        $this->template->assign('data', $data);
        $this->template->assign('sizes', $this->banners->getPlaceSizes($data['places_id']));
        $this->template->assign('action', 'edit');
        $this->response->body($this->template->fetch('banners/banner'))->asHtml();
    }

    public function delete($id)
    {
        return $this->banners->delete($id);
    }

    public function process($id = 0)
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
                echo $this->banners->getErrorMessage();
            }

        }

        $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
    }

    public function places()
    {
        include "Places.php";

        $params = func_get_args();
        $action = array_shift($params);

        $controller  = new Places();

        return call_user_func_array(array($controller, $action), $params);
    }
}