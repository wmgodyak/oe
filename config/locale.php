<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 18.12.15 : 12:24
 */
    /*
    * Set the server timezone
    * see: http://us3.php.net/manual/en/timezones.php
    */
    date_default_timezone_set("Europe/Kiev");

    /*
    * Set everything to UTF-8
    */
    setlocale(LC_ALL, 'uk_UA.utf-8');

//    iconv_set_encoding("internal_encoding", "UTF-8");
    mb_internal_encoding('UTF-8');
