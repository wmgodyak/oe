<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 06.06.16
 * Time: 23:09
 */

namespace system\core;

/**
 * Class Widget
 * @package controllers\core
 */
abstract class Widget
{
    /**
     * item id
     * @var string
     */
    private $id;
    /**
     * item name
     * @var string
     */
    private $name;

    /**
     * item description
     * @var string
     */
    private $description;
    /**
     * item options
     * @var array
     */
    private $options = [];

    /**
     * Widget constructor.
     * @param string $id widget ID
     * @param string $name widget Name
     * @param null $description Description of widget
     * @param array $options Widget options
     */
    public function __construct($id, $name, $description = null, array $options = [] )
    {
        $this->id          = $id;
        $this->name        = $name;
        $this->description = $description;
        $this->options     = $options;
    }

    /**
     * @param array $data
     * @return string
     */
    public function form(array $data = [])
    {
        // todo підключити тут вюшку форми або результат цієї функціїї апихати в форму
        return "<span class='empty'>This widget do not have options.</span>";
    }

    /**
     * update form data
     */
    public final function update()
    {

    }

    /**
     * Generate form field name
     * @param $name
     * @return string
     */
    public final function getFieldName($name)
    {
        if ($pos = strpos( $name, '[' ) === false){
            return 'widget_' . $this->id . '[' . $name . ']';
        } else{
            return 'widget_' . $this->id . '[' . substr_replace( $name, '][', $pos, strlen( '[' ) );
        }
    }

    /**
     * generate form field ID
     * @param $name
     * @return string
     */
    public final function getFieldID($name)
    {
        return 'widget_' . $this->id . '_' . $name;
    }

    /**
     * @param array $args
     * @param array $data
     * @return mixed
     */
    abstract public function display(array $args = [], array $data = []);
}