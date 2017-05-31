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

    public function __construct()
    {
        // todo read all validators and save it to
    }

    public function rules(array $rules = [])
    {
        // todo sanitize input data
    }

    public function getErrors()
    {

    }

    public function run(array $data, $rules = [])
    {
        $this->errors = [];

        foreach ($rules as $field => $_rules) {

            $_rules = explode('|', $_rules);

            $lookFor = ['required'];

            if (count(array_intersect($lookFor, $_rules)) > 0 || (isset($data[$field]) && !is_array($data[$field]))) {
                foreach ($_rules as $rule) {

                    $controller = null;
                    $action     = 'validate';
                    $param      = [];

                    // Check if we have rule parameters
                    if (strstr($rule, ',') !== false) {
                        $rule   = explode(',', $rule);
                        $controller = $rule[0];
                        $param  = $rule[1];
                        $rule   = $rule[0];

                        // If there is a reference to a field
                        if (preg_match('/(?:(?:^|;)_([a-z_]+))/', $param, $matches)) {

                            // If provided parameter is a field
                            if (isset($data[$matches[1]])) {
                                $param = str_replace('_'.$matches[1], $data[$matches[1]], $param);
                            }
                        }
                    } else {
                        $controller = $rule;
                    }

                    //self::$validation_methods[$rule] = $callback;

                    d($controller);d($param);die;

                    if (is_callable(array($this, $controller))) {
                        $result = $this->$method(
                            $field, $data, $param
                        );

                        if (is_array($result)) {
                            $this->errors[] = $result;
                        }
                    } elseif(isset(self::$validation_methods[$rule])) {
                        $result = call_user_func(self::$validation_methods[$rule], $field, $data, $param);

                        if($result === false) {
                            $this->errors[] = array(
                                'field' => $field,
                                'value' => $data,
                                'rule' => $rule,
                                'param' => $param,
                            );
                        }
                    } else {
                        throw new \Exception("Validator method '$method' does not exist.");
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
}