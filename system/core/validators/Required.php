<?php
namespace system\core\validators;

use system\core\ValidatorInterface;

/**
 * Class Required
 * @package system\core\validators
 */
class Required implements ValidatorInterface
{
    public function validate($data)
    {
        d($data);
        return false;
    }
}