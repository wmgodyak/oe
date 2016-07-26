<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 29.06.16 : 15:23
 */

namespace modules\shop\controllers\admin;

use helpers\PHPDocReader;
use system\Engine;
defined("CPATH") or die();

class Import extends Engine
{
    const ADAPTERS_PATH = 'modules\shop\controllers\admin\import\\';
    const UPLOADS_DIR = 'tmp/';
    private $fname;

    public function __construct()
    {
        parent::__construct();
    }

    public function index($content = null)
    {
        $this->addBreadCrumb('Імпорт');
        $this->template->assign('adapters', $this->getAdapters());
        return $this->output($this->template->fetch('shop/import/index'));
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
        $status = 0; $a = null;
        $adapter = $this->request->post('adapter');

        $res = ['status' => $status, 'adapter' => $adapter, 'type' => $this->request->post('type') ];

        $res['status'] = $this->upload();
        $res['file']   = $this->fname;

        $this->response->body($res)->asJSON();
    }

    public function adapter()
    {
        $params = func_get_args();

        if(empty($params)) {
            die('wrong params');
        }

        $module = array_shift($params);
        $ns     = self::ADAPTERS_PATH;
        $action = 'index';

        if(!empty($params)){
            $action = array_shift($params);
        }

        $c = $ns . ucfirst($module);
        $controller = new $c;

        if(!is_callable(array($controller, $action))){
            die('isn\'t callable ');
        }

        call_user_func_array(array($controller, $action), $params);
    }

    private function upload()
    {
        if($_FILES['file']['error'] == UPLOAD_ERR_OK){
            $path = $_FILES['file']['name'];
            $ext = pathinfo($path, PATHINFO_EXTENSION);
            $tmp_name = $_FILES["file"]["tmp_name"];
            $name = 'import.' . time() . '.' . $ext;
            $this->fname = $name;
            return move_uploaded_file($tmp_name, DOCROOT . self::UPLOADS_DIR . "$name");
        }

        return false;
    }

    private function getAdapters()
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
}