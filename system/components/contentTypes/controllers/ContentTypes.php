<?php

namespace system\components\contentTypes\controllers;

use system\core\DataTables2;
use system\Backend;
use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use helpers\FormValidation;
use system\models\Settings;

defined("CPATH") or die();

/**
 * Class ContentTypes
 * @package system\components\contentTypes\controllers
 */
class ContentTypes extends Backend
{
    private $contentTypes;
    private $path;

    const DIR = 'layouts/';
    const EXT = '.tpl';

    public function __construct()
    {
        parent::__construct();

        $this->contentTypes = new \system\components\contentTypes\models\ContentTypes();

        // шлях до тем
        $themes_path = Settings::getInstance()->get('themes_path');

        // активна тема
        $theme = Settings::getInstance()->get('app_theme_current');

        $this->path = DOCROOT .  $themes_path  . $theme .'/' . self::DIR;
    }

    public function init()
    {
        $this->assignToNav(t('contentTypes.action_index'), 'contentTypes', 'fa-file-text-o', 'tools' ,100);
    }


    public function index($parent_id=0)
    {
        if($parent_id > 0){
            $data = $this->contentTypes->getData($parent_id);
            $this->appendToPanel
            (
                (string)Link::create
                (
                    t('common.back'),
                    ['class' => 'btn-md b-contentTypes-create', 'href'=> 'contentTypes/index' . ($data['parent_id']>0 ? '/' . $data['parent_id'] : '')]
                )
            );
        }

        $this->appendToPanel
        (
            (string)Link::create
            (
                t('common.button_create'),
                ['class' => 'btn-md b-contentTypes-create btn-primary', 'href'=> 'contentTypes/create' . ($parent_id? "/$parent_id" : '')]
            )
        );

        $t = new DataTables2('contentTypes');

        $t
            -> th(t('common.id'), 'id', 1, 1, 'width:60px')
            -> th(t('contentTypes.name'), 'name', 1, 1)
            -> th(t('contentTypes.type'), 'type', 1, 1)
            -> th(t('contentTypes.template'), null, 0 , 0)
            -> th(t('common.tbl_func'), null, false, false, 'width: 130px')

            -> get('isfolder', 0, 0, 0)
            -> get('is_main', 0, 0, 0)
            -> ajax('contentTypes/items/' . $parent_id)
        ;


        $this->output($t->init());
    }

    /**
     * @param int $parent_id
     * @return array|string
     */
    public function items($parent_id = 0)
    {
        $t = new DataTables2();
        $t  -> from('__content_types')
            -> where(" parent_id = {$parent_id}")
            -> execute();

        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {

            $row['isfolder'] = '';
            $row['is_main']  = '';

            $res[$i][] = $row['id'];
            $res[$i][] = "<a href='contentTypes/index/{$row['id']}'>{$row['name']}</a>";
            $res[$i][] = $row['type'];
            $res[$i][] = $this->getPath($row['id'], false);
            $res[$i][] =
                (string)Link::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    ['class' => 'btn-primary', 'href' => "contentTypes/edit/" . $row['id'], 'title' => t('common.title_edit')]
                ) .
                ($row['is_main'] == 0 && $row['isfolder'] == 0 ? (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'b-contentTypes-delete btn-danger', 'data-id' => $row['id'], 'title' => t('common.title_delete')]
                ) : "")

            ;
        }

        return $t->render($res, $t->getTotal());
    }

    public function create($parent_id=null)
    {
        $this->appendToPanel((string)Link::create
        (
            t('common.back'),
            ['class' => 'btn-md b-contentTypes-create', 'href'=> 'contentTypes/index' . ($parent_id? "/$parent_id" : '')]
        )
        );


        $this->appendToPanel
        (
            (string)Button::create
            (
                t('common.button_save'),
                ['class' => 'btn-md b-form-save']
            )
        );
        $data = ['parent_id' => $parent_id,'images_sizes' => []];
        $this->template->assign('data', $data);
        $this->template->assign('content_types', $this->contentTypes->get(0));
        $this->template->assign('action', 'create');
        $this->output($this->template->fetch('system/contentTypes/form'));
    }

    /**
     * @param $id
     */
    public function edit($id)
    {
        $data = $this->contentTypes->getData($id);
        if(empty($data)) redirect(404);

        $this->appendToPanel
        (
            (string)Link::create
            (
                t('common.back'),
                ['class' => 'btn-md b-contentTypes-create', 'href'=> 'contentTypes/index' . ($data['parent_id']? "/{$data['parent_id']}" : '')]
            )
        );

        $this->appendToPanel
        (
            (string)Button::create
            (
                t('common.button_save'),
                ['class' => 'btn-md b-form-save']
            )
        );

        $data['template'] = $this->readTemplate($id);

        $this->template->assign('data', $data);
        $this->template->assign('content_types', $this->contentTypes->get(0));

        $this->template->assign('action', 'edit');
        $this->output($this->template->fetch('system/contentTypes/form'));
    }

    /**
     * @param null $id
     * @throws \Exception
     */
    public function process($id= null)
    {
        if(! $this->request->isPost()) die;

        $data = $this->request->post('data');

        $s=0; $i=[]; $m=null;

        FormValidation::setRule(['name', 'type'], FormValidation::REQUIRED);

        FormValidation::run($data);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } elseif($this->contentTypes->issetTemplate($data['parent_id'], $data['type'], $data['id'])){
            $i[] = ["data[type]" => t('contentTypes.error_isset_type')];
        } else {
            $data['settings'] = serialize($data['settings']);
            switch($this->request->post('action')){
                case 'create':
                    $s = $this->contentTypes->create($data);
                    if($s>0){
                        $this->createTemplate($s);
                    }
                    break;
                case 'edit':
                    if( $id > 0 ){
                        $prev_type = $this->contentTypes->getData($id, 'type');
                        $s = $this->contentTypes->update($id, $data);

                        if($prev_type !== $data['type']){
                            $this->renameTemplate($id, $prev_type, $data['type']);
                        }

                        $this->writeTemplate($id, $this->request->post('template'));
                        $m = t('common.update_success');
                    }
                    break;
            }
        }

        if($this->contentTypes->hasError()){
            echo $this->contentTypes->getErrorMessage();
        }

        return ['s'=>$s, 'i' => $i, 'm' => $m];
    }

    /**
     * @param $id
     * @return mixed
     */
    public function delete($id)
    {
        $parent_id = $this->contentTypes->getData($id, 'parent_id');

        $template = $this->getPath($id);

        $s = $this->contentTypes->delete($id);
        if($s>0){
            unlink($template);
            if($parent_id>0){
                if( ! $this->contentTypes->hasChildren($parent_id)){
                    $path  = $this->path;
                    $type  = $this->contentTypes->getData($parent_id , 'type');
                    $path .= $type;
                    rmdir($path);
                }
            }

        }
        return $s;
    }

    /**
     * @param $id
     * @param $oldname
     * @param $newname
     * @return bool
     */
    private function renameTemplate($id, $oldname, $newname)
    {
        $path = $this->path;
        $parent_id = $this->contentTypes->getData($id, 'parent_id');
        if( $parent_id > 0 ){
            $parent = $this->contentTypes->getData($parent_id);
            $path .= $parent['type'] .'/';
        }

        return rename($path . $oldname . self::EXT, $path . $newname . self::EXT);
    }

    /**
     * @param $id
     * @return int
     */
    private function createTemplate($id)
    {
        $data = $this->contentTypes->getData($id);
        $path = $this->path;
        if($data['parent_id'] > 0){
            $parent = $this->contentTypes->getData($data['parent_id']);
            $path .= $parent['type'] . '/';
        }

        if(!is_dir($path)) {
            mkdir($path, 0777, true);
        }


        $data = $this->contentTypes->getData($id);

        $now = date('c');
        $y = date('Y');
        $body = $this->request->post('template');
        $text = "{*
 * OYiEngine 7
 * @author {$this->admin['name']} mailto:{$this->admin['email']}
 * @copyright Copyright (c) {$y}
 * Date: {$now}
 * @name {$data['name']}
 *}\r\n
{extends 'layouts/index.tpl'}
{block name=body}\r\n
{$body}\r\n
{/block}
";
        return $this->writeTemplate($id, $text);
    }

    /**
     * @param $id
     * @return string
     */
    private function readTemplate($id)
    {
        $template = $this->getPath($id);
        return @file_get_contents( $template );
    }

    /**
     * @param $id
     * @param $text
     * @return int
     */
    public function writeTemplate($id, $text)
    {
        $template = $this->getPath($id);

        return file_put_contents($template, $text);
    }

    /**
     * @param $id
     * @param bool $abs
     * @return mixed|string
     */
    private function getPath($id, $abs = true)
    {
        $data = $this->contentTypes->getData($id);
        $path = $this->path;
        if($data['parent_id'] > 0){
            $parent = $this->contentTypes->getData($data['parent_id']);
            $path .= $parent['type'] . '/';
            $template = $path . $data['type'] .  self::EXT;
        } else {
            $template = $path . $data['type'] .  self::EXT;
        }

        return !$abs ? str_replace(DOCROOT , '', $template) : $template;
    }
}