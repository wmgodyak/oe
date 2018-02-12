<?php

namespace system\core;

/**
 * Class Languages
 * @package system\core
 */
class Languages
{
    private static $instance;
    public $languages;


    public $id;
    public $code;
    public $name;
    public $is_main;
    public $hreflang;
    public $dir;
    public $lang;

    private function __construct()
    {
        $this->languages = new \system\models\Languages();
    }

    private function __clone(){}

    /**
     * @return Languages
     */
    public static function getInstance(){

        if(self::$instance == null){
            self::$instance = new self;
        }

        return self::$instance;
    }

    /**
     * @param $id
     * @return bool
     */
    public function set($id)
    {
        $language = $this->languages->getData($id);
        if(empty($language)){
            return false;
        }

        $this->reset($language);

        return true;
    }

    /**
     * @param $code
     * @return bool
     */
    public function setByCode($code)
    {
        $language = $this->languages->getDataByCode($code);
        if(empty($language)){
            return false;
        }

        $this->reset($language);

        return true;
    }

    /**
     * @param $language
     */
    private function reset($language)
    {
        foreach ($language as $k=>$v) {
            $this->{$k} = $v;
        }

        // update request and session // todo remove it in future
        $_SESSION['app'] = [
            'languages_id'   => $this->id,
            'languages_code' => $this->code
        ];
    }

    public function __call($name, $arguments)
    {
        return call_user_func_array([$this->languages, $name], $arguments);
    }

    public function detect($request)
    {
        $uri = $request->uri;

        $language = null;

        $re = '^([a-z]{2})?(/.*)?$';

        if(preg_match("@$re@su", $uri, $matches)){

            if(isset($matches[1])){
                $lang     = $matches[1];
                $language = $this->languages->getDataByCode($lang);
            }

            if(!empty($language)){

                $request->uri = isset($matches[2]) ? ltrim($matches[2], '/') : "";

                if($language['is_main']){
                    redirect($request->uri, 302);
                }

            }
        }

        if(empty($language)){

            if (!empty($_SERVER['HTTP_X_ACCEPT_LANGUAGE'])) {

                $lang = trim($_SERVER['HTTP_X_ACCEPT_LANGUAGE']);

                if(! empty($lang)) {
                    $language = $this->languages->getDataByCode($lang);
                }
            }
        }

        if(empty($language)){
            $language = $this->languages->getDefault();
        }

        $request->language = (object)$language;

        $this->reset($language);
    }

}