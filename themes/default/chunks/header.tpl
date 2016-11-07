{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:support@otakoi.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-03-21T14:13:48+02:00
 * @name head
 *}
<!DOCTYPE html>
<html data-id="{$page.id}" lang="{$page.languages_code}" data-type="{$page.types_id}" data-template="{$page.template}">
<head>
    <!-- (c) Developed by Otakoyi.com | http://www.otakoyi.com/ -->
    <!-- (c) Powered by OYi.Engine | http://www.engine.otakoyi.com/ -->

    <base href="{$base_url}">

    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>{$page.title}</title>
    <meta name="description" content="{$page.description|escape}"/>
    <meta name="keywords" content="{{$page.keywords|escape}}" />
    <meta name="generator" content="OYi.Engine 7">

    <!--[if lt IE 9]>
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script>
        var TOKEN = '{$token}', LANG_ID={$page.languages_id * 1}, CONTENT_ID = {$page.id};
    </script>
    <!-- Bootstrap -->
    <link href="{$theme_url}assets/css/bootstrap.min.css" rel="stylesheet">
    <!-- custome-css -->
    <link href="{$theme_url}assets/css/style.css" rel="stylesheet" type="text/css" media="screen">
    <!-- font awesome for icons -->
    <link href="{$theme_url}assets/css/font-awesome.min.css" rel="stylesheet">
    <!-- google font -->
    <link href='https://fonts.googleapis.com/css?family=Merriweather:300,400,700' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700' rel='stylesheet' type='text/css'>
</head>
<body>