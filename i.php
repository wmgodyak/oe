<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 03.03.16 : 15:18
 */
function cryptPassword($password)
{
    $salt = strtr(base64_encode(mt_rand()), '+', '.');
    return crypt($password, $salt);
}

echo cryptPassword(123);