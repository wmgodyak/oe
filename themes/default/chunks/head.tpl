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

    <title>{block name='meta.title'}{$page.title}{/block}</title>
    <meta name="description" content="{block name='meta.description'}{$page.description|escape}{/block}"/>
    <meta name="keywords" content="{block name='meta.keywords'}{{$page.keywords|escape}}{/block}" />

    <meta name="generator" content="OYi.Engine">
    <meta name="csrf-token" content="{$token}">

    {block name="head.assets"}
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->

        {assets('images/favicon/apple-touch-icon.png')}
        {assets('images/favicon/favicon.ico')}

        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,600" rel="stylesheet">

        {assets('css/bootstrap.min.css')}
        {assets('vendors/font-awesome/css/font-awesome.min.css')}
        {assets('vendors/linearicons/css/linearicons.css')}
        {assets('vendors/owl-carousel/owl.carousel.min.css')}
        {assets('vendors/owl-carousel/owl.theme.min.css')}
        {assets('vendors/flexslider/flexslider.css')}
        {assets('css/base.css')}
        {assets('css/style.css')}

        {$events->call('head.assets', $page)}
    {/block}
    {$events->call('head', $page)}
</head>