<?php

namespace modules\shop\controllers\admin\import;

use modules\shop\models\admin\Import;
use system\core\DB;
use system\Engine;

/**
 * Class Csv
 * @name Custom CSV File
 * @package modules\shop\controllers\admin\import
 */
class Csv extends Engine
{
    private $data;
    private $file;
    private $path;
    private $db;

    private $import;

    public function __construct()
    {
        parent::__construct();

        $this->db = DB::getInstance();

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

        $this->import = new Import(1, $this->admin, 'cma.lviv.ua', 'USD');

//        if(! $this->import->checkCurrency()){
//            echo implode('<br>', $this->import->log);
//            die;
//        }
    }

    public function index(){
        switch($this->request->post('type')){
            case 'categories':
                $s = $this->parseCategories();
                break;
            case 'products':
                $s = $this->parseProducts(0);
                break;
            default:
                $s=0;
                break;
        }
        $this->response(['s' => $s, 'log' => $this->import->log]);
    }

    public function getTotalProducts()
    {
//        echo count($this->data->items->item);
    }

    /**
     * @param $start
     * @return bool
     */
    public function parseProducts($start)
    {
        $i=0;
        foreach ($this->data as $product) {
            d($product);
            if($i> 5) break;

            /*if($i == $start){
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
            }*/
            $i++;
        }

        $this->response(['s' => 1, 'log' => $this->import->log]);
    }

    private function parseCategories()
    {
        foreach ($this->data as $cat) {

            $ex_parent_id =  $cat[0];
            $external_id  =  $cat[1];
            $name         = trim($cat[2]);

            $s = $this->import->category($external_id, $name, $ex_parent_id);

            if(! $s) return false;
        }

        // set isfolder for parents
        $this->import->setIsFolder();
    }


    private function load()
    {
        if(! file_exists($this->path . $this->file)){
            $this->response(['m' => 'File not exist']);
            return false;
        }

        $file_handle = fopen($this->path . $this->file, 'r');
        while (!feof($file_handle) ) {
            $a = fgetcsv($file_handle, 1024, ';');
            if(!is_array($a)) continue;

            foreach ($a as $k=>$v) {
                $a[$k] = iconv('cp1251', 'utf-8', $v);
            }
            $this->data[] = $a;
        }

        fclose($file_handle);

        return true;
    }

    private function isValid()
    {
        return true;
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