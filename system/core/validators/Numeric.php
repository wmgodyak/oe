<?php
namespace system\core\validators;

use system\core\ValidatorInterface;

/**
 * Class AlphaNumeric
 * Determine if the provided value is a valid number or numeric string.
 *
 * Usage: '<field>' => 'numeric'
 * @package system\core\validators
 */
class Numeric implements ValidatorInterface
{
    public function validate($input)
    {
        if (empty($input)) {
            return false;
        }

        return is_numeric($input);
    }
}