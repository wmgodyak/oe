<?php

namespace modules\megamenu\controllers;

use system\core\Route;
use system\Frontend;

/**
 * Class Megamenu
 * @name Мега меню
 * @description
 * @author Maksym Lukyanov
 * @version 1.0.0
 * @package modules\megamenu\controllers
 */
class Megamenu extends Frontend
{
    protected $config;

    public function __construct()
    {
        parent::__construct();
        $this->config = module_config('megamenu');
    }

    public function index(){}

    public function init()
    {
        events()->add('boot', function(){

            Route::getInstance()->get('megamenu/author/{id}', function($id){
                $this->searchByAuthor($id);
            });

            Route::getInstance()->get('megamenu/tag/{alpha}', function($tag){
                $this->searchByTag($tag);
            });

            Route::getInstance()->get('megamenu/post/collect/{id}', function($id = null){
                header('Content-Type: application/javascript');
                if(empty($id)) return null;
                $this->collect($id);
            });

        });

        events()->add('init', function($page){

            $this->template->assignScript('modules/megamenu/js/megamenu.js');

            $megamenu = [];
            $megamenu['id'] = $this->config->id;
            $this->template->assign('megamenu', $megamenu);

            if($page['type'] == $this->config->post_type){
                $this->displayPost($page);

            } elseif($page['type'] == $this->config->category_type){
                $this->displayCategory($page);
            }
        });

    }
}