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
 * Class Plugins
 * @name Плагіни
 * @icon fa-puzzle-piece
 * @author Volodymyr Hodiak
 * @version 1.0.0

 * @package controllers\engine
 */
class Plugins extends Engine
{
    private $mPlugins;

    const PATH = 'controllers/engine/plugins/';

    public function __construct()
    {
        parent::__construct();

        $this->mPlugins = new \models\engine\Plugins();
    }

    public function index()
    {
        $t = new DataTables2('plugins');

        $t
            -> th($this->t('common.id'), null, false, false, 'width:30px')
            -> th($this->t('common.tbl_name'))
            -> th($this->t('plugins.author'))
            -> th($this->t('plugins.controller'))
            -> th($this->t('plugins.version'))
            -> th($this->t('common.tbl_func'), null, false, false, 'width:180px');

        $t-> ajax('plugins/index');

        if($this->request->isXhr()){

            $items = array();
            if ($handle = opendir(DOCROOT . self::PATH)) {
                while (false !== ($entry = readdir($handle))) {
                    if ($entry != "." && $entry != ".." && !is_dir(DOCROOT . self::PATH . $entry)) {

                        $module = str_replace('.php', '', $entry);
                        $ns = str_replace('/', '\\', self::PATH);

                        $row = PHPDocReader::getMeta($ns . ucfirst($module));
                        if(!isset($row['name'])) continue;

                        $row['controller'] = ucfirst($module);

                        $items[] = $row;
                    }
                }
                closedir($handle);
            }

            $res = array();

            foreach ($items as $i=>$item) {

                $data = $this->mPlugins->data($item['controller']);
                $installed = isset($data['id']);

                if($installed) $item = array_merge($item, $data);

                $icon      = $installed ? (string) Icon::TYPE_UNINSTALL : (string) Icon::TYPE_INSTALL;
                $icon_pub  = $installed && $data['published'] == 1 ? (string) Icon::TYPE_PUBLISHED : (string) Icon::TYPE_HIDDEN;

                $res[$i][] = $i;
                $res[$i][] = $item['name'];// . ($installed ? "<br><label class=\"label label-info\">{$t_installed}</label>" : '');
                $res[$i][] = $item['author'];
                $res[$i][] = (isset($item['package']) ? $item['package'] ."\\" : '') . $item['controller'] ;
                $res[$i][] = $item['version'];

                $res[$i][] =
                    (string) Button::create
                    (
                        Icon::create($icon),
                        [
                            'class'     => " b-plugin-" . ($installed ? 'uninstall' : 'install'),
                            'data-id'   => ($installed ? $data['id'] : $item['controller']),
                            'title'     => ($installed ? $this->t('plugins.uninstall') : $this->t('plugins.install'))
                        ]
                    ) . ($installed ?
                        (string) Button::create
                        (
                            Icon::create($icon_pub),
                            [
                                'class' => " b-plugin-" . ($installed && $data['published'] == 1 ? 'hide' : 'pub'),
                                'data-id' => $data['id'],
                                'title'   => ($installed && $data['published'] == 1 ? $this->t('plugins.pub') : $this->t('plugins.hide'))
                            ]
                        ) : '').
                    ($installed ?
                        (string) Button::create
                        (
                            Icon::create(Icon::TYPE_EDIT),
                            [
                                'class'   => Button::TYPE_PRIMARY  . " b-plugin-edit",
                                'data-id' => $data['id'],
                                'title'   => $this->t('plugins.edit')
                            ]
                        )
                        : '')

                ;
            }

            $this->response->body($t->render($res, count($res), false))->asJSON();
        }

        $this->output($t->init());
    }

    public function create()
    {

    }

    public function edit($id)
    {
        $data = $this->mPlugins->getDataByID($id);
        $this->template->assign('data', $data);
        $this->template->assign('components', $this->mPlugins->getComponents());
        $this->template->assign('place', $this->mPlugins->getPlace());
        $this->response->body($this->template->fetch('plugins/edit'))->asHtml();
    }

    public function delete($id)
    {
        // TODO: Implement delete() method.
    }

    public function process($id)
    {
        if(! $this->request->isPost()) die;

        $data = $this->request->post('data'); $s=0; $i=[]; $m = null;
        $components = $this->request->post('components');
        $s = $this->mPlugins->update($id, $data, $components);

        if($this->mPlugins->hasDBError()){
            $m = $this->mPlugins->getDBError() . $this->mPlugins->getDBErrorMessage();
        }
        $this->response->body(['s'=>$s, 'i' => $i, 'm' => $m])->asJSON();
    }



    public function install()
    {

        $plugin = $this->request->post('c');

        if($this->request->post('action')){

            $data = $this->request->post('data'); $s=0; $i=[];
            $data['controller'] = $plugin;

            FormValidation::setRule(['controller'], FormValidation::REQUIRED);

            FormValidation::run($data);

            if(FormValidation::hasErrors()){
                $i = FormValidation::getErrors();
            } elseif($this->mPlugins->isInstalled($plugin)){
                $i[] = ["data[parent_id]" => $this->t('plugins.error_plugin_installed')];
            } else {

                $meta = PHPDocReader::getMeta('controllers\engine\plugins\\'. $plugin);

                if(isset($meta['icon']))     $data['icon']     = $meta['icon'];
                if(isset($meta['author']))   $data['author']   = $meta['author'];
                if(isset($meta['rang']))     $data['rang']     = $meta['rang'];
                if(isset($meta['version']))  $data['version']  = $meta['version'];

                $data['published'] = 1;
                $components = $this->request->post('components');
                $s = $this->mPlugins->create($data, $components);
            }

            $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
        }

        $this->template->assign('components', $this->mPlugins->getComponents());
        $this->template->assign('place', $this->mPlugins->getPlace());
        $this->template->assign('plugin', $plugin);
        return $this->template->fetch('plugins/install');
    }

    public function uninstall()
    {
        $id = $this->request->post('id', 'i');
        if(empty($id)) die;
        $isset = $this->mPlugins->is($id);
        if($isset){
            $this->response->body($this->mPlugins->delete($id))->asPlainText();
        }
    }


    public function pub()
    {
        $id = $this->request->post('id', 'i');
        if(empty($id)) die;
        $isset = $this->mPlugins->is($id);
        if($isset){
            $this->response->body($this->mPlugins->pub($id))->asPlainText();
        }
    }

    public function hide()
    {
        $id = $this->request->post('id', 'i');
        if(empty($id)) die;
        $isset = $this->mPlugins->is($id);
        if($isset){
            $this->response->body($this->mPlugins->hide($id))->asPlainText();
        }
    }



    public static function get()
    {
        $request = Request::getInstance();

        $controller  = $request->param('controller');
        $action      = $request->param('action');
        $args        = $request->param('args');
        $ns          = $request->param('namespace');
        $ns = str_replace('\\','/', $ns);
        $ns = str_replace('controllers/engine/', '', $ns);
        $controller  = $ns . $controller;

        $r = DB::getInstance()
            -> select("
                select p.controller, p.icon, p.rang, p.place, p.settings
                from __plugins p
                join __components c on c.controller = '{$controller}'
                join __plugins_components pc on pc.plugins_id=p.id and pc.components_id=c.id
                where p.published=1
            ")
            -> all();

        $plugins = [];
        foreach ($r as $item) {
            if(!empty($item['settings'])) $item['settings'] = unserialize($item['settings']);

            if(! Permissions::check('plugins\\'. ucfirst($item['controller']), $action)){
                continue;
            }

            $p = self::getPlugin($item['controller'], $item);

            if(method_exists($p, $action) && !in_array($action, $p->disallow_actions)){ //  && $p->autoload == true
                $ds = call_user_func_array(array($p, $action), $args);

                if(empty($ds)) continue;

                $plugins[$item['place']][] = $ds;
            }
        }

        return $plugins;
    }

    /**
     * @param $plugin
     * @param null $data
     * @return mixed
     * @throws \FileNotFoundException
     */
    private static function getPlugin($plugin, $data=null)
    {
        if(! file_exists(DOCROOT . 'controllers/engine/plugins/' . ucfirst($plugin) . '.php')) {
            throw new \FileNotFoundException("Контроллер плагіну {$plugin} не знайдено.");
        }

        $cl = '\controllers\engine\plugins\\' .  ucfirst($plugin);

        $cl = new $cl();
        $cl->setMeta($data);

        return $cl;
    }
}