<?php
namespace system\core\validators;

use system\core\ValidatorInterface;

/**
 * Class ValidUrl
 * Determine if the provided value is a PHP accepted ValidUrl.
 *
 * Usage: '<field>' => 'valid_url'
 * @package system\core\validators
 */
class ValidUrl implements ValidatorInterface
{
    public function validate($input)
    {
        if (empty($input)) {
            return false;
        }

        return filter_var($input, FILTER_VALIDATE_FLOAT) === true;
    }
}