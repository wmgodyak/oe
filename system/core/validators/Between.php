<?php
namespace system\core\validators;

use system\core\ValidatorInterface;

/**
 * Class Required
 * @package system\core\validators
 */
class Between implements ValidatorInterface
{
    private $min, $max;

    public function __construct( $min, $max )
    {
        $this->min = (int)$min;
        $this->max = (int)$max;
    }

    public function validate($data)
    {
        return $data > $this->min && $data < $this->max;
    }
}