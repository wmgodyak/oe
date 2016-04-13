<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 15.01.16 : 18:24
 */

namespace models;

use controllers\core\Event;
use controllers\core\exceptions\Exception;
use models\app\Images;
use models\core\Model;
use models\engine\Settings;

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

    public function __construct($args = null, $languages_id = 0)
    {
        parent::__construct();

        $this->languages = new \models\app\Languages();
        $this->images    = new Images();

        if($args){
            $this->init($args);
        }

        if($this->languages_id == 0){
            $this->languages_id = $this->languages->getDefault('id');
            self::$language_id = $this->languages_id;
        } elseif($languages_id > 0){
            $this->languages_id = $languages_id;
            self::$language_id  = $this->languages_id;
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

        $url = isset($args['url']) ? $args['url'] : '';

        // обріжу останній слеш, якщо є
        if(isset($url) && substr($url,-1,1) == '/') {
            $url = substr($url, 0,-1);
        }

        // todo правила редиректів

        // інформація про сторінку
        $page = self::$db
            ->select("
                select c.*,i.languages_id, i.name,i.title,i.url,i.keywords, i.description,i.content, l.code as languages_code
                from content_info i
                join content c on c.id=i.content_id
                join languages l on l.id=i.languages_id
                where i.url = '{$url}' and i.languages_id={$this->languages_id}
                limit 1
                ")
            ->row();

        if(empty($page)) return;

        // page template
        if($page['types_id'] == $page['subtypes_id']){
           $page['template'] = self::$db
               ->select("select type from content_types where id={$page['subtypes_id']} limit 1")
               ->row('type');
            $page['type'] =$page['template'];
        } else {
            $type = self::$db
                ->select("select type from content_types where id={$page['types_id']} limit 1")
                ->row('type');
            $subtype = self::$db
                ->select("select type from content_types where id={$page['subtypes_id']} limit 1")
                ->row('type');
            $page['template'] = $type .'/'. $subtype;

            $page['type'] =$type;
        }

        // cover image
        $page['image'] = $this->images->cover($page['id']);

        if(!empty($page['image'])){
            $page['images'] = $this->images->get($page['id']);
        }

        // author
        $page['author'] = self::$db
            ->select("select id,name,surname,email,phone,avatar from users where id={$page['owner_id']}")
            ->row();

        // modules
        if(!empty($page['settings'])){
            $page['settings'] = unserialize($page['settings']);
        }

        if(!isset($page['settings']['modules'])){
            $page['settings']['modules'] = [];
        }

        $s = $this->getContentTypeSettings($page['subtypes_id']);

        if(!empty($s['modules'])){
            $page['settings']['modules'] = array_merge($s['modules'], $page['settings']['modules']);
        }

        $page = $this->makeMeta($page);

        $this->page = $page;

//        echo $this->getDBErrorMessage();
//        echo '<pre>';print_r($page);die;
    }

    /**
     *
    {title} - заголовок сторінки,
    {keywords} - ключові слова сторінки,
    {h1} - заголовок першого рвіня сторінки,
    {description} - опис сторінки,
    {company_name} - Назва компанії,
    {company_phone} - телефон,
    {category} - категорія,
    {categories} - список категорій,
    {delimiter} - розділювач, напр "/"
     * @param $page
     * @return mixed
     */
    private function makeMeta($page)
    {
//        $s = self::$db->select("select value from settings where name='seo' limit 1")->row('value');
        $settings = \controllers\core\Settings::getInstance()->get();
        $delimiter = $settings['delimiter'];
        $company_name  = $settings['company_name'];
        $company_phone = $settings['company_phone'];

        if(empty($page['h1'])) {
            $page['h1'] = $page['name'];
        }

        $meta = ['title', 'keywords', 'description', 'h1'];

        $s = unserialize($settings['seo']);
//        echo '<pre>'; print_r($s); die;
        foreach ($meta as $k=>$mk) {
            if(!isset($s[$page['type']][$this->languages_id][$mk])) continue;

            $tpl = $s[$page['type']][$this->languages_id][$mk];
            $page[$mk] = str_replace
            (
                [
                    '{title}',
                    '{keywords}',
                    '{description}',
                    '{h1}',
                    '{delimiter}',
                    '{company_name}',
                    '{company_phone}',
                ],
                [
                    $page['title'],
                    $page['keywords'],
                    $page['description'],
                    $page['h1'],
                    $delimiter,
                    $company_name,
                    $company_phone
                ],
                $tpl
            );

            if(strpos($page[$mk], '{category}') !== false){
                if($page['parent_id'] > 0){
                    $page[$mk] = str_replace('{category}', $this->pageInfo($page['parent_id'], $mk), $page[$mk]);
                } else {
                    $categories_id = $this->getRelationshipCategoryId($page['id']);
                    if($categories_id > 0){
                        $page[$mk] = str_replace('{category}', $this->pageInfo($categories_id, $mk), $page[$mk]);
                    }
                }
            }
        }
//                echo '<pre>'; print_r($page); die;
        return $page;
    }

    private function pageInfo($id, $key)
    {
        return self::$db
            ->select("
                select {$key}
                from content_info
                where content_id={$id} and languages_id={$this->languages_id}
                limit 1
                ")
            ->row($key);
    }

    private function getRelationshipCategoryId($content_id)
    {
        return self::$db
            ->select("select categories_id from content_relationship where content_id={$content_id} order by is_main desc limit 1")
            ->row('categories_id');
    }

    private function _getParentInfo($id)
    {
        $page = self::$db
            ->select("
                select c.id,c.types_id,c.isfolder,i.name, i.title, i.url, i.keywords, i.description
                from content_info i
                join content c on c.id = {$id}
                where i.content_id={$id} and i.languages_id={$this->languages_id}
                limit 1
                ")
            ->row();

        return $page;
    }

    public function callModule($module)
    {
        $a = explode('::', $module);
        $controller = $a[0]; $action = $a[1];

        $ns = '\controllers\modules\\';

        $c  = $ns . $controller;
        $path = str_replace("\\", "/", $c);

        if(!file_exists(DOCROOT . $path . '.php')) {
            die('Controller not found:' . DOCROOT . $path . '.php');
        }

        $controller = new $c;

        if(!is_callable(array($controller, $action))){
            die('Action '. $action .'is not callable: ' . DOCROOT . $path . '.php');
        }

        Event::fire($c, 'before'.ucfirst($action));
        call_user_func(array($controller, 'before'));
        call_user_func(array($controller, $action));
        Event::fire($c, 'after' . ucfirst($action));

    }

    private function getContentTypeSettings($types_id)
    {
        $data = self::$db->select("select parent_id, settings from content_types where id={$types_id} limit 1")->row();
        if(empty($data['settings'])) return null;
        $s = unserialize($data['settings']);
        if( $data['parent_id'] > 0 && isset($s['modules_ext']) && $s['modules_ext'] == 1){
            if(!isset($s['modules'])) $s['modules'] = [];
            $ps = $this->getContentTypeSettings($data['parent_id']);
            $s['modules'] = array_merge($ps['modules'], $s['modules']);
        }
        return $s;
    }

    public function getPage()
    {
        return $this->page;
    }

    public static function languagesID()
    {
        return self::$language_id;
    }

    public function __get($name)
    {
        if(method_exists($this, $name)){
            return $this->$name();
        } elseif(property_exists($this, $name)){
            return $this->{$name};
        }

        $ns = '\models\components\\';
        $c = $ns . ucfirst($name);
        $path = str_replace("\\", "/", $c);

        if(!file_exists(DOCROOT . $path . '.php')) {
            throw new Exception("Call to undefined property or method $name");
        }

        return new $c;
    }
}