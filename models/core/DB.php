<?php
/**
 * Company Otakoyi.com.
 * Author WMGODYAK.
 * Date: 19.04.13 11:49
 */

namespace models\core;

use controllers\core\Config;

if ( !defined('CPATH') )die();

/**
 * Class DB
 * Creates a PDO database connection. This connection will be passed into the models (so we use
 * the same connection for all models and prevent to open multiple connections at once)
 */

class DB extends \PDO {

    private static $instance;
    private static $error;
    private static $errorCode;
    private static $errorMessage;
    private static $count;

    private $db_prefix;
    private $db_type;
    private $db_name;
    private $sql;
    private $result;

    /**
     * Construct this Database object, extending the PDO object
     * By the way, the PDO object is built into PHP by default
     */
    public function __construct()
    {
        /**
         * set the (optional) options of the PDO connection. in this case, we set the fetch mode to
         * "objects", which means all results will be objects, like this: $result->user_name !
         * For example, fetch mode FETCH_ASSOC would return results like this: $result["user_name] !
         * @see http://www.php.net/manual/en/pdostatement.fetch.php
         */
        $conf = Config::getInstance()->get('db');
        $this->db_name = $conf['db'];

        $options = array(
            \PDO::ATTR_DEFAULT_FETCH_MODE => \PDO::FETCH_ASSOC,
            \PDO::ATTR_ERRMODE => \PDO::ERRMODE_EXCEPTION // ERRMODE_EXCEPTION
        );

        /**
         * Generate a database connection, using the PDO connector
         * @see http://net.tutsplus.com/tutorials/php/why-you-should-be-using-phps-pdo-for-database-access/
         * Also important: We include the charset, as leaving it out seems to be a security issue:
         * @see http://wiki.hashphp.org/PDO_Tutorial_for_MySQL_Developers#Connecting_to_MySQL says:
         * "Adding the charset to the DSN is very important for security reasons,
         * most examples you'll see around leave it out. MAKE SURE TO INCLUDE THE CHARSET!"
         */
        try{
            parent::__construct(
                $conf['type'] . ':host=' . $conf['host'] . ';dbname=' . $conf['db'] . ';charset=' . $conf['charset'],
                $conf['user'], $conf['pass'],
                $options
            );
            $this->exec("SET NAMES utf8");
        } catch (\Exception $e){

            header('HTTP/1.1 503 Service Temporarily Unavailable');
            header('Status: 503 Service Temporarily Unavailable');
            $output = self::fatalErrorPageContent();
            $output = str_ireplace(
                '{DESCRIPTION}',
                '<p>This application is currently experiencing some database difficulties</p>',
                $output
            );
            $output = str_ireplace(
                '{CODE}',
                '<b>Description:</b> '.$e->getMessage().'<br>
                    <b>File:</b> '.$e->getFile().'<br>
                    <b>Line:</b> '.$e->getLine(),
                $output
            );

            echo $output;

            exit(1);

        }
    }


    public static function getInstance()
    {

        if(!self::$instance instanceof self){
            self::$instance = new DB();
        }

        return self::$instance;
    }

    /**
     * close connection
     */
    public function close()
    {
        self::$instance = null;
    }

    public function getQueryCount()
    {
        return self::$count;
    }

    public function select($sql, $debug = false)
    {
        if($debug) echo '<pre> '. $sql .' </pre>';

        try {
            
            $this->sql = $sql;

            $this->result = $this->prepare($sql);
            $this->result->execute();

            ++self::$count;

        } catch(\PDOException $e){
            self::$errorMessage = "<pre>$sql" . $e->getMessage() .'</pre>';
            self::$errorCode = $e->getCode();
        }
        
        return $this;
    }

    /**
     * get row from query result
     * @param string $key
     * @return array|mixed
     */
    public function row($key='*')
    {
        $res = $this->result->fetch(DB::FETCH_ASSOC);
        if(strpos($key, ',')){
            $a = explode(',', $key);
            $b = [];
            foreach ($a as $k=>$v) {
                if(! isset($res[$v])) continue;
                $b[$v] = $res[$v];
            }
            return $b;
        }
        return $key=='*' ? $res : $res[$key];
    }

    /**
     * @return mixed
     */
    public function all($key = null)
    {
        if($key){
            $r = $this->result->fetchAll(DB::FETCH_ASSOC);
            $res = [];
            foreach ($r as $item) {
                $res[] = $item[$key];
            }
            return $res;
        }

        return $this->result->fetchAll(DB::FETCH_ASSOC);
    }

    /**
     * @param $table
     * @param $data
     * @param bool $debug
     * @return bool|string
     */
    public function insert($table, $data, $debug = false)
    {
        $fieldNames = implode('`, `', array_keys($data));
        $fieldValues = ':'.implode(', :', array_keys($data));

        $sql = 'INSERT INTO `'.$this->db_prefix.$table.'` (`'.$fieldNames.'`) VALUES ('.$fieldValues.')';
        $sth = $this->prepare($sql);

        foreach($data as $key => $value){
            list($key, $param) = $this->prepareParams($key);
            $sth->bindValue(':'.$key, $value, $param);
        }

        if($debug) {
            echo '<pre>' . $this->interpolateQuery($sql, $data) . '</pre>';
        }

        try {
            $sth->execute();
            $result = $this->lastInsertId();
        } catch(\PDOException $e){
            self::$errorMessage = $e->getMessage() . $this->interpolateQuery($sql, $data);
            self::$errorCode = $e->getCode();
            $result = false;
        }
        ++self::$count;
        return $result;
    }

    /**
     * @param $table
     * @param array $data
     * @param int $where
     * @param bool $debug
     * @return bool
     */
    public function update($table, array $data, $where = 1, $debug = false)
    {

        ksort($data);

        $fieldDetails = NULL;
        foreach($data as $key => $value){
            $fieldDetails .= '`'.$key.'` = :'.$key.',';
        }
        $fieldDetails = rtrim($fieldDetails, ',');

        $sql = 'UPDATE `'.$this->db_prefix.$table.'` SET '.$fieldDetails.' WHERE '.$where;
        $sth = $this->prepare($sql);

        foreach($data as $key => $value){
            list($key, $param) = $this->prepareParams($key);
            $sth->bindValue(':'.$key, $value, $param);
        }

        if($debug){
            echo '<pre>' . $this->interpolateQuery($sql, $data) . '</pre>';
        }
        try{
            $sth->execute();
            $result = true;
        }catch(\PDOException $e){
            self::$errorMessage = $e->getMessage() . $this->interpolateQuery($sql, $data);
            self::$errorCode = $e->getCode();
            $result = false;
        }
        ++self::$count;

        return $result;
    }

    /**
     * Performs delete query
     * @param string $table
     * @param string $where the WHERE clause of query
     * @param int $debug
     * @return integer affected rows
     */
    public function delete($table, $where = '', $debug = 0)
    {
        $where_clause = (!empty($where) && !preg_match('/\bwhere\b/i', $where)) ? ' WHERE '.$where : $where;
        $sql = 'DELETE FROM `'.$this->db_prefix.$table.'` '.$where_clause;

        $sth = $this->prepare($sql);
        if($debug){
            echo '<pre>' . $this->interpolateQuery($sql) . '</pre>';
        }
        try{
            //$result = $this->exec($sql);
            $sth->execute();
            $result = true;
        }catch(\PDOException $e){
            self::$errorMessage = $e->getMessage() . $this->interpolateQuery($sql);
            self::$errorCode = $e->getCode();
            $result = false;
        }
        ++self::$count;

        return $result;
    }

    /**
     * Performs a standard exec
     * @param string $sql
     * @return boolean
     */
    public function customExec($sql)
    {

        try{
            $result = $this->exec($sql);
        }catch(\PDOException $e){
            self::$errorMessage = $e->getMessage() . $this->interpolateQuery($sql);
            self::$errorCode = $e->getCode();
            $result = false;
        }
        ++self::$count;

        return $result;
    }

    /**
     * Performs a show tables query
     * @return mixed
     */
    public function showTables()
    {
        switch($this->db_type){
            case 'mssql';
            case 'sqlsrv':
                $sql = 'SELECT * FROM sys.all_objects WHERE type = \'U\'';
                break;
            case 'pgsql':
                $sql = 'SELECT tablename FROM pg_tables WHERE tableowner = current_user';
                break;
            case 'sqlite':
                $sql = 'SELECT * FROM sqlite_master WHERE type=\'table\'';
                break;
            case 'oci':
                $sql = 'SELECT * FROM system.tab';
                break;
            case 'ibm':
                $schema = '';
                $sql = 'SELECT TABLE_NAME FROM qsys2.systables'.
                    (($schema != '') ? ' WHERE TABLE_SCHEMA = \''.$schema.'\'' : '');
                break;
            case 'mysql':
            default:
                $sql = 'SHOW TABLES IN `'.$this->db_name.'`';
                break;
        }

        try{
            $sth = $this->query($sql);
            $result = $sth->fetchAll();
        }catch(\PDOException $e){
            self::$errorMessage = $e->getMessage() . $this->interpolateQuery($sql);
            self::$errorCode = $e->getCode();
            $result = false;
        }
        return $result;
    }



    /**
     * Performs a show column query
     * @param string $table
     * @return mixed
     */
    public function showColumns($table = '')
    {
        switch($this->db_type){
            case 'ibm':
                $sql = "SELECT COLUMN_NAME FROM qsys2.syscolumns WHERE TABLE_NAME = '".$this->db_prefix.$table."'";
                break;
            case 'mssql':
                $sql = "SELECT COLUMN_NAME, data_type, character_maximum_length FROM ".
                    $this->db_name.".information_schema.columns WHERE table_name = '".$this->db_prefix.$table."'";
                break;
            default:
                $sql = 'SHOW COLUMNS FROM `'.$this->db_prefix.$table.'`';
                break;
        }

        try{
            $sth = $this->query($sql);
            $result = $sth->fetchAll();
        } catch(\PDOException $e){
            self::$errorMessage = $e->getMessage() . $this->interpolateQuery($sql);
            self::$errorCode = $e->getCode();
            $result = false;
        }
        ++self::$count;

        return $result;
    }
    
    /**
     * Returns database engine version
     */
    public function getVersion()
    {
        $version = $this->getAttribute(\PDO::ATTR_SERVER_VERSION);
        // clean version number from alphabetic characters
        return preg_replace('/[^0-9,.]/', '', $version);
    }

    /**
     * Get error status
     * @return boolean
     */
    public function getErrorCode()
    {
        return self::$error;
    }

    /**
     * Get error message
     * @return string
     */
    public function getErrorMessage()
    {
        return self::$errorMessage;
    }

    public function hasError()
    {
        return self::$errorCode != '';
    }

    /**
     * Returns fata error page content
     * @return html code
     */
    private static function fatalErrorPageContent()
    {
        return '<!DOCTYPE html>
        <html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
        <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Database Fatal Error</title>
        <style type="text/css">
            html{background:#f9f9f9}
            body{
                background:#fff;
                color:#333;
                font-family:sans-serif;
                margin:2em auto;
                padding:1em 2em 2em;
                -webkit-border-radius:3px;
                border-radius:3px;
                border:1px solid #dfdfdf;
                max-width:750px;
                text-align:left;
            }
            #error-page{margin-top:50px}
            #error-page h2{border-bottom:1px dotted #ccc;}
            #error-page p{font-size:16px; line-height:1.5; margin:2px 0 15px}
            #error-page .code-wrapper{color:#400; background-color:#f1f2f3; padding:5px; border:1px dashed #ddd}
            #error-page code{font-size:15px; font-family:Consolas,Monaco,monospace;}
            a{color:#21759B; text-decoration:none}
            a:hover{color:#D54E21}
        </style>
        </head>
        <body id="error-page">
            <h2>Database connection error!</h2>
            {DESCRIPTION}
            <div class="code-wrapper">
            <code>{CODE}</code>
            </div>
        </body>
        </html>';
    }

    /**
     * Prepares/changes keys and parameters
     * @param $key
     * @return array
     */
    private function prepareParams($key)
    {
        $prefix = substr($key, 0, 2);
        switch($prefix){
            case 'i:':
                $key = str_replace('i:', ':', $key);
                $param = \PDO::PARAM_INT;
                break;
            case 'b:':
                $key = str_replace('b:', ':', $key);
                $param = \PDO::PARAM_BOOL;
                break;
            case 'f:':
                $key = str_replace('f:', ':', $key);
                $param = \PDO::PARAM_STR;
                break;
            case 's:':
                $key = str_replace('s:', ':', $key);
                $param = \PDO::PARAM_STR;
                break;
            case 'n:':
                $key = str_replace('n:', ':', $key);
                $param = \PDO::PARAM_NULL;
                break;
            default:
                $param = \PDO::PARAM_STR;
                break;
        }
        return array($key, $param);
    }

    /**
     * Replaces any parameter placeholders in a query with the value of that parameter
     * @param string $sql
     * @param array $params
     * @return string
     */
    private function interpolateQuery($sql, $params = array())
    {
        $keys = array();
        if(!is_array($params)) return $sql;

        // build regular expression for each parameter
        foreach($params as $key => $value){
            if (is_string($key)) {
                $keys[] = '/:'.$key.'/';
            }else{
                $keys[] = '/[?]/';
            }
        }

        return preg_replace($keys, $params, $sql, 1, $count);
    }

    function enumValues( $table, $field ){
        $enum = array();
        $type = $this->select( "SHOW COLUMNS FROM {$table} WHERE Field = '{$field}'")->row();
        preg_match('/^enum\((.*)\)$/', $type['Type'], $matches);
        foreach( explode(',', $matches[1]) as $value )
        {
            $enum[] = trim( $value, "'" );
        }
        return $enum;
    }

    function getColumns($table){
        $sql = 'SHOW COLUMNS FROM ' . $table;
        $names = array();
        $db = $this->prepare($sql);

        try {
            if($db->execute()){
                $raw_column_data = $db->fetchAll();

                foreach($raw_column_data as $outer_key => $array){
                    foreach($array as $inner_key => $value){

                        if ($inner_key === 'Field'){
                            if (!(int)$inner_key){
                                $names[] = $value;
                            }
                        }
                    }
                }
            }
            return $names;
        } catch (\Exception $e){
            return $e->getMessage(); //return exception
        }
    }
}