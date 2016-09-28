<?php

namespace modules\newsletter\controllers\admin\newsletter;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use helpers\FormValidation;
use system\core\DataTables2;
use system\Engine;

defined("CPATH") or die();

/**
 * Class Campaigns
 * @package modules\newsletter\controllers\admin\newsletter
 */
class Campaigns extends Engine
{
    private $campaigns;
    public function __construct()
    {
        parent::__construct();

        $this->campaigns = new \modules\newsletter\models\admin\Campaigns();
    }

    public function index()
    {

        $this->appendToPanel
        (
            (string)Link::create
            (
                $this->t('common.button_create'), ['class' => 'btn-md btn-primary', 'href' => 'module/run/newsletter/campaigns/create']
            )
        );

        $t = new DataTables2('newsletter_campaigns');

        $t
            -> th($this->t('common.id'), 'id', true, true)
            -> th('Name', 'name', true, true)
            -> th('Sender Name', 'sender_name', false, true)
            -> th('Sender Email', 'sender_email', false, true)
            -> th($this->t('common.func'), null, false, false)
        ;

        $t-> ajax('module/run/newsletter/campaigns');

        if($this->request->isXhr()){

            $t-> from('__newsletter_campaigns');
            $t-> get('status');
            $t-> execute();

            if(! $t){
                echo $t->getError();
                return null;
            }

            $res = array();
            foreach ($t->getResults(false) as $i=>$row) {

//                $row = DataFilter::apply('newsletter.campaigns.list.row', $row);

                $res[$i][] = $row['id'];
                $res[$i][] = $row['name'];
                $res[$i][] = $row['sender_name'];
                $res[$i][] = $row['sender_email'];

                $b = [];
                $b[] = (string)Link::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    ['class' => 'btn-primary', 'href' => "module/run/newsletter/campaigns/edit/{$row['id']}", 'title' => $this->t('common.title_edit')]
                );

                $b[] = (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'b-newsletter-campaigns-delete btn-danger', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                );

                $res[$i][] = implode('', $b);
            }

            echo $t->render($res, $t->getTotal());die;
        }
        $this->output($t->init());
    }

    public function create()
    {
        $this->appendToPanel((string)Link::create
        (
            $this->t('common.back'),
            ['class' => 'btn-md', 'href'=> 'module/run/newsletter/campaigns']
        )
        );

        $this->appendToPanel
        (
            (string)Button::create
            (
                $this->t('common.button_save'),
                ['class' => 'btn-md b-form-save']
            )
        );
        $this->template->assign('action', 'create');
        $this->output($this->template->fetch('modules/newsletter/campaigns/form'));
    }

    public function edit($id)
    {
        $this->appendToPanel((string)Link::create
        (
            $this->t('common.back'),
            ['class' => 'btn-md', 'href'=> 'module/run/newsletter/campaigns']
        )
        );

        $this->appendToPanel
        (
            (string)Button::create
            (
                $this->t('common.button_save'),
                ['class' => 'btn-md b-form-save']
            )
        );
        $this->template->assign('data', $this->campaigns->getData($id));
        $this->template->assign('action', 'edit');
        $this->output($this->template->fetch('modules/newsletter/campaigns/form'));
    }
    public function delete($id)
    {
        echo $this->campaigns->delete($id);
    }

    public function process($id = null)
    {
        if(! $this->request->isPost()) die;

        $data = $this->request->post('data');

        $s=0; $i=[]; $m="Saved success";

        FormValidation::setRule(['name', 'sender_name', 'sender_email'], FormValidation::REQUIRED);

        FormValidation::run($data);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } else {
            switch($this->request->post('action')){
                case 'create':
                    $s = $this->campaigns->create($data);
                    break;
                case 'edit':
                    $id = $this->request->post('id', 'i');
                    $s = $this->campaigns->update($id, $data);
                    break;
            }

        }

        if($this->campaigns->hasError()){
            $m = $this->campaigns->getErrorMessage();
        }

        $this->response->body(['s'=>$s, 'i' => $i, 'm' => $m])->asJSON();
    }
}