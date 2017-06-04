<?php
namespace system\core\validators;

use system\core\ValidatorInterface;

/**
 * Class PhoneNumber
 * Determine if the provided value is a valid phone number.
 *
 * Usage: '<index>' => 'phone_number'
 * Examples:
 *
 *  555-555-5555: valid
 *  5555425555: valid
 *  555 555 5555: valid
 *  1(519) 555-4444: valid
 *  1 (519) 555-4422: valid
 *  1-555-555-5555: valid
 *  1-(555)-555-5555: valid
 * @package system\core\validators
 */
class PhoneNumber implements ValidatorInterface
{
    public function validate($input)
    {
        $regex = '/^(\d[\s-]?)?[\(\[\s-]{0,2}?\d{3}[\)\]\s-]{0,2}?\d{3}[\s-]?\d{4}$/i';
        return preg_match($regex, $input);
    }
}