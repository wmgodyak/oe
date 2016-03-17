<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 05.02.16 : 12:12
 */

namespace controllers\engine;

use controllers\core\Settings;
use controllers\Engine;
use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use helpers\FormValidation;

defined("CPATH") or die();
/**
 * Class ContentTypes
 * @name Типи контенту
 * @icon fa-cubes
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class ContentTypes extends Engine
{
    private $contentTypes;
    private $path;

    const DIR = 'content_types/';
    const PATH = 'controllers/engine/content_types/';
    const EXT = '.tpl';

    public function __construct()
    {
        parent::__construct();

        $this->contentTypes = new \models\engine\ContentTypes();

        // шлях до тем
        $themes_path = Settings::getInstance()->get('themes_path');
        // активна тема
        $theme = Settings::getInstance()->get('app_theme_current');
        // шлях до вьюшок
        $vpath = Settings::getInstance()->get('app_views_path');

        $this->path = DOCROOT .  $themes_path  . $theme .'/' . $vpath . self::DIR;
    }

    public function index($parent_id=0)
    {
        if($parent_id > 0){
            $data = $this->contentTypes->getData($parent_id);
            $this->appendToPanel((string)Link::create
            (
                $this->t('common.back'),
                ['class' => 'btn-md b-contentTypes-create', 'href'=> 'contentTypes/index' . ($data['parent_id']>0 ? '/' . $data['parent_id'] : '')]
            )
            );
        }

        $this->appendToPanel
        (
            (string)Link::create
                (
                    $this->t('common.button_create'),
                    ['class' => 'btn-md b-contentTypes-create', 'href'=> 'contentTypes/create' . ($parent_id? "/$parent_id" : '')]
                )
        );

        $t = new DataTables();

        $t  -> setId('contentTypes')
            -> ajaxConfig('contentTypes/items/' . $parent_id)
//            -> setConfig('order', array(0, 'desc'))
            -> th($this->t('common.id'))
            -> th($this->t('contentTypes.name'))
            -> th($this->t('contentTypes.type'))
            -> th($this->t('contentTypes.template'))
            -> th($this->t('common.tbl_func'), '', 'width: 60px')
        ;

        $this->output($t->render());
    }

    public function items($parent_id = 0)
    {
        $t = new DataTables();
        $t  -> table('content_types')
            -> get('id, name, type, isfolder, is_main')
            -> where(" parent_id = {$parent_id}")
            -> execute();

        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {
            $res[$i][] = $row['id'];
            $res[$i][] = "<a href='ContentTypes/index/{$row['id']}'>{$row['name']}</a>";
            $res[$i][] = $row['type'];
            $res[$i][] = $this->getPath($row['id'], false);
            $res[$i][] =
                (string)Link::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    ['class' => 'btn-primary', 'href' => "contentTypes/edit/" . $row['id'], 'title' => $this->t('common.title_edit')]
                ) .
                ($row['is_main'] == 0 && $row['isfolder'] == 0 ? (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'b-contentTypes-delete', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                ) : "")

            ;
        }

        return $t->renderJSON($res, $t->getTotal());
    }

    public function create($parent_id=null)
    {
        $this->appendToPanel((string)Link::create
        (
            $this->t('common.back'),
            ['class' => 'btn-md b-contentTypes-create', 'href'=> 'contentTypes/index' . ($parent_id? "/$parent_id" : '')]
        )
        );


        $this->appendToPanel
        (
            (string)Button::create
            (
                $this->t('common.button_save'),
                ['class' => 'btn-md b-form-save']
            )
        );
        $data = ['parent_id' => $parent_id,'images_sizes' => []];
//        $data['controllers'] = $this->getContentTypes();
        $this->template->assign('data', $data);
        $this->template->assign('imagesSizes', $this->contentTypes->getContentImagesSizes());
        $this->template->assign('action', 'create');
        $this->output($this->template->fetch('contentTypes/form'));
    }

    /**
     * @param $id
     */
    public function edit($id)
    {
        $data = $this->contentTypes->getData($id);
        if(empty($data)) $this->redirect(404);

        $this->appendToPanel
        (
            (string)Link::create
            (
                $this->t('common.back'),
                ['class' => 'btn-md b-contentTypes-create', 'href'=> 'contentTypes/index' . ($data['parent_id']? "/{$data['parent_id']}" : '')]
            )
        );

        $this->appendToPanel
        (
            (string)Button::create
            (
                $this->t('common.button_save'),
                ['class' => 'btn-md b-form-save']
            )
        );

        $data['template'] = $this->readTemplate($id);

        $this->template->assign('imagesSizes', $this->contentTypes->getContentImagesSizes());
        $this->template->assign('data', $data);
        $this->template->assign('features', $this->contentTypes->getFeatures());
        $this->template->assign('action', 'edit');
        $this->output($this->template->fetch('contentTypes/form'));
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
            $i[] = ["data[type]" => $this->t('contentTypes.error_isset_type')];
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
                        $m = $this->t('common.update_success');
                    }
                    break;
            }
        }

        if($this->contentTypes->hasDBError()){
            echo $this->contentTypes->getDBErrorMessage();
        }

        $this->response->body(['s'=>$s, 'i' => $i, 'm' => $m])->asJSON();
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
//            chown($path, Config::getInstance()->get('core.user'));
        }


        $data = $this->contentTypes->getData($id);

        $now = date('c');
        $y = date('Y');
        $user = Admin::data();
        $text = "{*
 * OYiEngine 7
 * @author {$user['name']} {$user['surname']} mailto:support@otakoi.com
 * @copyright Copyright (c) {$y} Otakoyi.com
 * Date: {$now}
 * @name {$data['name']}
 *}\r\n"
            . $this->request->post('template');

        return $this->writeTemplate($id, $text);
    }

    /**
     * @param $id
     * @return string
     */
    private function readTemplate($id)
    {
        $template = $this->getPath($id);
        return file_get_contents( $template );
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

    /**
     * @param $types_id
     * @param $subtypes_id
     * @param $features_id
     * @return int
     */
    public function selectFeatures($types_id, $subtypes_id, $features_id)
    {
        if(empty($features_id)) return 0;

        if($types_id == 0) {
            $types_id = $subtypes_id;
            $subtypes_id = 0;
        }

        $s = $this->contentTypes->selectFeatures($types_id, $subtypes_id, $features_id);
        if($this->contentTypes->hasDBError()){
            echo $this->contentTypes->getDBErrorMessage();
        }

        $s = $s ? 1 : 0; $sf = null;

        if($s){
            $sf = $this->contentTypes->getSelectedFeatures($types_id, $subtypes_id);
        }
        $this->response->body(['s' => $s, 'sf' => $sf])->asJSON();
    }

    public function deleteFeatures($id)
    {
        $s = $this->contentTypes->deleteFeatures($id);
        $s = $s ? 1 : 0;
        $this->response->body($s)->asHtml();
    }
}