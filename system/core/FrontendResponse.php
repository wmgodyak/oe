<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 25.05.17
 * Time: 16:40
 */

namespace system\core;

use MatthiasMullie\Minify;
use system\models\Parser;
//use system\core\Config;
//use system\core\DataFilter;
//use system\core\DB;

class FrontendResponse implements ResponseInterface
{
    private $ds;
    private $template;

    public function __construct($ds)
    {
        $this->ds = $ds;

        $this->template = Template::getInstance();
    }

    public function display()
    {
        $parser = new Parser($this->ds);
        $ds = $parser->getDocumentSource();

        $ds = DataFilter::apply('documentSource', $ds);

        $db = DB::getInstance();

        $env = Config::getInstance()->get('core.environment');

        if($env == 'production'){

            $ds = $this->compress($ds);

        } elseif($env == 'debugging' ){

            $db = DB::getInstance();
            $time = $_SERVER['REQUEST_TIME_FLOAT'];
            $q = $db->getQueryCount();

            $ds.= "\r\n<!--\r\n";
            $time_end = microtime(true);
            $exec_time = round($time_end-$time, 4);
            $mu = memory_get_usage();
            $mp = 0; $mpf=0;
            if(function_exists('memory_get_peak_usage')){
                $mp = memory_get_peak_usage();
                $mpf = round(($mp / 1024) / 1024, 3);
            }
            $muf = round((memory_get_usage() / 1024) / 1024, 3);
            $ml=ini_get('memory_limit');

            if($mp > 0){
                $ds.= "    Memory peak in use: $mp ($mpf M)\r\n";
            }

            $ds.= "    Page generation time: ".$exec_time." seconds\r\n";
            $ds.= "    Memory in use: $mu ($muf M) \r\n";
            $ds.= "    Memory limit: $ml \r\n";
            $ds.= "    Total queries: $q \r\n";
            $ds.=  "-->";
        }

        $db->close();
        die($ds);
    }


    /**
     * @param $buffer
     * @return mixed
     */
    private function compress($buffer)
    {
        $compile_force = Config::getInstance()->get('core.assets_compile_force');

        $js_path = "tmp/{$this->template->theme}.min.js";
        $css_path = "tmp/{$this->template->theme}.min.css";

        $css_exists = file_exists(DOCROOT . $css_path);
        $js_exists = file_exists(DOCROOT . $js_path);

        if($compile_force || !$css_exists){

            $css = $this->template->getStyles();
            if(! empty($css)){

                $minifier = new Minify\CSS();

                foreach ($css as $k=>$v) {
                    $minifier->add(DOCROOT . $v);
                }

                $minifier->minify(DOCROOT . $css_path);
            }
        }

        if( $css_exists ){
            $v = filemtime(DOCROOT . $css_path);
            $css_compiled = "<link href='$css_path?_=$v' rel='stylesheet'>";
            $buffer = str_replace('</head>', "$css_compiled\n</head>", $buffer);
        }


        if($compile_force || !$js_exists){
            $js = $this->template->getScripts();
            if(!empty($js)){

                $minifier = new Minify\JS();

                foreach ($js as $k=>$v) {
                    $minifier->add(DOCROOT . $v);
                }

                $minifier->minify(DOCROOT . $js_path);

            }
        }

        if($js_exists){
            $v = filemtime(DOCROOT . $js_path);
            $js_compiled  = "<script src='$js_path?_=$v'></script>";
            $buffer = str_replace('</body>', "$js_compiled\n</body>", $buffer);
        }

        // minify html
        $search = array(
            '/\>[^\S ]+/s',  // strip whitespaces after tags, except space
            '/[^\S ]+\</s',  // strip whitespaces before tags, except space
            '/(\s)+/s'       // shorten multiple whitespace sequences
        );
        $replace = array(
            '>',
            '<',
            '\\1'
        );
        return preg_replace($search, $replace, $buffer);
    }
}