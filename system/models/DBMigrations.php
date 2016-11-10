<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 09.11.16 : 17:33
 */

namespace system\models;

defined("CPATH") or die();

abstract class DBMigrations extends Model
{
    abstract function up();
    abstract function down();
}