{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:support@otakoi.com
 * @copyright Copyright (c) 2017 Otakoyi.com
 * Date: 2017-03-21
 * @name index
 *}
<!DOCTYPE html>
<html lang="{block name="html.lang"}en{/block}">

    <head>{include file="chunks/head.tpl"}</head>

    <body class="{block name="body.class"}cnt-home{/block}">

        {$events->call('layout.index.body.before')}

        {block name=body}{$body}{/block}

        {$events->call('layout.index.body.after')}

        {include file="chunks/scripts.tpl"}

        {$events->call('layout.index.body.bottom')}

    </body>
</html>