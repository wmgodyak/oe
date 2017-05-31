<?php
namespace system\core\validators;

use system\core\ValidatorInterface;

/**
 * Class Required
 * @package system\core\validators
 */
class Required implements ValidatorInterface
{
    private $error = null;

    public function getError()
    {
        return $this->error;
    }

    public function validate($data)
    {
        // TODO: Implement validate() method.
    }
}