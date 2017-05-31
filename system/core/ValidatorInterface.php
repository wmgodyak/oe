<?php
namespace system\core;

interface ValidatorInterface
{
    public function getError();
    public function validate($data);
}