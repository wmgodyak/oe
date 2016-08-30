<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 13.01.16 : 14:43
 */

namespace helpers\bootstrap;

defined("CPATH") or die();


/**
 * Class IconBuilder
 * @package helpers\bootstrap
 */
abstract class IconBuilder
{

    const TYPE_INSTALL      = 'fa-toggle-on';
    const TYPE_UNINSTALL    = 'fa-toggle-off';
    const TYPE_PUBLISHED    = 'fa-eye';
    const TYPE_HIDDEN       = 'fa-eye-slash';
    const TYPE_CROP         = 'fa-crop';
    const TYPE_EDIT         = 'fa-pencil';
    const TYPE_DELETE       = 'fa-remove';
    const TYPE_TRASH        = 'fa-trash';
    const TYPE_TRASH_EMPTY  = 'fa-trash-o';
    const TYPE_BAN          = 'fa-ban';
    const TYPE_REPLY        = 'fa-reply';
    const TYPE_RESTORE      = 'fa-repeat';
    const TYPE_SETTINGS     = 'fa-cog';

    protected $type;
    protected $white;

    /**
     * IconBuilder constructor.
     * @param $type
     * @param bool $white
     */
    function __construct($type, $white = false)
    {
        $this->type  = $type;
        $this->white = $white;
    }

    /**
     * @param $type
     * @return $this
     */
    public function type($type)
    {
        $this->type = $type;

        return $this;
    }

    /**
     * @param $white
     * @return $this
     */
    public function white($white)
    {
        $this->white = $white;

        return $this;
    }

}

/**
 * Class Button
 * @package helpers\bootstrap
 */
class Icon extends IconBuilder
{
    public static function create($type, $white = false)
    {
        $class = __CLASS__;
        return new $class($type, $white);
    }


    function __toString()
    {
        $white = $this->white ? 'icon-white' : '';
        return "<i class=\"fa {$this->type}{$white}\"></i>";
    }

}