<?php
namespace modules\gmap\controllers\admin;

use helpers\bootstrap\Button;
use system\core\Session;
use system\models\Languages;
use system\models\Settings;

defined('CPATH') or die();


/**
 * Class Gmap
* @package modules\gmap\controllers\admin
*/
class Gmap extends \system\Engine
{
    private $mLanguages;
    private $model;
    public function __construct()
    {
        parent::__construct();
        $this->mLanguages = new Languages();
        $this->model = new \modules\gmap\models\admin\Gmap();
    }

    public function init()
    {
        parent::init();
            
        $this->assignToNav('Мапа', 'module/run/gmap', 'fa-map-marker');
        $this->template->assignScript('modules/gmap/js/admin/gmap.js');
    }

    public function index()
    {
        $this->appendToPanel((string)Button::create
        (
            "Додати маркер",
            ['class' => 'btn-md', 'onclick'=> 'gmap.loadForm()']
        )
        );

        $items = $this->model->get();
        $this->template->assign(array(
            'items'        => json_encode($items),
            'gmap_api_key' => Settings::getInstance()->get('modules.Gmap.config.api_key')
        ));
        $this->output($this->template->fetch('modules/gmap/map'));
    }

    public function loadForm()
    {
        $this->template->assign(array(
           'languages'=>$this->mLanguages->get(),
            'action' => 'create'
        ));
        echo $this->template->fetch('modules/gmap/form');
    }

    public function create()
    {

    }

    public function edit($id)
    {
        $languages = $this->mLanguages->get();
        foreach ($languages as $k=>$item) {
            $lang = $this->model->getField($id,'name', $item['id']);
            $languages[$k]['info'] = $lang;
        }

        $this->template->assign(array(
            'languages'=>$languages,
            'action' => 'edit',
            'coords' => $this->model->getField($id,'value'),
            'id' => $id
        ));
        echo $this->template->fetch('modules/gmap/form');
    }

    public function delete($id)
    {
        if (!isset($id) || empty($id)) return false;

        $this->model->delete($id);
    }

    public function process($id)
    {

    }

    public function processing()
    {
        $data = $this->request->post('data');
        $info = $this->request->post('info');
        $i=[]; $m = ''; $s = 0;


        switch($this->request->post('action')){
            case 'create':
                $id = $this->model->create($data,$info);
                break;
            case 'edit':
                $id = $this->request->post('id');

                $s = $this->model->update($id,$data,$info);
                break;
            default:
                die('Wrong Action');
                break;
        }

        if($this->model->hasError()){
            $i = $this->model->getError();
            $m = $this->model->getErrorMessage();
        } else {
            $s = 1;
            $m = 'OK';
        }

        $this->response->body(['s'=>$s, 'i' => $i, 'm' => $m, 'id' => $id])->asJSON();
    }
}