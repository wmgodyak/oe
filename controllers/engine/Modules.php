<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 28.01.16 : 14:01
 */
namespace controllers\engine;

use controllers\core\Request;
use controllers\Engine;
use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\FormValidation;
use helpers\PHPDocReader;
use models\core\DB;

defined("CPATH") or die();

/**
 * Class Modules
 * @name Модулі
 * @icon fa-puzzle-piece
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @rang 300
 * @package controllers\engine
 */
class Modules extends Engine
{
    private $mModules;

    const PATH = 'controllers/modules/';

    public function __construct()
    {
        parent::__construct();

        $this->mModules = new \models\engine\Modules();
    }

    public function index()
    {
        $t = new DataTables();

        $t  -> setId('modules')
            -> ajaxConfig('modules/items')
//            -> setConfig('order', array(0, 'desc'))
            -> th($this->t('common.tbl_name'))
            -> th($this->t('modules.author'))
            -> th($this->t('modules.controller'))
            -> th($this->t('modules.version'))
            -> th($this->t('common.tbl_func'), '', 'width:150px')
        ;

        $this->output($t->render());
    }

    public function items()
    {
        $items = array();
        if ($handle = opendir(DOCROOT . self::PATH)) {
            while (false !== ($entry = readdir($handle))) {
                if ($entry != "." && $entry != ".." && !is_dir(DOCROOT . self::PATH . $entry)) {

                    $module = str_replace('.php', '', $entry);
                    $ns = str_replace('/', '\\', self::PATH);

                    $row = PHPDocReader::getMeta($ns . ucfirst($module));
                    if(!isset($row['name'])) continue;

                    $row['controller'] = ucfirst($module);

                    if(!isset($row['rang'])) $row['rang'] = 101;

                    $items[] = $row;
                }
            }
            closedir($handle);
        }

        $res = array();
        $t = new DataTables();
        foreach ($items as $i=>$item) {
            $data = $this->mModules->data($item['controller']);
            $installed = isset($data['id']);

            if($installed) $item = array_merge($item, $data);

            $icon  = $installed ? (string) Icon::TYPE_UNINSTALL : (string) Icon::TYPE_INSTALL;
//            $icon_pub  = $installed && $data['published'] == 1 ? (string) Icon::TYPE_PUBLISHED : (string) Icon::TYPE_HIDDEN;

            $res[$i][] = $item['name'];// . ($installed ? "<br><label class=\"label label-info\">{$t_installed}</label>" : '');
            $res[$i][] = $item['author'];
            $res[$i][] = (isset($item['package']) ? $item['package'] ."\\" : '') . $item['controller'] ;
            $res[$i][] = $item['version'];

            $res[$i][] =
                (string) Button::create
                (
                    Icon::create($icon),
                    [
                        'class'     => Button::TYPE_DANGER  . " b-module-" . ($installed ? 'uninstall' : 'install'),
                        'data-id'   => ($installed ? $data['id'] : $item['controller']),
                        'title'     => ($installed ? $this->t('modules.uninstall') : $this->t('modules.install'))
                    ]
                ).
                ($installed ?
                    (string) Button::create
                    (
                        Icon::create(Icon::TYPE_EDIT),
                        [
                            'class'   => Button::TYPE_PRIMARY  . " b-module-edit",
                            'data-id' => $data['id'],
                            'title'   => $this->t('modules.edit')
                        ]
                    )
                    : '')

            ;
        }

        $this->response->body($t->renderJSON($res, count($res), false))->asJSON();
    }

    public function create()
    {

    }

    public function edit($id)
    {
        $data = $this->mModules->getDataByID($id);
        $this->template->assign('data', $data);
        $this->response->body($this->template->fetch('modules/edit'))->asHtml();
    }

    public function delete($id)
    {
        // TODO: Implement delete() method.
    }

    public function process($id)
    {
        if(! $this->request->isPost()) die;
        $s = $this->mModules->update($id);
        $m=null;
        if($this->mModules->hasDBError()){
            $m = $this->mModules->getDBError() . $this->mModules->getDBErrorMessage();
        }
        $this->response->body(['s'=>$s,'m' => $m])->asJSON();
    }



    public function install()
    {

            $module = $this->request->post('c');

            $s=0; $i=[]; $m=null;
            $data = [];
            $data['controller'] = $module;

            FormValidation::setRule(['controller'], FormValidation::REQUIRED);

            FormValidation::run($data);

            if(FormValidation::hasErrors()){
                $i = FormValidation::getErrors();
            } elseif($this->mModules->isInstalled($module)){
                $m = ["data[parent_id]" => $this->t('modules.error_module_installed')];
            } else {

                $meta = PHPDocReader::getMeta('controllers\modules\\'. $module);

                if(isset($meta['icon']))     $data['icon']     = $meta['icon'];
                if(isset($meta['author']))   $data['author']   = $meta['author'];
//                if(isset($meta['rang']))     $data['rang']     = $meta['rang'];
                if(isset($meta['version']))  $data['version']  = $meta['version'];

                $data['controller'] = lcfirst($data['controller']);
                $s = $this->mModules->create($data);
            }

            $this->response->body(['s'=>$s, 'i' => $i, 'm' => $m])->asJSON();
    }

    public function uninstall()
    {
        $id = $this->request->post('id', 'i');
        if(empty($id)) die;
        $isset = $this->mModules->is($id);
        if($isset){
            $this->response->body($this->mModules->delete($id))->asPlainText();
        }
    }
}