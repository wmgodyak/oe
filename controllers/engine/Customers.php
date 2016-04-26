<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 13.07.14 9:57
 */

namespace controllers\engine;
use controllers\Engine;
use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\DateTime;
use helpers\FormValidation;

defined('CPATH') or die();

/**
 * Class Customers
 * @name Клієнти
 * @icon fa-users
 * @author Volodymyr Hodiak
 * @version 1.0.0

 * @package controllers\engine
 */
class Customers extends Engine {

    private $mCustomers;

    public function __construct()
    {
        parent::__construct();

        $this->mCustomers = new \models\engine\Customers();
    }

    /**
     * @param null $group_id
     */
    public function index($group_id = null)
    {
        $this->appendToPanel((string)Button::create($this->t('common.button_create'), ['class' => 'btn-md b-customers-create']));

        $t = new DataTables();

        $t  -> setId('customers')
            -> ajaxConfig('customers/items/'.$group_id)
//            -> setConfig('order', array(0, 'desc'))
            -> th($this->t('common.id'))
            -> th($this->t('customers.pib'))
            -> th($this->t('customers.group'))
            -> th($this->t('customers.email'))
            -> th($this->t('customers.phone'))
            -> th($this->t('customers.created'), '', 'width: 200px')
            -> th($this->t('customers.lastlogin'), '', 'width: 200px')
            -> th($this->t('common.tbl_func'), '', 'width: 200px')
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
        $t  -> table('__users u')
            -> get('u.id,u.name, u.surname, ugi.name as user_group, u.email, u.phone, u.created, u.lastlogin, u.status')
            -> join("__users_group ug on ug.backend=0 {$and}")
            -> join("__users_group_info ugi on ugi.group_id=ug.id and ugi.languages_id={$this->languages_id}")
            -> where(" u.group_id=ug.id")
            -> execute();
        $s = ['ban' => $this->t('customers.status_ban'), 'deleted' => $this->t('customers.status_deleted')];
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
                ['class' => 'b-customers-edit btn-primary', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
            );
            if($row['status'] == 'active'){
                $b[] =  (string)Button::create
                (
                    Icon::create(Icon::TYPE_BAN),
                    ['class' => 'b-customers-ban btn-warning', 'data-id' => $row['id'], 'title' => $this->t('customers.title_ban')]
                );
                $b[] = (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'b-customers-delete', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                );
            } elseif($row['status'] == 'deleted' || $row['status'] == 'ban'){
                $b[] =  (string)Button::create
                (
                    Icon::create(Icon::TYPE_RESTORE),
                    ['class' => 'b-customers-restore', 'data-id' => $row['id'], 'title' => $this->t('customers.title_restore')]
                );
            }

            $b[] = (string)Button::create
            (
                Icon::create(Icon::TYPE_TRASH),
                ['class' => 'b-customers-remove btn-danger', 'data-id' => $row['id'], 'title' => $this->t('common.title_remove')]
            );

            $res[$i][] = implode('', $b);
        }

        return $t->renderJSON($res, $t->getTotal());
    }

    public function create()
    {
        $this->template->assign('action', 'create');
        $this->template->assign('groups', $this->mCustomers->getGroups());
        $this->response->body($this->template->fetch('customers/form'))->asHtml();
    }

    public function edit($id)
    {
        $this->template->assign('groups', $this->mCustomers->getGroups());
        $this->template->assign('data', $this->mCustomers->getData($id));
        $this->template->assign('action', 'edit');
        $this->response->body($this->template->fetch('customers/form'))->asHtml();
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
                } elseif($this->mCustomers->issetEmail($data['email'])){
                    $i[] = ["data[email]" => $this->t('customers.error_email_not_unique')];
                } else {
                    unset($data['password_c']);

                    if(empty($data['password'])) $data['password'] = $this->mCustomers->generatePassword();

                    $s = $this->mCustomers->create($data);

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
                    } elseif($this->mCustomers->issetEmail($data['email'], $id)){
                        $i[] = ["data[email]" => $this->t('customers.error_email_not_unique')];
                    } else {
                        unset($data['password_c']);

                        $s = $this->mCustomers->update($id, $data);

                        if( $s > 0 ){
                            if(isset($_FILES['avatar'])){
                                $a = $this->mCustomers->changeAvatar($id);
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

        if(!$s && $this->mCustomers->hasDBError()){
            echo $this->mCustomers->getDBErrorMessage();
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
        $tpl = implode("\r\n", $this->t('customers.notify_tpl'));
        $this->template->assign('data', $data);
        $mail->Body = $this->template->fetchString($tpl);
        return $mail->send();
    }

    public function delete($id)
    {
        return $this->mCustomers->delete($id);
    }

    public function remove($id)
    {
        return $this->mCustomers->remove($id);
    }

    public function ban($id)
    {
        return $this->mCustomers->ban($id);
    }
    public function restore($id)
    {
        return $this->mCustomers->restore($id);
    }
}
