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
        if (is_null($data)) {
            return false;
        } elseif (is_string($data) && trim($data) === '') {
            return false;
        } elseif ((is_array($data) || $data instanceof \Countable) && count($data) < 1) {
            return false;
        }

        return true;
    }

    public function getErrorMessage()
    {
        return "The {field} field is required";
    }
}