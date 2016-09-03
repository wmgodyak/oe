<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 15.07.16 : 16:23
 */

namespace modules\wishlist\controllers;

use helpers\FormValidation;
use modules\users\models\Users;
use system\core\EventsHandler;
use system\core\Session;
use system\Front;

defined("CPATH") or die();

/**
 * Class Wishlist
 * @name Список бажань
 * @description
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @package modules\wishlist\controllers
 */
class Wishlist extends Front
{
    private $wishlist;
    private $wishlistProducts;
    private $users;

    public function __construct()
    {
        parent::__construct();

        $this->wishlist = new \modules\wishlist\models\Wishlist();
        $this->wishlistProducts = new \modules\wishlist\models\WishlistProducts();
        $this->users = new Users();
    }

    public function init()
    {
        $this->template->assignScript('modules/wishlist/js/wishlist.js');
        EventsHandler::getInstance()->add('user.account.content', [$this, 'index']);
    }

    public function get()
    {
        return $this->wishlist->get();
    }

    public function index($page = null)
    {
        if($page['id'] != 27) return null;

        $this->template->assign('wishlists', $this->wishlist->get());
        return $this->template->fetch('modules/wishlist/index');
    }

   public function create()
   {
       if(!$this->request->isPost()) die;

       $s = 1; $m = null;

       $user = Session::get('user');

       if(! $user){
           $data = $this->request->post('data');

           FormValidation::setRule(['name', 'email'], FormValidation::REQUIRED);
           FormValidation::setRule('email', FormValidation::EMAIL);
           FormValidation::run($data);

           if(FormValidation::hasErrors()){
               $m = FormValidation::getErrors();
           } else {

               $u = $this->users->getUserByEmail($data['email']);

               if(empty($u)){
                   $users_id = $this->users->register(['name' => 'no name', 'email' => $data['email']]);

                   if($this->users->hasError()){
                       $m = $this->users->getError();
                       $s=0;
                       $this->response->body(['s'=>$s > 0, 'i' => $m])->asJSON();
                       return;
                   } else {
                       $user = $this->users->getData($users_id);
                       Session::set('user', $user);
                       $this->add();
                       return;
                   }
               } else{
                   Session::set('user', $u);
                   $this->add();
                   return;
               }
           }
       }

       $this->response->body(['s'=>$s > 0, 'i' => $m])->asJSON();
   }

    public function add()
    {
        $s = 0; $m = '';
        $data = $this->request->post('data');
        $products_id = $this->request->post('products_id', 'i');
        $variants_id = $this->request->post('variants_id', 'i');

        if(empty($products_id)) die;

        $wl = Session::get('wishlist');
        if(isset($wl[$products_id])) die;

        $user = Session::get('user');

        if(! $user){
            $this->response->body(['s'=> 0, 'a' => 'login'])->asJSON();
            return null;
        }

        $wishlist_id = Session::get('wishlist_id');

        if(! $wishlist_id){

            $name = isset($data['name']) ? $data['name'] : 'Мій список бажань';
            $wishlist_id = $this->wishlist->create($name, $user['id']);

            Session::set('wishlist_id', $wishlist_id);
        }

        if($wishlist_id > 0){
            $s = $this->wishlistProducts->create($wishlist_id, $products_id, $variants_id);
            if($s){
                $wl = Session::get('wishlist');
                $wl[$products_id] = $products_id;
                Session::set('wishlist', $wl);
            }else {
                $m = $this->wishlist->getError();
            }
        }

        $this->response->body(['s'=>$s > 0, 'i' => $m])->asJSON();
    }

    public function delete()
    {
        $id = $this->request->post('id', 'i');
        $wl = Session::get('wishlist');
        if(isset($wl[$id])){
            unset($wl[$id]);
            echo $this->wishlistProducts->delete($id);
        }
    }
}