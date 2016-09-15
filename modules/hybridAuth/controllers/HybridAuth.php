<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 15.09.16 : 8:40
 */

namespace modules\hybridAuth\controllers;

use system\core\EventsHandler;
use system\Front;

defined("CPATH") or die();

/**
 * Class HybridAuth
 * @name Авторизація через соц мережі
 * @description
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @package modules\hybridAuth\controllers
 */
class HybridAuth extends Front
{
    private $config = array(
        // "base_url" the url that point to HybridAuth Endpoint (where index.php and config.php are found)
        "base_url" => '/vendor/hybridauth',//todo add appurl

        "providers" => array (
            // google
            "Google" => array ( // 'id' is your google client id
               "enabled" => false,
               "keys" => array (
                   "id" => "",
                   "secret" => ""
               ),
            ),

         // facebook
            "Facebook" => array ( // 'id' is your facebook application id
               "enabled" => true,
               "keys" => array (
                   "id" => "1763511677233254",
                   "secret" => "73ecc87b997e88cf248d5ebb6d3adb60"
               ),
               "scope" => "email, user_about_me, user_birthday, user_hometown" // optional
            ),

         // Vk
            "Vkontakte" => array ( // 'key' is your twitter application consumer key
               "enabled" => true,
               "keys" => array (
                   "id" => "5629616",
                   "secret" => "bQ05uA9EDUdmMdYRcqEu"
               )
            ),

         // and so on ...
      ),

      "debug_mode" => true ,

      // to enable logging, set 'debug_mode' to true, then provide here a path of a writable file
      "debug_file" => "oauth.txt",
    );

    public function __construct()
    {
        parent::__construct();

        $this->config['base_url'] = APPURL . 'vendor/hybridauth';
    }

    public function init()
    {
        //$hybridauth = new Hybrid_Auth( $config );
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

        include_once DOCROOT . "/vendor/hybridauth/Hybrid/Auth.php";
        include_once DOCROOT . "/vendor/hybridauth/Hybrid/Endpoint.php";


        try{
            $hybridauth = new \Hybrid_Auth( $this->config );

            $adapter = $hybridauth->authenticate( $provider );

            $user_profile = $adapter->getUserProfile();
            d($user_profile);
//            \Hybrid_Endpoint::process();
        }
        catch(\ Exception $e ){
            die( "<b>got an error!</b> " . $e->getMessage() );
        }
//
//        $hybridauth = new \Hybrid_Auth( $this->config );
//
//        $sm = $hybridauth->authenticate( $provider );
//
//        d($sm);die;
//
//        $user_profile = $sm->getUserProfile();
//        d($user_profile);
//die('done');
//        echo "Hi there! " . $user_profile->displayName;
//
//        $twitter->setUserStatus( "Hello world!" );

//        $user_contacts = $twitter->getUserContacts();
    }

    public function authOk()
    {
        d($_SESSION);
    }
}