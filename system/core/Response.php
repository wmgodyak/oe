<?php
/**
 * Company Otakoyi.com
 * Author: wg
 * Date: 22.04.15 23:00
 */

namespace system\core;

use system\core\exceptions\Exception;
use system\models\Parser;

use MatthiasMullie\Minify;

defined("CPATH") or die();

/**
 * Class Response
 * @package controllers\core
 */
class Response
{
    private static $instance;

    /**
     * @var
     */
    private $body;

    /**
     * @var string json | text/plain
     */
    private $ct = 'text/html';

    private function __construct(){}
    private function __clone(){}
    
    /**
     * @return Response
     */
    public static function getInstance()
    {
        if(self::$instance == null){
            self::$instance = new Response;
        }

        return self::$instance;
    }

    /**
     * display content
     */
    public function render()
    {
        header('Content-Type: ' . $this->ct);

        if($this->ct == 'application/json'){
            echo json_encode($this->body); die;
        }

        $env = Config::getInstance()->get('core.environment');

        $body = $this->body;

        $mode = Request::getInstance()->getMode();

        switch($mode){
            case 'backend':
                if(! Request::getInstance()->isXhr()){
                    Template::getInstance()->assign('body', $body);

                    $scripts = Template::getInstance()->getScripts();
                    Template::getInstance()->assign('components_scripts', $scripts);

                    $styles = Template::getInstance()->getStyles();
                    Template::getInstance()->assign('components_styles', $styles);

                    $body = Template::getInstance()->fetch('index');
                }

                break;
            case 'frontend':
                $parser = new Parser($this->body);
                $body = $parser->getDocumentSource();
                if($env == 'production'){
                    $body = $this->compress($body);
                }
                break;
            default:
                throw new Exception("Wrong request mode");
                break;
        }

        $db = DB::getInstance();

        if($env == 'debugging' &&  $this->ct == 'text/html' && ! Request::getInstance()->isXhr()){
            $time = $_SERVER['REQUEST_TIME_FLOAT'];
            $q = $db->getQueryCount();

            $body.= "\r\n<!--\r\n";
            $time_end = microtime(true);
            $exec_time = round($time_end-$time, 4);
            $mu = memory_get_usage();
            $mp = 0; $mpf=0;
            if(function_exists('memory_get_peak_usage')){
                $mp = memory_get_peak_usage();
                $mpf = round(($mp / 1024) / 1024, 3);
            }
            $muf = round((memory_get_usage() / 1024) / 1024, 3);
            $ml=ini_get('memory_limit');

            if($mp > 0){
                $body.= "    Memory peak in use: $mp ($mpf M)\r\n";
            }

            $body.= "    Page generation time: ".$exec_time." seconds\r\n";
            $body.= "    Memory in use: $mu ($muf M) \r\n";
            $body.= "    Memory limit: $ml \r\n";
            $body.= "    Total queries: $q \r\n";
            $body.=  "-->";
        }

        $db->close();

        echo $body; die;
    }

    public function setHeader($header)
    {
        $this->ct = $header;
    }

    /**
     * @param $body
     * @return $this
     */
    public function body($body)
    {
        $this->body = $body;

        return $this;
    }

    public function asHtml()
    {
        $this->ct = 'text/html';
    }
    public function asPlainText()
    {
        $this->ct = 'text/plain';
    }

    public function asJSON()
    {
        header('Content-Type: application/json');
        $this->ct = 'application/json';
    }

    public function asXML()
    {
        $this->ct = 'application/xml';
    }

    /**
     * @param $code
     * @param bool|false $die
     */
    public function sendError($code, $die = false)
    {
        switch ($code) {
            case 100: $text = 'Continue'; break;
            case 101: $text = 'Switching Protocols'; break;
            case 200: $text = 'OK'; break;
            case 201: $text = 'Created'; break;
            case 202: $text = 'Accepted'; break;
            case 203: $text = 'Non-Authoritative Information'; break;
            case 204: $text = 'No Content'; break;
            case 205: $text = 'Reset Content'; break;
            case 206: $text = 'Partial Content'; break;
            case 300: $text = 'Multiple Choices'; break;
            case 301: $text = 'Moved Permanently'; break;
            case 302: $text = 'Moved Temporarily'; break;
            case 303: $text = 'See Other'; break;
            case 304: $text = 'Not Modified'; break;
            case 305: $text = 'Use Proxy'; break;
            case 400: $text = 'Bad Request'; break;
            case 401: $text = 'Unauthorized'; break;
            case 402: $text = 'Payment Required'; break;
            case 403: $text = 'Forbidden'; break;
            case 404: $text = 'Not Found'; break;
            case 405: $text = 'Method Not Allowed'; break;
            case 406: $text = 'Not Acceptable'; break;
            case 407: $text = 'Proxy Authentication Required'; break;
            case 408: $text = 'Request Time-out'; break;
            case 409: $text = 'Conflict'; break;
            case 410: $text = 'Gone'; break;
            case 411: $text = 'Length Required'; break;
            case 412: $text = 'Precondition Failed'; break;
            case 413: $text = 'Request Entity Too Large'; break;
            case 414: $text = 'Request-URI Too Large'; break;
            case 415: $text = 'Unsupported Media Type'; break;
            case 500: $text = 'Internal Server Error'; break;
            case 501: $text = 'Not Implemented'; break;
            case 502: $text = 'Bad Gateway'; break;
            case 503: $text = 'Service Unavailable'; break;
            case 504: $text = 'Gateway Time-out'; break;
            case 505: $text = 'HTTP Version not supported'; break;
            default:
                exit('Unknown http status code "' . htmlentities($code) . '"');
                break;
        }

        $protocol = (isset($_SERVER['SERVER_PROTOCOL']) ? $_SERVER['SERVER_PROTOCOL'] : 'HTTP/1.0');

        header($protocol . ' ' . $code . ' ' . $text);
        if($die) die;
    }

    /**
     * @param $buffer
     * @return mixed
     */
    private function compress($buffer)
    {
        $compile_force = Config::getInstance()->get('core.assets_compile_force');

        $template = Template::getInstance();

        $js_path = "tmp/{$template->theme}.min.js";
        $css_path = "tmp/{$template->theme}.min.css";

        $css_exists = file_exists(DOCROOT . $css_path);
        $js_exists = file_exists(DOCROOT . $js_path);

        if($compile_force || !$css_exists){

            $css = $template->getStyles();
            if(! empty($css)){

                $minifier = new Minify\CSS();

                foreach ($css as $k=>$v) {
                    $minifier->add(DOCROOT . $v);
                }

                $minifier->minify(DOCROOT . $css_path);
            }
        }

        if( $css_exists ){
            $v = filemtime(DOCROOT . $css_path);
            $css_compiled = "<link href='$css_path?_=$v' rel='stylesheet'>";
            $buffer = str_replace('</head>', "$css_compiled\n</head>", $buffer);
        }


        if($compile_force || !$js_exists){
            $js = $template->getScripts();
            if(!empty($js)){

                $minifier = new Minify\JS();

                foreach ($js as $k=>$v) {
                    $minifier->add(DOCROOT . $v);
                }

                $minifier->minify(DOCROOT . $js_path);

            }
        }

        if($js_exists){
            $v = filemtime(DOCROOT . $js_path);
            $js_compiled  = "<script src='$js_path?_=$v'></script>";
            $buffer = str_replace('</body>', "$js_compiled\n</body>", $buffer);
        }

        // minify html
        $search = array(
            '/\>[^\S ]+/s',  // strip whitespaces after tags, except space
            '/[^\S ]+\</s',  // strip whitespaces before tags, except space
            '/(\s)+/s'       // shorten multiple whitespace sequences
        );
        $replace = array(
            '>',
            '<',
            '\\1'
        );
        return preg_replace($search, $replace, $buffer);
    }

} 