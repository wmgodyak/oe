<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 21.06.16 : 17:35
 */

namespace system\models;

use system\core\Session;

defined("CPATH") or die();

class Frontend extends Model
{
    /**
     * @var
     */
    public $languages;
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

    protected $app;

    public function __construct()
    {
        parent::__construct();

        $this->languages = new Languages();

        $this->languages_id = $this->defileLanguageId();

        $this->images    = new Images();
        $this->app       = new App();
    }

    /**
     * detect languages id by request uri
     * @return array|mixed|null
     */
    public function defileLanguageId()
    {
        $id = $this->request->param('languages_id');
        if(!empty($id)) return $id;

        $args = $this->request->param();

        if(isset($args['lang'])) {
            // selected language
            $id = $this->languages->getDataByCode($args['lang'], 'id');
        } elseif(!empty($args['controller'])){
            $id = Session::get('app.languages_id');
        }

        if(empty($id)){
            $id = $this->languages->getDefault('id');
        }

        $this->request->param('languages_id', $id);

        return $id;
    }

    public function getPage()
    {
        $args = $this->request->param();

        if(empty($this->languages_id) && !isset($args['url']) && isset($args['lang'])){
            // короткий url
            $args['url'] = $args['lang'];
        }

        if(empty($args['url']) && !empty($args['lang'])){
            $def_lang_id = $this->languages->getDefault('id');
            $lang_id = $this->languages->getDataByCode($args['lang'], 'id');
            if($def_lang_id == $lang_id){
                $uri = APPURL;
                header("HTTP/1.1 301 Moved Permanently");
                header("Location: $uri");
                die;
            }
        }

        $url = isset($args['url']) ? $args['url'] : '';
        $url = rtrim($url, '/');

        if(empty($url)){
            $id = Settings::getInstance()->get('home_id');
        } else {
            // інформація про сторінку
            $id = self::$db
                ->select("select i.content_id
                from __content_info i
                where i.url = '{$url}' and i.languages_id='{$this->languages_id}'
                limit 1
                ")
                ->row('content_id');
        }

        if(empty($id)) return null;

        return $this->getPageById($id);
    }

    public function getPageById($id)
    {
        $page = self::$db
            ->select("
                select c.*,
                i.languages_id, i.name,i.title,i.h1,i.keywords, i.description,i.content, i.intro,
                 l.code as languages_code,
                 UNIX_TIMESTAMP(c.created) as created,
                 UNIX_TIMESTAMP(c.published) as published
                from __content_info i
                join __content c on c.id=i.content_id
                join __languages l on l.id=i.languages_id
                where c.id={$id} and i.languages_id='{$this->languages_id}'
                limit 1
                ")
            ->row();

        if(empty($page)) return null;

        // page template
        if($page['types_id'] == $page['subtypes_id']){
            $page['template'] = self::$db
                ->select("select type from __content_types where id={$page['subtypes_id']} limit 1")
                ->row('type');
            $page['type'] = $page['template'];
        } else {
            $type = self::$db
                ->select("select type from __content_types where id={$page['types_id']} limit 1")
                ->row('type');
            $subtype = self::$db
                ->select("select type from __content_types where id={$page['subtypes_id']} limit 1")
                ->row('type');
            $page['template'] = $type .'/'. $subtype;

            $page['type'] =$type;
        }

        $page['url'] = $this->app->page->url($page['id']);

        // cover image
        $page['image'] = $this->images->cover($page['id']);

        if(!empty($page['image'])){
            $page['images'] = $this->images->get($page['id']);
        }

        // author
        $page['author'] = self::$db
            ->select("select id, name, surname, email, phone, avatar from __users where id='{$page['owner_id']}'")
            ->row();

        return $this->makeMeta($page);
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
//        $s = self::$db->select("select value from __settings where name='seo' limit 1")->row('value');
        $settings = Settings::getInstance()->get();
        $delimiter = '/';
        $company_name  = $settings['company_name'];
        $company_phone = $settings['company_phone'];

        if(empty($page['title'])) {
            $page['title'] = $page['name'];
        }
        if(empty($page['h1'])) {
            $page['h1'] = $page['name'];
        }

        $meta = ['title', 'keywords', 'description', 'h1'];

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
                    $page[$mk] = str_replace('{category}', $this->getPageInfo($page['parent_id'], $mk), $page[$mk]);
                } else {
                    $categories_id = $this->getRelationshipCategoryId($page['id']);
                    if($categories_id > 0){
                        $page[$mk] = str_replace('{category}', $this->getPageInfo($categories_id, $mk), $page[$mk]);
                    }
                }
            }
        }

        return $page;
    }

    private function getPageInfo($id, $key = '*')
    {
        return self::$db
            ->select("
                select {$key}
                from __content_info
                where content_id={$id} and languages_id={$this->languages_id}
                limit 1
                ")
            ->row($key);
    }

    private function getRelationshipCategoryId($content_id)
    {
        return self::$db
            ->select("select categories_id from __content_relationship where content_id={$content_id} order by is_main desc limit 1")
            ->row('categories_id');
    }

    private function getContentTypeSettings($types_id)
    {
        $data = self::$db->select("select parent_id, settings from __content_types where id={$types_id} limit 1")->row();
        if(empty($data['settings'])) return null;
        $s = unserialize($data['settings']);
        if( $data['parent_id'] > 0 && isset($s['modules_ext']) && $s['modules_ext'] == 1){
            if(!isset($s['modules'])) $s['modules'] = [];
            $ps = $this->getContentTypeSettings($data['parent_id']);
            $s['modules'] = array_merge($ps['modules'], $s['modules']);
        }
        return $s;
    }
}