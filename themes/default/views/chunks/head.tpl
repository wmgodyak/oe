{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:support@otakoi.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-03-21T14:13:48+02:00
 * @name head
 *}

<!DOCTYPE html>
<html>
<head>

    <!-- (c) Developed by Otakoyi.com | http://www.otakoyi.com/ -->
    <!-- (c) Powered by OYi.Engine | http://www.engine.otakoyi.com/ -->

    <base href="{$base_url}">
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <title>{$page.title}</title>
    <meta name="description" content="{$page.description|escape}"/>
    <meta name="keywords" content="{{$page.keywords|escape}}" />
    <meta name="author" content="{$page.author.name} {$page.author.surname}">
    <meta name="generator" content="OYi.Engine7">

    <link rel="icon" type="image/x-icon" href={$theme_url}assets/favicon.ico" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- stylesheets -->
    <link rel="stylesheet" type="text/css" href="{$theme_url}assets/css/compiled/theme.css">
    <link rel="stylesheet" type="text/css" href="{$theme_url}assets/css/vendor/animate.css">

    <!-- javascript -->
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="{$theme_url}assets/js/bootstrap/bootstrap.min.js"></script>
    <script src="{$theme_url}assets/js/theme.js"></script>
    <script src="{$theme_url}assets/js/plugins.js" id="appScr"></script>
    <script src="{$theme_url}assets/js/app.js" id="appScr"></script>

    <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <script>
        var TOKEN = '{$token}', LANG_ID={$page.languages_id * 1};
    </script>
</head>