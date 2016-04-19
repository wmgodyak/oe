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
 * Class Chunks
 * @name Типи контенту
 * @icon fa-file-code-o
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class Chunks extends Engine
{
    private $chunks;
    private $path;

    const DIR = 'chunks/';
    const EXT = '.tpl';

    public function __construct()
    {
        parent::__construct();

        $this->chunks = new \models\engine\Chunks();

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
        $this->appendToPanel
        (
            (string)Link::create
                (
                    $this->t('common.button_create'),
                    ['class' => 'btn-md', 'href'=> 'chunks/create']
                )
        );

        $t = new DataTables();

        $t  -> setId('chunks')
            -> ajaxConfig('chunks/items')
//            -> setConfig('order', array(0, 'desc'))
            -> th($this->t('common.id'))
            -> th($this->t('chunks.name'))
            -> th($this->t('chunks.template'))
            -> th($this->t('common.tbl_func'), '', 'width: 60px')
        ;

        $this->output($t->render());
    }

    public function items()
    {
        $t = new DataTables();
        $t  -> table('__chunks')
            -> get('id, name, template')
            -> execute();

        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {
            $res[$i][] = $row['id'];
            $res[$i][] = "<a href='chunks/edit/{$row['id']}'>{$row['name']}</a>";
            $res[$i][] = $this->getPath($row['id'], false);
            $res[$i][] =
                (string)Link::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    ['class' => 'btn-primary', 'href' => "chunks/edit/" . $row['id'], 'title' => $this->t('common.title_edit')]
                ) .
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'b-chunks-delete', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                )
            ;
        }

        return $t->renderJSON($res, $t->getTotal());
    }

    public function create()
    {
        $this->appendToPanel((string)Link::create
        (
            $this->t('common.back'),
            ['class' => 'btn-md', 'href'=> 'chunks']
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
        $this->template->assign('action', 'create');
        $this->output($this->template->fetch('chunks/form'));
    }

    /**
     * @param $id
     */
    public function edit($id)
    {
        $data = $this->chunks->getData($id);
        if(empty($data)) $this->redirect(404);

        $this->appendToPanel
        (
            (string)Link::create
            (
                $this->t('common.back'),
                ['class' => 'btn-md', 'href'=> 'chunks']
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

        $this->template->assign('data', $data);
        $this->template->assign('template', $this->readTemplate($id));
        $this->template->assign('action', 'edit');
        $this->output($this->template->fetch('chunks/form'));
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

        FormValidation::setRule(['name', 'template'], FormValidation::REQUIRED);

        FormValidation::run($data);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } elseif($this->chunks->issetTemplate($data['template'], $id)){
            $i[] = ["data[type]" => $this->t('chunks.error_isset_type')];
        } else {
            switch($this->request->post('action')){
                case 'create':
                    $s = $this->chunks->create($data);
                    if($s>0){
                        $this->createTemplate($s);
                    }
                    break;
                case 'edit':
                    if( $id > 0 ){
                        $prev_type = $this->chunks->getData($id, 'template');
                        $s = $this->chunks->update($id, $data);

                        if($prev_type !== $data['template']){
                            $this->renameTemplate($prev_type, $data['template']);
                        }

                        $this->writeTemplate($id, $this->request->post('template'));
                        $m = $this->t('common.update_success');
                    }
                    break;
            }
        }

        if($this->chunks->hasDBError()){
            $m = $this->chunks->getDBErrorMessage();
        }

        $this->response->body(['s'=>$s, 'i' => $i, 'm' => $m])->asJSON();
    }

    /**
     * @param $id
     * @return mixed
     */
    public function delete($id)
    {
        $template = $this->getPath($id);

        $s = $this->chunks->delete($id);
        if($s>0){
            @unlink($template);
        }
        return $s;
    }

    /**
     * @param $oldname
     * @param $newname
     * @return bool
     */
    private function renameTemplate($oldname, $newname)
    {
        $path = $this->path;
        return rename($path . $oldname . self::EXT, $path . $newname . self::EXT);
    }

    /**
     * @param $id
     * @return int
     */
    private function createTemplate($id)
    {
        $path = $this->path;

        if(!is_dir($path)) {
            mkdir($path, 0777, true);
//            chown($path, Config::getInstance()->get('core.user'));
        }


        $data = $this->chunks->getData($id);

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

    private function getPath($id, $abs = true)
    {
        $data = $this->chunks->getData($id);
        $path = $this->path;
        $template = $path . $data['template'] .  self::EXT;

        return !$abs ? str_replace(DOCROOT , '', $template) : $template;
    }
}