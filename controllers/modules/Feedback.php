<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 31.03.16 : 16:54
 */

namespace controllers\modules;

use controllers\App;
use helpers\FormValidation;
use models\components\Mailer;

defined("CPATH") or die();
/**
 * Class Feedback
 * @name Feedback
 * @icon fa-mail
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class Feedback extends App
{
    public function send()
    {
        if(! $this->request->isPost()) die;
        sleep(1);
        $s=0; $i = array(); $m = '';
        $data = $this->request->post('data');

        $data['message'] = htmlspecialchars(strip_tags($data['message']));

        FormValidation::setRule(['message', 'name','email', 'phone'], FormValidation::REQUIRED);
        FormValidation::setRule('email', FormValidation::EMAIL);
        FormValidation::run($data);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } else {

            $mailer = new Mailer('feedback', $data);

            if(!$mailer->send()) {
                $m = '<br>ERROR: '.$mailer->getErrorInfo();
            } else {
                $s=1;
                $m = $this->t('feedback.success');
            }
        }
        $this->response->body(['s'=>$s, 'i' => $i, 'm' => $m])->asJSON();
    }
}