<?php

namespace system\core;

class Validator
{
     /**
     * List of error messages
     * @var array
     */
    private $error_messages = [];
    /**
     * @var array
     */
    private $custom_field_names = [];
    /**
     * @var array
     */
    private $errors = [];
    /**
     * @var array
     */
    private $validators = [];

    private $validation_methods = [];

    private $ns = "system\\core\\validators\\";

    public function __construct($error_messages = [])
    {
        $this->error_messages = $error_messages;

        // get validators
        $path = str_replace("\\", DIRECTORY_SEPARATOR, $this->ns);
        if ($handle = opendir(DOCROOT . $path)) {
            while (false !== ($controller = readdir($handle))) {
                if ($controller != "." && $controller != "..") {

                    $controller = str_replace('.php', '', $controller);
                    $c = $this->ns . $controller;
                    $this->validators[$controller] = new $c;

                }
            }
            closedir($handle);
        }
    }

    public function run(array $data, $rules = [])
    {
        $this->errors = [];

        foreach ($rules as $field => $_rules) {

            $_rules = explode('|', $_rules);

            if (isset($data[$field]) && !is_array($data[$field])) {

                foreach ($_rules as $rule) {

                    $validator  = $rule;
                    $action     = 'validate';
                    $value      = $data[$field];
                    $params = [$value];

                    if (strstr($rule, ',') !== false) {

                        $params = explode(',', $rule);
                        $validator = array_shift($params);
                        array_unshift($params, $value);
                    }

                    $validator_name = ucfirst($validator);
                    if(strpos($validator_name, '_') !== false){
                        $a = explode('_', $validator_name);
                        $validator_name = "";
                        foreach ($a as $k=>$v) {
                            $validator_name .= ucfirst($v);
                        }
                    }

                    if(isset($this->validators[$validator_name])){

                        d($validator_name); d($params);

                        $result = call_user_func_array([$this->validators[$validator_name], $action], $params);

                        if( ! $result ){
                            $this->errors[] =
                                [
                                    'field' => $field,
                                    'rule'  => $validator,
                                    'value' => $value,
                                ];
                        }
                    } elseif(isset($this->validation_methods[$validator_name])) {
                        $result = call_user_func_array($this->validation_methods[$validator_name], $params);

                        if($result === false) {
                            $this->errors[] = [
                                'field' => $field,
                                'rule'  => $validator,
                                'value' => $value,
                            ];
                        }
                    } else {
                        throw new \Exception("Validator '$validator_name' does not exist.");
                    }
                }
            }
        }
    }

    /**
     * get instance and run validation
     * @param array $data
     * @param array $rules
     * @return mixed
     */
    public static function make(array $data, $rules = [])
    {
        $valiator = new static();

        return $valiator->run($data, $rules);
    }

    public function setErrorMessage($rule, $message)
    {
        $this->error_messages[$rule] = $message;
    }

    /**
     * @param bool $to_string
     * @param string $symbol_l
     * @param string $symbol_r
     * @return array|string
     */
    public function getErrors($to_string = false, $symbol_l = "<li>", $symbol_r = "</li>")
    {
        $res = array();

        $messages = $this->error_messages;

        foreach ($this->errors as $e)
        {
            $field = ucwords(str_replace(array('_', '-'), chr(32), $e['field']));
            $value = $e['value'];

            if (array_key_exists($e['field'], $this->custom_field_names)) {
                $field = $this->custom_field_names[$e['field']];

                if (array_key_exists($value, $this->custom_field_names)) {
                    $value = $this->custom_field_names[$e['param']];
                }
            }

            // Messages
            if (isset($messages[$e['rule']])) {
                // Show first validation error and don't allow to be overwritten
                if (!isset($res[$e['field']])) {
                    if (is_array($value)) {
                        $value = implode(', ', $value);
                    }

                    $message = str_replace
                    (
                        ['{value}', '{field}'],
                        [$value, $field],
                        $messages[$e['rule']]
                    );

                    $res[$e['field']] = $message;
                }
            } else {
                $res[$e['field']] = 'Rule "'.$e['rule'].'" does not have an error message';
            }
        }

        if($to_string){
            $out = "";
            foreach ($res as $k=>$v){
                $out .= "$symbol_l $v $symbol_r";
            }

            return $out;
        }

        return $res;
    }


    public function setFieldName($field, $name)
    {
        $this->custom_field_names[$field] = $name;
    }


    public function __toString()
    {
       return $this->getErrors(true);
    }
}