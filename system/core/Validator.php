<?php

namespace system\core;
/**
 * Class Validator
 *
 * Examples
 * $data = [
    'name'=> 'a',
    'surname' => '',
    'age' => 10,
    'email' => "me@dot.com"
    ];

$validator = new Validator(t('validator'));

$validator->addMethod
(
'min_age',
function($value, $min_value)
{
return $value > $min_value;
}
, "You are too young"
);

$validator->run
(
$data,
[
'name' => 'required',
'email' => 'required|valid_email',
'age' => 'min_age, 18|between, 4, 6',
]
);

dd($validator->getErrors());
 * Result
Array
(
    [email] => The Email field must be a valid email address
    [age] => You are too young
)
 * @package system\core
 */
class Validator
{
     /**
     * List of error messages
     * @var array
     */
    private $error_messages = [];

    /**
     * Custom fields names. You can override default field name to custom.
     * @var array
     */
    private $custom_field_names = [];

    /**
     * Validation errors
     * @var array
     */
    private $errors = [];

    /**
     * custom validation methods
     * @var array
     */
    private $validation_methods = [];

    private $ns = "system\\core\\validators\\";

    public function __construct($error_messages = [])
    {
        if(empty($error_messages)) return;

        $this->error_messages = $error_messages;
    }

    /**
     * @param array $data
     * @param array $rules
     * @return bool
     * @throws \Exception
     */
    public function run(array $data, $rules = [])
    {
        $this->errors = [];
        $path = str_replace("\\", DIRECTORY_SEPARATOR, $this->ns);

        foreach ($rules as $field => $_rules) {

            if (is_string($_rules)) {
                $_rules = explode('|', $_rules);
            }

            foreach ($_rules as $rule) {

                $validator  = $rule;
                $action     = 'validate';
                $value      = $this->getValue($data, $field);
                $params = [$value];

                if (strstr($rule, ',') !== false) {

                    $params = explode(',', $rule);
                    $validator = array_shift($params);
                    array_unshift($params, $value);
                }

                if (!empty($this->validation_methods[$validator])) {
                    $result = call_user_func_array($this->validation_methods[$validator], $params);

                    if ($result === false) {

                        $this->errors[] = [
                            'field' => $field,
                            'rule'  => $validator,
                            'value' => $value,
                        ];

                    }

                    continue;
                }

                $validator_name = ucfirst($validator);
                if (strpos($validator_name, '_') !== false) {
                    $a = explode('_', $validator_name);
                    $validator_name = "";
                    foreach ($a as $k=>$v) {
                        $validator_name .= ucfirst($v);
                    }
                }

                if (file_exists(DOCROOT . $path . $validator_name . '.php')){

                    $c = $this->ns . $validator_name;

                    $input = array_shift($params);

                    $controller = new $c(... $params);
                    $result = call_user_func([$controller, $action], $input);

                    if (!$result) {

                        if (empty($this->error_messages[$validator])) {
                            $this->error_messages[$validator] = call_user_func([$controller, 'getErrorMessage']);
                        }

                        $this->errors[] =
                            [
                                'field' => $field,
                                'rule'  => $validator,
                                'value' => $value,
                            ];

                    }

                    continue;
                }

                throw new \Exception("Validator '$validator_name' does not exist.");
            }
        }

        return empty($this->errors);
    }

    /**
     * Get value from given data
     * @param $data
     * @param $field
     * @param null $default
     * @return null
     */
    public function getValue($data, $field, $default = null)
    {
        if (isset($data[$field]) && is_array($data[$field]))
            return $default;

        $value = isset($data[$field]) ? $data[$field] : $default;

        return $value;
    }

    /**
     * Get instance of validator and run validation
     * @param array $data
     * @param array $rules
     * @param array $error_messages
     * @return mixed
     * @throws \Exception
     */
    public static function make(array $data, array $rules, array $error_messages = [])
    {
        $validator = new static($error_messages);

        return $validator->run($data, $rules);
    }

    public function runOrDie(array $data, $rules = [])
    {
        $valid = $this->run($data, $rules);
        if( ! $valid ){
            if( Request::getInstance()->isXhr()){
                Response::getInstance()->body(['errors' => $this->getErrors()])->display();
            }
        }
    }

    /**
     * Override or add custom error message
     * @param $rule
     * @param $message
     */
    public function setErrorMessage($rule, $message)
    {
        $this->error_messages[$rule] = $message;
    }

    /**
     * Get validation errors
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

            if (isset($messages[$e['rule']])) {
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

    /**
     * Override field name
     * @param $field
     * @param $name
     * @return $this
     */
    public function setFieldName($field, $name)
    {
        $this->custom_field_names[$field] = $name;

        return $this;
    }


    public function __toString()
    {
       return $this->getErrors(true);
    }

    /**
     * Add custom validation closure
     * @param $rule
     * @param $callback
     * @param null $message
     * @return $this
     * @throws \Exception
     */
    public function addMethod($rule, $callback, $message = null)
    {
        if(isset($this->validation_methods[$rule])){
            throw new \Exception("Validator $rule exists.");
        }

        $this->validation_methods[$rule] = $callback;

        if($message){
            $this->error_messages[$rule] = $message;
        }

        return $this;
    }
}