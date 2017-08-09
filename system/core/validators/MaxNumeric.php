<?php
namespace system\core\validators;

use system\core\ValidatorInterface;

/**
 * Class MaxNumeric
 * Determine if the provided numeric value is lower or equal to a specific value.
 *
 * Usage: '<index>' => 'max_numeric,50'
 * @package system\core\validators
 */
class MaxNumeric implements ValidatorInterface
{
    private $max;

    public function __construct($max)
    {
        $this->max = $max;
    }

    public function validate($input)
    {
        if (empty($input)) {
            return false;
        }

        return is_numeric($input) && is_numeric($this->max) && ($input <= $this->max);
    }

    public function getErrorMessage()
    {
        return "The {field} field needs to be a numeric value, equal to, or lower than {param}";
    }
}