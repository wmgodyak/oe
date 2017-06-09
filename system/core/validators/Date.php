<?php
namespace system\core\validators;

use system\core\ValidatorInterface;

/**
 * Class Date
 * Determine if the provided input is a valid date (ISO 8601).
 *
 * Usage: '<index>' => 'date'
 * @package system\core\validators
 */
class Date implements ValidatorInterface
{
    /**
     * @param $input date ('Y-m-d') or datetime ('Y-m-d H:i:s')
     * @return bool
     */
    public function validate($input)
    {
        $cdate1 = date('Y-m-d', strtotime($input));
        $cdate2 = date('Y-m-d H:i:s', strtotime($input));

        return $cdate1 != $input && $cdate2 != $input;
    }

    public function getErrorMessage()
    {
        return "The {field} must be a valid date";
    }
}