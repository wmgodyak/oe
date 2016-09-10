{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:support@otakoi.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-03-21T14:13:48+02:00
 * @name head
 *}
<!DOCTYPE html>
<html data-id="{$page.id}" data-type="{$page.types_id}" data-template="{$page.template}">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
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
    <!--[if lt IE 9]>
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" href="{$theme_url}/assets/css/vendor/jquery.formstyler.css">
    <link rel="stylesheet" href="{$theme_url}/assets/css/vendor/owl.carousel.css">
    <link rel="stylesheet" href="{$theme_url}/assets/css/vendor/owl.theme.default.min.css">
    <link rel="stylesheet" href="{$theme_url}/assets/css/vendor/css-stars.css">
    <link rel="stylesheet" href="{$theme_url}/assets/css/vendor/plugins.css">
    <link rel="stylesheet" href="{$theme_url}/assets/css/style.css">
    <script>
        var TOKEN = '{$token}', LANG_ID={$page.languages_id * 1}, CONTENT_ID = {$page.id};
    </script>

    {* Якщо авторизований адміністратор, то показуємо додаткові опції * }

    {if $smarty.session.engine.admin}
        <script src="{$theme_url}assets/js/admin.js" id="admPanelScr"></script>
    {if $smarty.session.inline_editing}
        <script src="/vendor/ckeditor/ckeditor.js"></script>
    {/if}
        <link rel="stylesheet" type="text/css" href="{$theme_url}assets/css/admin.css">
    {/if}

    *}
</head>

<body>