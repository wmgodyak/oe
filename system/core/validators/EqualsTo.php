<?php
namespace system\core\validators;

use system\core\ValidatorInterface;

/**
 * Class EqualsTo
 * @package system\core\validators
 */
class EqualsTo implements ValidatorInterface
{
    private $val;

    public function __construct($val)
    {
        $this->val = $val;
    }

    public function validate($input)
    {
        if (empty($input)) {
            return false;
        }

        return $input == $this->val;
    }

    public function getErrorMessage()
    {
        return "The {field} field must be equals to password";
    }
}