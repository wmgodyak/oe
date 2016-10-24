{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-04T22:37:00+03:00
 * @name home
 *}
{include file="chunks/head.tpl"}
hello
    {*<pre>{print_r($app->module->banners->get('aaaa'))}</pre>*}
{*<pre>{print_r($app->module->banners)}</pre>*}
<pre>{var_dump($app->issetModule('banners'))}</pre>
{include file="chunks/footer.tpl"}
