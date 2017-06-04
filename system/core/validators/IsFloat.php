<?php
namespace system\core\validators;

use system\core\ValidatorInterface;

/**
 * Class IsFloat
 * Determine if the provided value is a PHP accepted IsFloat.
 *
 * Usage: '<field>' => 'is_float'
 * @package system\core\validators
 */
class IsFloat implements ValidatorInterface
{
    public function validate($input)
    {
        if (empty($input)) {
            return false;
        }

        return filter_var($input, FILTER_VALIDATE_FLOAT) === true;
    }
}