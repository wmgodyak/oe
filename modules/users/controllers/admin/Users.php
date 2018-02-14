<?php
/**
 *
 */
namespace modules\users\controllers\admin;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use helpers\DateTime;
use helpers\FormValidation;
use system\Backend;
use system\core\DataFilter;
use system\core\DataTables2;
use system\models\Permissions;

/**
 * Class users
 * @package modules\users\controllers\admin
 */
class Users extends Backend
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
        $this->assignToNav(t('users.action_index'), 'module/run/users', 'fa-user', null, 40);
        $this->template->assignScript("modules/users/js/admin/users.js");
    }

    /**
     * @param null $group_id
     * @return array|null|string
     */
    public function index($group_id = null)
    {
        if(Permissions::canModule('users', 'import')){

            $this->appendToPanel
            (
                (string)Button::create
                (
                    t('users.import'), ['class' => 'btn-md b-users-import']
                )
            );
        }
        if(Permissions::canModule('users', 'export')) {
            $this->appendToPanel
            (
                (string)Link::create
                (
                    t('users.export'), ['class' => 'btn-md', 'href' => "module/run/users/export/{$group_id}"]
                )
            );
        }
        if(Permissions::canModule('users', 'create')) {
            $this->appendToPanel
            (
                (string)Button::create
                (
                    t('common.button_create'), ['class' => 'btn-md btn-primary b-users-create']
                )
            );
        }
        $t = new DataTables2('users');

        $t
            -> th(t('common.id'),        'u.id', true, true)
            -> th(t('users.pib'),       'CONCAT(u.surname , \' \', u.name) as username', true, true )
            -> th(t('users.group.name'), 'ugi.name as group_name', false, true)
            -> th(t('users.email'),     'u.email', true, true)
            -> th(t('users.phone'),     'u.phone', true, true)
            -> th(t('users.created') ,  'u.created', true, false)
            -> th(t('users.lastlogin'), 'u.lastlogin', true, false)
            -> th(t('common.func'), null, false, false)
            -> get('u.status', 0, 0, 0 )
        ;

        $t-> ajax('module/run/users/index'. ($group_id ? "/$group_id" : ''));

        if($this->request->isXhr()){

            $t  -> from('__users u')
                -> join("__users_group ug on ug.backend = 0")
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

            $s = ['ban' => t('users.status_ban'), 'deleted' => t('users.status_deleted')];

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
                    ['class' => 'b-users-edit btn-primary', 'data-id' => $row['id'], 'title' => t('common.title_edit')]
                );
                if($row['status'] == 'active'){
                    $b[] =  (string)Button::create
                    (
                        Icon::create(Icon::TYPE_BAN),
                        ['class' => 'b-users-ban', 'data-id' => $row['id'], 'title' => t('users.title_ban')]
                    );
                    $b[] = (string)Button::create
                    (
                        Icon::create(Icon::TYPE_DELETE),
                        ['class' => 'b-users-delete', 'data-id' => $row['id'], 'title' => t('common.title_delete')]
                    );
                } elseif($row['status'] == 'deleted' || $row['status'] == 'ban'){
                    $b[] =  (string)Button::create
                    (
                        Icon::create(Icon::TYPE_RESTORE),
                        ['class' => 'b-users-restore', 'data-id' => $row['id'], 'title' => t('users.title_restore')]
                    );
                }

                $b[] = (string)Button::create
                (
                    Icon::create(Icon::TYPE_TRASH),
                    ['class' => 'b-users-remove btn-danger', 'data-id' => $row['id'], 'title' => t('common.title_remove')]
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
        $this->template->display('modules/users/form');
    }

    public function edit($id)
    {
        $this->template->assign('groups', $this->usersGroup->get());
        $this->template->assign('data', $this->users->getData($id));
        $this->template->assign('action', 'edit');
        $this->template->display('modules/users/form');
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
                    $i[] = ["data[password_c]" => t('users.e_pasw_equal')];
                } elseif($this->users->issetEmail($data['email'])){
                    $i[] = ["data[email]" => t('users.error_email_not_unique')];
                } else {
                    unset($data['password_c']);

                    if(empty($data['password'])) $data['password'] = $this->users->generatePassword();

                    $s = $this->users->create($data);
                    $id = $s;

                    if( $s > 0 ){
                        if(isset($_FILES['avatar'])){
                            $a = $this->users->changeAvatar($id);
                        }
                    }

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
                        $i[] = ["data[password_c]" => t('users.e_pasw_equal')];
                    } elseif($this->users->issetEmail($data['email'], $id)){
                        $i[] = ["data[email]" => t('users.error_email_not_unique')];
                    }  else {
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

        return ['s'=>$s, 'id' => $id, 'i' => $i, 'a' => isset($a['f']) ? $a['f'] : null];
    }

    private function notify($data)
    {
        $data['url'] = APPURL . 'engine';

        include_once DOCROOT . "/vendor/phpmailer/PHPMailer.php";

        $mail = new \PHPMailer();
        $mail->addAddress($data['email']);
        $mail->setFrom('no-reply@' . $_SERVER['HTTP_HOST'], t('core.sys_name'));
        $mail->isHTML(false);
        $tpl = implode("\r\n", t('users.notify_tpl'));
        $this->template->assign('data', $data);
        $mail->Body = $this->template->fetchString($tpl);
        return $mail->send();
    }

    public function delete($id)
    {
        return $this->users->delete($id);
    }

    public function remove($id)
    {
        return $this->users->remove($id);
    }

    public function ban($id)
    {
        return $this->users->ban($id);
    }

    public function restore($id)
    {
        return $this->users->restore($id);
    }
}