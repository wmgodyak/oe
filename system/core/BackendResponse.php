<?php
namespace system\core;

class BackendResponse implements ResponseInterface
{
    private $ds;

    public function __construct($ds)
    {
        $this->ds = $ds;
    }

    public function display()
    {
        echo $this->ds;die;
    }
}