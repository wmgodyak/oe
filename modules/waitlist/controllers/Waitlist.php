<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:11
 */

namespace modules\waitlist\controllers;

defined("CPATH") or die();

use helpers\FormValidation;
use system\core\WidgetsAreas;
use system\Front;
use system\models\Mailer;

/**
 * Class Waitlist
 * @name Списки бажаних товарів
 * @description
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @package modules\Waitlist\controllers
 */
class Waitlist extends Front
{
    private $waitlist;

    public function __construct()
    {
        parent::__construct();

        $this->waitlist = new \modules\waitlist\models\Waitlist();
    }

    public function init()
    {
        $this->template->assignScript('modules/waitlist/js/Waitlist.js');
    }

    public function create()
    {
        if(! $this->request->isPost()) die;

        $s=0; $i = array(); $m = '';
        $data = $this->request->post('data');

        FormValidation::setRule(['name', 'email'], FormValidation::REQUIRED);
        FormValidation::setRule(['email'], FormValidation::EMAIL);
        FormValidation::run($data);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } else {
            $s = $this->waitlist->create($data);
            if(! $s ){
                $m = 'ERROR1: '. $this->waitlist->getErrorMessage();
            } else {

                $mailer = new Mailer('modules/waitlist/mail', 'New Waitlist', $data);

                if(!$mailer->send()) {
                    $m = '<br>ERROR2: '.$mailer->getErrorInfo();
                } else {
                    $m = $this->t('waitlist.success');
                }
            }
        }
        $this->response->body(['s'=>$s, 'i' => $i, 'm' => $m])->asJSON();
    }
}