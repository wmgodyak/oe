<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:11
 */

namespace modules\banners\controllers\admin;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use system\core\DataTables2;
use system\Engine;

class Banners extends Engine
{
    private $banners;
    private $places;

    public function __construct()
    {
        parent::__construct();
        $this->banners = new \modules\banners\models\admin\Banners();
        $this->places  = new \modules\banners\models\admin\Places();
    }

    public function init()
    {
        $this->assignToNav('Банери', 'module/run/banners', 'fa-picture-o', null, 20);
        $this->template->assignScript("modules/banners/js/admin/banners.js");
    }

    public function index()
    {
        $this->template->assign('places', $this->places->get());
        $this->output($this->template->fetch('banners/index'));
    }

    public function place($id, $results = null)
    {
        $t = new DataTables2('banners_' . $id);
        $t  -> th($this->t('common.id'), '', 'width: 20px')
            -> th($this->t('banners.img'))
            -> th($this->t('banners.url'))
            -> th($this->t('banners.lang'))
            -> th($this->t('banners.active'))
            -> th($this->t('common.tbl_func'), '', 'width: 160px')
        ;

        if($results){

            $t  -> from('__banners')
                -> get('id, img, url, languages_id,  published, permanent, df, dt');
            $t  -> execute();
//            $lang = $this->banners->getLanguages();
            $res = array(); $appurl = APPURL;
            foreach ($t->getResults(false) as $i=>$row) {

                $row['img'] = empty($row['img']) ? "/themes/engine/assets/img/no-image.png" : $row['img'];
                $res[$i][] = $row['id'];
                $res[$i][] = "<img src='{$row['img']}' align='banner' style='max-height: 60px; max-width: 120px;'>";
                $res[$i][] = "<a href='{$appurl}{$row['url']}' target='_blank'>{$row['url']}</a>";
                $res[$i][] = $row['languages_id'];
                if($row['permanent'] == 1){
                    $res[$i][] = $this->t('banners.permanent_y');
                } else{
                    $res[$i][] = $this->t('banners.permanent_n');
                }

                $res[$i][] =
                    (string)Button::create
                    (
                        Icon::create(Icon::TYPE_EDIT),
                        ['class' => 'b-banners-edit btn-primary', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
                    ) .
                    (string)Button::create
                    (
                        Icon::create(Icon::TYPE_DELETE),
                        ['class' => 'b-banners-delete btn-danger', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                    )
                ;
            }

            echo $t->render($res, $t->getTotal());die;
        }

        $this->output($t->init());
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

    public function places()
    {
        include "Places.php";

        $params = func_get_args();
        $action = array_shift($params);

        $controller  = new Places();

        return call_user_func_array(array($controller, $action), $params);
    }
}