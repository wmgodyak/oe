<?php
namespace system\core\validators;

use system\core\ValidatorInterface;

/**
 * Class Integer
 * Determine if the provided value is a valid number or numeric string.
 *
 * Usage: '<field>' => 'numeric'
 * @package system\core\validators
 */
class Integer implements ValidatorInterface
{
    public function validate($input)
    {
        if (empty($input)) {
            return false;
        }

        return filter_var($input, FILTER_VALIDATE_INT) === true;
    }
}