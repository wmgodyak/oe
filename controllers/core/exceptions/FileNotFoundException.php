<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 13.01.16 : 10:00
 */

namespace controllers\core\exceptions;

defined("CPATH") or die();

class FileNotFoundException extends \Exception
{
    public function __construct($message, $code = 0, \Exception $previous = null) {
        echo '
        <style>
        pre {
            font-family: "Courier New", Courier, monospace, sans-serif; text-align: left;
            line-height: 1.6em;
            font-size: 14px;
            padding: 0 0.5em 0.3em 0.7em;
            border-left: 11px solid #ccc;
            margin: 1em 0 1.7em 0.3em;
            overflow: auto;
            width: 93%;
            }
        /* target IE7 and IE6 */
        *:first-child+html pre {
            padding-bottom: 2em;
            overflow-y: hidden;
            overflow: visible;
            overflow-x: auto;
            }
        * html pre {
            padding-bottom: 2em;
            overflow: visible;
            overflow-x: auto;
            }
        </style>
        <pre>';
        parent::__construct($message, $code, $previous);
    }

    public function __toString() {

        return __CLASS__ . ": [{$this->code}]: {$this->message}\n";
    }

    public function customFunction() {
        echo "Мы можем определять новые методы в наследуемом классе\n";
    }
}