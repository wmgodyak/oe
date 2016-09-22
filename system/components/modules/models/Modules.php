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
                $templates_files[$k]['orig'] = $item;

                $item = str_replace($dir, '', $item);
                $item = str_replace('default/', $themes_path . $theme_f . '/', $item);
                $item = str_replace('engine/', $themes_path . $theme_b . '/', $item);

                $templates_files[$k]['dest'] = $item;


                if(file_exists(DOCROOT . $themes_path . $item)){
                    $e = true;
                    $this->setError("File: {$themes_path}{$item} already exists");
                }
            }

            if($e){
                return false;
            }

        }

        $file = DOCROOT . "modules/{$module}/sql/install.sql";
        if(file_exists($file)){
            $q = file_get_contents($file);
            $q = str_replace('__', self::$db->getDbPrefix(), $q);
            self::$db->exec($q);

            if($this->hasError()){
                $this->setError($this->getErrorMessage());
                return false;
            }
        }

        if(!empty($templates_files)){
            foreach ($templates_files as $i=>$file) {
                $path_parts = pathinfo($file['dest']);
                if(!is_dir(DOCROOT . $path_parts['dirname'])){
                    if(!@mkdir(DOCROOT . $path_parts['dirname'], 0777, true)){

                        $this->setError("Can`t create directory {$path_parts['dirname']}. Permission denied");
                        return false;
                    };
                }
//                echo $file['orig'], ' -> ', DOCROOT . $file['dest'] , "\r\n";
                if( ! @copy($file['orig'], DOCROOT . $file['dest'])){
                    $this->setError("Can`t copy {$file['dest']}. Permission denied");
                };
            }
        }
//die;
        return true;
    }
    /**
     * @param $module
     * @return bool
     */
    public function uninstall($module)
    {
        $module = lcfirst($module);

        $themes_path = \system\models\Settings::getInstance()->get('themes_path');

        $dir = DOCROOT . "modules/{$module}/themes/";

        if(is_dir($dir)){
            $e = false;
            $dc = $this->getDirContents($dir);

            foreach ($dc as $k=>$item) {
                if(is_dir($item)) continue;

                $item = str_replace($dir, '', $item);

                if(file_exists(DOCROOT . $themes_path . $item)){
                    if(! @unlink(DOCROOT . $themes_path . $item)){
                       $this->setError("Can`t remove file {$themes_path}{$item}");
                       $e = true;
                   };
                }
            }

            if($e){
                return false;
            }
        }

        $file = DOCROOT . "modules/{$module}/sql/uninstall.sql";
        if(file_exists($file)){
            $q = file_get_contents($file);
            $q = str_replace('__', self::$db->getDbPrefix(), $q);
            self::$db->exec($q);

            if($this->hasError()){
                $this->setError($this->getErrorMessage());
                return false;
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
}