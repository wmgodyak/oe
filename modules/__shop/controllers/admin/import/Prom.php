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
use system\Backend;
use system\models\Model;

defined("CPATH") or die();

/**
 * Class Prom
 * @name Prom.ua
 * @package modules\shop\controllers\admin\import
 */
class Prom extends Backend
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

        if(! $this->load()){
            echo 'Виникла помилка при завантаженні файлу';
            die;
        }
//
        if(! $this->isValid()){
            echo  'Файл невідповідний до стандарту';
            die;
        }

        $currency     = $this->xml_attribute($this->data->currency, 'code');
        $this->import = new Import(1, $this->admin, $this->data->name, $currency);

        if(! $this->import->checkCurrency()){
            echo implode('<br>', $this->import->log);
            die;
        }
    }

    public function index(){

        $this->response(['s' => $this->parseCategories(), 'log' => $this->import->log]);
    }

    public function getTotalProducts()
    {
        echo count($this->data->items->item);
    }

    /**
     * @param $start
     * @return bool
     */
    public function parseProducts($start)
    {
        $i=0;
        foreach ($this->data->items->item as $product) {
            if($i == $start){
                $in_stock = $this->xml_attribute($product, 'available') ? 1 : 0;
                $ex_id    =  $this->xml_attribute($product, 'id');
                $name = $product->name;
                $category_ex_id = $product->categoryId;
                $price          = $product->price;
                $url = $product->url;
                $image = $product->image;
                $vendor = $product->vendor;
                $description = $product->description;
                $warranty = $product->warranty;

                $this->import->product
                (
                    $ex_id,
                    $name,
                    $url,
                    $category_ex_id,
                    $price,
                    $in_stock,
                    $image,
                    $description,
                    $vendor,
                    $warranty
                );
            }
            $i++;
        }

        $this->response(['s' => 1, 'log' => $this->import->log]);
    }

    private function parseCategories()
    {
        foreach ($this->data->catalog->category as $cat) {
            $ex_id     =  $this->xml_attribute($cat, 'id');
            $parent_id = $this->xml_attribute($cat, 'parentId');
            $name      = (string) $cat;
            $s = $this->import->category($ex_id, $name, $parent_id);

            if(! $s) return false;
        }

        return true;
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
