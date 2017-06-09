<?php
namespace system\core\validators;

use system\core\ValidatorInterface;

/**
 * Class ValidCc
 * Determine if the input is a valid credit card number.
 *
 * See: http://stackoverflow.com/questions/174730/what-is-the-best-way-to-validate-a-credit-card-in-php
 * Usage: '<index>' => 'cc'
 * @package system\core\validators
 */
class Cc implements ValidatorInterface
{
    public function validate($input)
    {
        $number = preg_replace('/\D/', '', $input);

        if (function_exists('mb_strlen')) {
            $number_length = mb_strlen($number);
        } else {
            $number_length = strlen($number);
        }

        $parity = $number_length % 2;

        $total = 0;
        for ($i = 0; $i < $number_length; ++$i) {
            $digit = $number[$i];
            if ($i % 2 == $parity) {
                $digit *= 2;
                if ($digit > 9) {
                    $digit -= 9;
                }
            }
            $total += $digit;
        }

        return $total % 10 == 0;
    }

    public function getErrorMessage()
    {
        return "The {field} is not a valid credit card number";
    }
}