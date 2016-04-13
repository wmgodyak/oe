<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 22.03.16 : 8:52
 */

namespace models\app;

use controllers\core\Settings;
use models\core\Model;

defined("CPATH") or die();

class Parser extends Model
{
    private $ds;

    public function __construct($ds)
    {
        parent::__construct();

        $this->ds = $ds;
    }

    private function getUrlById($id, $languages_id, $def_lang)
    {
        $url = self::$db
            ->select("select url from content_info where content_id = '{$id}' and languages_id={$languages_id} limit 1")
            ->row('url');

        if($languages_id == $def_lang['id']){
            return $url;
        }

        $code = $def_lang['code'];
        if(empty($url)){
            return $code;
        }
        return $code .'/'. $url;
    }

    /**
     * Паорсер системних посилань на красиві урли
     *
     * Приклад з
     *
     *
    <a href="2#abourt"></a>
    <a href="2"></a>
    <a href="3"></a>
    <a href="4"></a>
    <a href="8"></a>
    <a href="1;p=1"></a>
    <a href="2;p=3"></a>
    <a href="3;q=asdjklфів3"></a>
    <a href="3;q=asdjklфів3;p=4"></a>
    <a href="4;tag=seo"></a>
    <a href="4;tag=seo;author=wg"></a>
    <a href="4;tag=іущ"></a>
    <a href="4;author=wg"></a>
    <a href="4;author=wg;p=4"></a>
    <a href="4;brand=apple"></a>
    <a href="4;brand=apple;p=4"></a>
    <a href="4;filter/12=23"></a>
    <a href="4;filter/12=23;23=34"></a>
    <a href="4;filter/12=23;23=34;45=67"></a>
    <a href="4;filter/12=23,33,45;23=34;45=67"></a>
    <a href="4;filter/vendor=acer;display=14"></a>
    <a href="4;filter/vendor=acer;display=14;p=4"></a>
    <a href="4;filter/vendor=acer;display=14;ram=ddr3"></a>
    <a href="4;filter/vendor=acer,lenovo;display=14,15-16;ram=ddr3"></a>
    <a href="4;filter/vendor=acer,lenovo;display=14,15-16;ram=ddr3"></a>
    <a href="4;filter/vendor=acer;display=14;ram=ddr3;p=4"></a>
    <a href="8;order=name-desc"></a>
    <a href="8;order=name-asc"></a>
    <a href="8;order=price-asc"></a>
    <a href="8;order=price-asc"></a>
    <a href="8;order=action-asc"></a>
    <a href="8;order=action-desc"></a>
    <a href="8;order=action-desc;p=5"></a>
     * 
     * 
     * на
     * 
    <a href="uk"></a>
    <a href="uk/pro-nas"></a>
    <a href="uk/novyny"></a>
    <a href="uk/oplata-ta-dostavka"></a>
    <a href="uk/kontakty"></a>
    <a href="uk/page/1"></a>
    <a href="uk/pro-nas/page/3"></a>
    <a href="uk/novyny/q=asdjklфів3"></a>
    <a href="uk/novyny/q=asdjklфів3/page/4"></a>
    <a href="uk/oplata-ta-dostavka/tag=seo"></a>
    <a href="uk/oplata-ta-dostavka/tag=seo/author=wg"></a>
    <a href="uk/oplata-ta-dostavka/tag=іущ"></a>
    <a href="uk/oplata-ta-dostavka/author=wg"></a>
    <a href="uk/oplata-ta-dostavka/author=wg/page/4"></a>
    <a href="uk/oplata-ta-dostavka/brand=apple"></a>
    <a href="uk/oplata-ta-dostavka/brand=apple/page/4"></a>
    <a href="uk/oplata-ta-dostavka/filter/12=23"></a>
    <a href="uk/oplata-ta-dostavka/filter/12=23;23=34"></a>
    <a href="uk/oplata-ta-dostavka/filter/12=23;23=34;45=67"></a>
    <a href="uk/oplata-ta-dostavka/filter/12=23,33,45;23=34;45=67"></a>
    <a href="uk/oplata-ta-dostavka/filter/vendor=acer;display=14"></a>
    <a href="uk/oplata-ta-dostavka/filter/vendor=acer;display=14;/page/4"></a>
    <a href="uk/oplata-ta-dostavka/filter/vendor=acer;display=14;ram=ddr3"></a>
    <a href="uk/oplata-ta-dostavka/filter/vendor=acer,lenovo;display=14,15-16;ram=ddr3"></a>
    <a href="uk/oplata-ta-dostavka/filter/vendor=acer,lenovo;display=14,15-16;ram=ddr3"></a>

    <a href="uk/oplata-ta-dostavka/filter/vendor=acer;display=14;ram=ddr3;/page/4"></a>

    <a href="uk/kontakty/order=name-desc"></a>
    <a href="uk/kontakty/order=name-asc"></a>
    <a href="uk/kontakty/order=price-asc"></a>
    <a href="uk/kontakty/order=price-asc"></a>
    <a href="uk/kontakty/order=action-asc"></a>
    <a href="uk/kontakty/order=action-desc"></a>
    <a href="uk/kontakty/order=action-desc/page/5"></a>
     *
     * @return string
     */
    public function makeFriendlyUrl()
    {
        $def_lang = self::$db->select("select id,code from languages where is_main=1 limit 1")->row();
        $languages_id = $this->request->param('languages_id');
        $self = $this;
//        $pattern = '@(href|action)="([^\"]*)"@siU'; // ok
        //$pattern = '@(href|action)="([0-9]+)?;??(filter/[a-z0-9_\-]+=[a-z0-9_\-;,=]+)??;??([a-z]+=[a-z0-9а-яА-ЯіїЇІ_\-]+)??;??([a-z]+=[a-z0-9а-яА-ЯіїЇІ_\-]+)??;??([a-z]+=[a-z0-9а-яА-ЯіїЇІ_\-]+)??;??([a-z]+=[a-z0-9а-яА-ЯіїЇІ_\-]+)??([\?a-z]+=[a-z0-9а-яА-ЯіїЇІ_\-]+)??([\&a-z]+=[a-z0-9а-яА-ЯіїЇІ_\-]+)?"@isu';
//        $pattern = '@(href|action)="([0-9]+)?;??(filter/[a-z0-9_\-]+=[a-z0-9_\-;,=]+)??([a-z]+=[a-z0-9а-яА-ЯіїЇІ_\-]+)?"@isu';
        $pattern = '@(href|action)="([0-9]+)?;??(filter/[a-z0-9_\-]+=[a-z0-9_\-;,=]+)??(([?&a-z]+=[a-z0-9а-яА-ЯіїЇІ_\-]+)*)?"@isu';
        $this->ds = preg_replace_callback
        (
            $pattern,
            function($matches) use ($self, $languages_id, $def_lang)
            {
                if(!isset($matches[1])) return $matches[0];

                if(strpos($matches[0], '?') !== FALSE){
                    $c = count($matches); $c --;
                    unset($matches[$c]);
                }

                $url = '';
                $a = [];

                foreach ($matches as $k=>$v) {

                    if($k == 0){

                        continue;
                    }elseif(empty($v)) {

                        unset($matches[$k]);
                        continue;
                    } elseif(in_array($v, $a)){
                        unset($matches[$k]);
                    }

                    $a[] = $v;
                }

//                echo '<pre>'; print_r($matches); echo '</pre>';

                $action = $matches[1];

                if(!isset($matches[2])) return $matches[0];

                $id = (int)$matches[2];
                $url .= $self->getUrlById($id, $languages_id, $def_lang);

                foreach($matches as $k=>$v){
                    if($k > 2){
                        $v = preg_replace('/p=([0-9]+)/u','/page/$1', $v);
                        $s = substr($v,0,1);
                        if($s == '?' || $s == '&'){
                            $url .= "$v";
                        } else {
                            $url .= "/$v";
                        }

                    }
                }
                $url = str_replace('//','/', $url);

                return "$action=\"$url\"";

            },
            $this->ds
        );
    }

    public function addAnalytics()
    {
        $ga_id = Settings::getInstance()->get('google_analytics_id');
        $ya_m = Settings::getInstance()->get('yandex_metric');

        $out = null;

        if($ga_id){
            $out =  "
            (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o)
                ,
                m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
            })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

            ga('create', '{$ga_id}', 'auto');
            ga('send', 'pageview');
            ";
        }

        if($ya_m){
            $out .= "
            (function(w, c) {
                (w[c] = w[c] || []).push(function() {
                try {
                w.yaCounter$ya_m = new Ya.Metrika({id: $ya_m, enableAll: true});
                }
                catch(e){}
                });
            })(window, \"yandex_metrika_callbacks\");
            ";
        }
        if(!empty($out)){
            $out = "<script>{$out}</script>";
            $this->ds = str_replace('</head>', $out . '</head>',$this->ds);
        }
    }

    public function getDocumentSource()
    {
        return $this->ds;
    }
}