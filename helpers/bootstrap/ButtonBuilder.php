<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 13.01.16 : 17:23
 */


namespace helpers\bootstrap;


defined("CPATH") or die();
/**
 * Class ButtonBuilder
 * @package helpers\bootstrap
 */
abstract class ButtonBuilder
{
    const TYPE_PRIMARY 	= 'btn-primary';
    const TYPE_INFO 	= 'btn-info';
    const TYPE_SUCCESS 	= 'btn-success';
    const TYPE_WARNING 	= 'btn-warning';
    const TYPE_DANGER 	= 'btn-danger';
    const TYPE_INVERSE 	= 'btn-inverse';
    const TYPE_LINK 	= 'btn-link';
    const TYPE_DEFAULT	= '';

    const SIZE_LARGE	= 'btn-large';
    const SIZE_SMALL	= 'btn-small';
    const SIZE_MINI		= 'btn-mini';
    const SIZE_DEFAULT	= '';

    const WIDTH_BLOCK 	= 'btn-block';
    const WIDTH_DEFAULT = '';

    protected $text;
    protected $icon;
    protected $args;
    protected $type = 'button'; // or link

    /**
     * ButtonBuilder constructor.
     * @param $text
     * @param array $args
     * @param null $icon
     * @param string $type
     */
    function __construct($text, array $args, $icon = null, $type = 'button')
    {
        $this->text = $text;
        $this->args = $args;
        $this->icon = $icon;
        $this->type = $type;
    }

    /**
     * @param $text
     * @return $this
     */
    public function text($text)
    {
        $this->text = $text;

        return $this;
    }

    /**
     * @param $args
     * @return $this
     */
    public function args($args)
    {
        $this->args = $args;

        return $this;
    }


    /**
     * @return string
     */
    private function parseArgs()
    {
        $attr = '';

        if(empty($this->args)) return '';

        foreach ($this->args as $key => $val){

            if(empty($val) or is_array($val)) continue;

            if($key == 'class'){
                $val .= ' btn';
            }

            $attr .= ' '.$key.'="'.$val.'"';
        }

        return $attr;
    }

    function __toString()
    {
//        echo '<pre>'; print_r($this);
        $args = $this->parseArgs();


        if($this->type == 'button'){
            $out = "<button {$args}>{$this->icon}{$this->text}</button>";
        } else {
            $out = "<a {$args}>{$this->icon} {$this->text}</a>";
        }
        return $out;
    }
}