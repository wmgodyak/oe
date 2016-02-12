<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 25.12.15 : 17:46
 */

namespace controllers\engine;

use controllers\Engine;
use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\DateTime;
use helpers\FormValidation;

defined("CPATH") or die();

/**
 * Class Admins
 * @name Адміністратори
 * @icon fa-users
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class Admins extends Engine
{
    private $admins;
    private $usersGroup;

    public function __construct()
    {
        parent::__construct();

        $this->admins = new \models\engine\Admins();
        $this->usersGroup = new \models\engine\UsersGroup();
    }

    /**
     *
     */
    public function index($group_id = null)
    {
        $this->appendToPanel((string)Button::create($this->t('common.button_create'), ['class' => 'btn-md b-admins-create']));

        $t = new DataTables();

        $t  -> setId('admins')
            -> ajaxConfig('admins/items/'.$group_id)
//            -> setConfig('order', array(0, 'desc'))
            -> th($this->t('common.id'))
            -> th($this->t('admins.pib'))
            -> th($this->t('admins.group'))
            -> th($this->t('admins.email'))
            -> th($this->t('admins.phone'))
            -> th($this->t('admins.created'))
            -> th($this->t('admins.lastlogin'))
            -> th($this->t('common.tbl_func'), '', 'width: 60px')
        ;

        $this->output($t->render());
    }

    /**
     * @param int $group_id
     * @return string
     */
    public function items($group_id = null)
    {
        $and = ($group_id > 0) ? " and ug.id={$group_id}" : '';
        $t = new DataTables();
        $t  -> table('users u')
            -> get('u.id,u.name, u.surname, ugi.name as user_group, u.email, u.phone, u.created, u.lastlogin, u.status')
            -> join(" users_group ug on ug.rang > 100 {$and}")
            -> join(" users_group_info ugi on ugi.group_id=ug.id and ugi.languages_id={$this->languages_id}")
            -> where(" u.group_id=ug.id")
            -> execute();
        $s = ['ban' => $this->t('admins.status_ban'), 'deleted' => $this->t('admins.status_deleted')];
        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {
            $res[$i][] = $row['id'];
            $res[$i][] = $row['surname'] .' '. $row['name']  .
                ($row['status'] != 'active' ? "<br><label class='label label-danger'>{$s[$row['status']]}</label>" : '');
            $res[$i][] = $row['user_group'];
            $res[$i][] = $row['email'];
            $res[$i][] = $row['phone'];
            $res[$i][] = $row['created'];
            $res[$i][] = $row['lastlogin'] ? DateTime::ago(strtotime($row['lastlogin'])) : '';

            $b = [];
            $b[] = (string)Button::create
            (
                Icon::create(Icon::TYPE_EDIT),
                ['class' => 'b-admins-edit', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
            );
            if($row['status'] == 'active'){
                $b[] =  (string)Button::create
                (
                    Icon::create(Icon::TYPE_BAN),
                    ['class' => 'b-admins-ban', 'data-id' => $row['id'], 'title' => $this->t('admins.title_ban')]
                );
                $b[] = (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'b-admins-delete', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                );
            } elseif($row['status'] == 'deleted' || $row['status'] == 'ban'){
                $b[] =  (string)Button::create
                (
                    Icon::create(Icon::TYPE_RESTORE),
                    ['class' => 'b-admins-restore', 'data-id' => $row['id'], 'title' => $this->t('admins.title_restore')]
                );
            }

            $b[] = (string)Button::create
            (
                Icon::create(Icon::TYPE_TRASH),
                ['class' => 'b-admins-remove', 'data-id' => $row['id'], 'title' => $this->t('common.title_remove')]
            );

            $res[$i][] = implode('', $b);
        }

        return $t->renderJSON($res, $t->getTotal());

//        $this->response->body($t->renderJSON($res, count($res), false))->asJSON();
    }

    public function create()
    {
        $this->template->assign('action', 'create');
        $this->template->assign('groups', $this->usersGroup->get());
        $this->response->body($this->template->fetch('admins/form'))->asHtml();
    }

    public function edit($id)
    {
        $this->template->assign('groups', $this->usersGroup->get());
        $this->template->assign('data', $this->admins->getData($id));
        $this->template->assign('action', 'edit');
        $this->response->body($this->template->fetch('admins/form'))->asHtml();
    }

    public function process($id= null)
    {
        if(! $this->request->isPost()) die;

        $data = $this->request->post('data'); $s=0; $i=[];

        FormValidation::setRule(['name', 'surname', 'email'], FormValidation::REQUIRED);
        FormValidation::setRule('email', FormValidation::EMAIL);
        FormValidation::run($data);

        switch($this->request->post('action')){
            case 'create':

                if(FormValidation::hasErrors()){
                    $i = FormValidation::getErrors();
                } elseif(!empty($data['password']) && ($data['password_c'] != $data['password'])){
                    $i[] = ["data[password_c]" => $this->t('admin_profile.e_pasw_equal')];
                } elseif($this->admins->issetEmail($data['email'])){
                    $i[] = ["data[email]" => $this->t('admins.error_email_not_unique')];
                } else {
                    unset($data['password_c']);

                    if(empty($data['password'])) $data['password'] = $this->admins->generatePassword();

                    $s = $this->admins->create($data);

                    if($s > 0 && $this->request->post('notify', 'i') == 1){
                        $this->notify($data);
                    }
                }

                break;
            case 'edit':
                if( $id > 0 ){

                    if(FormValidation::hasErrors()){
                        $i = FormValidation::getErrors();
                    } elseif(!empty($data['password']) && ($data['password_c'] != $data['password'])){
                        $i[] = ["data[password_c]" => $this->t('admin_profile.e_pasw_equal')];
                    } elseif($this->admins->issetEmail($data['email'], $id)){
                        $i[] = ["data[email]" => $this->t('admins.error_email_not_unique')];
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

        if(!$s && $this->admins->hasDBError()){
            echo $this->admins->getDBErrorMessage();
        }

        $this->response->body(['s'=>$s, 'i' => $i, 'a' => isset($a['f']) ? $a['f'] : null])->asJSON();
    }

    private function notify($data)
    {
        $data['url'] = APPURL . 'engine';

        include_once DOCROOT . "/vendor/phpmailer/PHPMailer.php";

        $mail = new \PHPMailer();
        $mail->addAddress($data['email']);
        $mail->setFrom('no-reply@' . $_SERVER['HTTP_HOST'], $this->t('core.sys_name'));
        $mail->isHTML(false);
        $tpl = implode("\r\n", $this->t('admins.notify_tpl'));
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