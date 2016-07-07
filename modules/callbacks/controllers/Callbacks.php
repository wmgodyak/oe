<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:11
 */

namespace modules\callbacks\controllers;

defined("CPATH") or die();

use helpers\FormValidation;
use system\core\WidgetsAreas;
use system\Front;
use system\models\Mailer;

/**
 * Class Callback
 * @package modules\callback\controllers
 */
class Callbacks extends Front
{
    private $callback;

    public function __construct()
    {
        parent::__construct();

        $this->callback = new \modules\callbacks\models\Callbacks();
    }

    public function init()
    {
    }

    public function process()
    {
        if(! $this->request->isPost()) die;

        $s=0; $i = array(); $m = '';
        $data = $this->request->post('data', 's');

        FormValidation::setRule(['message', 'name', 'phone'], FormValidation::REQUIRED);
        FormValidation::run($data);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } else {
            $s = $this->callback->create($data);
            if(! $s ){
                $m = 'ERROR1: '. $this->callback->getErrorMessage();
            } else {

                $mailer = new Mailer('callback', $data);

                if(!$mailer->send()) {
                    $m = '<br>ERROR2: '.$mailer->getErrorInfo();
                } else {
                    $m = $this->t('callback.success');
                }
            }
        }
        $this->response->body(['s'=>$s, 'i' => $i, 'm' => $m])->asJSON();
    }
}