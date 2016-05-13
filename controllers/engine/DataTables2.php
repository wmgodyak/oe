<?php
/**
 * Company Otakoyi.com
 * Author: wg
 * Date: 02.05.15 16:05
 */

namespace controllers\engine;

use controllers\core\exceptions\Exception;
use models\core\DB;

defined("CPATH") or die();

class DataTables2
{
    /**
     * Table ID
     * @var string
     */
    private $id;

    /**
     * table heading columns
     * @var array
     */
    private $th = [];

    /**
     * @var array
     */
    private $config = [];

//    /**
//     * row of table body
//     * @var array
//     */
//    private $tr = array();
//
    private $db;
//
    private $table;
    private $join     = [];
    private $where    = [];
    private $cols     = [];
    private $limit    = '';

    private $iDisplayLength = 50;

    private $debug    = 0;
    private $total    = 0;
    private $results  = [];

    private $error = null;
//    private $search_cols = [];

    public function __construct($id = null)
    {
        $this->db = DB::getInstance();

        if( $id ){
            $this->id = $id;
        }

        return $this;
    }

    /**
     * @param $label
     * @param $col
     * @param bool $orderable
     * @param bool $searchable
     * @param null $style
     * @return $this
     * @throws Exception
     */
    public function th($label, $col = null, $orderable = true, $searchable = true, $style = null)
    {
        if(is_array($label) && empty($col)){
            $this->th[] = $label;

            $label['orderable'] = isset($label['orderable']) ? $label['orderable'] : true;
            $label['orderable'] = isset($label['orderable']) ? $label['orderable'] : true;

//            if(isset($label['col'])){
                $this->get($label['col'], $label['orderable'], $label['searchable']);
//            }

            return $this;
        }

        $this->th[] = [
          'label'      => $label,
          'col'        => $col,
          'orderable'  => $orderable,
          'searchable' => $searchable,
          'style'      => $style
        ];

//        if(isset($col)) {
            $this->get($col, $orderable, $searchable);
//        }

        return $this;
    }

    /**
     * @param $id
     * @return $this
     */
    public function setID($id)
    {
        $this->id = $id;

        return $this;
    }

    /**
     * @param $table
     * @return $this
     */
    public function from($table)
    {
        $this->table = $table;

        return $this;
    }

    /**
     * @param $q
     * @param string $type
     * @return $this
     */
    public function join($q, $type = "join ")
    {
        $this->join[] = $type .' '. $q;

        return $this;
    }
//
    /**
     * @param $q
     * @return $this
     */
    public function where($q)
    {
        $this->where[] = $q;

        return $this;
    }

    /**
     * @param $start
     * @param $num
     * @return $this
     */
    public function limit($start, $num)
    {
        $this->limit = "limit $start, $num";

        return $this;
    }

    /**
     * @param $col
     * @param bool $orderable
     * @param bool $searchable
     * @return $this
     */
    public function get($col, $orderable = false, $searchable = false)
    {
        $this->cols[] =  [
            'col'        => $col,
            'orderable'  => $orderable,
            'searchable' => $searchable
        ];

        return $this;
    }

    /**
     * @param $key
     * @param null $val
     * @return $this|null
     */
    public function config($key, $val = null)
    {
        if( $val ){
            $this->config = array_merge( $this->config, array( $key => $val ));

            return $this;
        }

        if( ! isset($this->config[$key]) ) return null;

        return $this->config[$key];
    }

     /**
     * @param bool $s
     * @return $this
     */
    public function debug($s = true)
    {
        $this->debug = $s;

        return $this;
    }

    /**
     * @param $url
     * @param array $data
     * @return $this
     */
    public function ajax($url, $data = [])
    {
        $data['token'] = TOKEN;

        $data['cols'] = base64_encode(TOKEN . serialize($this->cols) . TOKEN);
        $data['sign'] = md5(serialize($this->cols));

        $this ->config('processing', true)
              ->config('serverSide', true)
              ->config
              (
                  'ajax',
                  [
                      'url'  => $url,
                      'type' => 'POST',
                      'data' => $data
                  ]
              );

        return $this;
    }

    /**
     * render table body
     * @return string
     */
    private function body()
    {
        $c =0; // count th
        $html = '';

        $html .= "<div class='table'>
                    <table class='display table' style='width: 100%; cellspacing: 0;' id='{$this->id}'>
                    <thead>
                    <tr>\r\n";

        foreach ($this->th as $th) {
            $attr = empty($th['style']) ? '' : "style=\"{$th['style']}\"";
            $html .= "<th {$attr}>{$th['label']}</th>\r\n";
            $c++;
        }

        $html .= "
                    </tr>
                </thead>
                ";

//        if(!empty($this->tr)) {
//            $html .= "<tbody>\r\n". implode('', $this->tr) ."</tbody>";
//        } else {
            $html .= "
                <tbody>
                    <tr>
                        <td colspan=\"{$c}\" class=\"dataTables_empty\">Немає даних</td>
                    </tr>
                </tbody>\r\n";
//        }

        $html .= "</table></div>";

        return $html;
    }

    /**
     * @return string
     */
    private function js()
    {
        // definition to column search and ordering
        $idx = []; $sidx = []; $defs = [];

        foreach ($this->cols as $k=>$col) {
           if(is_null($col['col'])){
               $idx[] = $k;
               $sidx[] = $k;

               continue;
           }

           if($col['orderable'] == false){
               $idx[] = $k;
           }

           if($col['searchable'] == false){
               $sidx[] = $k;
           }
        }

        // disable ordering
        if(!empty($idx)){
            $defs[] = ['orderable' => false, 'targets' => $idx];
        }

        // disable columns search
        if(!empty($sidx)){
            $defs[] = ['bSearchable' => false, 'targets' => $sidx];
        }

        // disable columns search
        if(!empty($defs)){
            $this->config('columnDefs', $defs);
        }

        $this->config
        (
            'fnInitComplete',
            'function(){
                $(\'.dataTables_wrapper\').find(\'input, select\').addClass(\'form-control\');
            }'
        );

        $this->config('iDisplayLength', $this->iDisplayLength);

        $config = json_encode($this->config);
        $config = str_replace('\n', '', $config);
        $config = str_replace('\r', '', $config);
        $config = str_replace('"function', 'function', $config);
        $config = str_replace('}"', '}', $config);
        $config = ltrim($config, '"');
        $config = rtrim($config, '"');
        $config = stripslashes($config);
        return "
        <script>
            $(document).ready(function() {
                $('#{$this->id}').dataTable($config);
            });
        </script>";
    }

    /**
     *
     * @return string
     */
    public function init()
    {
        return $this->body() . $this->js();
    }



    /**
     * @return $this
     */
    public function execute()
    {
        /**
         * limit
         */
        if(isset($_POST['start']) && isset($_POST['length'])){
            $start = (int)$_POST['start'];
            $num   = (int)$_POST['length'];
            $this->limit($start, $num);
        }

        if(empty($this->cols) && isset($_POST['cols'])){

            /*
             $data['cols'] = base64_encode(TOKEN . serialize($this->cols) . TOKEN);
             $data['sign'] = md5(serialize($this->cols));
            */

            $cols = base64_decode($_POST['cols']);

            $a = explode(TOKEN, $cols);
            if(!isset($a[1])) die('wrong sign');

            $cols = $a[1];

            if(!isset($_POST['sign']) || $_POST['sign'] !== md5($cols)){
                die('Wrong sign');
            }

            $this->cols = unserialize($cols);
        }

        /**
         * Search
         */
        if(isset( $_POST['search']['value']) && strlen($_POST['search']['value']) > 2){

            $q = trim($_POST['search']['value']);

            if(!empty($q) && strlen($q) > 2){
                $w = array();
                foreach ($this->cols as $col) {
                    if(!$col['searchable']) continue;

                    $a = explode(' as ', $col['col']);
                    if(isset($a[1])){

                        $col['col'] = $a[0];
                    }

                    $w[] = " {$col['col']} like '{$q}%'";
                }

                if(!empty($w)){
                    $this->where[] = " (". implode(' or ', $w) .")";
                }
            }
        }

        $order_by = "ORDER BY"; $ob = [];
        /**
         * Sorting
         */
        if(isset($_POST['order'])){
//            echo '<pre>'; print_r($_POST);die;
            foreach ($_POST['order'] as $k=>$col) {

                $_col = $this->cols[$col['column']]['col'];

                $a = explode(' as ', $_col);
                if(isset($a[1])){
                    $_col = $a[1];
                }

                $ob[] = " {$_col} {$col['dir']}";
            }

            $order_by .= implode(', ', $ob);
        }

        $a = [];
        foreach ($this->cols as $col) {
            if(is_null($col['col'])) continue;
            $a[] = $col['col'];
        }

        $cols = implode(',', $a);

        $w = empty($this->where) ? '' : "WHERE " . implode(' and ', $this->where);
        $j = implode(' ', $this->join);


        $t = "SELECT COUNT(*) AS t FROM {$this->table} {$j} {$w}";
        $q = "SELECT {$cols} FROM {$this->table} {$j} {$w} {$order_by} {$this->limit}";

        if($this->debug){
            echo $t,"\r\n";
            echo $q;
        }

        $this->total   = $this->db->select($t, $this->debug)->row('t');

        if($this->db->hasError()){
            $this->error = 'Error: #' . $this->db->getErrorCode() .'. '. $this->db->getErrorMessage();
            return false;
        }

        $this->results = $this->db->select($q, $this->debug)->all();

        if($this->db->hasError()){
            $this->error = 'Error: #' . $this->db->getErrorCode() .'. '. $this->db->getErrorMessage();
            return false;
        }

        return true;
    }

    public function getError()
    {
        return $this->error;
    }

    /**
     * @param bool $format
     * @return array
     */
    public function getResults($format = true)
    {
        if(! $format) {
            return $this->results;
        }

        $res = array();
        foreach ($this->results as $item) {
            $a = array();

            foreach ($this->cols as $col) {
                $c = explode(' as ', $col['col']);
                if(isset($c[1])){
                    $col['col'] = $c[0];
                }

                $a[] = isset($item[$col['col']]) ? $item[$col['col']] : $col['col'];
            }

            $res[] = $a;
        }

        return $res;
    }

    /**
     * @param array $data
     * @param int $recordsTotal
     * @param bool $encode
     * @return array|string
     */
    public function render(array $data, $recordsTotal=0, $encode = true)
    {
        $_data = array(); $draw= isset($_POST['draw']) ? (int)$_POST['draw'] : 1;  $recordsFiltered = $recordsTotal;
        if($recordsTotal == 0){
            $recordsTotal = $draw;
        }
        foreach ($data as $row) {
            $_data[] = array_values($row);
        }

        $a = array(
            'draw'            => $draw,
            'data'            => $_data,
            'recordsTotal'    => (int) $recordsTotal,
            'recordsFiltered' => (int) $recordsFiltered
        );

        return $encode ? json_encode($a) : $a;
    }

    /**
     * @param $var
     * @param bool|false $use_var_dump
     */
    final private function dump($var)
    {
        echo '<pre>'; print_r($var); echo '</pre>';
    }

    /**
     * @return int
     */
    public function getTotal()
    {
        return $this->total;
    }
}