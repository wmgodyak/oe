<?php

namespace modules\exchange1c\models;

use modules\order\models\Order;
use modules\order\models\Status;
use system\core\Logger;
use system\models\Model;
use system\models\Settings;
use system\models\Users;

/**
 * Class Sale
 * @package modules\exchange1c\models
 */
class Sale extends Model
{
    private $tmp_dir;
    private $config;
    private $login;
    private $password;

    private $ordersStatus;
    private $users;

    /**
     * csv array data
     * @var array
     */
    private $data = [];

    public function __construct($login, $password, $config)
    {
        parent::__construct();

        $this->tmp_dir = DOCROOT . 'tmp/1c_exchange/sale/';

        if(!is_dir($this->tmp_dir)){
            mkdir($this->tmp_dir, 0777, true);
        }

        $this->config   = $config;
        $this->login    = $login;
        $this->password = $password;

        $this->ordersStatus = new Status();
        $this->users = new Users();
    }

    public function orders()
    {
        if( ! $this->auth()) return ['failure', "Wrong token"];

        $mo = new Order();

        $orders = self::$db
            ->select("
                select DISTINCT o.id, o.oid, os.external_id as status,
                 o.users_id as user_id,
                 cu.code, o.currency_rate, 0 as amount,
                 o.comment, o.created, o.paid, o.paid_date, o.payment_id, o.delivery_id, o.delivery_cost, o.delivery_address
                from __orders o
                join __orders_status os on os.id=o.status_id
                join __currency cu on cu.id=o.currency_id
                where (isnull(o.ex_date) or o.ex_date < o.edited) and o.status_id >= 6
                order by o.id desc
            ")
            ->all();

        foreach ($orders as $k=>$order) {
            $orders[$k]['amount'] = $mo->amount($order['id']);
        }

        header("Content-type: text/csv; charset=windows-1251");
        header("Content-Disposition: attachment; filename=orders.csv");
        header("Pragma: no-cache");
        header("Expires: 0");

        if(!empty($orders)){

            echo "oid;status;user_id;currency;currency_rate;amount;comment;created;paid;paid_date;payment_id;delivery_id;delivery_cost;delivery_address\n";

            $in = [];
            foreach ($orders as $fields) {
                $in[] = $fields['id'];
                unset($fields['id']);
                echo implode(';', $fields), "\n";
            }

            $in = implode(',', $in);
            file_put_contents($this->tmp_dir . 'oid.txt', $in);

            Logger::info("Export orders: {$in}");

        }
        die;
    }

    public function customers()
    {
        if( ! $this->auth()) return ['failure', "Wrong token"];

        $products = self::$db
            -> select("
                select u.id, u.group_id, u.name, u.surname, u.phone, u.email, u.barcode, u.created
                from __orders o
                join __users u on u.id=o.users_id
                where (isnull(o.ex_date) or o.ex_date < o.edited) and o.status_id >= 6
                order by u.id desc
            ")
            -> all();

        header("Content-type: text/csv; charset=windows-1251");
        header("Content-Disposition: attachment; filename=orders_customers.csv");
        header("Pragma: no-cache");
        header("Expires: 0");

        echo "id;group_id;name;surname;phone;email;barcode;created\n";

        foreach ($products as $fields) {
            echo implode(';', $fields), "\n";
        }

        die;
    }

    public function products()
    {
        if( ! $this->auth()) return ['failure', "Wrong token"];

        if( ! file_exists($this->tmp_dir . 'oid.txt')) {
            Logger::error("No orders");
            return ['failure', 'EX011. There are no orders'];
        }

        $in = file_get_contents($this->tmp_dir . 'oid.txt');

        if(empty($in)){
            Logger::error("No orders");
            return ['failure', 'EX011. There are no orders'];
        }

        $products = self::$db
            -> select("
                select o.oid, op.products_id, p.sku, pi.name as products_name, op.quantity, op.price
                from
                __orders_products op
                join __orders o on o.id=op.orders_id
                join __content p on p.id=op.products_id
                join __content_info pi on pi.content_id=op.products_id and pi.languages_id='{$this->languages_id}'
                where op.orders_id in ($in)
                order by op.orders_id desc
            ")
            -> all();

        $kits = self::$db
            ->select("
                select ok.id, ok.kits_products_id, ok.kits_products_price, ok.quantity, p.sku, pi.name as products_name, o.oid
                from __orders_kits ok
                join __orders o on o.id=ok.orders_id
                join __content p on p.id=ok.kits_products_id
                join __content_info pi on pi.content_id=p.id and pi.languages_id='{$this->languages_id}'
                where ok.orders_id in ({$in})
            ")
            ->all();

        foreach ($kits as $kit) {
            $products[] = [
                'oid'           => $kit['oid'],
                'products_id'   => $kit['kits_products_id'],
                'sku'           => $kit['sku'],
                'products_name' => $kit['products_name'],
                'quantity'      => $kit['quantity'],
                'price'         => $kit['kits_products_price']
            ];

            // get kits produts
            $kp = self::$db
                ->select("
                    select p.id, p.sku, kp.price, pi.name
                    from __orders_kits_products kp
                    join __content p on p.id=kp.kits_products_products_id
                    join __content_info pi on pi.content_id=p.id and pi.languages_id='{$this->languages_id}'
                    where kp.orders_kits_id = {$kit['id']}
                ")
                ->all();

            foreach ($kp as $p) {
                $products[] = [
                    'oid'           => $kit['oid'],
                    'products_id'   => $p['id'],
                    'sku'           => $kit['sku'],
                    'products_name' => $p['name'],
                    'quantity'      => $kit['quantity'],
                    'price'         => $p['price']
                ];
            }
        }

        header("Content-type: text/csv; charset=windows-1251");
        header("Content-Disposition: attachment; filename=orders_products.csv");
        header("Pragma: no-cache");
        header("Expires: 0");

        echo "orders_id;products_id;sku;products_name;quantity;price\n";

        foreach ($products as $fields) {
            echo implode(';', $fields), "\n";
        }

        die;
    }

    public function success()
    {
        if( ! $this->auth()) return ['failure', "Wrong token"];

        if( ! file_exists($this->tmp_dir . 'oid.txt')) {
            Logger::error("No orders");
            return ['failure', 'EX012. There are no orders'];
        }

        $in = file_get_contents($this->tmp_dir . 'oid.txt');

        self::$db->update('__orders', ['ex_date' => date('Y-m-d H:i:s')], " id in ($in)");

        @unlink($this->tmp_dir . 'oid.txt');

        Logger::info("Export orders: {$in} success");

        return ['success'];
    }

    public function checkauth()
    {
        if (!isset($_SERVER['PHP_AUTH_USER'])) {
            header('WWW-Authenticate: Basic realm="OYi.Engine"');
            return ['failure', "EX000. Authentication Required."];
        }
        if (
            ($this->config['user']['login'] == $this->login)
            && ($this->config['user']['password'] == $this->password)
        ) {

            $key  = session_name();
            $pass = TOKEN;

            Logger::info("Auth success. SN: $key PASS: $pass");

            Settings::getInstance()->set('1c_token', $pass);

            return ['success', $key, $pass];
        }

        Logger::error("Auth fail. L:{$this->login}. P:{$this->password}");
//        Logger::debug(var_export($_SERVER, 1));

        return ['failure', "EX003. Bad login or password."];
    }

    public function init()
    {
//        if( ! $this->auth()) return ['failure', "EX004. Wrong token"];

        return ["zip={$this->config['zip']}", "file_limit={$this->config['file_limit']}"];
    }

    private function auth()
    {
        $pass = Settings::getInstance()->get('1c_token');

        if($pass == TOKEN){
            Logger::debug('Auth OK');

            return true;
        }

        Logger::error('Auth FAIL');

        return false;
    }


    public function file()
    {
        return ['failure', "This action was disabled by administrator"];
        if( ! $this->auth()) return ['failure', "EX004. Wrong token"];

        $file_info = pathinfo($this->request->get('filename', 's'));

        if(empty($file_info['basename'])){
            return ['failure', "EX005. empty filename"];
        }

        $file_extension = $file_info['extension'];
        $basename = $file_info['basename'];

        Logger::debug('Loading filename:' . $basename);

        $file_content = file_get_contents('php://input');

        if(empty($file_content)){
            Logger::error('failure php://input  return empty string');
            return ['failure', 'EX006. php://input  return empty string'];
        }

        if ( $file_extension == 'csv' ) {
            if (! $this->saveFile($this->tmp_dir . $this->request->get('filename', 's'), $file_content, 'w+')) {
                return ['failure', "EX007 . Can't save file"];
            }
        } else if ($file_extension == 'zip' && class_exists('ZipArchive')) {
            $zip = new \ZipArchive();
            $res = $zip->open($this->tmp_dir . $this->request->get('filename', 's'));
            if ($res > 0 && $res != TRUE) {
                switch ($res) {
                    case \ZipArchive::ER_NOZIP :
                        Logger::error('Not a zip archive.');
                        break;
                    case \ZipArchive::ER_INCONS :
                        Logger::error('Zip archive inconsistent.');
                        break;
                    case \ZipArchive::ER_CRC :
                        Logger::error('checksum failed');
                        break;
                    case \ZipArchive::ER_EXISTS :
                        Logger::error('File already exists.');
                        break;
                    case \ZipArchive::ER_INVAL :
                        Logger::error('Invalid argument.');
                        break;
                    case \ZipArchive::ER_MEMORY :
                        Logger::error('Malloc failure.');
                        break;
                    case \ZipArchive::ER_NOENT :
                        Logger::error('No such file.');
                        break;
                    case \ZipArchive::ER_OPEN :
                        Logger::error("Can't open file.");
                        break;
                    case \ZipArchive::ER_READ :
                        Logger::error("Read error.");
                        break;
                    case \ZipArchive::ER_SEEK :
                        Logger::error("Seek error.");
                        break;
                }
                return ['failure', "EX008. Can't save zip archive"];
            }

            $zip->extractTo($this->tmp_dir);
            $zip->close();
        }

        return ['success'];
    }


    /**
     * @param $path
     * @param $data
     * @param string $mode
     * @return bool
     */
    private function saveFile($path, $data, $mode = 'w+b')
    {
        if ( ! $fp = @fopen($path, $mode))
        {
            return FALSE;
        }

        flock($fp, LOCK_EX);
        fwrite($fp, $data);
        flock($fp, LOCK_UN);
        fclose($fp);

        return TRUE;
    }

    public function import()
    {
        return ['failure', "This action was disabled by administrator"];
        if( ! $this->auth()) return ['failure', "EX004. Wrong token"];

        $filename = $this->request->get('filename', 's');

        if(empty($filename) || !file_exists($this->tmp_dir . $filename)){
            Logger::error("Can't find file {$filename}");
            return ['failure', "EX005. Can't find file {$filename}"];
        }

//        $csv = array_map('str_getcsv', file($this->tmp_dir . $filename));
        $file_handle = fopen($this->tmp_dir . $filename, 'r');

        while (!feof($file_handle) ) {
            $a = fgetcsv($file_handle, 1024, ';');
            if(!is_array($a)) continue;

            foreach ($a as $k=>$v) {
                $a[$k] = trim(iconv('cp1251', 'utf-8', $v));
            }
            $csv[] = $a;
        }

        fclose($file_handle);


        array_walk($csv, function(&$a) use ($csv) {
            $a = array_combine($csv[0], $a);
        });
        array_shift($csv); # remove column header

        $this->data = $csv;

        $fname = pathinfo($filename, PATHINFO_FILENAME);

        switch($fname){
            case 'orders':
                return $this->importOrders();
                break;

            case 'orders_products':
                return $this->importProducts();
                break;
        }

        return ['failure', "EX005. Wrong filename"];
    }

    private function importOrders()
    {
        $currency = [
            'USD' => 1,
            'UAH' => 2
        ];

        $users_group_id = Settings::getInstance()->get('modules.Exchange1c.config.users_group_id');
        $languages_id   =  Settings::getInstance()->get('modules.Exchange1c.config.languages_id');

       foreach ($this->data as $i=>$order) {

            $status_id = $this->ordersStatus->getIdByExternalId($order['status']);

            if(empty($status_id)){
                return ['failure', "EX013. Wrong status"];
            }

            $users_id = $order['user_id'];

            if(empty($users_id)){
                // create user
                $users_id = $this->users->create
                (
                    [
                        'group_id'     => $users_group_id,
                        'languages_id' => $languages_id,
                        'name'         => $order['user_name'],
                        'surname'      => $order['user_surname'],
                        'phone'        => $order['user_phone'],
                        'email'        => $order['user_email']
                    ]
                );
            } else {
                $s = $this->users->getData($order['user_id'], 'id');

                if(empty($s)){
                    return ['failure', "EX014. Wrong users_id"];
                }
            }

            $data = [
                'oid'            => $order['oid'],
                'external_id'    => $order['external_id'],
                'languages_id'   => $languages_id,
                'status_id'      => $status_id,
                'one_click'      => $order['one_click'],
                'users_id'       => $users_id,
                'users_group_id' => $users_group_id,
                'currency_id'    => $currency[$order['currency']],
                'currency_rate'  => $order['currency_rate'],
                'comment'        => $order['comment'],
                'created'        => $order['created'],
                'paid'           => $order['paid'],
                'paid_date'      => $order['paid_date'],
                'payment_id'     => $order['payment_id'],
                'delivery_id'     => $order['delivery_id'],
                'delivery_cost'   => $order['delivery_cost'],
                'delivery_address'=> $order['delivery_address'],
            ];

            if(empty($order['id'])){
                $this->createRow('__orders', $data);

                if($this->hasError()){
                    return ['failure', 'EX015. ' . $this->getErrorMessage()];
                }
            } else {
                $id = self::$db->select("select id from __orders where id='{$order['id']}' limit 1")->row('id');

                if(empty($id)){
                    return ['failure', "EX016. Wrong id"];
                }

                $this->updateRow
                (
                    '__orders',
                    $id,
                    [
                        'edited'          => date('Y-m-d H:i:s'),
                        'external_id'     => $order['external_id'],
                        'paid'            => $order['paid'],
                        'paid_date'       => $order['paid_date'],
                        'payment_id'      => $order['payment_id'],
                        'delivery_id'     => $order['delivery_id'],
                        'delivery_cost'   => $order['delivery_cost'],
                        'delivery_address'=> $order['delivery_address']
                    ]
                );

                if($this->hasError()){
                    return ['failure',  'EX015. ' . $this->getErrorMessage()];
                }
            }
       }

        return ['success'];
    }

    private function importProducts()
    {
        foreach ($this->data as $product) {

            unset($product['products_name'], $product['sku']);

            if(empty($product['orders_id'])){
                // get orders_id by ex_id
                if(empty($product['external_id'])){
                    return ['failure', 'EX017. Can not save record. Empty orders_id and empty external_id'];
                }

                $product['orders_id'] = $this->getOrdersIdByExternalId($product['external_id']);
                if(empty($product['orders_id'])){
                    return ['failure', 'EX018. Can not save record. Wrong External id Empty orders_id and empty external_id'];
                }

                $this->createRow('__orders_products', $product);
                if($this->hasError()){
                    return ['failure', 'EX019. '. $this->getErrorMessage()];
                }
            }

            self::$db
                ->update
                (
                    '__orders_products',
                    $product,
                    "orders_id = '{$product['orders_id']}' and products_id = '{$product['products_id']}' limit 1"
                );

            if($this->hasError()){
                return ['failure', 'EX020. ' . $this->getErrorMessage()];
            }
        }

        return ['success'];
    }

    private function getOrdersIdByExternalId($ex_id)
    {
        return self::$db->select("select id from __orders where external_id = '{$ex_id}' limit 1")->row('id');
    }
}