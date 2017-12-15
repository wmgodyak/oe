<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 21.06.16 : 17:35
 */

namespace system\models;

defined("CPATH") or die();

/**
 * Class Frontend
 * @package system\models
 */
class Frontend extends Model
{
    /**
     * @var
     */
    public $languages;
    /**
     * Page info
     * @var array
     */
    protected $page;

    protected $app;

    protected $debug;

    public function __construct()
    {
        parent::__construct();

        $this->languages = new Languages();

        $this->app       = App::getInstance();
        $this->languages = \system\core\Languages::getInstance();
    }

    public function debug($status = 1)
    {
        $this->debug = $status;

        return $this;
    }

}