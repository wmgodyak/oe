<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 27.06.16 : 18:12
 */

namespace modules\banners\controllers\admin;

use helpers\FormValidation;
use system\Engine;

defined("CPATH") or die();

/**
 * Class Places
 * @package modules\banners\controllers\admin
 */
class Places extends Engine
{
    private $places;

    public function __construct()
    {
        parent::__construct();
        $this->places = new \modules\banners\models\admin\Places();
    }


    public function index()
    {
        // TODO: Implement index() method.
    }

    public function create()
    {
        $this->template->assign('action', 'create');
        $this->response->body($this->template->fetch('modules/banners/places/form'));
    }
    public function edit($id)
    {
        // TODO: Implement edit() method.
    }
    public function delete($id)
    {
        echo $this->places->delete($id);
    }

    public function process($id = null)
    {
        if(! $this->request->isPost()) die;

        $data = $this->request->post('data');
        $s=0; $i=[];

        FormValidation::setRule(['name', 'code', 'width', 'height'], FormValidation::REQUIRED);

        FormValidation::run($data);

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
                echo $this->places->getErrorMessage();
            }

        }

        $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
    }
}