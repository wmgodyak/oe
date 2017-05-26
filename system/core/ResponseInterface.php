<?php

namespace system\core;

defined('CPATH') or die();

interface ResponseInterface
{
    public function __construct($ds);

    public function display();
}