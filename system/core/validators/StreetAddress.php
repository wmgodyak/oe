<?php
namespace system\core\validators;

use system\core\ValidatorInterface;

/**
 * Class StreetAddress
 * Determine if the provided input is likely to be a street address using weak detection.
 *
 * Usage: '<index>' => 'street_address'
 * @package system\core\validators
 */
class StreetAddress implements ValidatorInterface
{
    public function validate($input)
    {
        // Theory: 1 number, 1 or more spaces, 1 or more words
        $hasLetter = preg_match('/[a-zA-Zа-яА-Я]/', $input);
        $hasDigit = preg_match('/\d/', $input);
        $hasSpace = preg_match('/\s/', $input);

        return $hasLetter && $hasDigit && $hasSpace;
    }

    public function getErrorMessage()
    {
        return "The {field} field needs to be a valid street address";
    }
}