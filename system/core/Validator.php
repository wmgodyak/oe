<?php

namespace system\core;

class Validator
{
    /*
     * functions to must be
     * set_field_name
     */

    private $translations = [];
    private $errors = [];
    private $rules  = [];

    private $validators = [];

    private $validation_methods = [];

    private $ns = "system\\core\\validators\\";

    public function __construct()
    {
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

    public function rules(array $rules = [])
    {
        // todo sanitize input data
    }

    public function run(array $data, $rules = [])
    {
        $rules = array_merge($this->rules, $rules);

        $this->rules  = [];
        $this->errors = [];

        foreach ($rules as $field => $_rules) {

            $_rules = explode('|', $_rules);

            if (isset($data[$field]) && !is_array($data[$field])) {

                foreach ($_rules as $rule) {

                    $validator  = $rule;
                    $action     = 'validate';
                    $param      = $data[$field];

                    if (strstr($rule, ',') !== false) {

                        $rule      = explode(',', $rule);
                        $validator = $rule[0];
                        $param     = $rule[1];
                        $rule      = $rule[0];

                        if (preg_match('/(?:(?:^|;)_([a-z_]+))/', $param, $matches)) {

                            if (isset($data[$matches[1]])) {
                                $param = str_replace('_'.$matches[1], $data[$matches[1]], $param);
                            }

                        }

                    }

                    $validator_name = lcfirst($validator);

                    if(isset($this->validators[$validator_name])){
                        $result = call_user_func([$this->validators[$validator_name], $action], $param);

                        if( ! $result ){
                            $this->errors[] =
                                [
                                    'field' => $field,
//                                    'value' => $data,
                                    'rule'  => $rule,
                                    'param' => $param,
                                ];
                        }
                    } elseif(isset($this->validation_methods[$rule])) {
                        $result = call_user_func($this->validation_methods[$rule], $field, $data, $param);

                        if($result === false) {
                            $this->errors[] = [
                                'field' => $field,
//                                'value' => $data,
                                'rule'  => $rule,
                                'param' => $param,
                            ];
                        }
                    } else {
                        throw new \Exception("Validator '$validator' does not exist.");
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

    public function getErrors($to_string = false)
    {

    }

    public function __toString()
    {
        // todo get errors converted to string
        return '';
    }
}