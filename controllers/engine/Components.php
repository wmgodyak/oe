<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 25.12.15 : 17:46
 */

namespace controllers\engine;

use controllers\Engine;
use helpers\FormValidation;
use helpers\PHPDocReader;

defined("CPATH") or die();

/**
 * Class Components
 * @name Компоненти
 * @icon fa fa-users
 * @position 5
 * @author Volodymyr Hodiak
 * @version 7.0.0
 * @package controllers\engine
 */
class Components extends Engine
{
    private $mComponents;

    public function __construct()
    {
        parent::__construct();

        $this->mComponents = new \models\engine\Components();
    }
    public function index($component = '')
    {
        if(empty($component)) $component = 'components';

        $cl = ComponentsFactory::create($component);
        $cl ->index();
    }

    public function items($component = '')
    {
        if(empty($component)) $component = 'components';

        $cl = ComponentsFactory::create($component);
        $cl ->items();
    }


    public function edit($id)
    {
        $component = $this->request->post('c');

        if(empty($component)) $component = 'components';

        $cl = ComponentsFactory::create($component);
        $cl ->edit($id);
    }

    public function create()
    {

    }

    public function delete($id)
    {

    }

    public function process($id)
    {
        $component = $this->request->post('c');

        if(empty($component)) $component = 'components';

        $cl = ComponentsFactory::create($component);
        $cl ->process($id);
    }

    public function pub()
    {
        $id = $this->request->post('id', 'i');
        if(empty($id)) die;
        $isset = $this->mComponents->is($id);
        if($isset){
            $this->response->body($this->mComponents->pub($id))->asPlainText();
        }
    }

    public function hide()
    {
        $id = $this->request->post('id', 'i');
        if(empty($id)) die;
        $isset = $this->mComponents->is($id);
        if($isset){
            $this->response->body($this->mComponents->hide($id))->asPlainText();
        }
    }

    public function install()
    {

        $component = $this->request->post('c');
        $type      = $this->request->post('t');


        if($this->request->post('action')){
            switch($type){
                case 'component':
                    if(empty($component) || empty($type)) return 0;
                    return $this->installComponent($component);
                default:
                    // archive
                    return $this->installArchive();
            }
        }

        switch($type){
            case 'component':
                if(empty($component) || empty($type)) return 0;
                $this->template->assign('tree', $this->mComponents->tree());
                break;
            default:
                // archive
                $this->template->assign('tree', $this->mComponents->tree());
                // тип
                $this->template->assign('ctype', ['component', 'module', 'plugin']);
                break;
        }

        $this->template->assign('component', $component);
        $this->template->assign('type', $type);

        return $this->template->fetch('components/install_' . $type);
    }

    private function installArchive()
    {
        $data = $this->request->post('data'); $s=0; $i=[]; $m='';
        $file = $_FILES['file'];
        // перевірка підтримки zip
        if (! class_exists('ZipArchive')) {
            $i[] = ["file" => $this->t('components.error_component_installed')];
        } else {
            $file_info = pathinfo($file['name']);
            $file_extension = $file_info['extension'];
            $file_content = file_get_contents($file['tmp_name']);

            if(empty($file_content)){
                $i[] = ["file" => 'failure php://input  return empty string'];
            }
            if(empty($i)){
                if ($file_extension == 'zip' && class_exists('ZipArchive')) {

                    $zip = new \ZipArchive();
                    $res = $zip->open($file['tmp_name']);
                    $files_exists = [];

                    for ($c = 0; $c < $zip->numFiles; $c++) {
                        if(
                            !is_dir(DOCROOT . $zip->getNameIndex($c)) &&
                            file_exists(DOCROOT . $zip->getNameIndex($c))
                        )
                        {
                            $files_exists[] = $zip->getNameIndex($c);
                        }
                    }

                    if(!empty($files_exists)){
                        $i[] = ["file" =>  $this->t('components.error_file_exists') . implode('<br>', $files_exists)];
                    }

                    if ($res > 0 && $res != TRUE) {
                        $i[] = ["file" => 'failure code:' . $res];
                    }

                    if(empty($i)){
                        $zip->extractTo(DOCROOT);

                        $s=1;
                    }
                    $zip->close();
                }
            }
        }

        $this->response->body(['s'=>$s, 'i' => $i, 'm' => $m])->asJSON();
    }

    private function installComponent($controller)
    {
        $data = $this->request->post('data'); $s=0; $i=[];
        $data['controller'] = $controller;

        FormValidation::setRule(['type', 'controller'], FormValidation::REQUIRED);

        FormValidation::run($data);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } elseif($this->mComponents->isInstalled($controller)){
            $i[] = ["data[parent_id]" => $this->t('components.error_component_installed')];
        } else {
            // do install
            // буду розширяти по факту
            $meta = PHPDocReader::getMeta('controllers\engine\\'. $controller);
//            $this->dump($meta);

            if(isset($meta['icon']))     $data['icon']     = $meta['icon'];
            if(isset($meta['position'])) $data['position'] = $meta['position'];
            if(isset($meta['author']))   $data['author']   = $meta['author'];
            if(isset($meta['rang']))     $data['rang']     = $meta['rang'];

            $data['published'] = 1;

            $s = $this->mComponents->create($data);
        }

        $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
    }

    public function uninstall()
    {
        $id = $this->request->post('id', 'i');
        if(empty($id)) die;
        $isset = $this->mComponents->is($id);
        if($isset){
            $this->response->body($this->mComponents->delete($id))->asPlainText();
        }
    }
}