<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- (c) Developed by Otakoyi.com | http://otakoyi.com/ -->
<!-- (c) Powered by OYi.Engine | http://engine.otakoyi.com/ -->

<base href="{$base_url}">

<meta charset="UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>{block name='meta.title'}{$page.title}{/block}</title>
<meta name="description" content="{block name='meta.description'}{$page.description|escape}{/block}"/>
<meta name="keywords" content="{block name='meta.keywords'}{{$page.keywords|escape}}{/block}"/>

<meta name="generator" content="OYi.Engine">
<meta name="csrf-token" content="{$token}">

{block name="chunks.head"}
    <!-- Bootstrap Core CSS -->
    {assets('css/style.css')}
    {$events->call('chunks.head', $page)}
{/block}