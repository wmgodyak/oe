<?php

namespace system\core;

/**
 * Class Languages
 * @package system\core
 */
class Languages
{
    private static $instance;
    private $request;
    public $languages;


    public $id;
    public $code;
    public $name;
    public $is_main;

    private function __construct()
    {
        $this->request = Request::getInstance();
        $this->languages = new \system\models\Languages();

        $args = $this->request->param();

        if(isset($args['lang'])) {
            // Selected language
            $language = $this->languages->getDataByCode($args['lang']);
        } else {
            $id = Session::get('app.languages_id');

            if(empty($id)){
                $language = $this->languages->getDefault();
            }
        }

        if(empty($language)){
            $language = $this->languages->getDefault();
        }

        $this->reset($language);
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

        // update request and session
        $_SESSION['app'] = [
            'languages_id'   => $this->id,
            'languages_code' => $this->code
        ];
    }

}