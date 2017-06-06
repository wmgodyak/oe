<?php
namespace system\core\validators;

use system\core\ValidatorInterface;

/**
 * Class Required
 * @package system\core\validators
 */
class Email implements ValidatorInterface
{
    public function validate($email)
    {
        if (empty($email)) {
            return false;
        }

        return filter_var($email, FILTER_VALIDATE_EMAIL);
    }
}