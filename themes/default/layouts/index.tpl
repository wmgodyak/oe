{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:support@otakoi.com
 * @copyright Copyright (c) 2017 Otakoyi.com
 * Date: 2017-03-21
 * @name index
 *}
<!DOCTYPE html>
<html data-lang="{block name="html.lang"}{$request->language->code}{/block}" dir="{block name="html.dir"}{$request->language->dir}{/block}" lang="{block name="html.dir"}{$request->language->lang}{/block}" data-page="{$page.id}" data-template="{$page.template}" data-type="{$page.type}">

    <head>{include file="chunks/head.tpl"}</head>

    <body class="{block name="body.class"}cms-index-index index-opt-8{/block}">

        {$events->call('layout.index.body.before')}

        {block name=body}{$body}{/block}

        {$events->call('layout.index.body.after')}

        {include file="chunks/scripts.tpl"}

        {$events->call('layout.index.body.bottom')}

    </body>
</html>