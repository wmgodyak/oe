<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 15.01.16 : 18:24
 */

namespace models;

use controllers\core\Session;
use models\app\Images;
use models\core\Model;
use models\engine\Languages;

defined("CPATH") or die();

/**
 * Class App
 * @package models
 */
class App extends Model
{
    /**
     * Languages model
     * @var app\Languages
     */
    protected $languages;
    /**
     * Page info
     * @var array
     */
    protected $page;
    /**
     * Images model
     * @var Images
     */
    protected $images;

    public function __construct($args = null)
    {
        parent::__construct();

        $this->languages = new \models\app\Languages();
        $this->images    = new Images();

        if($args){
            $this->init($args);
        }

        if($this->languages_id == 0){
            $this->languages_id = $this->languages->getDefault('id');
        }
    }

    private function init($args)
    {
        if(empty($args['lang'])) { // && $this->request->isGet()
            // треба витягнути мову по замовчуванню
            $this->languages_id = $this->languages->getDefault('id');
        } elseif(isset($args['lang'])) {
            // вибрана мова
            $this->languages_id = $this->languages->getIdByCode($args['lang']);
        }

        if(empty($this->languages_id) && !isset($args['url']) && isset($args['lang'])){
            // короткий url
            $args['url'] = $args['lang'];

            // встановлю мову по замовчуванню
            $this->languages_id = $this->languages->getDefault('id');
        }

        // обріжу останній слеш, якщо є
        if(substr($args['url'],-1,1) == '/') {
            $args['url'] = substr($args['url'], 0,-1);
        }

        // todo правила редиректів

        // інформація про сторінку
        $page = self::$db
            ->select("
                select c.*,i.languages_id, i.name,i.title,i.url,i.keywords, i.description,i.content
                from content_info i
                join content c on c.id=i.content_id
                where i.url = '{$args['url']}' and i.languages_id={$this->languages_id}
                limit 1
                ")
            ->row();

        if(empty($page)) return;

        if(empty($page['h1'])) {
            $page['h1'] = $page['name'];
        }

        // page template
        if($page['types_id'] == $page['subtypes_id']){
           $page['template'] = self::$db
               ->select("select type from content_types where id={$page['subtypes_id']} limit 1")
               ->row('type');
        } else{
            $type = self::$db
                ->select("select type from content_types where id={$page['types_id']} limit 1")
                ->row('type');
            $subtype = self::$db
                ->select("select type from content_types where id={$page['subtypes_id']} limit 1")
                ->row('type');
            $page['template'] = $type .'/'. $subtype;
        }

        // cover image
        $page['image'] = $this->images->cover($page['id']);

        // author
        $page['author'] = self::$db
            ->select("select id,name,surname,email,phone from users where id={$page['owner_id']}")
            ->row();
        $this->page = $page;

//        echo $this->getDBErrorMessage();
//        echo '<pre>';print_r($page);die;
    }

    public function getPage()
    {
        return $this->page;
    }

    public function getLanguagesId()
    {
        return $this->languages_id;
    }
}