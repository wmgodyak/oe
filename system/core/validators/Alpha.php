<?php
namespace system\core\validators;

use system\core\ValidatorInterface;

/**
 * Class Alpha
 * Determine if the provided value contains only alpha characters.
 *
 * Usage: '<field>' => 'alpha'
 * @package system\core\validators
 */
class Alpha implements ValidatorInterface
{
    public function validate($input)
    {
        if (empty($input)) {
            return false;
        }

        return preg_match('/^([a-zÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÒÓÔÕÖßÙÚÛÜÝàáâãäåçèéêëìíîïðòóôõöùúûüýÿ])+$/i', $input) !== false;
    }
}