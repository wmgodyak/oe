<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 21.09.16 : 16:27
 */

namespace system\components\modules\models;

use system\components\settings\controllers\Settings;
use system\models\Model;

defined("CPATH") or die();

/**
 * Class Modules
 * @package system\components\modules\models
 */
class Modules extends Model
{
    /**
     * @param $module
     * @return bool
     */
    public function install($module)
    {
        $module = lcfirst($module);

        $themes_path = \system\models\Settings::getInstance()->get('themes_path');
        $theme_b = \system\models\Settings::getInstance()->get('engine_theme_current');
        $theme_f = \system\models\Settings::getInstance()->get('app_theme_current');

        $templates_files = [];
        $dir = DOCROOT . "modules/{$module}/themes/";

        if(is_dir($dir)){
            $e = false;
            $dc = $this->getDirContents($dir);
            foreach ($dc as $k=>$item) {
                if(is_dir($item)) continue;
                $item = str_replace($dir, '', $item);
                $item = str_replace('default/', $theme_f . '/', $item);
                $item = str_replace('engine/', $theme_b . '/', $item);
                $templates_files[] = $item;
                if(file_exists(DOCROOT . $themes_path . $item)){
                    $e = true;
                    $this->setError("File: {$themes_path}{$item} already exists");
                }
            }

            if($e){
//                d($this->getError());
                return false;
            }
        }
        die;

        $file = DOCROOT . "modules/{$module}/sql/install.sql";
        if(file_exists($file)){
            $q = file_get_contents($file);
            $q = str_replace('__', self::$db->getDbPrefix(), $q);
            self::$db->exec($q);

            if($this->hasError()){
//                echo $this->getErrorMessage();die;
                return false;
            }
        }

        if(!empty($templates_files)){
            foreach ($templates_files as $i=>$file) {
                $path_parts = pathinfo('/www/htdocs/inc/lib.inc.php');
                if(!is_dir(DOCROOT . $path_parts['dirname'])){
                    mkdir(DOCROOT . $path_parts['dirname'], 0777, true);
                }
//                copy()
            }
        }

        return true;
    }

     private function getDirContents($dir, &$results = array()){
        $files = scandir($dir);

        foreach($files as $key => $value){
            $path = realpath($dir.DIRECTORY_SEPARATOR.$value);
            if(!is_dir($path)) {
                $results[] = $path;
            } else if($value != "." && $value != "..") {
                $this->getDirContents($path, $results);
                $results[] = $path;
            }
        }

        return $results;
    }
    /**
     * @param $module
     * @return bool
     */
    public function uninstall($module)
    {
        $module = lcfirst($module);
        $file = DOCROOT . "modules/{$module}/sql/uninstall.sql";
        if(file_exists($file)){
            $q = file_get_contents($file);
            $q = str_replace('__', self::$db->getDbPrefix(), $q);
            self::$db->exec($q);

            if($this->hasError()){
//                echo $this->getErrorMessage();die;
                return false;
            }
        }

        return true;
    }
}