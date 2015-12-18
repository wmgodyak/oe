<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 29.06.15
 * Time: 17:31
 */

namespace controllers\core;


use models\app\Languages;
use models\app\Translations;

class Parser{
    private $t;
    private $languages_id;

    public function __construct()
    {
        die('__coming_soon__');
        $languages = new Languages();
        $this->languages_id = $languages->getDefault('id');
        $this->setTranslation();
    }
    /**
     * парсить контент
     *
     * модуль <br/>
    [[mod:Shop]]
     *
    модуль, метод
    [[mod:Shop::hello]]

    модуль, метод, параметри
    [[mod:Shop::hello(7,3,6)]]

    виклик чанку
    [[chunk:test]]
     *
     * @param $ds string document source
     * @return mixed
     */
    public function parse($ds)
    {
        $self = $this;
        $t = $this->translation;
        $themes_path = Settings::instance()->get('themes_path');

        $current = Settings::instance()->get('app_theme_current');
        $chunks_path = Settings::instance()->get('app_chunks_path');
        $chunks_path = $themes_path . $current.'/'.$chunks_path;

        $template_url = APPURL . $themes_path . $current . '/';
        $base_url = APPURL;

        $ds = preg_replace_callback(
            '@\[\[([app|mod|chunk]+):([a-zA-Z_0-9\-]+)?(::[a-zA-Z_0-9]+)??(\([0-9,]+\))?\]\]@s',
            function($data) use ($self, $t, $template_url, $base_url, $chunks_path){
                $self->template = Template::instance();
                $self->load = Load::instance();
                $out = '';
                $app = new \controllers\App();
                switch($data[1]){
                    case 'mod': // модуль
                        $module = ''; $action = ''; $params = array();
                        if(isset($data[2]) && !empty($data[2])) {
                            $module = $data[2];
                        }
                        if(isset($data[3]) && !empty($data[3])) {
                            $action = ltrim($data[3], '::');
                        }
                        if(isset($data[4]) && !empty($data[4])) {
                            $params = explode(',', trim($data[4], '()'));
                        }

                        $out = $self->load->module($module , $action, $params);
                        $out = $app->parse($out);
                        break;
                    case 'chunk': // чанк
                        $out = $self->template->fetch($chunks_path . $data[2]);
                        $out = $app->parse($out);
                        break;
                    case 'app': // виклик функції метатегів
                        if(isset($data[2])){
                            if($data[2] == 'metatags'){
                                $out = $self->metatags();
                            }
                            else{
                                $out = '<b>Error.</b> invalid parse: ' . $data[2];
                            }
                        }
                        break;
                    default:
                        return 'invalid parse, use pattenrn:
                          @\[{([mod|chunk]+):([a-zA-Z_0-9]+)?(::[a-zA-Z_0-9]+)?}\]@s';
                        break;
                }
                return $out;
            },
            $ds
        );
        return $ds;
    }

    private function makeFriendlyUrl($ds)
    {
        $mc = $this->load->model('app\Content');
        $current_languages_id = $this->request->get('languages_id');
//        мову по замовчуванню
        $_languages_id = $this->languages->getDefault('id');

        // список мов
        $_languages = $this->languages->get();
        $languages = array();
        foreach ($_languages as $row) {
            $languages[$row['id']] = $row['code'];
        }

        $ds = preg_replace_callback(
//            '@href=["|\'](.*)["|\']@i',
            '/href=\"([^\"]*)\"/siU',
            function($data) use ($mc, $_languages_id, $languages, $current_languages_id){

                /* $id=0; $p=0; $languages_id=0;
                 $out = ''; $qs = array();

                 // content id
                 if(isset($data[1]) && !empty($data[1])){
                     $id = rtrim($data[1], ';');
                 }
                 $data = array_slice($data, 2);

 //                $this->dump($data);
                 foreach ($data as $k=>$v) {
                     if(strpos($v, 'l=') !== false){
                         $l = ltrim($v,'l=');
                         $languages_id = rtrim($l, ';');
                         continue;
                     }
                     if(strpos($v, 'p=') !== false){
                         $p = ltrim($v,'p=');
                         $p = rtrim($p,';');
                         continue;
                     }
                     if($k>1){
                         $qs[] = $v;
                     }
                 }
                 */

                $id=0; $languages_id=0; $p=0; $tag = ''; $out = ''; $qs = array();

                // пошук по системних параметрах
                if(strpos($data[1], ';') !== false){
                    // пошук по системних параметрах
                    $a = explode(';', $data[1]);
//                    $this->dump($a);
//                    $qs = end($a);
//                    $qs = '?'. ltrim($qs, '&');
                    if(isset($a[1])){
                        foreach ($a as $i=>$row) {
                            if($i == 0) {
                                $id = (int) $row;
                            } else {
                                if(strpos($row, 'l=') !== false){
                                    $languages_id = ltrim($row,'l=');
                                    $languages_id = rtrim($languages_id, ';');
                                    continue;
                                }elseif(strpos($row, 'p=') !== false){
                                    $p = ltrim($row,'p=');
                                    $p = rtrim($p,';');
                                    continue;
                                }elseif(strpos($row, 'tag=') !== false){
                                    $tag = ltrim($row,'tag=');
                                    $tag = rtrim($tag,';');
                                    continue;
                                } elseif(!empty($row)){
                                    $qs[] = $row;
                                }
                            }
                        }

                    }
                } else if(preg_match('@^([0-9]+)$@', $data[1], $mathes)){
                    $id = (int)$mathes[1];
                } else {
                    return $data[0];
                }
//echo 'RES: ID:', $id, ' L:', $languages_id, ' P: ', $p;
                // якщо вказана мова
                if($languages_id > 0){
                    // якщо не мова по замовчванню то присвою префік

                    if($languages_id != $_languages_id) {
                        $out .= $languages[$languages_id] . '/';
                    }


                } else {

                    // використаю мову по замовчуванню
                    if($_languages_id != $current_languages_id ) {
                        $out .= $languages[$current_languages_id] . '/';
                    }

                    $languages_id = $current_languages_id;

                }

                if($id > 0){
//                    echo $id, '++<br>';
                    if($id == 1){
                        $alias = '/';
                    } else {
                        $alias = $mc->getAliasById($id, $languages_id);
                    }

                    $out .= $alias;
                }
                if($p > 0){
                    $out .= '/' . $p;
                }

                if($tag != '') {
                    $out .= '/tag/' . $tag;
                }
//echo'---<---
                if(!empty($qs)){
                    $out .= '?'. implode('&', $qs);
                }

                $out = str_replace('//','/', $out);
                $result = 'href="'.$out.'"';
                return $result;
            },
            $ds
        );

        return $ds;
    }
}