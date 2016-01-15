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
use helpers\FormValidation;
use helpers\PHPDocReader;
use models\engine\Component;

defined("CPATH") or die();

/**
 * Class Components
 * @package controllers\engine\components
 */
class Components extends Engine
{
    private $mComponents;

    const PATH = 'controllers/engine/';

    public function __construct()
    {
//        $this->requireComponent('Installer');

        parent::__construct();

        $this->mComponents = new \models\engine\Components();
    }

    public function index()
    {
        $this->appendToPanel((string)Button::create($this->t('components.install'), ['class' => 'btn-md install-archive']));

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
            $data = $this->mComponents->data($item['controller'], 'component');
            $installed = isset($data['id']);

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
        $data = Component::create($id)->data();

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
            $s = Component::create($id)->update($data);
        }

        $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
    }
}