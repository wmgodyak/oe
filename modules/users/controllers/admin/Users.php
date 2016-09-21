<?php
/**
 *
 */
namespace modules\users\controllers\admin;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\DateTime;
use helpers\FormValidation;
use system\core\DataFilter;
use system\core\DataTables2;
use system\Engine;

/**
 * Class users
 * @package modules\users\controllers\admin
 */
class Users extends Engine
{
    private $users;
    private $usersGroup;

    public function __construct()
    {
        parent::__construct();

        $this->users = new \modules\users\models\Users();
        $this->usersGroup = new \modules\users\models\UsersGroup();
    }

    public function init()
    {
        $this->assignToNav('Клієнти', 'module/run/users', 'fa-user', null, 40);
        $this->template->assignScript("modules/users/js/admin/users.js");
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
                $this->t('common.button_create'), ['class' => 'btn-md btn-primary b-users-create']
            )
        );

        $t = new DataTables2('users');

        $t
            -> th($this->t('common.id'),        'u.id', true, true)
            -> th($this->t('users.pib'),       'CONCAT(u.surname , \' \', u.name) as username', true, true )
            -> th($this->t('users.group.name'), 'ugi.name as group_name', false, true)
            -> th($this->t('users.email'),     'u.email', true, true)
            -> th($this->t('users.phone'),     'u.phone', true, true)
            -> th($this->t('users.created') ,  'u.created', true, false)
            -> th($this->t('users.lastlogin'), 'u.lastlogin', true, false)
            -> th($this->t('common.func'), null, false, false)
            -> get('u.status', 0, 0, 0 )
        ;

        $t-> ajax('module/run/users/index/'. $group_id);

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

            $s = ['ban' => $this->t('users.status_ban'), 'deleted' => $this->t('users.status_deleted')];

            $res = array();
            foreach ($t->getResults(false) as $i=>$row) {

                $row = DataFilter::apply('users.list.row', $row);

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
                    ['class' => 'b-users-edit btn-primary', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
                );
                if($row['status'] == 'active'){
                    $b[] =  (string)Button::create
                    (
                        Icon::create(Icon::TYPE_BAN),
                        ['class' => 'b-users-ban', 'data-id' => $row['id'], 'title' => $this->t('users.title_ban')]
                    );
                    $b[] = (string)Button::create
                    (
                        Icon::create(Icon::TYPE_DELETE),
                        ['class' => 'b-users-delete', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                    );
                } elseif($row['status'] == 'deleted' || $row['status'] == 'ban'){
                    $b[] =  (string)Button::create
                    (
                        Icon::create(Icon::TYPE_RESTORE),
                        ['class' => 'b-users-restore', 'data-id' => $row['id'], 'title' => $this->t('users.title_restore')]
                    );
                }

                $b[] = (string)Button::create
                (
                    Icon::create(Icon::TYPE_TRASH),
                    ['class' => 'b-users-remove btn-danger', 'data-id' => $row['id'], 'title' => $this->t('common.title_remove')]
                );

                $res[$i][] = implode('', $b);
            }

            echo $t->render($res, $t->getTotal());die;
        }


        $this->template->assign('sidebar', $this->template->fetch('modules/users/groups/tree'));
        $this->output($t->init());
    }

    public function create()
    {
        $this->template->assign('action', 'create');
        $this->template->assign('data', ['avatar' => '']);
        $this->template->assign('groups', $this->usersGroup->get());
        $this->response->body($this->template->fetch('modules/users/form'))->asHtml();
    }

    public function edit($id)
    {
        $this->template->assign('groups', $this->usersGroup->get());
        $this->template->assign('data', $this->users->getData($id));
        $this->template->assign('action', 'edit');
        $this->response->body($this->template->fetch('modules/users/form'))->asHtml();
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
                    $i[] = ["data[password_c]" => $this->t('users.e_pasw_equal')];
                } elseif($this->users->issetEmail($data['email'])){
                    $i[] = ["data[email]" => $this->t('users.error_email_not_unique')];
                } else {
                    unset($data['password_c']);

                    if(empty($data['password'])) $data['password'] = $this->users->generatePassword();

                    $s = $this->users->create($data);
                    $id = $s;

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
                        $i[] = ["data[password_c]" => $this->t('users.e_pasw_equal')];
                    } elseif($this->users->issetEmail($data['email'], $id)){
                        $i[] = ["data[email]" => $this->t('users.error_email_not_unique')];
                    } else {
                        unset($data['password_c']);

                        $s = $this->users->update($id, $data);

                        if( $s > 0 ){
                            if(isset($_FILES['avatar'])){
                                $a = $this->users->changeAvatar($id);
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

        if(!$s && $this->users->hasError()){
            echo $this->users->getErrorMessage();
        }

        $this->response->body(['s'=>$s, 'id' => $id, 'i' => $i, 'a' => isset($a['f']) ? $a['f'] : null])->asJSON();
    }

    private function notify($data)
    {
        $data['url'] = APPURL . 'engine';

        include_once DOCROOT . "/vendor/phpmailer/PHPMailer.php";

        $mail = new \PHPMailer();
        $mail->addAddress($data['email']);
        $mail->setFrom('no-reply@' . $_SERVER['HTTP_HOST'], $this->t('core.sys_name'));
        $mail->isHTML(false);
        $tpl = implode("\r\n", $this->t('users.notify_tpl'));
        $this->template->assign('data', $data);
        $mail->Body = $this->template->fetchString($tpl);
        return $mail->send();
    }

    public function delete($id)
    {
        echo $this->users->delete($id);
    }

    public function remove($id)
    {
        echo $this->users->remove($id);
    }

    public function ban($id)
    {
        echo $this->users->ban($id);
    }
    public function restore($id)
    {
        echo $this->users->restore($id);
    }

    public function groups()
    {
        include "UsersGroup.php";

        $params = func_get_args();
        $action = array_shift($params);

        $controller  = new usersGroup();

        call_user_func_array(array($controller, $action), $params);
    }
}