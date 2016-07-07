<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 07.07.16 : 14:24
 */

namespace modules\shop\controllers\admin\import;

use modules\shop\models\admin\Import;
use system\core\Response;
use system\Engine;
use system\models\Model;

defined("CPATH") or die();

/**
 * Class Prom
 * @name Prom.ua
 * @package modules\shop\controllers\admin\import
 */
class Prom extends Engine
{
    private $data;
    private $file;
    private $path;

    private $import;

    public function __construct()
    {
        parent::__construct();

        $this->file = $this->request->post('file');
        $this->path = DOCROOT . 'tmp/';

        $this->import = new Import(1, $this->admin);
    }

    public function index(){

        if(! $this->load()){
            return;
        }
//
        if(! $this->isValid()){
            return;
        }

        $this->parseCategories();

        echo 'OK';
    }

    private function parseCategories()
    {
        foreach ($this->data->catalog->category as $cat) {
            $ex_id     =  $this->xml_attribute($cat, 'id');
            $parent_id = $this->xml_attribute($cat, 'parentId');
            $name      = (string) $cat;
            $this->import->category($ex_id, $name, $parent_id);
        }

    }

    function xml_attribute($object, $attribute)
    {
        if(isset($object[$attribute]))
            return (string) $object[$attribute];
    }

    private function load()
    {
        if(! file_exists($this->path . $this->file)){
            $this->response(['m' => 'File not exist']);
            return false;
        }

        $this->data = simplexml_load_file($this->path . $this->file);

        return true;
    }

    private function isValid()
    {
        return isset($this->data->catalog->category) && isset($this->data->items);
    }

    private function response($res)
    {
        header('Content-Type: application/json');
        echo json_encode($res);
    }

    public function delete($id)
    {
        // TODO: Implement delete() method.
    }
    public function create()
    {
        // TODO: Implement create() method.
    }
    public function edit($id)
    {
        // TODO: Implement edit() method.
    }
    public function process($id)
    {
        // TODO: Implement process() method.
    }
}
