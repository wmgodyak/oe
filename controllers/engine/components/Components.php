<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 13.01.16 : 9:46
 */

namespace controllers\engine\components;

use controllers\Engine;
use controllers\engine\DataTables;
use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\PHPDocReader;

defined("CPATH") or die();

/**
 * Class Components
 * @package controllers\engine\components
 */
class Components extends Engine
{
    private $mc;

    const PATH = 'controllers/engine/';

    public function __construct()
    {
        parent::__construct();

        $this->mc = new \models\engine\Components();
    }

    public function index()
    {
        $this->appendButtonToPanel($this->t('components.install'), ['onclick' => 'engine.components.install();']);

        $t = new DataTables();

        $t  -> setId('components')
            -> ajaxConfig('components/items')
//            -> setConfig('order', array(0, 'desc'))
            -> th('#')
            -> th($this->t('common.tbl_name'))
            -> th($this->t('components.author'))
            -> th($this->t('components.controller'))
            -> th($this->t('components.version'))
            -> th($this->t('components.rang'))
            -> th($this->t('common.tbl_func'))
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
        $t_installed = $this->t('components.installed');
        foreach ($items as $i=>$item) {
            $installed = $this->mc->isInstalled($item['controller']);

            $icon  = $installed ? (string) Icon::TYPE_INSTALL : (string) Icon::TYPE_INSTALL;

            $res[$i][] = $i;
            $res[$i][] = $item['name'] . ($installed ? "<br><label class=\"label label-info\">{$t_installed}</label>" : '');
            $res[$i][] = $item['author'];
            $res[$i][] = (isset($item['package']) ? $item['package'] ."\\" : '') . $item['controller'] ;
            $res[$i][] = $item['version'];
            $res[$i][] = $item['rang'];

            $res[$i][] =
                (string) Button::create
                (
                    Icon::create($icon),
                    [ 'class' => Button::TYPE_PRIMARY  . " b-component-" . ($installed ? 'uninstall' : 'install'), 'data-id' => $item['controller']]
                )
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
        // TODO: Implement edit() method.
    }
    public function delete($id)
    {
        // TODO: Implement delete() method.
    }
    public function process($id)
    {
        // TODO: Implement process() method.
    }
}