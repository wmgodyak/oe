<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 15.09.16 : 8:40
 */

namespace modules\hybridAuth\controllers;

use modules\users\controllers\Users;
use system\core\EventsHandler;
use system\core\Session;

defined("CPATH") or die();
include_once DOCROOT . "/vendor/hybridauth/Hybrid/Auth.php";
include_once DOCROOT . "/vendor/hybridauth/Hybrid/Endpoint.php";

/**
 * Class HybridAuth
 * @name Авторизація через соц мережі
 * @description
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @package modules\hybridAuth\controllers
 */
class HybridAuth extends Users
{
    private $config = array(
        // "base_url" the url that point to HybridAuth Endpoint (where index.php and config.php are found)
        "base_url" => '/vendor/hybridauth',//todo add appurl

        "providers" => array (
            "Facebook" => array ( // 'id' is your facebook application id
               "enabled" => true,
               "keys" => array (
                   "id" => "1763511677233254",
                   "secret" => "73ecc87b997e88cf248d5ebb6d3adb60"
               ),
               "scope" => "email, user_about_me, user_birthday, user_hometown" // optional
            ),
            "Vkontakte" => array ( // 'key' is your twitter application consumer key
               "enabled" => true,
               "keys" => array (
                   "id" => "5629616",
                   "secret" => "bQ05uA9EDUdmMdYRcqEu"
               )
            ),
            "Google" => array ( // 'key' is your twitter application consumer key
                "enabled" => true,
                "keys" => array (
                    "id" => "530082045902-1r7its3k9jp0ohhua99sh9hp58ut9g07.apps.googleusercontent.com",
                    "secret" => "PkYojlfBcyOrKhb9MA_Y2FrV"
                )
            )
      ),
//      "debug_mode" => true ,
//      "debug_file" => "oauth.txt",
    );

    private $ha;

    public function __construct()
    {
        parent::__construct();

        $this->config['base_url'] = APPURL . "vendor/hybridauth/";

        $this->ha = new \modules\hybridAuth\models\HybridAuth();
    }

    public function init()
    {
        EventsHandler::getInstance()->add('users.form.login', [$this, 'displayProviders']);
    }

    public function displayProviders()
    {
        $this->template->assign('providers', $this->config['providers']);
        return $this->template->fetch('modules/hybridauth/providers');
    }

    public function auth($provider)
    {
        if( ! isset($this->config['providers'][$provider])) die;

        try {
            $hybridauth = new \Hybrid_Auth( $this->config );

            $adapter = $hybridauth->authenticate( $provider );

            $profile = $adapter->getUserProfile();

            if(!empty($profile)){
                $id = $this->ha->auth($provider, $profile->identifier);
                if($id > 0){
                    $users_id = $this->ha->getUsersId($id);
                    $user = $this->users->getData($users_id);
                } else {
                    // register user
                    $user = [
                        'email' => $profile->email,
                        'name'  => $profile->firstName,
                        'surname' => $profile->lastName,
                        'avatar'  => $profile->photoURL,
                        'group_id' => 7,
                        'status'   => 'active'
                    ];

                    $u = $this->users->getUserByEmail($profile->email);

                    if(!empty($u)){
                        $user = $u;
                    } else {
                        $users_id = $this->users->create($user);
                        $user['id'] = $users_id;
                    }

                    $this->ha->create($user['id'], $provider, $profile->identifier, $profile );
                }

                if($user['status'] == 'ban'){
                    die($this->t('admin.e_login_ban'));
                } elseif($user['status'] == 'deleted'){
                    die($this->t('admin.e_login_deleted'));
                } else {
                    // login user
                    $status = $this->users->setOnline($user);
                    if($status){
                        Session::set('user', $user);
                        $this->redirect($this->getUrl(28));die;
                    }
                }
            }
        }
        catch(\ Exception $e ){
            die( "<b>got an error!</b> " . $e->getMessage() );
        }
    }
}