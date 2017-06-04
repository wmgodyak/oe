<?php
namespace system\core\validators;

use system\core\ValidatorInterface;

/**
 * Class Regex
 * Custom regex validator.
 *
 * Usage: '<index>' => 'regex,/your-regex-expression/'
 *
 * @package system\core\validators
 */
class Regex implements ValidatorInterface
{
    private $regex;

    public function __construct($regex)
    {
        $this->regex = $regex;
    }

    public function validate($input)
    {
        return preg_match($this->regex, $input);
    }
}