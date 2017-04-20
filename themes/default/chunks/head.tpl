<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- (c) Developed by Otakoyi.com | http://otakoyi.com/ -->
    <!-- (c) Powered by OYi.Engine | http://engine.otakoyi.com/ -->

    <base href="{$base_url}">

    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1">

    {block name=head_meta}
        <title>{$page.title}</title>
        <meta name="description" content="{$page.description|escape}"/>
        <meta name="keywords" content="{{$page.keywords|escape}}" />
    {/block}

    <meta name="generator" content="OYi.Engine">
    <meta name="csrf-token" content="{$token}">

    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    {assets('bootstrap/css/bootstrap.min.css')}
    {assets('bootstrap/css/bootstrap-theme.min.css')}

    {block name=head}
        {$events->call('head', $page)}
    {/block}
</head>