<?php
namespace system\core\validators;

use system\core\ValidatorInterface;

/**
 * Class Boolean
 * Determine if the provided value is a PHP accepted boolean.
 *
 * Usage: '<field>' => 'boolean'
 * @package system\core\validators
 */
class Boolean implements ValidatorInterface
{
    public function validate($input)
    {
        if (empty($input)) {
            return false;
        }

        $booleans = array('1', 'true', true, 1, '0', 'false', false, 0, 'yes', 'no', 'on', 'off');
        return in_array($input, $booleans, true );
    }
}