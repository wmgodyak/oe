<?php

namespace modules\images\controllers\admin;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use system\core\DataTables2;
use system\Backend;

defined("CPATH") or die();

/**
 * Class ImagesSizes
 * @package modules\images\controllers\admin
 */
class ImagesSizes extends Backend
{
    private $imagesSizes;

    public function __construct()
    {
        parent::__construct();
        $this->imagesSizes = new \modules\images\models\ImagesSizes;
    }

    public function init() { }

    public function index()
    {
        $this->appendToPanel
        (
            (string)Button::create
            (
                t('common.button_create'),
                [
                    'class' => 'btn-md b-imagesSizes-create'
                ]
            )
        );

        $t = new DataTables2('imagesSizesList');

        $t  -> th(t('common.id'), 'id', null, null, 'width: 20px')
            -> th(t('images.imagesSizes.size'), 'size', 1, 1)
            -> th(t('images.imagesSizes.width'), 'width', 1, 1)
            -> th(t('images.imagesSizes.height'), 'height', 1, 1)
            -> th(t('common.tbl_func'), null, null, null, 'width: 180px')
            -> ajax('module/run/images/imagesSizes/items');

        $this->output
        (
            '<div id="resizeBox" class="row" style="display: none"><div id="progress" class=\'progress progress-thin progress-striped active\'><div style=\'width: 0;\' class=\'progress-bar progress-bar-success\'></div></div></div>'.
            $t->init()
        );
    }

    public function items()
    {
        $t = new DataTables2();
        $t  -> from('__content_images_sizes')
            -> execute();

        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {
            $res[$i][] = $row['id'];
            $res[$i][] = $row['size'];
            $res[$i][] = $row['width'];
            $res[$i][] = $row['height'];
            $res[$i][] =
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_CROP),
                    ['class' => 'b-imagesSizes-crop', 'data-id' => $row['id'], 'title' => t('common.title_edit')]
                ) .
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    ['class' => 'b-imagesSizes-edit btn-primary', 'data-id' => $row['id'], 'title' => t('common.title_edit')]
                ) .
                (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'b-imagesSizes-delete btn-danger', 'data-id' => $row['id'], 'title' => t('common.title_delete')]
                );
        }

        return $t->render($res, $t->getTotal());
    }

    /**
     * Images module image size create form
     * @return string
     */
    public function create()
    {
        $this->template->assign('types',$this->imagesSizes->getContentTypes(0));
        $this->template->assign('data', ['types' => []]);
        $this->template->assign('action', 'create');
        return $this->template->fetch('modules/images/sizes/edit');
    }

    /**
     * Images module image size edit form
     * @return string
     */
    public function edit($id)
    {
        $this->template->assign('types',$this->imagesSizes->getContentTypes(0));
        $this->template->assign('data', $this->imagesSizes->getData($id));
        $this->template->assign('action', 'edit');
        return $this->template->fetch('modules/images/sizes/edit');
    }

    /**
     * Images module save image size
     * @param null $id
     * @return array
     */
    public function process($id= null)
    {
        if (!$this->request->isPost()) die;

        $data = $this->request->post('data');
        $s=0; $i=[];

        $validator = $this->validator->run($data, [
            'size' => 'required',
            'width' => 'required',
            'height' => 'required'
        ]);

        if (!$validator){
            $i = $this->validator->getErrors();
        } else {
            switch ($this->request->post('action')) {
                case 'create':
                    $s = $this->imagesSizes->create();
                    break;
                case 'edit':
                    if ( $id > 0 ) {
                        $s = $this->imagesSizes->update($id);
                    }
                    break;
            }
            if (!$s) {
                echo $this->imagesSizes->getErrorMessage();
            }
        }

        return ['s' => $s, 'i' => $i];
    }

    /**
     * Images module delete image size
     * @param $id
     * @return int
     */
    public function delete($id)
    {
        return $this->imagesSizes->delete($id);
    }

    /**
     * Images module get total images for resize
     * @return array|mixed
     */
    public function resizeGetTotal()
    {
        $size_id = $this->request->post('sizes_id', 'i');
        if (empty($size_id)) die(0);

        $t = $this->imagesSizes->resizeGetTotal($size_id);
        echo $this->imagesSizes->getErrorMessage();
        return $t;
    }

    /**
     * Images module resize image
     * @return mixed
     */
    public function resizeItems()
    {
        $num = 1;
        $size_id = $this->request->post('sizes_id', 'i');
        $start   = $this->request->post('start', 'i');
        if ($start > 0) {
            $start = $start * $num;
        }

        $s = $this->imagesSizes->resizeItems($size_id, $start, $num);

        return $s;
    }
}