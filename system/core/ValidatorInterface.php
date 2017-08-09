<?php
namespace system\core;

interface ValidatorInterface
{
    public function validate($input);
    public function getErrorMessage();
}