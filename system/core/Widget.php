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

//    protected $template;

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

//        $this->template = Template::getInstance();
    }

    /**
     * @param array $data
     * @return string
     */
    public function form($data = [])
    {
        return "<span class='empty'>This widget do not have options.</span>";
    }

    /**
     * Generate form field name
     * @param $name
     * @return string
     */
    public final function getFieldName($name)
    {
        if ($pos = strpos( $name, '[' ) === false){
            return 'data[' . $name . ']';
        } else {
            return 'data[' . substr_replace( $name, '][', $pos, strlen( '[' ) );
        }
    }

    /**
     * generate form field ID
     * @param $name
     * @return string
     */
    public final function getFieldID($name)
    {
        return 'data_' . $name;
    }

    /**
     * @param array $args
     * @param array $data
     * @return mixed
     */
    abstract public function display($args, $data);

    public function __toString()
    {
        return $this->id;
    }

    /**
     * @return array
     */
    public function getMeta()
    {
        return [
            'id'          => $this->id,
            'name'        => $this->name,
            'description' => $this->description
        ];
    }

    public function getName()
    {
        return $this->name;
    }
}