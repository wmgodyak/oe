<head>
    <base href="{$base_url}">
    <meta charset="utf-8" />
    <!--[if lt IE 9]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
    <title>{$title} :: {$t.system.name}</title>
    <link href="{$theme_url}assets/css/vendor/style.css" rel="stylesheet">
    <link href="{$theme_url}assets/css/vendor/jquery.materialripple.css" rel="stylesheet">
    <link href="{$theme_url}assets/css/vendor/bootstrap.min.css" rel="stylesheet">
    <link href="{$theme_url}assets/css/vendor/jquery.mCustomScrollbar.css" rel="stylesheet">
    <link href="{$theme_url}assets/css/style.css?v={$version}" rel="stylesheet">
    <script src="{$theme_url}assets/js/vendor/jquery-1.11.3.min.js"></script>

    <link rel="apple-touch-icon" sizes="180x180" href="{$theme_url}/assets/img/favicons/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="{$theme_url}/assets/img/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="{$theme_url}/assets/img/favicons/favicon-16x16.png">
    <link rel="mask-icon" href="{$theme_url}/assets/img/favicons/safari-pinned-tab.svg" color="#5bbad5">
    <meta name="theme-color" content="#ffffff">

    {literal}
        <style>

            .form-control-static {
                min-height: 34px;
                padding-top: 7px;
                padding-bottom: 7px;
                margin-bottom: 0;
            }
            .form-control-static.input-lg,
            .form-control-static.input-sm {
                padding-right: 0;
                padding-left: 0;
            }
            .badge.badge-info {
                background-color: #5bc0de;
                color: #fff;
            }
            .badge.badge-info > a{
                color: #fff;
            }
        </style>
    {/literal}
    {block name="head"}{/block}
</head>