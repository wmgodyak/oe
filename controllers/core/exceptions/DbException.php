<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 02.03.16 : 9:47
 */

namespace controllers\core\exceptions;

defined("CPATH") or die();

class DbException extends \Exception
{
    // Переопределим исключение так, что параметр message станет обязательным
    public function __construct($message, $code = 0, \Exception $previous = null) {

        parent::__construct($message, $code, $previous);
    }

    // Переопределим строковое представление объекта.
    public function __toString() {
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
        return parent::__toString();
    }
}