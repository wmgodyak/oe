<head>
    <base href="{$base_url}{$settings->get('backend_url')}/">
    <meta charset="utf-8" />
    <!--[if lt IE 9]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
    <title>{$title} :: {$t.system.name}</title>
    <link href="{$theme_url}assets/css/vendor/style.css" rel="stylesheet">
    <link href="{$theme_url}assets/css/vendor/jquery.materialripple.css" rel="stylesheet">
    <link href="{$theme_url}assets/css/vendor/bootstrap.min.css" rel="stylesheet">
    <link href="{$theme_url}assets/css/vendor/jquery.mCustomScrollbar.css" rel="stylesheet">
    <link href="{$theme_url}assets/css/style.css?v={$version}" rel="stylesheet">
    <link href="{$theme_url}assets/css/custom.css?v={$version}" rel="stylesheet">
    <script src="{$theme_url}assets/js/vendor/jquery-1.11.3.min.js"></script>
    {block name="head"}
        {if $custom_styles}
            {foreach $custom_styles as $src}
                <link href="{$src}" rel="stylesheet">
            {/foreach}
        {/if}
    {/block}
</head>