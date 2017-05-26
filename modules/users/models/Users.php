<?php
namespace modules\users\models;
use helpers\FormValidation;
use system\core\Session;
use system\models\Mailer;

/**
 * Class users
 * @package modules\users\models
 */
class Users extends \system\models\Users
{
    public function setOnline($user)
    {
        return self::$db->update('__users', ['sessid' => session_id(), 'lastlogin' => date('Y-m-d H:i:s')], " id = {$user['id']} limit 1");
    }

    /**
     * @param $data
     * @param bool $auth
     * @return bool|string
     * @throws \Exception
     */
    public function register($data, $auth = true)
    {
        $s = false;

        FormValidation::setRule(['name', 'email'], FormValidation::REQUIRED);
        FormValidation::setRule('email', FormValidation::EMAIL);
        FormValidation::run($data);

        if(FormValidation::hasErrors()){
            $this->error = FormValidation::getErrors();
        } elseif(!empty($data['password']) && ($data['password_c'] != $data['password'])){
            $this->error = ["data[password_c]" => t('admin_profile.e_pasw_equal')];
        } elseif($this->issetEmail($data['email'])){
            $this->error = ["data[email]" => t('admins.error_email_not_unique')];
        } else {
            unset($data['password_c']);

            if(empty($data['password'])) $data['password'] = $this->generatePassword();

            $s = $this->create($data);

            if($s && $auth){
                $data['id'] = $s;
                Session::set('user', $data);
            }

            if($s && isset($data['email'])){
                $mailer = new Mailer('modules/users/mail/register', 'Register user', $data);
                $mailer
                    ->addAddress($data['email'], $data['name'])
                    ->send();
            }
        }

        return $s;
    }

    public function export($group_id = 0)
    {
        $w = $group_id > 0 ? " where group_id={$group_id}" : '';
        return self::$db
            ->select("
            select u.id, u.group_id, u.name, u.surname, u.email, u.phone, u.created, u.status
            from __users u
            join __users_group g on u.group_id=g.id and g.backend=0
             {$w}
            ")
            ->all();
    }

}