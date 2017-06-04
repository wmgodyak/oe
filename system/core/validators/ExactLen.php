<?php
namespace system\core\validators;

use system\core\ValidatorInterface;

/**
 * Class Required
 * Determine if the provided value length matches a specific value.
 *
 * Usage: '<field>' => 'exact_len,5'
 * @package system\core\validators
 */
class ExactLen implements ValidatorInterface
{
    private $len;

    public function __construct($len)
    {
        $this->len = $len;
    }

    public function validate($input)
    {
        if (empty($input)) {
            return false;
        }

        if (function_exists('mb_strlen')) {
            if (mb_strlen($input) == (int) $this->len) {
                return true;
            }
        }
        
        if (strlen($input) == (int) $this->len) {
            return true;
        }

        return false;
    }
}