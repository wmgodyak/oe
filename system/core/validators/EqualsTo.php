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
        d($val);
        $this->val = $val;
    }

    public function validate($input)
    {
        if (empty($input)) {
            return false;
        }
        dd($input);
        return $input == $this->val;
    }
}