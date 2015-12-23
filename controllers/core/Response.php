<?php
/**
 * Company Otakoyi.com
 * Author: wg
 * Date: 22.04.15 23:00
 */

namespace controllers\core;

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
    public static function instance()
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
        $body = '';
        switch($this->ct){
            case 'text/html':
                $body = $this->body;
                break;
            case 'text/plain':
                $body = $this->body;
                break;

            case 'json':
                header('Content-Type: application/json');
                $body = json_encode($this->body);
                break;

            default:
                header('Content-Type: text/html');
                if(!empty($this->body)){
                    Template::instance()->assign('body', $this->body);
                    $body = Template::instance()->fetch('index');
                }
                break;
        }

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

        $this->render();
    }
    public function asPlainText()
    {
        $this->ct = 'text/plain';

        $this->render();
    }

    public function asJSON()
    {
        $this->ct = 'json';

        $this->render();
    }

    public function asXML()
    {
        $this->ct = 'xml';

        $this->render();
    }

    /**
     * @param $code
     * @param bool|false $die
     */
    public function sendError($code, $die = false)
    {
        if ($code !== NULL) {

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

            $GLOBALS['http_response_code'] = $code;

        } else {

            $code = (isset($GLOBALS['http_response_code']) ? $GLOBALS['http_response_code'] : 200);

        }

        echo $code; $die ? die() : null;
    }
} 