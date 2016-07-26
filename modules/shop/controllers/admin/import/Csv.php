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
        echo count($this->data);
    }

    /**
     * @param $start
     * @return bool
     */
    public function parseProducts($start = 0)
    {
        $i=0; $s = 1;
        foreach ($this->data as $product) {

            if($i > 13325 ){ // && $i == $start

                $currency = [
                    'USD' => 1,
                    'UAH' => 2
                ];

                $data = []; $info = []; $prices = [];

                $category_ex_id = $product[0];
                $ex_id          = $product[1];

                $data['sku']         = $product[2];
                $data['currency_id'] = $product[5] == 'ДОЛАР' ? $currency['USD'] : 'UAH';
                $data['quantity'] = $product[6];
                $data['in_stock'] = $product[6] > 0 ? 1 : 0;

                $info['name']   = $product[3];
                $info['title']  = $product[4];

                $prices[5] = $product[7] * 1;
                $prices[6] = $product[8] * 1;
                $prices[7] = $product[9] * 1;
                $prices[8] = $product[10] * 1;

                $s = $this->import->product2
                (
                    $ex_id,
                    $category_ex_id,
                    $data,
                    $info,
                    $prices
                );

                $s = $s ? 1 : 0;
            }
            $i++;
        }

        $this->response(['s' => $s, 'log' => $this->import->log]);
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
                $a[$k] = trim(iconv('cp1251', 'utf-8', $v));
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