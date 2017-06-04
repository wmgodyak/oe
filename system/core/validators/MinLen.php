<?php
namespace system\core\validators;

use system\core\ValidatorInterface;

/**
 * Class Required
 * @package system\core\validators
 */
class MinLen implements ValidatorInterface
{
    private $min_val;

    public function __construct($min_val)
    {
        $this->min_val = $min_val;
    }

    public function validate($input)
    {
        if (empty($input)) {
            return false;
        }

        if (function_exists('mb_strlen')) {
            if (mb_strlen($input) >= (int) $this->min_val) {
                return true;
            }
        }

        if (strlen($input) >= (int) $this->min_val) {
            return true;
        }

        return false;
    }
}