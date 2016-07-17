<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:11
 */

namespace modules\feedback\controllers;

use helpers\FormValidation;
use system\Front;
use system\models\Mailer;

/**
 * Class Feedback
 * @name Фідбек
 * @description
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @package modules\feedback\controllers
 */
class Feedback extends Front
{
    private $feedback;

    public function __construct()
    {
        parent::__construct();

        $this->feedback = new \modules\feedback\models\Feedback();
    }

    public function init()
    {
        $this->template->assignScript('modules/feedback/js/feedback.js');
    }

    public function process()
    {
        if(! $this->request->isPost()) die;

        $s=0; $i = array(); $m = '';
        $data = $this->request->post('data');

        $data['message'] = htmlspecialchars(strip_tags($data['message']));

        FormValidation::setRule(['message', 'name','email', 'phone'], FormValidation::REQUIRED);
        FormValidation::setRule('email', FormValidation::EMAIL);
        FormValidation::run($data);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } else {

            $this->feedback->create($data);
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