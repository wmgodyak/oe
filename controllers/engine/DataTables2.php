<?php
/**
 * Company Otakoyi.com
 * Author: wg
 * Date: 02.05.15 16:05
 */

namespace controllers\engine;

use controllers\core\exceptions\Exception;
use controllers\core\Request;
use controllers\core\Response;
use models\core\DB;

defined("CPATH") or die();

/**
 * Example
 *
$t = new DataTables2('admins');

$t
-> th($this->t('common.id'),        'u.id', true, true)
-> th($this->t('admins.pib'),       'CONCAT(u.surname , \' \', u.name) as username', true, true )
-> th($this->t('admins.group'),     'ugi.name as group_name', false, true)
-> th($this->t('admins.email'),     'u.email', true, true)
-> th($this->t('admins.phone'),     'u.phone', true, true)
-> th($this->t('admins.created') ,  'u.created', true, false)
-> th($this->t('admins.lastlogin'), 'u.lastlogin', true, false)
-> th($this->t('common.func'), null, false, false);

$t-> ajax('admins/index/'. $group_id);

//        $t->addGroupAction('Delete', 'b-group-action-delete');
//        $t->addGroupAction('Ban', 'b-group-action-ban');
//        $t->addGroupAction('Export to Excell', 'Admins.exportExcell'); // t1odo заганяти в неї вибрані чекбокси
//        $t->addGroupAction('Ban', 'engine.admins.groupActions.ban'); // t1odo заганяти в неї вибрані чекбокси
//

// row sorting ui
// $t->sortable('__users', 'id', 'position');

$t->orderDef(1, 'desc');

$this->output($t->init());

Ajax response:
    if($this->request->isXhr()){
        //            $t->debug();
        $t->get('u.status');
        $t  -> from('__users u')
        -> join("__users_group ug on ug.backend = 1")
        -> join("__users_group_info ugi on ugi.group_id=ug.id and ugi.languages_id={$this->languages_id}")
        -> where(" u.group_id=ug.id")
        -> execute();

        if(! $t){
            echo $t->getError();
            return null;
        }

        $s = ['ban' => $this->t('admins.status_ban'), 'deleted' => $this->t('admins.status_deleted')];

        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {
            $res[$i][] = $row['id'];
            $res[$i][] = $row['username'] .
            ($row['status'] != 'active' ? "<br><label class='label label-danger'>{$s[$row['status']]}</label>" : '');
            $res[$i][] = $row['group_name'];
            $res[$i][] = $row['email'];
            $res[$i][] = $row['phone'];
            $res[$i][] = $row['created'];
            $res[$i][] = $row['lastlogin'] ? DateTime::ago(strtotime($row['lastlogin'])) : '';

            $b = [];
            $b[] = (string)Button::create
            (
            Icon::create(Icon::TYPE_EDIT),
            ['class' => 'b-admins-edit btn-primary', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
            );
            if($row['status'] == 'active'){
            $b[] =  (string)Button::create
            (
            Icon::create(Icon::TYPE_BAN),
            ['class' => 'b-admins-ban', 'data-id' => $row['id'], 'title' => $this->t('admins.title_ban')]
            );
            $b[] = (string)Button::create
            (
            Icon::create(Icon::TYPE_DELETE),
            ['class' => 'b-admins-delete', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
            );
            } elseif($row['status'] == 'deleted' || $row['status'] == 'ban'){
            $b[] =  (string)Button::create
            (
            Icon::create(Icon::TYPE_RESTORE),
            ['class' => 'b-admins-restore', 'data-id' => $row['id'], 'title' => $this->t('admins.title_restore')]
            );
            }

            $b[] = (string)Button::create
            (
            Icon::create(Icon::TYPE_TRASH),
            ['class' => 'b-admins-remove btn-danger', 'data-id' => $row['id'], 'title' => $this->t('common.title_remove')]
            );

            $res[$i][] = implode('', $b);
        }

        return $t->render($res, $t->getTotal());
    }
 * Class DataTables2
 * @package controllers\engine
 */
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
    public function th($label, $col = null, $searchable = false, $orderable = false, $style = null)
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

        if(!empty($this->group_actions)){
            $html .= "<th style='width: 60px;'><input type='checkbox' class='dt-check-all''></th>\r\n";
        }

        if(!empty($this->sortable)){
            $html .= "<th style='width: 60px;'><i class='fa fa-list'></i></th>\r\n";
        }

        foreach ($this->th as $th) {
            $attr = empty($th['style']) ? '' : "style=\"{$th['style']}\"";
            $html .= "<th {$attr}>{$th['label']}</th>\r\n";
            $c++;
        }

        $html .= "</tr>
                </thead>\r\n";

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
     * ordering definitions
     * @var array
     */
    private $order_defs = [];

    /**
     * @link https://datatables.net/examples/basic_init/table_sorting.html
     * @param $index
     * @param $order
     * @return $this
     */
    public function orderDef($index, $order)
    {
        $this->order_defs = ['index' => $index, 'order' => $order];

        return $this;
    }

    /**
     * @return string
     */
    private function js()
    {
        // definition to column search and ordering
        $idx = []; $sidx = []; $defs = [];

        if($this->sortable){
            array_unshift($this->cols, ['col' => null]);
        }

        if(!empty($this->group_actions)){
            array_unshift($this->cols, ['col' => null]);
        }

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

        // set default order

        if($this->sortable && !empty($this->group_actions)){
            if(empty($this->order_defs)){
                $this->order_defs['index'] = 2;
                $this->order_defs['order'] = 'asc';
            } else {
                $this->order_defs['index'] += 2;
            }
        } elseif(!$this->sortable && empty($this->group_actions)){
            if(empty($this->order_defs)){
                $this->order_defs['index'] = 0;
                $this->order_defs['order'] = 'asc';
            }
        } else {
            if(empty($this->order_defs)){
                $this->order_defs['index'] = 1;
                $this->order_defs['order'] = 'asc';
            } else {
                $this->order_defs['index'] ++;
            }
        }

        $this->config('order', [$this->order_defs['index'], $this->order_defs['order']]);

        $in_init_functions = '';
        if(!empty($this->group_actions)){
            $opt = '<label>Set action: <select id="tbl_group_actions" class="form-control" style="width: 300px;">';
            $opt .= "<option value=\"\">no action</option>";
            foreach ($this->group_actions as $group_action) {
                $opt .= "<option value=\"{$group_action['action']}\">{$group_action['label']}</option>";
            }
            $opt .= "</select> <button class=\"btn\" id=\"tbl_group_actions_submit\">Go</button></label>";

            $in_init_functions .= "$('<div id=\"group_actions\" style=\"width: 360px;float:right;\">$opt</div>').css('opacity',0).insertAfter('.dataTables_filter');";
        }

        if($this->sortable){
//            $this->config('rowReorder', true);
//            $this->sortableParams $this->sortableParams = ['action' => $action, 'pk' => $pk, 'col' => $col];
            $in_init_functions .= "$(\"#{$this->id} .dt-reorder-icon\").each(function(){ $(this).parents(\"tr\").attr(\"id\", $(this).attr(\"id\")).addClass(\"dt-reorder\"); $(this).removeAttr(\"id\"); });   $(\"#{$this->id} > tbody \").sortable({ /*handle: \".dt-reorder\",*/ update: function(event, ui) { var no = $(this).sortable('toArray').toString();   saveOrdering(\"{$this->sortableParams['table']}\", \"{$this->sortableParams['pk']}\", \"{$this->sortableParams['col']}\", no);     } });";
        }

        $this->config
        (
            'fnInitComplete',
            'function(){
                $(\'.dataTables_wrapper\').find(\'input\').addClass(\'form-control\');
                '. $in_init_functions .'
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
                function saveOrdering(table, pk, col, oData)
                {
                    engine.request.post({
                        url: 'DataTables2/reorder',
                        data: {
                            table: table,
                            pk   : pk,
                            col  : col,
                            order: oData
                        },
                        success: function(d){engine.notify(d.m, 'success');}
                    });
                }

                var table = $('#{$this->id}').dataTable($config);

                $(document).on('click', '#tbl_group_actions_submit', function(){
                   var action = $('#tbl_group_actions').find('option:selected').val();
                   if(action == '') return ;

                    action += '(d)';

//                    console.log(action);

                    var fn = new Function('d', action);
                    fn(getSelectedChb());
                });

                $(document).on('change', '.dt-check-all', function(){
                    var chb = $('.dataTable').find('.dt-chb');
                    if($(this).is(':checked')){
                        chb.attr('checked', true);
                        showGroupActions();
                    } else {
                        chb.removeAttr('checked');
                        hideGroupActions();
                    }
                });

                $(document).on('change', '.dt-chb', function(){
                    var checked = false;
                    var chb = $('.dataTable').find('.dt-chb');
                    chb.each(function(){
                        if($(this).is(':checked')) {
                            checked = true;
                            return true;
                        }
                    });

                    if(checked){
                        showGroupActions();
                    } else {
                        hideGroupActions();
                    }
                });

                function showGroupActions()
                {
                    $(\"#group_actions\").css('opacity', 1);
                }

                function hideGroupActions()
                {
                    $(\"#group_actions\").css('opacity', 0)
                }

                function getSelectedChb()
                {
                    var selected = [], chb = $('.dataTable').find('.dt-chb');

                    chb.each(function(){
                        if($(this).is(':checked')) {
                            selected.push(parseInt($(this).val()));
                        }
                    });

                    return selected;
                }
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

        $order_by = ''; $ob = [];
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

                if(empty($_col)) continue;

                $ob[] = " {$_col} {$col['dir']}";
            }

            if(!empty($ob)){
                $order_by .= "ORDER BY" . implode(', ', $ob);
            }
        }

        $a = [];
        foreach ($this->cols as $col) {
            if(empty($col['col'])) continue;
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
            $id = $row[0];
            if($this->sortable){
                array_unshift($row, '<i class="fa fa-list dt-reorder-icon" id="dt-'. $id .'"></i>');
            }

            if(!empty($this->group_actions)){
                array_unshift($row, '<input class=\'dt-chb\' value=\''. $id .'\' type=\'checkbox\' style=\'height: auto;\'>');
            }

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

    /**
     * @var array
     */
    private $group_actions = [];

    private $group_actions_pk = null;

    /**
     * @param $label
     * @param $action
     * @return $this
     */
    public function addGroupAction($label, $action)
    {
        $this->group_actions[] = ['label' => $label, 'action' => $action];

        return $this;
    }

    /**
     * set primary key to adding him to checkboxes
     * @param $key
     * @return $this
     */
    public function groupActionsPk($key)
    {
        $this->group_actions_pk = $key;

        return $this;
    }

    private $sortable = false;
    private $sortableParams = [];

    /**
     * @param $table
     * @param $pk
     * @param $col
     * @return $this
     */
    public function sortable($table, $pk, $col)
    {
        $this->sortableParams = ['table' => $table, 'pk' => $pk, 'col' => $col];
        $this->sortable = true;

        return $this;
    }

    /**
     * save order
     */
    public function reorder()
    {
        $m=null; $s = 0;

        $request = Request::getInstance();
        $table   = $request->post('table', 's');
        $pk      = $request->post('pk', 's');
        $col     = $request->post('col', 's');
        $order   = $request->post('order');
        $order   = str_replace('dt-','', $order);

        if(empty($table) || empty($pk) || empty($col) || empty($order)) {$m = 'wrong params';}

        $a = explode(',', $order);
        foreach ($a as $k => $row_id) {
           $s +=  $this->db->update($table, [$col => $k], " $pk = '$row_id' limit 1");
        }

        if($s > 0){
            $m = "Сортування збережено";
        }
        Response::getInstance()->body(['m' => $m])->asJSON();
    }

    public function before(){}
    public function after(){}
}