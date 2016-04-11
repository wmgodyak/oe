<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 11.04.16 : 9:58
 */

namespace controllers\modules;

use controllers\App;
use helpers\FormValidation;
use models\components\Mailer;

defined("CPATH") or die();

/**
 * Class Callback
 * @package controllers\modules
 */
class Callback extends App
{
    private $callback;

    public function __construct()
    {
        parent::__construct();
        $this->callback = new \models\modules\Callback();
    }

    public function process()
    {
        if(! $this->request->isPost()) die;
        sleep(1);
        $s=0; $i = array(); $m = '';
        $data = $this->request->post('data');

        $data['message'] = htmlspecialchars(strip_tags($data['message']));

        FormValidation::setRule(['message', 'name', 'phone'], FormValidation::REQUIRED);
        FormValidation::run($data);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } else {
            $s = $this->callback->create($data);
            if(! $s ){
                $m = 'ERROR1: '. $this->callback->getDBErrorMessage();
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