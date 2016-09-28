<?php

namespace modules\newsletter\controllers;

use helpers\FormValidation;
use modules\newsletter\models\Campaigns;
use modules\newsletter\models\Subscribers;
use system\core\EventsHandler;
use system\models\Mailer;
use system\models\Settings;

defined("CPATH") or die();
/**
 * Class Newsletter
 * @name Newsletter
 */
class Newsletter extends \system\Front
{
    private $subscribers;
    private $campaigns;

    public function __construct()
    {
        parent::__construct();

        $this->subscribers = new Subscribers();
        $this->campaigns = new Campaigns();
    }

    public function init()
    {
        parent::init(); // TODO: Change the autogenerated stub
        $this->template->assignScript('modules/newsletter/js/newsletter.js');
        EventsHandler::getInstance()->add('system.cron.run', [$this, 'cron']);
    }

    public function subscribe()
    {
//        FormValidation::
        if(! $this->request->isPost()) die;

        $data = $this->request->post('data');

        $s=0; $i = array(); $m = '';

        FormValidation::setRule(['email'], FormValidation::REQUIRED);
        FormValidation::setRule('email', FormValidation::EMAIL);
        FormValidation::run($data);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } elseif($this->subscribers->is($data['email'])){

            $i[] = ['data[email]' => $this->t('newsletter.is_subscribe_on')];

        } else {

            $group_id = Settings::getInstance()->get('modules.Newsletter.config.group_id');

            $subscriber_id = $this->subscribers->create($data);

            if($subscriber_id > 0 && $group_id > 0){
                $this->subscribers->groups_subscribers->create($group_id, $subscriber_id);
            }

            if($subscriber_id > 0){
                $sData  = $this->subscribers->getData($subscriber_id);
                $mailer = new Mailer('modules/newsletter/mail/confirm', 'Підтвердіть e-mail', $sData);
                $mailer->addAddress($data['email']);
                if(!$mailer->send()) {
                    $m = '<br>ERROR: '.$mailer->getErrorInfo();
                } else {
                    $s=1;
                    $m = $this->t('newsletter.confirm_email');
                }
            } elseif($this->subscribers->hasError()) {
                $m = 'DB ERROR';//$this->subscribers->getErrorMessage();
            }
        }
        $this->response->body(['s'=>$s, 'i' => $i, 'm' => $m])->asJSON();
    }

    public function confirm($code = null)
    {
        if(empty($code)) die;

        if( ! $this->subscribers->confirm($code)){
            echo $this->t('newsletter.confirm_error');
        } else {
            $m = $this->t('newsletter.confirm_success');
            echo "<p>{$m}</p>";
            echo "<script>setTimeout(function(){self.location.href='/'}, 2000);</script>";
        }
    }

    public function unsubscribe($code = null)
    {
        if(empty($code)) die;

        if( ! $this->subscribers->unsubscribe($code)){
            echo $this->t('newsletter.unsubscribe_error');
        } else {
            $m = $this->t('newsletter.unsubscribe_success');
            echo "<p>{$m}</p>";
            echo "<script>setTimeout(function(){self.location.href='/'}, 2000);</script>";
        }
    }

    public function cron()
    {
        $this->campaigns->cron();
    }
}