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
    /**
     * Default group ID to register
     * @var int
     */
    private $guest_group_id = 5;

    public function setOnline($user)
    {
        return self::$db->update('__users', ['sessid' => session_id(), 'lastlogin' => date('Y-m-d H:i:s')], " id = {$user['id']} limit 1");
    }

    public function register($data)
    {
        $s = false;

        FormValidation::setRule(['name', 'email'], FormValidation::REQUIRED);
        FormValidation::setRule('email', FormValidation::EMAIL);
        FormValidation::run($data);

        if(FormValidation::hasErrors()){
            $this->error = FormValidation::getErrors();
        } elseif(!empty($data['password']) && ($data['password_c'] != $data['password'])){
            $this->error = ["data[password_c]" => $this->t('admin_profile.e_pasw_equal')];
        } elseif($this->issetEmail($data['email'])){
            $this->error = ["data[email]" => $this->t('admins.error_email_not_unique')];
        } else {
            unset($data['password_c']);

            if(empty($data['password'])) $data['password'] = $this->generatePassword();

            $data['group_id'] = $this->guest_group_id;

            $s = $this->create($data);

            if($s){
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

}