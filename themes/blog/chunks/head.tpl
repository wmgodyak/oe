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
    {assets('css/bootstrap.min.css')}

    <!-- Customizable CSS -->
    {assets('css/main.css')}
    {assets('css/orange.css')}
    {assets('css/owl.carousel.css')}
    {assets('css/owl.transitions.css')}
    {assets('assets/css/lightbox.css')}
    {assets('css/animate.min.css')}
    {assets('css/rateit.css')}
    {assets('css/bootstrap-select.min.css')}
    <!-- Icons/Glyphs -->
    {assets('css/font-awesome.min.css')}

    <!-- Fonts -->
    <link href='http://fonts.googleapis.com/css?family=Roboto:300,400,500,700' rel='stylesheet' type='text/css'>
    <!-- Favicon -->
    {assets('images/favicon.ico')}

    <!-- HTML5 elements and media queries Support for IE8 : HTML5 shim and Respond.js -->
    <!--[if lt IE 9]>
    <script src="assets/js/html5shiv.js"></script>
    <script src="assets/js/respond.min.js"></script>
    <![endif]-->
    {$events->call('chunks.head', $page)}
{/block}