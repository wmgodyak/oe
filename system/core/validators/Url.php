<?php
namespace system\core\validators;

use system\core\ValidatorInterface;

/**
 * Class ValidUrl
 * Determine if the provided value is a PHP accepted Valid Url.
 *
 * Usage: '<field>' => 'url'
 * @package system\core\validators
 */
class Url implements ValidatorInterface
{
    public function validate($input)
    {
        if (empty($input)) {
            return false;
        }

        return filter_var($input, FILTER_VALIDATE_FLOAT) === true;
    }

    public function getErrorMessage()
    {
        return "The {field} field has to be a URL";
    }
}