<?php
namespace system\core\validators;

use system\core\ValidatorInterface;

/**
 * Class AlphaNumeric
 * Determine if the provided value contains only alpha-numeric characters.
 *
 * Usage: '<field>' => 'alpha_numeric'
 * @package system\core\validators
 */
class AlphaNumeric implements ValidatorInterface
{
    public function validate($input)
    {
        if (empty($input)) {
            return false;
        }

        return preg_match('/^([a-z0-9ÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÒÓÔÕÖßÙÚÛÜÝàáâãäåçèéêëìíîïðòóôõöùúûüýÿ])+$/i', $input) !== false;
    }

    public function getErrorMessage()
    {
        return "The {field} field may only contain letters and numbers";
    }
}