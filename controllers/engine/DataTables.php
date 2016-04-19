<?php
/**
 * Company Otakoyi.com
 * Author: wg
 * Date: 02.05.15 16:05
 */

namespace controllers\engine;

use models\core\DB;

defined("CPATH") or die();

/**
 * Class DataTables
 * @package controllers\engine
 *
 * Examples
 *
 * html example
 *
$t = new DataTables();
$t->setId('content')
->setTitle('table title')
-> th('#')
-> th('name')
-> th('controller')
-> th('rang')
-> th('func')
;

// some html data

$t->tr(array(1,'name','c','r', 'f'));
$t->tr(array(2,'name2','c','r', 'f'));
$t->tr(array(3,'name2','c','r', 'f'));
$t->tr(array(4,'name2','c','r', 'f'));
$t->tr(array(5,'name2','c','r', 'f'));

// render output
return $t->render();
 *
 *
 * JSON VS DB
 *
$t = new DataTables();
$t  -> table('__content c')
-> get('c.id, i.name, c.published')
-> join("__join content_info i on i.content_id=c.id and i.languages_id=1")
-> execute();

return $t->renderJSON($t->getResults(), $t->getTotal());
 *
 * JSON VS DB CUSTOM FORMAT

$t = new DataTables();
$t  -> table('__content c')
-> get('c.id, i.name, c.published')
-> join("__join content_info i on i.content_id=c.id and i.languages_id=1")
-> execute();

$res = array();
foreach ($t->getResults(false) as $i=>$row) {
$res[$i][] = $row['id'];
$res[$i][] = "<a href='{$row['id']}'>{$row['name']}</a>";
$res[$i][] = "<a class='btn btn-primary' href='{$row['id']}'><i class='icon-edit icon-white'></i></a>";
}

return $t->renderJSON($res, $t->getTotal());
 *
 */
class DataTables {

    /**
     * set title of table
     * @var string
     */
    private $title;

    /**
     * @var array
     */
    private $config = array();

    /**
     * table ID
     * @var string
     */

    private $table_id;

    /**
     * table heading columns
     * @var array
     */
    private $th = array();

    /**
     * row of table body
     * @var array
     */
    private $tr = array();

    private $db;

    private $table;
    private $join     = array();
    private $where    = array();
    private $order_by = '';
    private $rows     = '';
    private $search_cols = array();
    private $limit    = '';
    private $debug    = 0;
    private $total    = 0;
    private $results  = array();

    private $iDisplayLength = 50;

    public function __construct()
    {
        $this->db = DB::getInstance();
        return $this;
    }

    /**
     * @param $table
     * @return $this
     */
    public function table($table)
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
     * @param $q
     * @return $this
     */
    public function orderBy($q)
    {
        $this->order_by = $q;

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
     * @param $rows
     * @return $this
     */
    public function get($rows)
    {
        if(is_array($rows)){
            $this->rows = implode(',', $rows);
        } else {
            $this->rows = $rows;
        }

        return $this;
    }

    /**
     * @param $rows
     * @return $this
     */
    public function searchCol($rows)
    {

        if(is_array($rows)){
            $this->search_cols = $rows;
        } else {
            $this->search_cols = explode(',', $rows);
        }

        return $this;
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

        /**
         * sorting
         */
        if(isset($_POST['order'][0]['column'])){
            $col  = (int)$_POST['order'][0]['column'];
            $rows = explode(',', $this->rows);
            $dir = isset($_POST['order'][0]['dir']) && $_POST['order'][0]['dir'] == 'asc' ? 'ASC' : 'DESC';
            if(isset($rows[$col])){
                if(strpos($rows[$col], ' as ')){
                    $a = explode(' as ', $rows[$col]);
                    $rows[$col] = $a[1];
                }
                $this->order_by = " ORDER BY {$rows[$col]} {$dir}";
            }
        }

        if( !empty($this->search_cols) && isset( $_POST['search']['value']) && strlen($_POST['search']['value']) > 2){
            $q = trim($_POST['search']['value']);
            if(!empty($q) && strlen($q) > 1){
                $w = array();
                foreach ($this->search_cols as $k => $row) {
                    $w[] = " {$row} like '%{$q}%'";
                }

                $this->where("(". implode(' or ', $w) .")");
            }
//            var_dump($_POST['search']['value']); die();
        }


        $w = empty($this->where) ? '' : 'WHERE ' . implode(' and ', $this->where);
        $j = implode(' ', $this->join);

        $t = "SELECT COUNT(*) AS t FROM {$this->table} {$j} {$w}";
        $q = "SELECT {$this->rows} FROM {$this->table} {$j} {$w} {$this->order_by} {$this->limit}";
//        echo $t,"\r\n";
//        echo $q;
        $this->total   = $this->db->select($t, $this->debug)->row('t');
        $this->results = $this->db->select($q, $this->debug)->all();
        if($this->db->hasError()){
            die($this->db->getErrorMessage());
        }
        return $this;
    }

    /**
     * @return int
     */
    public function getTotal()
    {
        return $this->total;
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
        $rows = explode(',', $this->rows);
        foreach ($rows as $i=>$col) {
            if(strpos($col, '.') !== false){
                $a = explode('.', $col);
                $rows[$i] = $a[1];
            }elseif(strpos($col, 'as') !== false){
                $a = explode('as', $col);
                $rows[$i] = trim($a[1]);
            }
        }

        $res = array();
        foreach ($this->results as $item) {
            $a = array();

            foreach ($rows as $row) {
                $a[] = isset($item[$row]) ? $item[$row] : $row . ' issues';
            }

            $res[] = $a;
        }

        return $res;
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
     * @param $num
     * @return $this
     */
    public function setDisplayLength($num)
    {
        $this->iDisplayLength = $num;

        return $this;
    }

    /**
     * @param $name
     * @param string $class
     * @param string $style
     * @return $this
     */
    public function th($name, $class = '', $style = '')
    {
        if(empty($this->th)) {
            if($this->getConfig('groupFunctions')){
                $this->config['ajax']['data']['groupFunction'] = true;
                $this->th[] = array(
                    'name' => "<input type='checkbox' class='check-all'>",
                    'class' => 'w-20'
                );
            }
            if($this->getConfig('sortable')){
                $this->config['ajax']['data']['sortable'] = true;
                $this->th[] = array(
                    'name' => "<i class='icon-reorder'></i>",
                    'class' => 'w-20'
                );
            }
        }

        $this->th[] = array(
            'name'  => $name,
            'class' => $class,
            'style' => $style
        );

        return $this;
    }

    /**
     * add row
     * @param $tr array
     * @return $this
     */
    public function tr($tr)
    {
        $_tr = array();

        foreach ($tr as $k => $td) {
            $_tr[] = "<td>{$td}</td>\r\n";
        }

        $this->tr[] = "<tr>". implode('', $_tr) ."</tr>\r\n";

        return $this;
    }

    /**
     * @param $key
     * @param $val
     * @return $this
     */
    public function setConfig($key, $val)
    {
        $this->config = array_merge(
            $this->config,
            array( $key => $val )
        );

        return $this;
    }

    /**
     * @param $key
     * @return mixed
     */
    public function getConfig($key)
    {
        if( ! isset($this->config[$key])) return false;

        return $this->config[$key];
    }

    /**
     * @param $id
     * @return $this
     */
    public function setId($id)
    {
        $this->table_id = $id;

        return $this;
    }

    /**
     * @param $title
     * @return $this
     */
    public function setTitle($title)
    {
        $this->title = "<div id='data-table' class='panel-heading datatable-heading'>
                            <h4 class='section-title'>{$title}</h4>
                        </div>";

        return $this;
    }

    /**
     * @param $url
     * @param array $data
     * @return $this
     */
    public function ajaxConfig($url, $data = array())
    {
        $this ->setConfig('processing', true)
            ->setConfig('serverSide', true)
            ->setConfig(
                'ajax',
                array(
                    'url'  => $url,
                    'type' => 'POST',
//                    'data' => $data
                )
            );
        $this->config['ajax']['data']['token'] = TOKEN;

        return $this;
    }

    /**
     * @param array $data
     * @param int $recordsTotal
     * @param bool $encode
     * @return string
     */
    public function renderJSON(array $data, $recordsTotal=0, $encode = true)
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
     * render table body
     * @return string
     */
    private function body()
    {
        $c =0; // count th
        $html = '';

        if(!empty($this->title)){
            $html .= "<div class='panel panel-default panel-block'>";
            $html .= $this->title;
        }

        $html .= "<div class='table'>
                    <table class='display table' style='width: 100%; cellspacing: 0;' id='{$this->table_id}'>
                    <thead>
                    <tr>\r\n";

        foreach ($this->th as $th) {
            $attr = empty($th['class']) ? '' : "class=\"{$th['class']}\"";
            $attr .= empty($th['style']) ? '' : "style=\"{$th['style']}\"";
            $html .= "<th {$attr}>{$th['name']}</th>\r\n";
            $c++;
        }

        $html .= "
                    </tr>
                </thead>
                ";
        if(!empty($this->tr)) {
            $html .= "<tbody>\r\n". implode('', $this->tr) ."</tbody>";
        } else {
            $html .= "
                <tbody>
                    <tr>
                        <td colspan=\"{$c}\" class=\"dataTables_empty\">empty data</td>
                    </tr>
                </tbody>\r\n";
        }
        $html .= "</table></div>";

        if(!empty($this->title)){
            $html .= "</div>"; // .panel
        }
        return $html;
    }

    /**
     * @return string
     */
    private function js()
    {
        $this->setConfig(
            'fnInitComplete',
            'function(){
                $(\'.dataTables_wrapper\').find(\'input, select\').addClass(\'form-control\');
            }');

        $this->setConfig('iDisplayLength', $this->iDisplayLength);
//        $this->setConfig('fnInitComplete','function () {console.log(\'init complete\');}');

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
                $('#{$this->table_id}').dataTable($config);
            });
        </script>";
    }

    /**
     * @return string
     */
    public function render()
    {
        return $this->body() . $this->js();
    }
} 