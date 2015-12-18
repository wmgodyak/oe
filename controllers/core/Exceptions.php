<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 03.05.14 21:59
 */

namespace controllers\core;

defined('CPATH') or die();

class Exceptions extends \Exception{
    protected $message = 'Unknown exception';   // Сообшение
    private   $string;                          // Свойство для __toString
    protected $code = 0;                        // Код исключения,

    // определяемый пользователем
    protected $file;                            // Файл в котором было

    // выброшено исключение
    protected $line;                            // Строка в которой было

    // выброшено исключение
    private   $trace;                           // Трассировка вызовов методов и функций

    private   $previous;                        // Предыдущее исключение, для
    // вложенных блоков try


    public function __construct($message, $code = 0, \Exception $previous = null){
        parent::__construct($message, $code, $previous);
    }

    public function __toString() {
        return __CLASS__ . ": [{$this->code}]: {$this->message}\n";
    }

    public function showError(){
        $out = "<style>pre code{}</style>";

        $out .= "<pre>ERROR: #{$this->getCode()} <br>
                      MESSAGE: {$this->getMessage()} <br>
                      IN: {$this->getFile()} <br>
                      ON LINE: {$this->getLine()}
                 </pre>";

        return $out;
    }


} 