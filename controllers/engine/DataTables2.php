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
     * @param null $format
     * @param null $style
     * @return $this
     * @throws Exception
     */
    public function th($label, $col, $orderable = true, $searchable = true, $format = null, $style = null)
    {
        if(is_array($label) && empty($col)){
            $this->th[] = $label;

            if(!isset($label['col']))
                throw new Exception("Fields label and col required");

            $label['orderable'] = isset($label['orderable']) ? $label['orderable'] : true;
            $label['orderable'] = isset($label['orderable']) ? $label['orderable'] : true;

            $this->get($label['col'], $label['orderable'], $label['searchable']);

            return $this;
        }

        $this->th[] = [
          'label'      => $label,
          'col'        => $col,
          'orderable'  => $orderable,
          'searchable' => $searchable,
          'format'     => $format,
          'style'      => $style
        ];

        $this->get($col, $orderable, $searchable);

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
    public function get($col, $orderable = true, $searchable = true)
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


//
//    /**
//     * @param array $data
//     * @param int $recordsTotal
//     * @param bool $encode
//     * @return string
//     */
//    public function renderJSON(array $data, $recordsTotal=0, $encode = true)
//    {
//        $_data = array(); $draw= isset($_POST['draw']) ? (int)$_POST['draw'] : 1;  $recordsFiltered = $recordsTotal;
//        if($recordsTotal == 0){
//            $recordsTotal = $draw;
//        }
//        foreach ($data as $row) {
//            $_data[] = array_values($row);
//        }
//
//        $a = array(
//            'draw'            => $draw,
//            'data'            => $_data,
//            'recordsTotal'    => (int) $recordsTotal,
//            'recordsFiltered' => (int) $recordsFiltered
//        );
//
//        return $encode ? json_encode($a) : $a;
//    }
//
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

//        if( !empty($this->search_cols) && isset( $_POST['search']['value']) && strlen($_POST['search']['value']) > 2){
//            $q = trim($_POST['search']['value']);
//            if(!empty($q) && strlen($q) > 1){
//                $w = array();
//                foreach ($this->search_cols as $k => $row) {
//                    $w[] = " {$row} like '%{$q}%'";
//                }
//
//                $this->where("(". implode(' or ', $w) .")");
//            }
////            var_dump($_POST['search']['value']); die();
//        }



        /**
         * Search
         */
        if(isset( $_POST['search']['value']) && strlen($_POST['search']['value']) > 2){

//            echo '<pre>'; print_r($_POST);die;

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

//            echo '<pre>'; print_r($_POST);die;
        }

        $order_by = "ORDER BY"; $ob = [];
        /**
         * Sorting
         */
        if(isset($_POST['order'])){

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
     * @param array $data
     * @return string
     */
    public function render(array $data = array())
    {
        if(empty($data)){
            $data = $this->results;
        }

        $_data = [];
        $draw= isset($_POST['draw']) ? (int)$_POST['draw'] : 1;
        $recordsFiltered = $this->total;

//        if($this->total == 0){
//            $this->total = $draw;
//        }
//
        foreach ($data as $row) {
            $_data[] = array_values($row);
        }

        header('Content-Type: application/json');

        echo  json_encode([
            'draw'            => $draw,
            'data'            => $_data,
            'recordsTotal'    => (int) $this->total,
            'recordsFiltered' => (int) $recordsFiltered
        ]);

        die;
    }

//    /**
//     * @return int
//     */
//    public function getTotal()
//    {
//        return $this->total;
//    }
//
//    /**
//     * @param bool $format
//     * @return array
//     */
//    public function getResults($format = true)
//    {
//        if(! $format) {
//            return $this->results;
//        }
//        $rows = explode(',', $this->rows);
//        foreach ($rows as $i=>$col) {
//            if(strpos($col, '.') !== false){
//                $a = explode('.', $col);
//                $rows[$i] = $a[1];
//            }elseif(strpos($col, 'as') !== false){
//                $a = explode('as', $col);
//                $rows[$i] = trim($a[1]);
//            }
//        }
//
//        $res = array();
//        foreach ($this->results as $item) {
//            $a = array();
//
//            foreach ($rows as $row) {
//                $a[] = isset($item[$row]) ? $item[$row] : $row . ' issues';
//            }
//
//            $res[] = $a;
//        }
//
//        return $res;
//    }
//

//
//    /**
//     * @param array $cols
//     * @return $this
//     */
//    public function search(array $cols)
//    {
//        $this->search_cols = array_merge($this->search_cols, $cols);
//
//        return $this;
//    }



//    /**
//     * @param $rows
//     * @return $this
//     */
//    public function searchCol($rows)
//    {
//
//        if(is_array($rows)){
//            $this->search_cols = $rows;
//        } else {
//            $this->search_cols = explode(',', $rows);
//        }
//
//        return $this;
//    }
//
//    /**
//     * @return $this
//     */
//    public function execute()
//    {
//        /**
//         * limit
//         */
//        if(isset($_POST['start']) && isset($_POST['length'])){
//            $start = (int)$_POST['start'];
//            $num   = (int)$_POST['length'];
//            $this->limit($start, $num);
//        }
//
//        /**
//         * sorting
//         */
//        if(isset($_POST['order'][0]['column'])){
//            $col  = (int)$_POST['order'][0]['column'];
//            $rows = explode(',', $this->rows);
//            $dir = isset($_POST['order'][0]['dir']) && $_POST['order'][0]['dir'] == 'asc' ? 'ASC' : 'DESC';
//            if(isset($rows[$col])){
//                if(strpos($rows[$col], ' as ')){
//                    $a = explode(' as ', $rows[$col]);
//                    $rows[$col] = $a[1];
//                }
//                $this->order_by = " ORDER BY {$rows[$col]} {$dir}";
//            }
//        }
//
//        if( !empty($this->search_cols) && isset( $_POST['search']['value']) && strlen($_POST['search']['value']) > 2){
//            $q = trim($_POST['search']['value']);
//            if(!empty($q) && strlen($q) > 1){
//                $w = array();
//                foreach ($this->search_cols as $k => $row) {
//                    $w[] = " {$row} like '%{$q}%'";
//                }
//
//                $this->where("(". implode(' or ', $w) .")");
//            }
////            var_dump($_POST['search']['value']); die();
//        }
//
//
//        $w = empty($this->where) ? '' : 'WHERE ' . implode(' and ', $this->where);
//        $j = implode(' ', $this->join);
//
//        $t = "SELECT COUNT(*) AS t FROM {$this->table} {$j} {$w}";
//        $q = "SELECT {$this->rows} FROM {$this->table} {$j} {$w} {$this->order_by} {$this->limit}";
////        echo $t,"\r\n";
////        echo $q;
//        $this->total   = $this->db->select($t, $this->debug)->row('t');
//        $this->results = $this->db->select($q, $this->debug)->all();
//        if($this->db->hasError()){
//            die($this->db->getErrorMessage());
//        }
//        return $this;
//    }
//
//    /**
//     * @return int
//     */
//    public function getTotal()
//    {
//        return $this->total;
//    }
//
//    /**
//     * @param bool $format
//     * @return array
//     */
//    public function getResults($format = true)
//    {
//        if(! $format) {
//            return $this->results;
//        }
//        $rows = explode(',', $this->rows);
//        foreach ($rows as $i=>$col) {
//            if(strpos($col, '.') !== false){
//                $a = explode('.', $col);
//                $rows[$i] = $a[1];
//            }elseif(strpos($col, 'as') !== false){
//                $a = explode('as', $col);
//                $rows[$i] = trim($a[1]);
//            }
//        }
//
//        $res = array();
//        foreach ($this->results as $item) {
//            $a = array();
//
//            foreach ($rows as $row) {
//                $a[] = isset($item[$row]) ? $item[$row] : $row . ' issues';
//            }
//
//            $res[] = $a;
//        }
//
//        return $res;
//    }
//
//    /**
//     * @param bool $s
//     * @return $this
//     */
//    public function debug($s = true)
//    {
//        $this->debug = $s;
//
//        return $this;
//    }
//
//    /**
//     * @param $num
//     * @return $this
//     */
//    public function setDisplayLength($num)
//    {
//        $this->iDisplayLength = $num;
//
//        return $this;
//    }
//
//    /**
//     * @param $name
//     * @param string $class
//     * @param string $style
//     * @return $this
//     */
//    public function th($name, $class = '', $style = '')
//    {
//        if(empty($this->th)) {
//            if($this->getConfig('groupFunctions')){
//                $this->config['ajax']['data']['groupFunction'] = true;
//                $this->th[] = array(
//                    'name' => "<input type='checkbox' class='check-all'>",
//                    'class' => 'w-20'
//                );
//            }
//            if($this->getConfig('sortable')){
//                $this->config['ajax']['data']['sortable'] = true;
//                $this->th[] = array(
//                    'name' => "<i class='icon-reorder'></i>",
//                    'class' => 'w-20'
//                );
//            }
//        }
//
//        $this->th[] = array(
//            'name'  => $name,
//            'class' => $class,
//            'style' => $style
//        );
//
//        return $this;
//    }
//
//    /**
//     * add row
//     * @param $tr array
//     * @return $this
//     */
//    public function tr($tr)
//    {
//        $_tr = array();
//
//        foreach ($tr as $k => $td) {
//            $_tr[] = "<td>{$td}</td>\r\n";
//        }
//
//        $this->tr[] = "<tr>". implode('', $_tr) ."</tr>\r\n";
//
//        return $this;
//    }
//
//    /**
//     * @param $key
//     * @param $val
//     * @return $this
//     */
//    public function setConfig($key, $val)
//    {
//        $this->config = array_merge(
//            $this->config,
//            array( $key => $val )
//        );
//
//        return $this;
//    }
//
//    /**
//     * @param $key
//     * @return mixed
//     */
//    public function getConfig($key)
//    {
//        if( ! isset($this->config[$key])) return false;
//
//        return $this->config[$key];
//    }

//
//    /**
//     * @param $title
//     * @return $this
//     */
//    public function setTitle($title)
//    {
//        $this->title = "<div id='data-table' class='panel-heading datatable-heading'>
//                            <h4 class='section-title'>{$title}</h4>
//                        </div>";
//
//        return $this;
//    }
//
//    /**
//     * @param $url
//     * @param array $data
//     * @return $this
//     */
//    public function ajaxConfig($url, $data = array())
//    {
//        $this ->setConfig('processing', true)
//            ->setConfig('serverSide', true)
//            ->setConfig(
//                'ajax',
//                array(
//                    'url'  => $url,
//                    'type' => 'POST',
////                    'data' => $data
//                )
//            );
//        $this->config['ajax']['data']['token'] = TOKEN;
//
//        return $this;
//    }
//
//    /**
//     * @param array $data
//     * @param int $recordsTotal
//     * @param bool $encode
//     * @return string
//     */
//    public function renderJSON(array $data, $recordsTotal=0, $encode = true)
//    {
//        $_data = array(); $draw= isset($_POST['draw']) ? (int)$_POST['draw'] : 1;  $recordsFiltered = $recordsTotal;
//        if($recordsTotal == 0){
//            $recordsTotal = $draw;
//        }
//        foreach ($data as $row) {
//            $_data[] = array_values($row);
//        }
//
//        $a = array(
//            'draw'            => $draw,
//            'data'            => $_data,
//            'recordsTotal'    => (int) $recordsTotal,
//            'recordsFiltered' => (int) $recordsFiltered
//        );
//
//        return $encode ? json_encode($a) : $a;
//    }
//
//    /**
//     * render table body
//     * @return string
//     */
//    private function body()
//    {
//        $c =0; // count th
//        $html = '';
//
//        if(!empty($this->title)){
//            $html .= "<div class='panel panel-default panel-block'>";
//            $html .= $this->title;
//        }
//
//        $html .= "<div class='table'>
//                    <table class='display table' style='width: 100%; cellspacing: 0;' id='{$this->table_id}'>
//                    <thead>
//                    <tr>\r\n";
//
//        foreach ($this->th as $th) {
//            $attr = empty($th['class']) ? '' : "class=\"{$th['class']}\"";
//            $attr .= empty($th['style']) ? '' : "style=\"{$th['style']}\"";
//            $html .= "<th {$attr}>{$th['name']}</th>\r\n";
//            $c++;
//        }
//
//        $html .= "
//                    </tr>
//                </thead>
//                ";
//        if(!empty($this->tr)) {
//            $html .= "<tbody>\r\n". implode('', $this->tr) ."</tbody>";
//        } else {
//            $html .= "
//                <tbody>
//                    <tr>
//                        <td colspan=\"{$c}\" class=\"dataTables_empty\">empty data</td>
//                    </tr>
//                </tbody>\r\n";
//        }
//        $html .= "</table></div>";
//
//        if(!empty($this->title)){
//            $html .= "</div>"; // .panel
//        }
//        return $html;
//    }
//
//    /**
//     * @return string
//     */
//    private function js()
//    {
//        $this->setConfig(
//            'fnInitComplete',
//            'function(){
//                $(\'.dataTables_wrapper\').find(\'input, select\').addClass(\'form-control\');
//            }');
//
//        $this->setConfig('iDisplayLength', $this->iDisplayLength);
////        $this->setConfig('fnInitComplete','function () {console.log(\'init complete\');}');
//
//        $config = json_encode($this->config);
//        $config = str_replace('\n', '', $config);
//        $config = str_replace('\r', '', $config);
//        $config = str_replace('"function', 'function', $config);
//        $config = str_replace('}"', '}', $config);
//        $config = ltrim($config, '"');
//        $config = rtrim($config, '"');
//        $config = stripslashes($config);
//        return "
//        <script>
//            $(document).ready(function() {
//                $('#{$this->table_id}').dataTable($config);
//            });
//        </script>";
//    }
//
//    /**
//     * @return string
//     */
//    public function render()
//    {
//        return $this->body() . $this->js();
//    }
}