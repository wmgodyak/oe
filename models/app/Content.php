<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 21.03.16 : 12:13
 */

namespace models\app;

use models\App;

defined("CPATH") or die();

/**
 * Class Content
 * @package models\app
 */
class Content extends App
{
    private $q_join     = [];
    private $q_where    = [];
    private $q_order    = '';
    private $q_group_by = '';
    private $q_limit    = '';

    private $debug = 0;

    public function getUrlById($id)
    {
        $url = self::$db
            ->select("select url from content_info where content_id = '{$id}' and languages_id={$this->languages_id} limit 1")
            ->row('url');

        if($this->languages_id == $this->languages->getDefault('id')){
            return $url;
        }

        $code = $this->languages->getData($this->languages_id, 'code');

        return $code .'/'. $url;
    }

    public function getItems($key = '*')
    {
        $w = implode(",", $this->q_where); if(!empty($w)) $w .= ' and ';

        $j = implode(' ', $this->q_join);

        return self::$db->select("
          select {$key}
          from content c
          {$j}
          join content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
          where {$w}  c.status='published'
          {$this->q_order}
          {$this->q_group_by}
          {$this->q_limit}
          ", $this->debug)->all();
    }

    protected function getTotal()
    {
        $w = implode(",", $this->q_where); if(!empty($w)) $w .= ' and ';

        $j = implode(' ', $this->q_join);

        return self::$db->select("
          select count(c.id) as t
          from content c
          {$j}
          join content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
          where {$w}  c.status='published'
          ", $this->debug)->row('t');
    }

    public function getItem($id, $key = '*')
    {
        $j = implode(' ', $this->q_join);

        return self::$db->select("
          select {$key}
          from content c
          {$j}
          join content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}
          where c.id={$id} and c.status='published'
          ", $this->debug)->row();
    }

    protected function join($join)
    {
        if(strpos($join, 'join') === false){
            $join = 'join '.$join;
        }

        $this->q_join[] = $join;

        return $this;
    }

    /**
     * @param $q
     * @return $this
     */
    protected function where($q)
    {
        if(empty($this->q_where)){
            if(substr($q, 0, 3) == 'and'){
                $q = substr($q, -4);
            }
            if(substr($q, 0, 2) == 'and'){
                $q = substr($q, -3);
            }
        }
        $this->q_where[] = $q;
        return $this;
    }

    /**
     * @param $q
     * @return $this
     */
    protected function orderBy($q)
    {
        $this->q_order = 'order by ' . $q;
        return $this;
    }

    protected function groupBy($q)
    {
        $this->q_group_by = $q;
        return $this;
    }

    public function limit($start, $num)
    {
        $this->q_limit = " LIMIT {$start}, {$num}";

        return $this;
    }

    /**
     * @param int $status
     * @return $this
     */
    protected function debug($status = 1)
    {
        $this->debug = $status;

        return $this;
    }

    public function clearQuery()
    {
        $this->q_where    = [];
        $this->q_join     = [];
        $this->q_order    = '';
        $this->q_group_by = '';
        $this->q_limit    = '';

        return $this;
    }
}