<?php
namespace system\core\validators;

use system\core\ValidatorInterface;

/**
 * Class MinAge
 * Determine if the provided input meets age requirement (ISO 8601).
 *
 * Usage: '<index>' => 'min_age,13'
 * @package system\core\validators
 */
class MinAge implements ValidatorInterface
{
    private $min;

    public function __construct( $min )
    {
        $this->min = (int)$min;
    }

    /**
     * @param $input date ('Y-m-d') or datetime ('Y-m-d H:i:s')
     * @return bool
     */
    public function validate($input)
    {
        $cdate1 = new \DateTime(date('Y-m-d', strtotime($input)));
        $today = new \DateTime(date('d-m-Y'));
        $interval = $cdate1->diff($today);
        $age = $interval->y;
        return $age <= $this->min;
    }
}