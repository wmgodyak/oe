<?php
namespace system\core\validators;

use system\core\ValidatorInterface;

/**
 * Class Required
 * @package system\core\validators
 */
class Between // implements ValidatorInterface
{
    public function validate($data, $min, $max)
    {
        return false;
    }
}