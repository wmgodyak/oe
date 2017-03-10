<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 21.06.16 : 17:35
 */

namespace system\models;

use system\core\Session;

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
    /**
     * Images model
     * @var Images
     */
    public $images;

    protected $app;

    public function __construct()
    {
        parent::__construct();

        $this->languages = new Languages();

        $this->languages_id = $this->defileLanguageId();

        $this->images    = new Images();
        $this->app       = App::getInstance();
    }

    /**
     * detect languages id by request uri or set if empty
     * @return array|mixed|null
     */
    public function defileLanguageId()
    {
        $id = $this->request->param('languages_id');
        if(!empty($id)) return $id;

        $args = $this->request->param();

        if(isset($args['lang'])) {
            // selected language
            $id = $this->languages->getDataByCode($args['lang'], 'id');
        } elseif(!empty($args['controller'])){
            $id = Session::get('app.languages_id');
        }

        if(empty($id)){
            $id = $this->languages->getDefault('id');
        }

        $this->request->param('languages_id', $id);

        return $id;
    }
}