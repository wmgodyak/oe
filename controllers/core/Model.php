<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 03.05.14 21:49
 */
namespace controllers\core;

defined('CPATH') or die();

/**
 * Base Model
 */
abstract class Model {

    protected $db;
    protected $languages_id;
    protected $languages_code;
    private   $error;

    public function __construct()
    {
        $this->db = DB::instance();
        $l = $this->db->select("select id,code from languages where front_default = 1 limit 1")->row();
        $this->languages_id= $l['id'];
        $this->languages_code = $l['code'];
//        $this->languages_id = Config::instance()->get('languages.id');
    }

    /**
     * get data from table row
     * @param $table
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function data($table, $id, $key='*')
    {
        return $this->db->select("
                                SELECT {$key}
                                FROM {$table} where id = {$id}
                                LIMIT 1
                                ")->row($key);
    }

    /**
     * create row on custom table
     * @param $table
     * @param $data
     * @return bool|string
     */
    public function createRow($table, $data)
    {
        $this->db->beginTransaction();

        $id = $this->db->insert($table, $data);

        if($id > 0) {
            $this->db->commit();
        } else {
            $this->error(DB::getErrorMessage());
            $this->db->rollBack();
        }

        return $id;
    }
    /**
     * update custom row on custom table
     * @param $table
     * @param $id
     * @param $data
     * @param $debug
     * @return bool
     */
    public function updateRow($table, $id, $data, $debug=0)
    {
        $this->db->beginTransaction();

        $r = $this->db->update($table, $data, "id={$id} limit 1", $debug);

        if($r > 0) {
            $this->db->commit();
        } else {
            $this->db->rollBack();
        }

        return $r;
    }
    /**
     * delete custom row on custom table
     * @param $table
     * @param $id
     * @return bool
     */
    public function deleteRow($table, $id)
    {
        $this->db->beginTransaction();

        if($this->db->delete($table, " id = {$id} limit 1")){
            $this->db->commit();
        } else {
            $this->db->rollBack();
        }

        return 1;
    }

    /**
     * @param $table
     * @param $pk
     * @param $id
     * @return array
     */
    public function fulInfo($table, $pk, $id)
    {
        $columns = $this->db->showColumns($table);
        $r = $this->db->select("
                                SELECT *
                                FROM {$table} where {$pk} = {$id}
                                ")->all();
        $res=array();
        foreach ($r as $row) {
            foreach ($columns as $col) {
                $res[$row['languages_id']][$col['Field']] = $row[$col['Field']];
            }
        }
        return $res;
    }

    /**
     * витягує кілкість записів в талиці
     * @param $table
     * @return array|mixed
     */
    public function totalRecords($table)
    {
        return $this->db->select("select count(*) as t from {$table}")->row('t');
    }

    public function error($val=null)
    {
        echo $val;
        if($val) $this->error[] = $val;
        return !empty($this->error) ? implode('<br>', $this->error) : '';
    }

    /**
     * @return mixed
     */
    public function getError()
    {
        return $this->error;
    }

    /**
     * @param $tbl
     * @param $col
     * @return array
     */
    public function enumValues($tbl, $col)
    {
        return $this->db->enumValues($tbl, $col);
    }
}