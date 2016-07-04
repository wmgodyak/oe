<?php
/**
 *
 */
namespace modules\customers\controllers\admin;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\DateTime;
use helpers\FormValidation;
use system\core\DataTables2;
use system\Engine;

/**
 * Class Customers
 * @package modules\customers\controllers\admin
 */
class Customers extends Engine
{
    private $customers;
    private $customersGroup;

    public function __construct()
    {
        parent::__construct();

        $this->customers = new \modules\customers\models\Customers();
        $this->customersGroup = new \modules\customers\models\CustomersGroup();
    }

    public function init()
    {
        $this->assignToNav('Клієнти', 'module/run/customers', 'fa-user', null, 40);
        $this->template->assignScript("modules/customers/js/admin/customers.js");
    }



    /**
     * @param null $group_id
     * @return array|null|string
     */
    public function index($group_id = null)
    {
        $this->appendToPanel
        (
            (string)Button::create
            (
                $this->t('common.button_create'), ['class' => 'btn-md btn-primary b-customers-create']
            )
        );

        $t = new DataTables2('customers');

        $t
            -> th($this->t('common.id'),        'u.id', true, true)
            -> th($this->t('customers.pib'),       'CONCAT(u.surname , \' \', u.name) as username', true, true )
            -> th($this->t('customers.group'),     'ugi.name as group_name', false, true)
            -> th($this->t('customers.email'),     'u.email', true, true)
            -> th($this->t('customers.phone'),     'u.phone', true, true)
            -> th($this->t('customers.created') ,  'u.created', true, false)
            -> th($this->t('customers.lastlogin'), 'u.lastlogin', true, false)
            -> th($this->t('common.func'), null, false, false)
            -> get('u.status', 0, 0, 0 )
        ;

        $t-> ajax('module/run/customers/index/'. $group_id);

        if($this->request->isXhr()){

            $t  -> from('__users u')
                -> join("__users_group ug on ug.backend = 0")
                -> join("__users_group_info ugi on ugi.group_id=ug.id and ugi.languages_id={$this->languages_id}")
                -> where(" u.group_id=ug.id");

            if($group_id > 0){
                $t->where("ug.id=$group_id");
            }

            $t  -> execute();

            if(! $t){
                echo $t->getError();
                return null;
            }

            $s = ['ban' => $this->t('customers.status_ban'), 'deleted' => $this->t('customers.status_deleted')];

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
                    ['class' => 'b-customers-edit btn-primary', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
                );
                if($row['status'] == 'active'){
                    $b[] =  (string)Button::create
                    (
                        Icon::create(Icon::TYPE_BAN),
                        ['class' => 'b-customers-ban', 'data-id' => $row['id'], 'title' => $this->t('customers.title_ban')]
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

            echo $t->render($res, $t->getTotal());die;
        }


        $this->template->assign('sidebar', $this->template->fetch('customers/groups/tree'));
        $this->output($t->init());
    }

    public function create()
    {
        $this->template->assign('action', 'create');
        $this->template->assign('data', ['avatar' => '']);
        $this->template->assign('groups', $this->customersGroup->get());
        $this->response->body($this->template->fetch('customers/form'))->asHtml();
    }

    public function edit($id)
    {
        $this->template->assign('groups', $this->customersGroup->get());
        $this->template->assign('data', $this->customers->getData($id));
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
                    $i[] = ["data[password_c]" => $this->t('customers.e_pasw_equal')];
                } elseif($this->customers->issetEmail($data['email'])){
                    $i[] = ["data[email]" => $this->t('customers.error_email_not_unique')];
                } else {
                    unset($data['password_c']);

                    if(empty($data['password'])) $data['password'] = $this->customers->generatePassword();

                    $s = $this->customers->create($data);

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
                        $i[] = ["data[password_c]" => $this->t('customers.e_pasw_equal')];
                    } elseif($this->customers->issetEmail($data['email'], $id)){
                        $i[] = ["data[email]" => $this->t('customers.error_email_not_unique')];
                    } else {
                        unset($data['password_c']);

                        $s = $this->customers->update($id, $data);

                        if( $s > 0 ){
                            if(isset($_FILES['avatar'])){
                                $a = $this->customers->changeAvatar($id);
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

        if(!$s && $this->customers->hasError()){
            echo $this->customers->getErrorMessage();
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
        echo $this->customers->delete($id);
    }

    public function remove($id)
    {
        echo $this->customers->remove($id);
    }

    public function ban($id)
    {
        echo $this->customers->ban($id);
    }
    public function restore($id)
    {
        echo $this->customers->restore($id);
    }

    public function groups()
    {
        include "CustomersGroup.php";

        $params = func_get_args();
        $action = array_shift($params);

        $controller  = new CustomersGroup();

        call_user_func_array(array($controller, $action), $params);
    }
}