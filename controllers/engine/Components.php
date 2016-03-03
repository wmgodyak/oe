<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 28.01.16 : 14:01
 */
namespace controllers\engine;

use controllers\Engine;
use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\FormValidation;
use helpers\PHPDocReader;

defined("CPATH") or die();

/**
 * Class Components
 * @name Компоненти
 * @icon fa-puzzle-piece
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class Components extends Engine
{
    private $mComponents;

    const PATH = 'controllers/engine/';

    public function __construct()
    {
        parent::__construct();

        $this->mComponents = new \models\engine\Components();
    }

    public function index()
    {
        //  $this->appendToPanel((string)Button::create($this->t('components.install'), ['class' => 'btn-md install-archive']));

        $t = new DataTables();

        $t  -> setId('components')
            -> ajaxConfig('components/items')
//            -> setConfig('order', array(0, 'desc'))
            -> th($this->t('common.tbl_name'))
            -> th($this->t('components.author'))
            -> th($this->t('components.controller'))
            -> th($this->t('components.version'))
            -> th($this->t('components.rang'))
            -> th($this->t('common.tbl_func'))
        ;

        $this->output($t->render());
    }

    private function readComponents($path)
    {
        $items  = []; $disabled = ['.','..', 'plugins'];
        if ($handle = opendir(DOCROOT . $path)) {
            while (false !== ($entry = readdir($handle))) {
                if (in_array($entry, $disabled)) continue;

                    if(is_dir($path . $entry)){
                        $items = array_merge($items, $this->readComponents($path . $entry . '/'));
                    }

                    $module = str_replace('.php', '', $entry);
                    $ns = str_replace('/', '\\', $path);

                    $row = PHPDocReader::getMeta($ns . ucfirst($module));
                    if(!isset($row['name'])) continue;

                    $row['controller'] = str_replace('controllers/engine/','', $path . ucfirst($module));

                    if(!isset($row['rang'])) $row['rang'] = 101;

                    $items[] = $row;

            }
            closedir($handle);
        }

        return $items;
    }

    public function items()
    {
        $items = $this->readComponents(self::PATH);

        $res = array();
        $t = new DataTables();
        $t_installed = $this->t('components.installed');
        foreach ($items as $i=>$item) {
            $data = $this->mComponents->data($item['controller']);
            $installed = isset($data['id']);

            if($installed) $item = array_merge($item, $data);

            $icon  = $installed ? (string) Icon::TYPE_UNINSTALL : (string) Icon::TYPE_INSTALL;
            $icon_pub  = $installed && $data['published'] == 1 ? (string) Icon::TYPE_PUBLISHED : (string) Icon::TYPE_HIDDEN;

            $res[$i][] = $item['name'] . ($installed ? "<br><label class=\"label label-info\">{$t_installed}</label>" : '');
            $res[$i][] = $item['author'];
            $res[$i][] = (isset($item['package']) ? $item['package'] ."\\" : '') . $item['controller'] ;
            $res[$i][] = $item['version'];
            $res[$i][] = $item['rang'];

            $res[$i][] =
                (string) Button::create
                (
                    Icon::create($icon),
                    [
                        'class'     => Button::TYPE_PRIMARY  . " b-component-" . ($installed ? 'uninstall' : 'install'),
                        'data-id'   => ($installed ? $data['id'] : $item['controller']),
                        'data-type' => 'component',
                        'title'     => ($installed ? $this->t('components.uninstall') : $this->t('components.install'))
                    ]
                ) . ($installed ?
                    (string) Button::create
                    (
                        Icon::create($icon_pub),
                        [
                            'class' => Button::TYPE_PRIMARY  . " b-component-" . ($installed && $data['published'] == 1 ? 'hide' : 'pub'),
                            'data-id' => $data['id'],
                            'title'   => ($installed && $data['published'] == 1 ? $this->t('components.pub') : $this->t('components.hide'))
                        ]
                    ) : '').
                ($installed ?
                    (string) Button::create
                    (
                        Icon::create(Icon::TYPE_EDIT),
                        [
                            'class'   => Button::TYPE_PRIMARY  . " b-component-edit",
                            'data-id' => $data['id'],
                            'data-type' => 'components',
                            'title'   => $this->t('components.edit')
                        ]
                    )
                    : '')

            ;
        }

        $this->response->body($t->renderJSON($res, count($res), false))->asJSON();
    }

    public function create()
    {
        // TODO: Implement create() method.
    }

    public function edit($id)
    {
        die('Дію заборонено');
        $data = $this->mComponents->getDataByID($id);

        $this->template->assign('data', $data);
        $this->template->assign('tree', $this->mComponents->tree());

        $this->response->body($this->template->fetch('components/edit'))->asHtml();
    }

    public function delete($id)
    {
        // TODO: Implement delete() method.
    }

    public function process($id)
    {
        if(! $this->request->isPost()) die;

        $data = $this->request->post('data'); $s=0; $i=[];

        FormValidation::setRule(['icon', 'position'], FormValidation::REQUIRED);

        FormValidation::run($data);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } else {
            $s = $this->mComponents->update($id, $data);
        }

        $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
    }



    public function install()
    {
        $component = $this->request->post('c');

        if($this->request->post('action')){

            $data = $this->request->post('data'); $s=0; $i=[];
            $data['controller'] = $component;

            FormValidation::setRule(['type', 'controller'], FormValidation::REQUIRED);

            FormValidation::run($data);

            if(FormValidation::hasErrors()){
                $i = FormValidation::getErrors();
            } elseif($this->mComponents->isInstalled($component)){
                $i[] = ["data[parent_id]" => $this->t('components.error_component_installed')];
            } else {
                $component = str_replace('/','\\', $component);
                $meta = PHPDocReader::getMeta('controllers\engine\\'. $component);

                if(isset($meta['icon']))     $data['icon']     = $meta['icon'];
                if(isset($meta['position'])) $data['position'] = $meta['position'];
                if(isset($meta['author']))   $data['author']   = $meta['author'];
                if(isset($meta['rang']))     $data['rang']     = $meta['rang'];
                if(isset($meta['version']))  $data['version']  = $meta['version'];

                $data['published'] = 1;

                $s = $this->mComponents->create($data);
            }

            $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
        }

        $this->template->assign('tree', $this->mComponents->tree());
        $this->template->assign('component', $component);
        return $this->template->fetch('components/install_component');
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

    public function uninstall()
    {
        $id = $this->request->post('id', 'i');
        if(empty($id)) die;
        $isset = $this->mComponents->is($id);
        if($isset){
            $this->response->body($this->mComponents->delete($id))->asPlainText();
        }
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
}