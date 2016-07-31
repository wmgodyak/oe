<?php

namespace modules\shop\controllers\admin;

use system\Engine;
use system\models\ContentMeta;

/**
 * Class Video
 * @package modules\shop\controllers\admin
 */
class Video extends Engine
{
    private $contentMeta;

    public function __construct()
    {
        parent::__construct();

        $this->contentMeta = new ContentMeta();
    }

    public function index()
    {
        return $this->template->fetch('shop/products/video');
    }

    public function create()
    {
    }

    public function edit($id)
    {
    }

    public function delete($id){}

    public function process($id = null)
    {

    }

}