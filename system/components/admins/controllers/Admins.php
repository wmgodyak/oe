<?php

namespace system\components\admins\controllers;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\DateTime;
use helpers\FormValidation;
use system\core\DataTables2;
use system\Backend;

defined("CPATH") or die();

class Admins extends Backend
{
    private $admins;

    public function __construct()
    {
        parent::__construct();

        $this->admins = new \system\components\admins\models\Admins();
    }

    public function init()
    {
        $this->assignToNav(t('admins.action_index'), 'admins', 'fa-users', null, 200);
    }

    /**
     * @param null $group_id
     * @return array|null|string
     */
    public function index($group_id = null)
    {
        $this->appendToPanel((string)Button::create(t('common.button_create'), ['class' => 'btn-md btn-primary b-admins-create']));

        $t = new DataTables2('admins');

        $t
            -> th(t('common.id'),        'u.id', true, true)
            -> th(t('admins.pib'),       'CONCAT(u.surname , \' \', u.name) as username', true, true )
            -> th(t('admins.group'),     'ugi.name as group_name', false, true)
            -> th(t('admins.email'),     'u.email', true, true)
            -> th(t('admins.phone'),     'u.phone', true, true)
            -> th(t('admins.created') ,  'u.created', true, false)
            -> th(t('admins.lastlogin'), 'u.lastlogin', true, false)
            -> th(t('common.func'), null, false, false)
            -> get('u.status', 0, 0, 0 )
        ;

        $t-> ajax('admins/index/'. $group_id);

        if($this->request->isXhr()){

//            $t->get('u.status');
            $t  -> from('__users u')
                -> join("__users_group ug on ug.backend = 1")
                -> join("__users_group_info ugi on ugi.group_id=ug.id and ugi.languages_id={$this->languages->id}")
                -> where(" u.group_id=ug.id");

            if($group_id > 0){
                $t->where("ug.id=$group_id");
            }

            $t  -> execute();

            if(! $t){
                echo $t->getError();
                return null;
            }

            $s = ['ban' => t('admins.status_ban'), 'deleted' => t('admins.status_deleted')];

            $res = array();
            foreach ($t->getResults(false) as $i=>$row) {
                $res[$i][] = $row['id'];
                $res[$i][] = $row['username'] .
                    ($row['status'] != 'active' ? "<br><label class='label label-danger'>{$s[$row['status']]}</label>" : '');
                $res[$i][] = $row['group_name'];
                $res[$i][] = $row['email'];
                $res[$i][] = $row['phone'];
                $res[$i][] = $row['created'];
                $res[$i][] = $row['lastlogin'] ? DateTime::ago(strtotime($row['lastlogin'])) : '';

                $b = [];
                $b[] = (string)Button::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    ['class' => 'b-admins-edit btn-primary', 'data-id' => $row['id'], 'title' => t('common.title_edit')]
                );
                if($row['status'] == 'active'){
                    $b[] =  (string)Button::create
                    (
                        Icon::create(Icon::TYPE_BAN),
                        ['class' => 'b-admins-ban', 'data-id' => $row['id'], 'title' => t('admins.title_ban')]
                    );
                    $b[] = (string)Button::create
                    (
                        Icon::create(Icon::TYPE_DELETE),
                        ['class' => 'b-admins-delete', 'data-id' => $row['id'], 'title' => t('common.title_delete')]
                    );
                } elseif($row['status'] == 'deleted' || $row['status'] == 'ban'){
                    $b[] =  (string)Button::create
                    (
                        Icon::create(Icon::TYPE_RESTORE),
                        ['class' => 'b-admins-restore', 'data-id' => $row['id'], 'title' => t('admins.title_restore')]
                    );
                }

                $b[] = (string)Button::create
                (
                    Icon::create(Icon::TYPE_TRASH),
                    ['class' => 'b-admins-remove btn-danger', 'data-id' => $row['id'], 'title' => t('common.title_remove')]
                );

                $res[$i][] = implode('', $b);
            }

            return $t->render($res, $t->getTotal());
        }


        $this->template->assign('sidebar', $this->template->fetch('system/admins/groups/tree'));
        $this->output($t->init());
    }

    public function create()
    {
        $this->template->assign('action', 'create');
        $this->template->assign('data', ['avatar' => '']);
        $this->template->assign('groups', $this->admins->getGroups());
        $this->template->display('system/admins/form');
    }

    public function edit($id)
    {
        $this->template->assign('groups', $this->admins->getGroups());
        $this->template->assign('data', $this->admins->getData($id));
        $this->template->assign('action', 'edit');
        $this->template->display('system/admins/form');
    }

    public function process($id= null)
    {
        if(! $this->request->isPost()) die;

        $data = $this->request->post('data'); $s=0; $i=[];

        FormValidation::setRule(['name', 'email'], FormValidation::REQUIRED);
        FormValidation::setRule('email', FormValidation::EMAIL);
        FormValidation::run($data);

        switch($this->request->post('action')){
            case 'create':

                if(FormValidation::hasErrors()){
                    $i = FormValidation::getErrors();
                } elseif(!empty($data['password']) && ($data['password_c'] != $data['password'])){
                    $i[] = ["data[password_c]" => t('admin_profile.e_pasw_equal')];
                } elseif($this->admins->issetEmail($data['email'])){
                    $i[] = ["data[email]" => t('admins.error_email_not_unique')];
                } else {
                    unset($data['password_c']);

                    if(empty($data['password'])) $data['password'] = $this->admins->generatePassword();

                    $s = $this->admins->create($data);

                    if($s > 0 && $this->request->post('notify', 'i') == 1){
                        $this->notify($data);
                    }

                    if( $s > 0 ){
                        if(isset($_FILES['avatar'])){
                            $a = $this->admins->changeAvatar($id);
                        }
                    }
                }

                break;
            case 'edit':
                if( $id > 0 ){

                    if(FormValidation::hasErrors()){
                        $i = FormValidation::getErrors();
                    } elseif(!empty($data['password']) && ($data['password_c'] != $data['password'])){
                        $i[] = ["data[password_c]" => t('admin_profile.e_pasw_equal')];
                    } elseif($this->admins->issetEmail($data['email'], $id)){
                        $i[] = ["data[email]" => t('admins.error_email_not_unique')];
                    } else {
                        unset($data['password_c']);

                        $s = $this->admins->update($id, $data);

                        if( $s > 0 ){
                            if(isset($_FILES['avatar'])){
                                $a = $this->admins->changeAvatar($id);
                            }
                        }

                        if($s > 0 && $this->request->post('notify', 'i') == 1){
                            $this->notify($data);
                        }
                    }
                }
                break;
            default:
                break;
        }

        if(!$s && $this->admins->hasError()){
            echo $this->admins->getErrorMessage();
        }

        return ['s'=>$s, 'i' => $i, 'a' => isset($a['f']) ? $a['f'] : null];
    }

    private function notify($data)
    {
        $data['url'] = APPURL . $this->settings->get('backend_url');

        include_once DOCROOT . "/vendor/phpmailer/PHPMailer.php";

        $mail = new \PHPMailer();
        $mail->addAddress($data['email']);
        $mail->setFrom('no-reply@' . $_SERVER['HTTP_HOST'], t('core.sys_name'));
        $mail->isHTML(false);
        $tpl = t('admins.notify_tpl');
        $this->template->assign('data', $data);
        $mail->Body = $this->template->fetchString($tpl);
        return $mail->send();
    }

    public function delete($id)
    {
        return $this->admins->delete($id);
    }

    public function remove($id)
    {
        return $this->admins->remove($id);
    }

    public function ban($id)
    {
        return $this->admins->ban($id);
    }
    public function restore($id)
    {
        return $this->admins->restore($id);
    }
}