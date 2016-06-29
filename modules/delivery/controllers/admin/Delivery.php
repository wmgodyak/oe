<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:11
 */

namespace modules\delivery\controllers\admin;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\PHPDocReader;
use modules\delivery\controllers\DeliveryFactory;
use modules\delivery\models\DeliveryPayment;
use system\core\DataTables2;
use system\Engine;

class Delivery extends Engine
{
    private $delivery;
    private $delivery_payment;

    const ADAPTERS_PATH = 'modules\delivery\adapters\\';

    public function __construct()
    {
        parent::__construct();

        $this->delivery = new \modules\delivery\models\admin\Delivery();
        $this->delivery_payment = new DeliveryPayment();
    }

    public function init()
    {
        $this->assignToNav('Доставка', 'module/run/delivery', 'fa-bus');//, 'module/run/shop'
        $this->template->assignScript("modules/delivery/js/admin/delivery.js");
    }


    public function index()
    {
        $this->appendToPanel
        (
            (string)Button::create($this->t('common.button_create'), ['class' => 'btn-md btn-primary b-delivery-create'])
        );
        $t = new DataTables2('delivery');

        $t  -> ajax('module/run/delivery')
            -> th($this->t('common.id'), 'd.id',1,1, 'width: 20px')
            -> th($this->t('delivery.name'), 'i.name', 1,1)
            -> th($this->t('delivery.price'), 'd.price',1,1, 'width: 200px')
            -> th($this->t('delivery.free_from'), 'd.free_from', 1, 1, 'width: 200px')
            -> th($this->t('common.tbl_func'), null, 0, 0, 'width: 180px')
            -> get('d.published')
        ;

        if($this->request->isXhr()){

            $t  -> from('__delivery d')
                -> join("__delivery_info i on i.delivery_id=d.id and i.languages_id={$this->languages_id}")
                -> execute();

            $res = array();
            foreach ($t->getResults(false) as $i=>$row) {
                $res[$i][] = $row['id'];
                $res[$i][] = $row['name'];
                $res[$i][] = $row['price'];
                $res[$i][] = $row['free_from'];
                $res[$i][] =
                    (string)(
                    $row['published'] ?
                        Button::create
                        (
                            Icon::create(Icon::TYPE_PUBLISHED),
                            [
                                'class' => 'b-delivery-hide',
                                'title' => $this->t('common.title_pub'),
                                'data-id' => $row['id']
                            ]
                        )
                        :
                        Button::create
                        (
                            Icon::create(Icon::TYPE_HIDDEN),
                            [
                                'class' => 'b-delivery-pub',
                                'title' => $this->t('common.title_hide'),
                                'data-id' => $row['id']
                            ]
                        )
                    ).
                    (string)Button::create
                    (
                        Icon::create(Icon::TYPE_EDIT),
                        ['class' => 'b-delivery-edit btn-primary', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
                    ) .
                    (string)Button::create
                    (
                        Icon::create(Icon::TYPE_DELETE),
                        ['class' => 'b-delivery-delete btn-danger', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                    )
                ;
            }

            echo $t->render($res, $t->getTotal());return;
        }

        $this->output($t->init());
    }

    public function create()
    {
        $this->template->assign('action', 'create');
        $this->template->assign('payment', $this->delivery_payment->getPayment());
        $this->template->assign('modules', $this->getModules());
        $this->response->body($this->template->fetch('delivery/edit'))->asHtml();
    }

    public function edit($id)
    {
        $this->template->assign('data', $this->delivery->getData($id));
        $this->template->assign('action', 'edit');
        $this->template->assign('payment', $this->delivery_payment->getPayment());
        $this->template->assign('selected', $this->delivery_payment->getSelectedPayment($id));
        $this->template->assign('modules', $this->getModules());
        $this->response->body($this->template->fetch('delivery/edit'))->asHtml();
    }

    public function process($id= null)
    {
        if(! $this->request->isPost()) die;

        $delivery_info = $this->request->post('info');
        $s=0; $i=[];

        foreach ($delivery_info as $languages_id=> $item) {
            if(empty($item['name'])){
                $i[] = ["info[$languages_id][name]" => $this->t('delivery.empty_name')];
            }
        }

        if(empty($i)){
            switch($this->request->post('action')){
                case 'create':
                    $s = $this->delivery->create();
                    break;
                case 'edit':
                    if( $id > 0 ){
                        $s = $this->delivery->update($id);
                    }
                    break;
            }
            if(! $s){
                echo $this->delivery->getErrorMessage();
            }

        }

        $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
    }

    private function getModules()
    {
        $path = str_replace('\\', '/', self::ADAPTERS_PATH);

        $items = array();
        if ($handle = opendir(DOCROOT . $path)) {
            while (false !== ($entry = readdir($handle))) {
                if ($entry != "." && $entry != ".." ) {

                    $module = str_replace('.php', '', $entry);

                    $meta = PHPDocReader::getMeta(self::ADAPTERS_PATH . $module);
                    $items[] = ['module' => $module, 'name' => $meta['name']];
                }
            }
            closedir($handle);
        }

        return $items;
    }

    public function getModuleSettings()
    {
        $module = $this->request->post('module');
        $db_settings = $this->delivery->getSettings($module);

        $settings = DeliveryFactory::getSettings($module);

        $res = [];$i=0;
        foreach ($settings as $k=>$v) {
            $res[$i]['name']  = $k;
            $res[$i]['value'] = isset($db_settings[$k]) ? $db_settings[$k] : null;
            $i++;
        }
        $this->response->body(['s' => $res])->asJSON();
    }

    public function delete($id)
    {
        $this->response->body(  $this->delivery->delete($id) );
    }

    public function pub($id)
    {
        $this->response->body( $this->delivery->pub($id));
    }

    public function hide($id)
    {
        $this->response->body(  $this->delivery->hide($id));
    }
}